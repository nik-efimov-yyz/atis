class ATIS::Group::Cavok < ATIS::Group::Base

  property :cavok? do
    match.present?
  end

  voice_message do

  end
end