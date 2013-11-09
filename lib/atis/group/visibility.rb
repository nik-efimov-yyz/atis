class ATIS::Group::Visibility < ATIS::Group::Base

  property :visibility do
      match[1].to_i
  end

  property :unlimited? do
    visibility == 9999
  end

  voice_message do
    if unlimited?

    end

  end

end
