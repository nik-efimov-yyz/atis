class ATIS::Section::Turbulence < ATIS::Section::Base

  uses :metar, group: :turbulence

  format :en do |f|
    f.block :prefix, scope: :warnings unless metar.icing.any?
    f.block turbulence.intensity
    f.block :prefix
    f.block :in_cloud if turbulence.in_cloud
    f.block :in_out_cloud if turbulence.in_out_cloud
    if turbulence.height.max > 0
      f.block :from
      human_number_blocks_for turbulence.height.min
      f.block :to
      human_number_blocks_for turbulence.height.max
    end
  end

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