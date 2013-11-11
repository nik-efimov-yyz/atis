class METAR::Node::Wind < METAR::Node::Base

  property :direction do
    if match[1] == "VRB"
      match[1]
    else
      match[1].to_i
    end
  end

  property :speed do
    if gusting?
      gusts
    else
      match[2].to_i
    end
  end

  property :units do
    match[3]
  end

  property :variable? do
    (match[1] =~ /VRB/).present? or match[4].present?
  end

  property :variable_from do
    match[5] && match[5].to_i
  end

  property :variable_to do
    match[6] && match[6].to_i
  end

  property :calm? do
    speed == 0 and direction == 0
  end

  property :gusting? do
    gusts.present?
  end

  property :gusts do
    $1.to_i..$2.to_i if match[2].match(/(\d{2})G(\d{2})/).present?
  end

end