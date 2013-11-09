class ATIS::Group::Wind < ATIS::Group::Base

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

  voice_message do
    parts = ["[ветер у земли]"]
    if calm?
      parts << "[тихий]"

    elsif gusting?

    elsif variable?
      parts << "[неустойчивый]"
      parts << "[от] [#{direction_v_from}]" if direction_v_from.present?
    end
    parts.join(" ")
  end

end