class ATIS::Section::Time < ATIS::Section::Base

  uses :metar, group: :time, first: true

  format :en do
    text source.time
  end

  format :ru do
    if source.hours.to_i > 9
      number_conversion source.hours
    else
      digit_conversion source.hours
    end
    if source.minutes.to_i > 9
      number_conversion source.minutes
    else
      digit_conversion source.minutes
    end
  end

end