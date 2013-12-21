module METAR::Report::Extensions
  extend ActiveSupport::Concern

  included do
    @groups = []
  end

  module ClassMethods

    def group(name, options = {})
      @groups << name
      options.reverse_merge!(in: :metar)

      define_method(name) do |args = {}|

        sources = args[:from] || options[:in]
        sources = [sources] unless sources.is_a?(Array)

        sources = sources.map do |s|
          src = send("#{s}".to_sym)
          src && src.clone
        end

        nodes = []

        sources.compact.each do |source|
          loop do
            match = source.match(options[:matches])
            break if match.nil?
            nodes << "METAR::Node::#{name.to_s.camelcase}".constantize.new(match)
            source.gsub!(match[0].strip, "")
          end
        end

        nodes

        #metar.visibility from: :trend
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