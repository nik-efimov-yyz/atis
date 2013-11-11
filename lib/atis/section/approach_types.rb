class ATIS::Section::ApproachTypes < ATIS::Section::Base

  format :ru do |f|
    message.approach_types.each do |t|
      f.block :prefix
      f.block t.downcase.to_sym
    end
  end

end