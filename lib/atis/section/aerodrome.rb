class ATIS::Section::Aerodrome < ATIS::Section::Base

  format [:en, :ru] do
    block airport.icao
  end

  def airport
    metar.aerodrome.first
  end

end