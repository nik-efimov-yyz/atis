class ATIS::Section::Aerodrome < ATIS::Section::Base

  format :en do
    block airport.icao
  end

  format :ru do
    block airport.icao
  end

  def airport
    metar.aerodrome.first
  end

end