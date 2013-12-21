class METAR::Node::Time < METAR::Node::Base

  property :date do
    match[1].to_i
  end

  property :time do
    [hours, minutes].join
  end

  property :hours do
    sprintf("%02d", match[2].to_i)
  end

  property :minutes do
    sprintf("%02d", match[3].to_i)
  end

  property :time_zone do
    "Z"
  end

end

