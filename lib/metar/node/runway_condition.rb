class METAR::Node::RunwayCondition < METAR::Node::Base


  property :runway do
    case
      when match[1] == "88"
        :all
      when match[1].to_i > 50 && match[1].to_i < 60
        "0#{match[1].to_i - 50}R"
      when match[1].to_i >= 60
        "#{match[1].to_i - 50}R"
      else
        match[1]
    end
  end

  property :condition do
    case match[2]
      when "C", "0"
        :clear_and_dry
      when "1"
        :damp
      when "2"
        :wet
      when "3"
        :frost
      when "4"
        :dry_snow
      when "5"
        :wet_snow
      when "6"
        :slush
      when "7"
        :ice
      when "8"
        :compacted_snow
      when "9"
        :rough_ice
      else
        nil
    end
  end

  property :coverage do
    case match[3]
      when "1"
        0..10
      when "2"
        11..25
      when "3"
        26..50
      when "5"
        26..50
      when "9"
        51..100
      else
        nil
    end
  end

  property :depth do
    case
      when ["RD", "//"].include?(match[4])
        nil
      when match[4].to_i <= 90
        match[4].to_i
      when match[4].to_i > 98
        nil
      else
        (match[4].to_i - 90) * 50
    end

  end

  property :braking_action do
    if match[5] == "//"
      nil
    else
      case match[5].to_i
        when 0..25, 91
          :poor
        when 26..29, 92
          :poor_to_medium
        when 30..35, 93
          :medium
        when 36..39, 94
          :medium_to_good
        when 40..90, 95
          :good
        else
          nil
      end
    end

  end

  property :friction_index do
    if match[5] == "//"
      nil
    else
      case match[5].to_i
        when 0..90
          sprintf("%.2f", match[5].to_i * 0.01)
        else
          nil
      end
    end

  end



end