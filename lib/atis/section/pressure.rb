class ATIS::Section::Pressure < ATIS::Section::Base

  uses :metar, group: :pressure

  format :ru do |f|
    f.block :prefix
    f.text mm_from_hpa(qfe_from(pressure.pressure))
    f.block :or
    f.text qfe_from(pressure.pressure)
    f.block :hpa
  end

  def pressure
    source.first
  end

  def qfe_from(qnh)
    qnh = qnh.to_i
    airport = Airport.where(icao: metar.aerodrome.first.icao).first
    return qnh unless airport.present?

    (qnh*(((288-(0.0065*Converter.feet_to_meters(airport.elevation)))/288)**5.2561)).round

  end

  def mm_from_hpa(hpa)
    (hpa * 0.750098697).round
  end
end