class ATIS::Section::Temperature < ATIS::Section::Base

  uses :metar, group: :temperature

  format :en do
    block :prefix
    block :minus, scope: :numbers if temperature.temperature < 0
    text temperature.temperature.abs
    block :dew_point
    block :minus, scope: :numbers if temperature.dew_point < 0
    text temperature.dew_point.abs
  end

  format :ru do
    block :prefix
    block :minus, scope: :numbers if temperature.temperature < 0
    if temperature.temperature.abs.to_s.length < 2
      digit_conversion temperature.temperature.abs
    else
      number_conversion temperature.temperature.abs
    end
    block :dew_point
    block :minus, scope: :numbers if temperature.dew_point < 0
    if temperature.dew_point.abs.to_s.length < 2
      digit_conversion temperature.dew_point.abs
    else
      number_conversion temperature.dew_point.abs
    end
  end

  def temperature
    source.first
  end

end