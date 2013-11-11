class METAR::Node::Aerodrome < METAR::Node::Base

  property :icao do
    match[0].strip
  end


end
