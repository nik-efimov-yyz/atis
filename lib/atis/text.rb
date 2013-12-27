class ATIS::Text

  def initialize(content, options = {})
    @content, @options = content, options
  end

  def render(options = {})
    @content
  end

end