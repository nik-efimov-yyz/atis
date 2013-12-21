class ATIS::Section::DepartureRunways < ATIS::Section::RunwayInformation

  uses :departure_runways

  format :en do |f|
    f.block :prefix
    message.departure_runways.each do |rwy|

      f.block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      f.text runway_number
      f.block side.downcase.to_sym, scope: :runway if side.present?

      if !message.arrival_runways.include?(rwy) and rwy_cond = en_runway_condition_for(rwy)
        f.text rwy_cond
      end

    end
  end

  format :ru do |f|
    f.block :prefix
    message.departure_runways.each do |rwy|

      f.block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      f.block runway_number
      f.block side.downcase.to_sym, scope: :runway if side.present?

      if !message.arrival_runways.include?(rwy) and rwy_cond = ru_runway_condition_for(rwy)
        f.text rwy_cond
      end

    end
  end

end