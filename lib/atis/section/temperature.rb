class ATIS::Section::Temperature < ATIS::Section::Base

  uses :metar, group: :temperature

  format :en do |f|
    f.block :prefix
    f.block :minus, scope: :numbers if temperature.temperature < 0
    f.text temperature.temperature.abs
    f.block :dew_point
    f.block :minus, scope: :numbers if temperature.dew_point < 0
    f.text temperature.dew_point.abs
  end

  format :ru do |f|
    f.block :prefix
    f.block :minus, scope: :numbers if temperature.temperature < 0
    f.text temperature.temperature.abs
    f.block :dew_point
    f.block :minus, scope: :numbers if temperature.dew_point < 0
    f.text temperature.dew_point.abs
  end

  def temperature
    source.first
  end

end