class ATIS::Section::Icing < ATIS::Section::Base

  uses :metar, group: :icing

  format :en do
    block :prefix, scope: :warnings
    block icing.intensity
    block :prefix
    block :in_cloud if icing.in_cloud
    if icing.height.max > 0
      block :from
      human_number_blocks_for icing.height.min
      block :to
      human_number_blocks_for icing.height.max
      block :meters, scope: :units
    end
  end

  format :ru do
    block :prefix, scope: :warnings
    block :in_cloud if icing.in_cloud
    block icing.intensity
    block :prefix
    if icing.height.max > 0
      block :layer
      block :from
      block icing.height.min
      block :to
      block icing.height.max
    end
  end

  def icing
    source.first
  end
end