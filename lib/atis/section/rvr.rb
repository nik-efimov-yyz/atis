class ATIS::Section::Rvr < ATIS::Section::Base

  uses :metar, group: :rvr

  format :en do
    "English visibility stuff"
  end

  format :ru do |f|
    f.block :prefix
    metar.rvr.each do |rvr|
      f.block rvr.runway_number
      f.block rvr.runway_suffix.downcase.to_sym, scope: :runway if rvr.runway_suffix.present?

      if rvr.variable?
        f.block :variable
        f.block :from
        f.block :minimum if rvr.minimum?
        f.block rvr.visibility.min
        f.block :to
        f.block :peak if rvr.peak?
        f.block rvr.visibility.max
      else
        f.block :peak if rvr.peak?
        f.block :minimum if rvr.minimum?
        f.block rvr.visibility
      end

      f.block rvr.trend if rvr.trend.present?
    end
  end

end