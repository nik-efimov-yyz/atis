module ATIS::Group

  class Base

    @pattern = nil

    def initialize(metar_object)
      @metar = metar_object
    end

    def self.matches(pattern)
      @pattern = pattern
    end

    def self.property(name, &block)
      define_method name do
        instance_eval &block if match.present?
      end
    end

    def self.pattern
      @pattern
    end

    def match
      @metar.raw.present? && @metar.raw.match(self.class.pattern)
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