class ATIS::Section::Obstructions < ATIS::Section::Base

  uses :metar, group: :obstructions

  format :en do

    metar.obstructions.each do |o|
      block o.obstacle
      block :obscured
    end

  end

  format :ru do

    metar.obstructions.each do |o|
      block o.obstacle
      block :obscured
    end

  end

end