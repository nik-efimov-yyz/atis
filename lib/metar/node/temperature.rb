class METAR::Node::Temperature < METAR::Node::Base

  property :temperature do
    match[1].gsub("M","-").to_i
  end

  property :dew_point do
    match[2].gsub("M","-").to_i
  end

end