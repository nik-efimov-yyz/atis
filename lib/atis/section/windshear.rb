class ATIS::Section::Windshear < ATIS::Section::Base

  uses :metar, group: :windshear

  format :en do

    case windshear.runway
      when :all
        block :windshear
        block :all_runways
      else
        common_windshear_blocks
    end
  end

  format :ru do

    case windshear.runway
      when :all
        block :all_runways
        block :windshear
      else
        common_windshear_blocks
    end
  end

  def common_windshear_blocks
    runway_number, side = windshear.runway.split(/(L|R|C)/)
    block :windshear
    block :runway, scope: :runway
    block runway_number
    block side.downcase.to_sym, scope: :runway if side.present?
  end

  def windshear
    source.first
  end

end