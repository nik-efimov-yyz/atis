class ATIS::Section::Windshear < ATIS::Section::Base

  uses :metar, group: :windshear

  format :en do |f|

    case windshear.runway
      when :all
        f.block :windshear
        f.block :all_runways
      else
        runway_number, side = windshear.runway.split(/(L|R|C)/)
        f.block :windshear
        f.block :runway, scope: :runway
        f.block runway_number
        f.block side.downcase.to_sym, scope: :runway if side.present?
    end
  end

  format :ru do |f|

    case windshear.runway
      when :all
        f.block :all_runways
        f.block :windshear
      else
        runway_number, side = windshear.runway.split(/(L|R|C)/)
        f.block :windshear
        f.block :runway, scope: :runway
        f.block runway_number
        f.block side.downcase.to_sym, scope: :runway if side.present?
    end
  end

  def windshear
    source.first
  end

end