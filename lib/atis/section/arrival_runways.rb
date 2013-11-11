class ATIS::Section::ArrivalRunways < ATIS::Section::RunwayInformation

  uses :arrival_runways

  format :ru do |f|

    message.arrival_runways.each do |rwy|

      f.block :prefix

      runway_number, side = rwy.split(/(L|R|C)/)
      f.block runway_number
      f.block side.downcase.to_sym if side.present?

      if rwy_cond = runway_condition_for(rwy)
        f.text rwy_cond
      end

    end

  end

end