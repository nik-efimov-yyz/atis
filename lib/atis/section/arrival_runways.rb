class ATIS::Section::ArrivalRunways < ATIS::Section::RunwayInformation

  uses :arrival_runways

  format :en do |f|

    message.arrival_runways.each do |rwy|

      f.block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      f.text runway_number
      f.block side.downcase.to_sym, scope: :runway if side.present?

      if rwy_cond = en_runway_condition_for(rwy)
        f.text rwy_cond
      end

    end

  end

  format :ru do |f|

    message.arrival_runways.each do |rwy|

      f.block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      f.block runway_number
      f.block side.downcase.to_sym, scope: :runway if side.present?

      if rwy_cond = ru_runway_condition_for(rwy)
        f.text rwy_cond
      end

    end

  end

end