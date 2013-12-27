class METAR::Node::Rvr < METAR::Node::Base

  property :runway do
    match[1]
  end

  property :runway_number do
    if runway.match(/(\d{2})/).present?
      $1
    end
  end

  property :runway_suffix do
    if runway.match(/(L|C|R)/).present?
      $1
    end
  end

  property :variable? do
    match[4].present?
  end

  property :visibility do
    if variable?
      match[3].to_i..match[6].to_i
    else
      match[3].to_i
    end
  end

  property :trend do
    case match[7]
      when "U"
        :upward
      when "D"
        :downward
      when "N"
        :no_change
      else
        nil
    end
  end

  property :peak? do
    match[2] == "P" or match[5] == "P"
  end

  property :minimum? do
    match[2] == "M"
  end

  private

  def visibility_block
    match[0]
  end

end