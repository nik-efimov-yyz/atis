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

    def self.group(name, options = {})
      define_method(name) do
        group = []
        metar_copy = @metar.clone
        loop do
          match = metar_copy.match(options[:matches])
          group << "ATIS::Group::#{name.to_s.camelcase}".constantize.new(match) if group.empty? or match.present?
          break if match.nil?
          metar_copy.slice!(match[0])
        end
        group.count > 1 ? group : group.first
      end
    end

    group :time, matches: /(\d{2})(\d{2})(\d{2})Z/
    group :wind, matches: /(VRB|\d{3})(\d{2}|\d{2}G\d{2})(KT|MPS)( (\d{3})V(\d{3}))?/
    group :visibility, matches: /\s(\d{4})\s/
    group :rvr, matches: /R(\d{2}[RLC]?)\/([\/V\dUDNPM]*)/
    group :cavok, matches: /\s(CAVOK)\s/

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