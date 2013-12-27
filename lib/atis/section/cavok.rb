class ATIS::Section::Cavok < ATIS::Section::Base

  uses :metar, group: :cavok

  format [:en, :ru] do
    block :cavok
  end

end