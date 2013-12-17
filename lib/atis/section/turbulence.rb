class ATIS::Section::Turbulence < ATIS::Section::Base

  uses :metar, group: :turbulence

  format :ru do |f|
    f.block :prefix, scope: :warnings unless metar.icing.any?
    f.block :in_cloud if turbulence.in_cloud
    f.block :in_out_cloud if turbulence.in_out_cloud
    f.block turbulence.intensity
    f.block :prefix
    if turbulence.height.max > 0
      f.block :layer
      f.block :from
      f.block turbulence.height.min
      f.block :to
      f.block turbulence.height.max
    end
  end

  def turbulence
    source.first
  end
end