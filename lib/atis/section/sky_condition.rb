class ATIS::Section::SkyCondition < ATIS::Section::Base

  uses :metar, group: :sky_condition

  format :en do

    sky_cover_below_5000_reported, sky_clear_reported = false

    source.each_with_index do |sky, index|

      case
        when sky.clear?
          block :clear

        when sky.no_significant_cloud?
          block :no_significant_cloud

        when sky.cover

          break unless sky.height.present?

          if sky.height <= 5000 or %w(CB TCU).include?(sky.cloud_type)

            block sky.cover.downcase.to_sym
            block sky.cloud_type.downcase.to_sym if sky.cloud_type.present?

            if index == 0 and metar.qbb.present?
              human_number_blocks_for metar.qbb.first.height
              block :meters, scope: :units
            else
              human_number_blocks_for metric_cloud_height_from(sky.height)
              block :meters, scope: :units
            end
            sky_cover_below_5000_reported = true

          elsif !sky_cover_below_5000_reported and !sky_clear_reported

            block :clear
            sky_clear_reported = true

          end

        when sky.vertical_visibility?
          block :vertical_visibility

          if index == 0 and metar.qbb.present?
            human_number_blocks_for metar.qbb.first.height
            block :meters, scope: :units
          else
            human_number_blocks_for metric_cloud_height_from(sky.height)
            block :meters, scope: :units
          end
      end

    end
  end


  format :ru do

    sky_cover_below_5000_reported, sky_clear_reported = false

    source.each_with_index do |sky, index|

      case
        when sky.clear?
          block :clear

        when sky.no_significant_cloud?
          block :no_significant_cloud

        when sky.cover

          break unless sky.height.present?

          if sky.height <= 5000 or %w(CB TCU).include?(sky.cloud_type)

            block sky.cover.downcase.to_sym
            block sky.cloud_type.downcase.to_sym if sky.cloud_type.present?

            if index == 0 and metar.qbb.present?
              block metar.qbb.first.height
            else
              block metric_cloud_height_from(sky.height)
            end

            sky_cover_below_5000_reported = true

          elsif !sky_cover_below_5000_reported and !sky_clear_reported

            block :clear
            sky_clear_reported = true

          end

        when sky.vertical_visibility?
          block :vertical_visibility

          if index == 0 and metar.qbb.present?
            block metar.qbb.first.height
          else
            block metric_cloud_height_from(sky.height)
          end
      end

    end
  end

  def metric_cloud_height_from(height_in_feet)
    (height_in_feet.to_i * 0.3).to_i
  end


end