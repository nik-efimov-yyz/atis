class ATIS::Section::Visibility < ATIS::Section::Base

  uses :metar, group: :visibility

  format :en do
    block :prefix

    case
      when visibility.greater?
        block :greater
      when visibility.less?
        block :less
    end

    case
      when visibility.unlimited?
        block :unlimited
      when visibility.less_than_50?
        block :less_than_50
        block :meters, scope: :units
      else
        if visibility.visibility.to_i < 5000
          block visibility.visibility
          block :meters, scope: :units
        else
          block (visibility.visibility.to_f * 0.001).to_i
          block :kilometers
        end
      end
    end

  format :ru do
    block :prefix
    case
      when visibility.greater?
        block :greater
      when visibility.less?
        block :less
    end
    case
      when visibility.unlimited?
        block :unlimited
      when visibility.less_than_50?
        block :less_than_50
      else
        add_visibility_range_to
      end
    end

  def visibility
    source.first
  end


  def add_visibility_range_to
    if visibility.visibility.to_i < 5000
      number_conversion visibility.visibility.to_i
    else
      number_conversion (visibility.visibility.to_f * 0.001).to_i
      block :kilometers
    end
  end

end