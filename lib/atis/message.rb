class ATIS::Message

  include ATIS::Message::Sectionable

  section :aerodrome
  section :message_index
  section :time
  section :approach_types
  section :arrival_runways
  section :departure_runways
  section :transition_level
  section :extra_information
  section :wind
  section :cavok
  section :visibility
  section :rvr
  section :phenomena
  section :sky_condition
  section :obstructions
  section :temperature
  section :pressure
  section :windshear
  section :icing
  section :turbulence
  section :trend
  section :wind, from: :trend
  section :visibility, from: :trend
  section :phenomena, from: :trend
  section :sky_condition, from: :trend
  section :message_end

  attr_accessor :metar, :options

  def initialize(metar_or_airport_code, options = {})
    @metar = METAR::Report.new(metar_or_airport_code)
    @options = options
  end

  def render_in(language = :en)
    self.class.sections.inject([]) do |array, section_hash|
      section = "ATIS::Section::#{section_hash[:name].to_s.camelize}".constantize.new(self, section_hash[:options])
      array << section.render_in(language)
    end.compact.join(" ")
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

  def report_pressure_in
    @options[:report_pressure_in] ||= ["QFE"]
  end

  def languages
    @options[:languages] ||= ["ru", "en"]
  end

end