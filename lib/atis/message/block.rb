class ATIS::Message::Block

  class_attribute :formats
  self.formats = {}

  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def self.format(language, &block)
    proc = Proc.new {
      raw = self.instance_eval &block
      if raw
        raw.gsub(/:([0-9a-zA-Z_]+)/) do |match|
          I18n.translate $1, locale: language, scope: self.class.name.demodulize.downcase
        end
      end
    }
    self.formats = self.formats.merge(language => proc )
  end

  def text_in(language = :en)
    self.instance_eval &formats[language]
  end

  def metar
    @message.metar
  end


end