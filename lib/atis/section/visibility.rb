class ATIS::Section::Visibility < ATIS::Section::Base

  uses :metar, group: :visibility

  format :en do
    "English visibility stuff"
  end

  format :ru do |f|
    f.block :prefix

    if visibility.unlimited?
      f.block :unlimited
    else
      add_visibility_range_to f
    end
  end

  def visibility
    metar.visibility.first
  end

  def add_visibility_range_to(f)
    if visibility.visibility < 5000
      f.block visibility.visibility
    else
      f.block (visibility.visibility.to_f * 0.001).to_i
      f.block :kilometers
    end
  end

end