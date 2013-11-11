class METAR::Node::SkyCondition < METAR::Node::Base

  COVER_CODES = %w(FEW SCT BKN OVC)

  property :clear? do
    match[1].match(/SKC/).present?
  end

  property :no_significant_cloud? do
    match[1].match(/NSC/).present?
  end

  property :vertical_visibility? do
    match[2] and match[2].match(/VV/).present?
  end

  property :cover do
    match[2] and match[2].match(/(#{COVER_CODES.join("|")})/).present? ? match[2] : nil
  end

  property :height do
    (cover or vertical_visibility?) and match[3].to_i * 100
  end

  property :cloud_type do
    match[4]
  end

end
