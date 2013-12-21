class ATIS::Section::Icing < ATIS::Section::Base

  uses :metar, group: :icing

  format :en do |f|
    f.block :prefix, scope: :warnings
    f.block :in_cloud if icing.in_cloud
    f.block icing.intensity
    f.block :prefix
    if icing.height.max > 0
      f.block :from
      f.block icing.height.min
      f.block :to
      f.block icing.height.max
    end
  end

  format :ru do |f|
    f.block :prefix, scope: :warnings
    f.block :in_cloud if icing.in_cloud
    f.block icing.intensity
    f.block :prefix
    if icing.height.max > 0
      f.block :layer
      f.block :from
      f.block icing.height.min
      f.block :to
      f.block icing.height.max
    end
  end

  def icing
    source.first
  end
end