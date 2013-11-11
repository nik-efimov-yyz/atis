class ATIS::Section::Temperature < ATIS::Section::Base

  uses :metar, group: :temperature

  format :ru do |f|
    f.block :prefix
    f.block :minus, scope: :numbers if temperature.temperature < 0
    f.block temperature.temperature.abs
    f.block :dew_point
    f.block :minus, scope: :numbers if temperature.dew_point < 0
    f.block temperature.dew_point.abs
  end

  def temperature
    source.first
  end

end