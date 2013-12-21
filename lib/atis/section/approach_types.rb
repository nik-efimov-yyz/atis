class ATIS::Section::ApproachTypes < ATIS::Section::Base

  format :en do |f|
    f.block :expect
    message.approach_types.each do |t|
      f.block t.downcase.to_sym
    end
    f.block :approach
  end

  format :ru do |f|
    message.approach_types.each do |t|
      f.block :prefix
      f.block t.downcase.to_sym
    end
  end

end