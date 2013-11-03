class ATIS::Group::Visibility < ATIS::Group::Base

  matches /\s(\d{4})\s/

  property :visibility do
      match[1].to_i
  end

  property :unlimited? do
    visibility == 9999
  end

end
