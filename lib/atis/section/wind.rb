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
        text sprintf("%03d", wind.direction.to_i)
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
        digit_conversion(wind.gusts.min)
      else
        number_conversion(wind.gusts.min)
      end
      block :gusting_to
      if wind.gusts.max.to_s.length < 2
        digit_conversion(wind.gusts.max)
      else
        number_conversion(wind.gusts.max)
      end
      units_ru(wind.gusts.max)
    else
      if wind.speed.to_s.length < 2
        digit_conversion(wind.speed)
      else
        number_conversion(wind.speed)
      end
      units_ru(wind.speed)
    end
  end

  def add_wind_speed_blocks_to_en
    if wind.gusting?
      text(wind.gusts.min)
      block :gusting
      block :to
      text(wind.gusts.max)
      units_en(wind.gusts.max)
    else
      text(wind.speed)
      units_en(wind.speed)
    end
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
      text sprintf("%03d", wind.variable_from.to_i)
    end

    if wind.variable_to
      block :variable_to
      text sprintf("%03d", wind.variable_to.to_i)
      block :degrees
    end
  end

  def mps_from(speed)
    case wind.units
      when "KT"
        (speed.to_i * 0.514).round(0)
      else
        speed.round(0)
      end
  end

  def units_en(speed)
    case wind.units
      when "KT"
        if speed == 1
          block :knot
        else
          block :knots
        end
      when "MPS"
        block :mps
    end
  end

  def units_ru(speed)
    case wind.units
      when "KT"
        if speed.to_i == 1 or speed.to_i % 10 == 1 and speed.to_i != 11
          block :knots_1
        elsif (2..4).include?(speed.to_i) or (2..4).include?(speed.to_i % 10 ) and (not (12..14).include?(speed.to_i))
          block :knots_2_4
        else
          block :knots
        end
      when "MPS"
    end
  end
end