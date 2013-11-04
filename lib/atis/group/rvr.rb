class ATIS::Group::Rvr < ATIS::Group::Base

  property :runway do
    match[1]
  end

  property :variable? do
    visibility_block.match("V").present?
  end

  property :visibility do
    if variable?
      submatch = visibility_block.match(/(\d{4})V[PM]?(\d{4})/)
      submatch[1].to_i..submatch[2].to_i
    else
      submatch = visibility_block.match(/(\d{4})/)
      submatch[1].to_i
    end
  end

  property :trend do
    if visibility_block.match(/U/).present?
      :upward
    elsif visibility_block.match(/D/).present?
      :downward
    elsif visibility_block.match(/N/).present?
      :no_change
    else
      nil
    end
  end

  property :peak do
    visibility_block.match(/P/).present?
  end

  property :minimum do
    visibility_block.match(/M/).present?
  end

  private

  def visibility_block
    match[2]
  end

end