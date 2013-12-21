class ATIS::Section::MessageEnd < ATIS::Section::Base

  uses :index

  format :en do
    block :end_message, scope: :end
    block :information, scope: :end
    block message.index, scope: :phonetics if message.index.present?
  end

  format :ru do
    block :end_message, scope: :end
    block message.index, scope: :phonetics if message.index.present?
  end

end