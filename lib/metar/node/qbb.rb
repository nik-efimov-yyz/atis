class METAR::Node::Qbb < METAR::Node::Base

  property :height do
    match[1].to_i
  end

end