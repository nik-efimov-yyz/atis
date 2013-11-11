class ATIS::Section::Wind < ATIS::Section::Base

  uses :metar, group: :wind

  format :en do
    "English cloud stuff"
  end

  format :ru do |f|
    f.block :prefix
    case
      when wind.calm?
        f.block :calm
      when wind.variable?
        add_variable_wind_blocks_to f
      when wind.direction
        f.block wind.direction
        f.block :degrees
    end
    add_wind_speed_blocks_to f unless wind.calm?
  end

  def wind
    metar.wind.first
  end

  def add_wind_speed_blocks_to(f)
    if wind.gusting?
      f.block wind.gusts.min
      f.block :gusting_to
      f.block wind.gusts.max
    else
      f.block wind.speed
    end
  end

  def add_variable_wind_blocks_to(f)
    f.block :variable
    if wind.variable_from
      f.block :variable_from
      f.block wind.variable_from
    end

    if wind.variable_to
      f.block :variable_to
      f.block wind.variable_to
      f.block :degrees
    end
  end

end