class ATIS::Section::Rvr < ATIS::Section::Base

  uses :metar, group: :rvr

  format :en do |f|
    f.block :prefix
    metar.rvr.each do |rvr|
      f.block :runway, scope: :runway
      f.block rvr.runway_number
      f.block rvr.runway_suffix.downcase.to_sym, scope: :runway if rvr.runway_suffix.present?

      if rvr.variable?
        f.block :variable
        f.block :from
        f.block :minimum if rvr.minimum?
        human_number_blocks_for rvr.visibility.min
        f.block :to
        f.block :peak if rvr.peak?
        human_number_blocks_for rvr.visibility.max
      else
        f.block :peak if rvr.peak?
        f.block :minimum if rvr.minimum?
        human_number_blocks_for rvr.visibility
      end

      f.block rvr.trend if rvr.trend.present?
    end
  end

  format :ru do |f|
    f.block :prefix
    metar.rvr.each do |rvr|
      f.block :runway, scope: :runway
      f.block rvr.runway_number
      f.block rvr.runway_suffix.downcase.to_sym, scope: :runway if rvr.runway_suffix.present?

      if rvr.variable?
        f.block :variable
        f.block :from
        f.block :minimum if rvr.minimum?
        f.block rvr.visibility.min.to_i
        f.block :to
        f.block :peak if rvr.peak?
        f.block rvr.visibility.max.to_i
      else
        f.block :peak if rvr.peak?
        f.block :minimum if rvr.minimum?
        f.block rvr.visibility.to_i
      end

      f.block rvr.trend if rvr.trend.present?
    end
  end

end