class ATIS::Block

  def initialize(content, options = {})
    @content, @options = content, options
  end

  def render(i18n_options = {})
    i18n_options.merge!(@options)
    @content = I18n.t @content, i18n_options if @content.is_a?(Symbol)
    @content = "[#{@content}]"
  end

end