class ATIS::Section::ExtraInformation < ATIS::Section::Base

  uses :extra

  format [:en, :ru] do

    source.each do |e|
      block e.to_sym
    end
  end

end