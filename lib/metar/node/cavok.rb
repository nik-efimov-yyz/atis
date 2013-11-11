class METAR::Node::Cavok < METAR::Node::Base

  property :cavok? do
    match.present?
  end

end