class ATIS::Section::Cavok < ATIS::Section::Base

  uses :metar, group: :cavok

  format :en do |f|
    f.block :cavok
  end

  format :ru do |f|
    f.block :cavok
  end

end