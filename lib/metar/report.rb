require "open-uri"

class METAR::Report
  include METAR::Report::Extensions

  attr_accessor :metar, :trend

  alias :raw :metar
  alias :to_s :metar

  def initialize(icao_or_metar, options = {})
    @options = options.reverse_merge(source: :vatsim)
    @metar = icao_or_metar.length <= 4 ? fetch(icao_or_metar) : icao_or_metar
    @metar = @metar + " "
    clean_up

  end

  group :aerodrome, matches: /^[A-Z]{4}\s/
  group :time, matches: /\s(\d{2})(\d{4})Z\s/
  group :wind, matches: /\s(VRB|\d{3})(\d{2}|\d{2}G\d{2})(KT|MPS)( (\d{3})V(\d{3}))?\s/
  group :visibility, matches: /\sP?(\d{1,4})(SM)?\s/
  group :rvr, matches: /\sR(\d{2}[RLC]?)\/(M|P)?(\d{4})(V?)(P?)(\d{4}?)(U|D|N)?\s/
  group :phenomena, matches: /\s(\+|-|VC)?(#{METAR::Node::Phenomena::DESCRIPTORS.join("|")})?(#{METAR::Node::Phenomena::PHENOMENA.join("|")})\s/
  group :sky_condition, matches: /\s(SKC|NSC|(FEW|SCT|BKN|OVC|VV)(\d{3})(TCU|CB)?)\s/
  group :obstructions, matches: /\s(MAST|MT|OBST|OBST PT) OBSC\s/, in: :trend
  group :temperature, matches: /\s(M?\d{2})\/(M?\d{2})\s/
  group :pressure, matches: /\s(A|Q)(\d{4})\s/
  group :runway_condition, matches: /\sR?(\d{2}(?:L|R|C)?)\/?(\d{1}|\/{1}|C)(\d{1}|\/{1}|L)(\d{2}|\/{2}|RD)(\d{2}|\/{2})\s/
  group :cavok, matches: /\s(CAVOK)\s/
  group :qbb, matches: /\sQBB(\d{3})\s/, in: [:metar, :trend]
  group :windshear, matches: /\sWS (ALL RWY|RWY (\d{2}(?:L|R|C)))\s/
  group :icing, matches: /\s(MOD|FBL|SEV)\s(ICE)\s(?:(INC)(?:\((.*)\))?\s?)?(?:(\d{1,4})M?-(\d{1,4})M?)?\s/, in: [:metar, :trend]
  group :turbulence, matches: /\s(MOD|FBL|SEV)\s(TURB)\s(?:(INC|IAO)(?:\((.*)\))?\s?)?(?:(\d{1,4})M?-(\d{1,4})M?)?\s/, in: [:metar, :trend]

  private

  def fetch(icao_code)
    case @options[:source]
      when :vatsim
        open("http://metar.vatsim.net/#{icao_code.to_s}").read
      else
        raise "Unknown Online METAR Source"
    end
  end

  def clean_up
    @metar, separator, @trend = @metar.split(/(TEMPO|BECMG|NOSIG)/)
  end

end