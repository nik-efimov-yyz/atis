class ATIS::Message::Block::SkyCondition < ATIS::Message::Block

  format :en do
    "English cloud stuff"
  end

  format :ru do
    blocks = []

    metar.sky_condition.each do |sky|
      case
        when sky.clear?
          blocks << ":clear"
        when sky.no_significant_cloud?
          blocks << ":no_significant_cloud"
        when sky.cover
          blocks << ":#{sky.cover.downcase}"
        when sky.vertical_visibility?
          blocks << ":vertical_visibility"
      end

      blocks << ":#{sky.cloud_type.downcase}" if sky.cloud_type
      blocks << (sky.height) if sky.height
    end


    blocks.map { |b| "[#{b}]" }.join(" ")
  end


end