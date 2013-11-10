class ATIS::Message::Block::Visibility < ATIS::Message::Block

  format :en do
    "English visibility stuff"
  end

  format :ru do
    blocks = [":prefix"]

    if visibility.unlimited?
      blocks << ":unlimited"
    else
      add_visibility_range_to blocks
    end
    blocks.compact.map { |b| "[#{b}]" }.join(" ")
  end

  def visibility
    metar.visibility.first
  end

  def add_visibility_range_to(blocks)
    if visibility.visibility < 5000
      blocks << visibility.visibility
    else
      blocks << (visibility.visibility.to_f * 0.001).to_i
      blocks << ":kilometers"
    end
  end


end