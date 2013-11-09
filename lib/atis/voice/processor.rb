class ATIS::Voice::Processor

  def initialize(metar)
    @metar = metar
  end

  def compile_from_groups(groups)
    groups.map { |g| @metar.send(g).to_voice }.compact.join(" ")
  end

end