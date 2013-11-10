class ATIS::Message::Block::Wind < ATIS::Message::Block

  format :en do
    "English cloud stuff"
  end

  format :ru do
    blocks = [":prefix"]
    case
      when wind.calm?
        blocks << ":calm"
      when wind.variable?
        add_variable_wind_blocks_to blocks
      when wind.direction
        blocks << wind.direction
        blocks << ":degrees"
    end

    add_wind_speed_blocks_to blocks unless wind.calm?

    blocks.map { |b| "[#{b}]" }.join(" ")
  end

  def wind
    metar.wind.first
  end

  def add_wind_speed_blocks_to(blocks)
    if wind.gusting?
      blocks << wind.gusts.min
      blocks << ":gusting_to"
      blocks << wind.gusts.max
    else
      blocks << wind.speed
    end
  end

  def add_variable_wind_blocks_to(blocks)
    blocks << ":variable"
    if wind.variable_from
      blocks << ":variable_from"
      blocks << wind.variable_from
    end

    if wind.variable_to
      blocks << ":variable_to"
      blocks << wind.variable_to
      blocks << ":degrees"
    end
  end

end