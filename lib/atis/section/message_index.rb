class ATIS::Section::MessageIndex < ATIS::Section::Base

  uses :index

  format :en do |f|
    f.block :atis
    f.block :information
    f.block message.index, scope: :phonetics if message.index.present?
  end

  format :ru do |f|
    f.block :atis
    f.block :information
    f.block message.index, scope: :phonetics if message.index.present?
  end

end