class ATIS::Section::MessageEnd < ATIS::Section::Base

  uses :index

  format :en do |f|
    f.block :end_message, scope: :end
    f.block :information, scope: :end
    f.block message.index, scope: :phonetics if message.index.present?
  end

  format :ru do |f|
    f.block :end_message, scope: :end
    f.block message.index, scope: :phonetics if message.index.present?
  end

end