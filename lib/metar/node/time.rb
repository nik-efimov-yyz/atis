class METAR::Node::Time < METAR::Node::Base

  property :date do
    match[1].to_i
  end

  property :time do
    match[2].to_s
  end

  property :time_zone do
    "Z"
  end

end

