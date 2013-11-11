module METAR::Report::Extensions
  extend ActiveSupport::Concern

  included do
    @groups = []
  end

  module ClassMethods

    def group(name, options = {})
      @groups << name
      options.reverse_merge!(in: :metar)

      options[:in] = [options[:in]] unless options[:in].is_a?(Array)

      define_method(name) do

        subjects = options[:in].map do |s|
          src = send("#{s}".to_sym)
          src && src.clone
        end
        nodes = []

        subjects.compact.each do |s|
          loop do
            match = s.match(options[:matches])
            break if match.nil?
            nodes << "METAR::Node::#{name.to_s.camelcase}".constantize.new(match)
            s.gsub!(match[0].strip, "")
          end
        end



        nodes
      end
    end

    def groups
      @groups
    end

  end

  def groups
    self.class.groups
  end

end