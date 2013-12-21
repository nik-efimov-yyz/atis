class ATIS::Section::Base

  attr_accessor :message

  def initialize(message, options = {})
    @message, @options = message, options
    @blocks = []
  end

  class << self

    def format(languages, &block)
      @formats ||= {}
      languages = [languages] unless languages.is_a?(Array)
      languages.each do |language|
        @formats[language] = block
      end

    end

    def formats
      @formats
    end

    def uses(name, options = {})
      @source = name
      @source_options = options
    end

    def source
      @source
    end

    def source_options
      @source_options
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

  def render_in(language = :en)
    raise "format not specified for #{language} in #{self.class}" unless formats[language].present?

    return if source_empty?

    # Calling the appropriate format to load up blocks
    instance_exec @options, &formats[language]
    @blocks.map { |b| b.render locale: language, scope: self.class.name.demodulize.downcase.to_sym }.join(" ")
  end

  def source
    if self.class.source.present?
      src = self.class.source_options[:group].present? ? metar.send(self.class.source_options[:group], @options) : message.send(self.class.source)
      src = src.send(:first) if self.class.source_options[:first]
      src
    end
  end

  def source_empty?
    self.class.source.present? && !source.present?
  end

  def human_number_blocks_for(number)
    number = number.to_i
    if number >= 1000
      block (number/1000).to_s.to_sym, scope: :numbers
      block :thousand, scope: :numbers
    end
    if number >= 100 and number % 1000 > 0
      block ((number % 1000) / 100).to_s.to_sym, scope: :numbers
      block :hundred, scope: :numbers
    end
    block (number % 100).to_s.to_sym, scope: :numbers if number % 100 > 0
  end

  def spaced_number_blocks_for(number)
    number = number.to_s
    if number[-2] == "0"
      number.split("").each { |c| block " " + c }
    else
      block number
    end
  end

end