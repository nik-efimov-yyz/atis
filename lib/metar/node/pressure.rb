class METAR::Node::Pressure < METAR::Node::Base

  property :pressure do
    match[2]
  end

  property :units do
    match[1] == "Q" ? "MBAR" : "IN.HG"
  end

end