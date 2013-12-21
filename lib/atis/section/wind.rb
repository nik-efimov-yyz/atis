class ATIS::Section::Wind < ATIS::Section::Base

  uses :metar, group: :wind

  format :en do
    block :prefix
    case
      when wind.calm?
        block :calm
      when wind.variable?
        add_variable_wind_blocks_to_en
      when wind.direction
        text wind.direction
        block :degrees
    end
    add_wind_speed_blocks_to_en unless wind.calm?
  end

  format :ru do
    block :prefix
    case
      when wind.calm?
        block :calm
      when wind.variable?
        add_variable_wind_blocks
      when wind.direction
        block wind.direction
        block :degrees
    end
    add_wind_speed_blocks unless wind.calm?
  end

  def wind
    source.first
  end

  def add_wind_speed_blocks
    if wind.gusting?
      block wind.gusts.min
      block :gusting_to
      block wind.gusts.max
    else
      block wind.speed
    end
  end

  def add_wind_speed_blocks_to_en
    if wind.gusting?
      text wind.gusts.min
      block :gusting_to
      text wind.gusts.max
    else
      text wind.speed
    end
    block :mps
  end

  def add_variable_wind_blocks
    block :variable
    if wind.variable_from
      block :variable_from
      block wind.variable_from
    end

    if wind.variable_to
      block :variable_to
      block wind.variable_to
      block :degrees
    end
  end

  def add_variable_wind_blocks_to_en
    block :variable
    if wind.variable_from
      block :variable_from
      text wind.variable_from
    end

    if wind.variable_to
      block :variable_to
      text wind.variable_to
      block :degrees
    end
  end

end