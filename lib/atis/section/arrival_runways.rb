class ATIS::Section::ArrivalRunways < ATIS::Section::RunwayInformation

  uses :arrival_runways

  format :en do

    message.arrival_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      text runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

      if rwy_cond = en_runway_condition_for(rwy)
        text rwy_cond
      end

    end

  end

  format :ru do

    message.arrival_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      rwy_number_conversion runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

      if rwy_cond = ru_runway_condition_for(rwy)
        text rwy_cond
      end

    end

  end

end