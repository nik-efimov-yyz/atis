class ATIS::Section::ExtraInformation < ATIS::Section::Base

  uses :extra

  format :en do

    source.each do |e|
      block e.to_sym
    end

  end

  format :ru do

    source.each do |e|
      block e.to_sym
    end

  end

end