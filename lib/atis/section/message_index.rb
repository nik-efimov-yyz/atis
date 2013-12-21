class ATIS::Section::MessageIndex < ATIS::Section::Base

  uses :index

  format :en do
    block :atis
    block :information
    block message.index, scope: :phonetics if message.index.present?
  end

  format :ru do
    block :atis
    block :information
    block message.index, scope: :phonetics if message.index.present?
  end

end