class METAR::Node::Friction < METAR::Node::Base

  property :friction_coefficient do
    match[1].to_i
  end

end