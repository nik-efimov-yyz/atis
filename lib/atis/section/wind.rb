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
        add_variable_wind_blocks_to_ru
      when wind.direction
        number_conversion wind.direction
        block :degrees
    end
    add_wind_speed_blocks_to_ru unless wind.calm?
  end

  def wind
    source.first
  end

  def add_wind_speed_blocks_to_ru
    if wind.gusting?
      if wind.gusts.min.to_s.length < 2
        digit_conversion wind.gusts.min
      else
        number_conversion wind.gusts.min
      end
      block :gusting_to
      if wind.gusts.max.to_s.length < 2
        digit_conversion wind.gusts.max
      else
        number_conversion wind.gusts.max
      end
    else
      if wind.speed.to_s.length < 2
        digit_conversion wind.speed
      else
        number_conversion wind.speed
      end
    end
  end

  def add_wind_speed_blocks_to_en
    if wind.gusting?
      text wind.gusts.min
      block :gusting
      block :to
      text wind.gusts.max
    else
      text wind.speed
    end
    block :mps
  end

  def add_variable_wind_blocks_to_ru
    block :variable
    if wind.variable_from
      block :variable_from
      number_conversion wind.variable_from
    end

    if wind.variable_to
      block :variable_to
      number_conversion wind.variable_to
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