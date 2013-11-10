class ATIS::Message

  attr_accessor :blocks, :metar

  def initialize(metar_or_airport_code, options = {})
    @metar = ATIS::METAR.new(metar_or_airport_code)
    @blocks = [
      ATIS::Message::Block::Airport.new(self),
      ATIS::Message::Block::Wind.new(self),
      ATIS::Message::Block::Visibility.new(self),
      ATIS::Message::Block::Rvr.new(self),
      ATIS::Message::Block::SkyCondition.new(self)
    ]
  end

  def text_in(language = :en)
    blocks.inject("") do |message, block|
      block_text = block.text_in(language)
      message << block_text if block_text.present?
      message
    end
  end

end