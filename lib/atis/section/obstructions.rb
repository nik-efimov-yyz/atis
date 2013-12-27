class ATIS::Section::Obstructions < ATIS::Section::Base

  uses :metar, group: :obstructions

  format [:en, :ru] do

    metar.obstructions.each do |o|
      block o.obstacle
      block :obscured
    end

  end

end