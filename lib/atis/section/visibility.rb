class ATIS::Section::Visibility < ATIS::Section::Base

  uses :metar, group: :visibility

  format :en do |f|
    f.block :prefix

    case
      when visibility.unlimited?
        f.block :unlimited
      when visibility.less_than_50?
        f.block :less_than_50
        f.block :meters, scope: :units
      else
        if visibility.visibility.to_i < 5000
          human_number_blocks_for visibility.visibility
        else
          f.text (visibility.visibility.to_f * 0.001).to_i
          f.block :kilometers
        end
      end
    end

  format :ru do |f|
    f.block :prefix
    case
      when visibility.unlimited?
        f.block :unlimited
      when visibility.less_than_50?
        f.block :less_than_50
      else
        add_visibility_range_to_ru f
      end
    end

  def visibility
    metar.visibility.first
  end

  def add_visibility_range_to_en(f)

  end

  def add_visibility_range_to_ru(f)
    if visibility.visibility.to_i < 5000
      f.block visibility.visibility.to_i
    else
      f.block (visibility.visibility.to_f * 0.001).to_i
      f.block :kilometers
    end
  end

end