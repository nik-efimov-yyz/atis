class ATIS::Section::Turbulence < ATIS::Section::Base

  uses :metar, group: :turbulence

  format :en do
    block :prefix, scope: :warnings unless metar.icing.any?
    block turbulence.intensity
    block :prefix
    block :in_cloud if turbulence.in_cloud
    block :in_out_cloud if turbulence.in_out_cloud
    if turbulence.height.max > 0
      block :from
      if turbulence.height.min == 0
        block :surface
      else
        block icing.height.min
      end
      block :to
      block turbulence.height.max
    end
  end

  format :ru do
    block :prefix, scope: :warnings unless metar.icing.any?
    block :in_cloud if turbulence.in_cloud
    block :in_out_cloud if turbulence.in_out_cloud
    block turbulence.intensity
    block :prefix
    
    if turbulence.height.max > 0
      block :layer
      block :from
      if turbulence.height.min == 0
        block :surface
      else
        number_conversion turbulence.height.min
      end
      block :to
      number_conversion turbulence.height.max
    end
  end

  def turbulence
    source.first
  end
end