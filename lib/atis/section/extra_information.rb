class ATIS::Section::ExtraInformation < ATIS::Section::Base

  uses :extra

  format :ru do |f|

    source.each do |e|
      f.block e.to_sym
    end

  end

end