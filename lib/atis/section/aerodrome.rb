class ATIS::Section::Aerodrome < ATIS::Section::Base

  format :en do |f|
    f.block airport.icao
  end

  format :ru do |f|
    f.block airport.icao
  end

  def airport
    metar.aerodrome.first
  end

end