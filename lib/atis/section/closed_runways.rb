class ATIS::Section::ClosedRunways < ATIS::Section::Base

  uses :closed_runways

  format :en do

    message.closed_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      text runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

    end

    block :closed, scope: :extrainformation

  end


  format :ru do

    count = 0

    message.closed_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      rwy_number_conversion runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

      count += 1
    end

    if count >= 2
      block :closed_plural, scope: :extrainformation
    else
      block :closed_singular, scope: :extrainformation
    end

  end

end