class ATIS::Section::Aerodrome < ATIS::Section::Base

  format :en do
    "English cloud stuff"
  end

  format :ru do |f|
    f.block airport.icao
  end

  def airport
    metar.aerodrome.first
  end

end