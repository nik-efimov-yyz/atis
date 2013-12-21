class ATIS::Section::SkyCondition < ATIS::Section::Base

  format :en do |f|

    sky_cover_below_5000_reported, sky_clear_reported = false

    metar.sky_condition.each_with_index do |sky, index|

      case
        when sky.clear?
          f.block :clear

        when sky.no_significant_cloud?
          f.block :no_significant_cloud

        when sky.cover

          break unless sky.height.present?

          if sky.height <= 5000 or %w(CB TCU).include?(sky.cloud_type)

            f.block sky.cover.downcase.to_sym
            f.block sky.cloud_type.downcase.to_sym if sky.cloud_type.present?

            if index == 0 and metar.qbb.present?
              human_number_blocks_for metar.qbb.first.height
              f.block :meters, scope: :units
            else
              human_number_blocks_for metric_cloud_height_from(sky.height)
              f.block :meters, scope: :units
            end
            sky_cover_below_5000_reported = true

          elsif !sky_cover_below_5000_reported and !sky_clear_reported

            f.block :clear
            sky_clear_reported = true

          end

        when sky.vertical_visibility?
          f.block :vertical_visibility

          if index == 0 and metar.qbb.present?
            f.block metar.qbb.first.height
            f.block :meters, scope: :units
          else
            f.block metric_cloud_height_from(sky.height)
            f.block :meters, scope: :units
          end
      end

    end
  end


  format :ru do |f|

    sky_cover_below_5000_reported, sky_clear_reported = false

    metar.sky_condition.each_with_index do |sky, index|

      case
        when sky.clear?
          f.block :clear

        when sky.no_significant_cloud?
          f.block :no_significant_cloud

        when sky.cover

          break unless sky.height.present?

          if sky.height <= 5000 or %w(CB TCU).include?(sky.cloud_type)

            f.block sky.cover.downcase.to_sym
            f.block sky.cloud_type.downcase.to_sym if sky.cloud_type.present?

            if index == 0 and metar.qbb.present?
              f.block metar.qbb.first.height
            else
              f.block metric_cloud_height_from(sky.height)
            end

            sky_cover_below_5000_reported = true

          elsif !sky_cover_below_5000_reported and !sky_clear_reported

            f.block :clear
            sky_clear_reported = true

          end

        when sky.vertical_visibility?
          f.block :vertical_visibility

          if index == 0 and metar.qbb.present?
            f.block metar.qbb.first.height
          else
            f.block metric_cloud_height_from(sky.height)
          end
      end

    end
  end

  def metric_cloud_height_from(height_in_feet)
    (height_in_feet.to_i * 0.3).to_i
  end


end