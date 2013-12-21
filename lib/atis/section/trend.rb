class ATIS::Section::Trend < ATIS::Section::Base

  format [:en, :ru] do
    block metar.trend_type.downcase.to_sym
  end

  def source_empty?
    !metar.trend.present?
  end

end