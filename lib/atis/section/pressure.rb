class ATIS::Section::Pressure < ATIS::Section::Base

  uses :metar, group: :pressure

  format :ru do |f|
    message.report_pressure_in.each do |pressure_type|
      if message.report_pressure_in == ["QFE"]
        f.block :pressure
      else
        f.block pressure_type.downcase.to_sym
      end

      case pressure_type.downcase.to_sym
        when :qfe
          f.text mm_from_hpa(qfe_from(pressure.pressure))
          f.block :or
          f.text qfe_from(pressure.pressure)
          f.block :hpa
        when :qnh
          f.text pressure.pressure
          f.block :hpa
          f.block :or
          f.text mm_from_hpa(pressure.pressure)
      end

    end
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
    (hpa.to_i * 0.750098697).round
  end
end