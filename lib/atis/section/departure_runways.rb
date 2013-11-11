class ATIS::Section::DepartureRunways < ATIS::Section::RunwayInformation

  uses :departure_runways

  format :ru do |f|
    f.block :prefix
    message.departure_runways.each do |rwy|

      f.block :runway

      runway_number, side = rwy.split(/(L|R|C)/)
      f.block runway_number
      f.block side.downcase.to_sym if side.present?

      if !message.arrival_runways.include?(rwy) and rwy_cond = runway_condition_for(rwy)
        f.text rwy_cond
      end

    end
  end

end