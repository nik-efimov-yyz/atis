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
    block temperature.temperature.abs
    block :dew_point
    block :minus, scope: :numbers if temperature.dew_point < 0
    block temperature.dew_point.abs
  end

  def temperature
    source.first
  end

end