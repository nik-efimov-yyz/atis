require "open-uri"
require "atis/group/base"

module ATIS

  class METAR

    def initialize(string_or_airport = nil, options = {})
      @options = options.reverse_merge(
          online_source: :vatsim
      )

      if string_or_airport.present?
        if string_or_airport.length <= 4
          # Assume Airport Code Given
          @metar = fetch(string_or_airport)
        else
          @metar = string_or_airport
        end
      end

    end

    def self.group(name)
      self.class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name.to_s}
          @#{name.to_s} ||= ATIS::Group::#{name.to_s.camelcase}.new(self)
        end
      CODE
    end

    group :time
    group :wind
    group :visibility
    group :rvr

    def fetch(airport_code)
      case @options[:online_source]
        when :vatsim
          open("http://metar.vatsim.net/#{airport_code.to_s}").read
        else
          raise "Unknown Online METAR Source"
      end
    end

    def raw
      @metar
    end

    def to_s
      @metar
    end

  end
end