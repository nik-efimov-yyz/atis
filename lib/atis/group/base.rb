module ATIS::Group

  class Base

    def initialize(match = nil)
      @match = match
    end

    def self.property(name, &block)
      define_method name do
        instance_eval &block if match.present?
      end
    end

    def self.voice_message(schema = :default, &block)
      define_method :to_voice do
        instance_eval &block if match.present?
      end
    end

    def match
      @match
    end

    def raw
      match && match[0]
    end

    alias :to_s :raw



    protected

    def i18n_scope
      self.class.to_s.demodulize.downcase.to_sym
    end

  end
end