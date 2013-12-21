class ATIS::Section::Cavok < ATIS::Section::Base

  uses :metar, group: :cavok

  format :en do
    block :cavok
  end

  format :ru do
    block :cavok
  end

end