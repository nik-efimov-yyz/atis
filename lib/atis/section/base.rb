class ATIS::Section::Base

  attr_accessor :message

  def initialize(message)
    @message = message
    @blocks = []
  end

  class << self

    def format(language, &block)
      @formats ||= {}
      @formats[language] = block
    end

    def formats
      @formats
    end

    def uses(name, options = {})
      @source = name
      @metar_group = options[:group]
    end

    def source
      @source
    end

    def metar_group
      @metar_group
    end

  end

  def add_block(content, options = {})
    @blocks << ATIS::Block.new(content, options)
  end

  alias :block :add_block

  def add_text(content)
    @blocks << ATIS::Text.new(content)
  end

  alias :text :add_text

  def formats
    self.class.formats
  end

  def metar
    @message.metar
  end

  def render_in(language = :en, options = {})
    raise "format not specified for #{language} in #{self.class}" unless formats[language].present?

    return "" if source_empty?

    # Calling the appropriate format to load up blocks
    instance_exec self, options, &formats[language]
    @blocks.map { |b| b.render locale: language, scope: self.class.name.demodulize.downcase.to_sym }.join(" ")
  end

  def source
    if self.class.source.present?
      self.class.metar_group.present? ? metar.send(self.class.metar_group) : message.send(self.class.source)
    end
  end

  def source_empty?
    self.class.source.present? && !source.present?
  end

end