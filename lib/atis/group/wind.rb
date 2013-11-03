class ATIS::Group::Wind < ATIS::Group::Base

  matches /(VRB|\d{3})(\d{2}|\d{2}G\d{2})(KT|MPS)( (\d{3})V(\d{3}))?/

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

  property :direction_v_from do
    match[5] && match[5].to_i
  end

  property :direction_v_to do
    match[6] && match[6].to_i
  end

  property :calm? do
    speed == 0 and direction == 0
  end

  property :gusting? do
    gusts.present?
  end

  property :gusts do
    if gust_match = match[2].match(/(\d{2})G(\d{2})/)
      gust_match[1].to_i..gust_match[2].to_i
    else
      nil
    end
  end

end