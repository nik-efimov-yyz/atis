class ATIS::Section::DepartureRunways < ATIS::Section::RunwayInformation

  uses :departure_runways

  format :en do
    block :prefix
    message.departure_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      text runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

      if !message.arrival_runways.include?(rwy) and rwy_cond = en_runway_condition_for(rwy)
        text rwy_cond
      end

    end
  end

  format :ru do
    block :prefix
    message.departure_runways.each do |rwy|

      block :runway, scope: :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      block runway_number
      block side.downcase.to_sym, scope: :runway if side.present?

      if !message.arrival_runways.include?(rwy) and rwy_cond = ru_runway_condition_for(rwy)
        text rwy_cond
      end

    end
  end

end