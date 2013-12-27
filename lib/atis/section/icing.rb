class ATIS::Section::Icing < ATIS::Section::Base

  uses :metar, group: :icing

  format :en do
    block :prefix, scope: :warnings
    block icing.intensity
    block :prefix
    block :in_cloud if icing.in_cloud
    if icing.height.max > 0
      block :from
      if icing.height.min == 0
        block :surface
      else
        block icing.height.min
      end
      block :to
     block icing.height.max
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
      if icing.height.min == 0
        block :surface
      else
        number_conversion icing.height.min
      end
      block :to
      number_conversion icing.height.max
    end
  end

  def icing
    source.first
  end
end