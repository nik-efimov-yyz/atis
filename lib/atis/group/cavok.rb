class ATIS::Group::Cavok < ATIS::Group::Base

  property :cavok? do
    match.present?
  end
end