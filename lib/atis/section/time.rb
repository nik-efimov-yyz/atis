class ATIS::Section::Time < ATIS::Section::Base

  uses :metar, group: :time

  format :en do |f|
    f.text time.time
  end

  format :ru do |f|
    tens_hours, hours, tens_minutes, minutes = time.time.to_s.split('')
    case
      when tens_hours.to_i != 0
        f.block (tens_hours + hours)
        case
          when tens_minutes.to_i != 0
            f.block (tens_minutes + minutes)
          else
            f.block tens_minutes
            f.block minutes
        end
      else
        f.block tens_hours
        f.block hours
        case
          when tens_minutes.to_i != 0
            f.block (tens_minutes + minutes)
          else
            f.block tens_minutes
            f.block minutes
        end
    end
  end

  def time
    metar.time.first
  end

end