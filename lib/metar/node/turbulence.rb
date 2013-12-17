class METAR::Node::Turbulence < METAR::Node::Base

  property :intensity do
    case match[1]
      when "FBL"
        :light
      when "MOD"
        :moderate
      when "SEV"
        :severe
      else
        nil
    end
  end

  property :in_cloud do
    match[3].present? and match[3].match(/INC/).present?
  end

  property :in_out_cloud do
    match[3].present? and match[3].match(/IAO/).present?
  end

  property :height do
    match[5].to_i..match[6].to_i
  end
end