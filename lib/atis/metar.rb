require "open-uri"
require "atis/group/base"

module ATIS

  class METAR

    cattr_accessor(:groups) { [] }

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

    def self.group(name, options = {})

      groups << name

      define_method(name) do
        return "ATIS::Group::#{name.to_s.camelcase}".constantize.new unless @metar.present?

        elements = []
        metar_copy = @metar.clone
        loop do
          match = metar_copy.match(options[:matches])
          elements << "ATIS::Group::#{name.to_s.camelcase}".constantize.new(match) if elements.empty? or match.present?
          break if match.nil?
          metar_copy.slice!(match[0])
        end
        elements.count > 1 ? elements : elements.first
      end
    end

    group :time, matches: /(\d{2})(\d{2})(\d{2})Z/
    group :wind, matches: /(VRB|\d{3})(\d{2}|\d{2}G\d{2})(KT|MPS)( (\d{3})V(\d{3}))?/
    group :visibility, matches: /\s(\d{4})\s/
    group :rvr, matches: /R(\d{2}[RLC]?)\/([\/V\dUDNPM]*)/
    group :cavok, matches: /\s(CAVOK)\s/
    group :temperature, matches: /\s(M?\d{2})\/(M?\d{2})\s/

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

    def to_voice_script
      voice_processor.compile_from_groups(groups).gsub(/[\[\]]/, '')
    end

    def voice_processor
      @voice_processor ||= ATIS::Voice::Processor.new(self)
    end

  end
end