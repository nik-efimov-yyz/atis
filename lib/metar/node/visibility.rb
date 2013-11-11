class METAR::Node::Visibility < METAR::Node::Base

  property :visibility do
      match[1].to_i
  end

  property :unlimited? do
    visibility == 9999
  end

  property :units do
    match[2].present? ? match[2] : "M"
  end


end
