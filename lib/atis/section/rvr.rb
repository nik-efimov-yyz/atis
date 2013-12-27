class ATIS::Section::Rvr < ATIS::Section::Base

  uses :metar, group: :rvr

  format :en do
    block :prefix
    metar.rvr.each do |rvr|
      block :runway, scope: :runway
      block rvr.runway_number
      block rvr.runway_suffix.downcase.to_sym, scope: :runway if rvr.runway_suffix.present?

      if rvr.variable?
        block :variable
        block :from
        block :minimum if rvr.minimum?
        block rvr.visibility.min
        block :to
        block :peak if rvr.peak?
        block rvr.visibility.max
      else
        block :peak if rvr.peak?
        block :minimum if rvr.minimum?
        block rvr.visibility
      end

      block rvr.trend if rvr.trend.present?
    end
  end

  format :ru do
    block :prefix
    metar.rvr.each do |rvr|
      block :runway, scope: :runway
      rwy_number_conversion rvr.runway_number
      block rvr.runway_suffix.downcase.to_sym, scope: :runway if rvr.runway_suffix.present?

      if rvr.variable?
        block :variable
        block :from
        block :minimum if rvr.minimum?
        number_conversion rvr.visibility.min
        block :to
        block :peak if rvr.peak?
        number_conversion rvr.visibility.max
      else
        block :peak if rvr.peak?
        block :minimum if rvr.minimum?
        number_conversion rvr.visibility
      end

      block rvr.trend if rvr.trend.present?
    end
  end

end