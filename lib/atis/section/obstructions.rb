class ATIS::Section::Obstructions < ATIS::Section::Base

  uses :metar, group: :obstructions

  format :en do |f|

    metar.obstructions.each do |o|
      f.block o.obstacle
      f.block :obscured
    end

  end

  format :ru do |f|

    metar.obstructions.each do |o|
      f.block o.obstacle
      f.block :obscured
    end

  end

end