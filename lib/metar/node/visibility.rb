class METAR::Node::Visibility < METAR::Node::Base

  property :visibility do
      match[2].to_i
  end

  property :unlimited? do
    visibility == 9999
  end

  property :less_than_50? do
    visibility.to_i < 50
  end

  property :units do
    match[3].present? ? match[2] : "M"
  end

  property :greater? do
    match[1] == "P"
  end

  property :less? do
    match[1] == "M"
  end


end
