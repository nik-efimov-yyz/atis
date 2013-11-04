class ATIS::Group::Time < ATIS::Group::Base

  property :hours do
    match[2].to_i
  end

  property :minutes do
    match[3].to_i
  end

  property :time_zone do
    "Z"
  end
end

