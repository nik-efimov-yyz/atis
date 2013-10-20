class ATIS::Group::Wind < ATIS::Group::Base

  matches /(VRB|\d{3}|\d{3}V\d{3})(\d{2}|\d{2}G\d{2})(KT|MPS)/

  property :direction do
    match[1]
  end

  property :speed do
    if gusting?
      gusts
    else
      match[2]
    end
  end

  property :units do
    match[3]
  end

  property :variable? do
    (match[1] =~ /VRB/).present?
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