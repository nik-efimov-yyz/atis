class ATIS::Section::ApproachTypes < ATIS::Section::Base

  format :en do
    block :expect
    message.approach_types.each do |t|
      block t.downcase.to_sym
    end
    block :approach
  end

  format :ru do
    message.approach_types.each do |t|
      block :prefix
      block t.downcase.to_sym
    end
  end

end