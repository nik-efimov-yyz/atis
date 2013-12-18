class ATIS::Message

  DEFAULT_MESSAGE_SECTIONS = [
      :aerodrome,
      :message_index,
      :approach_types,
      :arrival_runways,
      :departure_runways,
      :transition_level,
      :extra_information,
      :wind,
      :cavok,
      :visibility,
      :rvr,
      :phenomena,
      :sky_condition,
      :obstructions,
      :temperature,
      :pressure,
      :windshear,
      :icing,
      :turbulence
  ]

  attr_accessor :sections, :metar, :options

  def initialize(metar_or_airport_code, options = {})
    @metar = METAR::Report.new(metar_or_airport_code)
    @sections = DEFAULT_MESSAGE_SECTIONS
    @options = options
  end

  def render_in(language = :en)
    sections.inject([]) do |array, section_name|
      section = "ATIS::Section::#{section_name.to_s.camelize}".constantize.new(self)
      array << section.render_in(language)
    end.join(" ")
  end

  def index
    @options[:index] && @options[:index].to_sym
  end

  def arrival_runways
    @options[:arrival_runways] ||= []
  end

  def approach_types
    @options[:approach_types] ||= []
  end

  def departure_runways
    @options[:departure_runways] ||= []
  end

  def transition_level
    @options[:transition_level] ||= []
  end

  def extra
    @options[:extra] ||= []
  end

end