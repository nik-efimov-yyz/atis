class ATIS::Section::RunwayCondition < ATIS::Section::Base

  uses :metar, group: :runway_condition

  format :en do |options|

    source.each do |rwy|

      next if options[:if].present? and !instance_exec(rwy, &options[:if])

      unless rwy.condition == :clear_and_dry or rwy.condition.nil?
        block :covered_in unless [:damp, :wet].include? rwy.condition
        block rwy.condition
      end

      case rwy.condition

        when :damp

        when :wet
          if rwy.depth.present? and rwy.depth !=0 and rwy.depth != nil
            block :patches_of
            block :water
          end

        else

          if rwy.coverage.present? and rwy.depth != 0 and rwy.depth != nil
            block :patches_of
            block :up_to
            if rwy.depth.to_i > 90
              text (rwy.depth.to_i / 10)
              block :cm
            else
              text rwy.depth
              block :mm
            end

          end

      end

      if rwy.condition != :clear_and_dry || rwy.friction_index.to_f <= 0.6
        block :braking_action
        block rwy.braking_action
      end

    end

  end

  format :ru do |options|

    source.each do |rwy|

      next if options[:if].present? and !instance_exec(rwy, &options[:if])

      unless rwy.condition == :clear_and_dry or rwy.condition.nil?
        block :covered_in unless [:damp, :wet].include? rwy.condition
        block rwy.condition
      end

      case rwy.condition

        when :damp

        when :wet
          if rwy.depth.present? and rwy.depth != 0
            block :patches_of
            block :water
          end

        else

          if rwy.coverage.present? and rwy.depth != 0 and rwy.depth != nil
            block :patches_of
            block :up_to
            if rwy.depth.to_i < 10
              digit_conversion rwy.depth
              block :mm
            else
              if rwy.depth.to_i > 90
                number_conversion (rwy.depth.to_i / 10)
                block :cm
              else
                number_conversion rwy.depth
                block :mm
              end
            end
          end
      end

      if rwy.condition != :clear_and_dry || rwy.friction_index.to_f <= 0.6

        block :friction_index
        if rwy.friction_index.present?

          rwy.friction_index.to_s.split(".").each do |part|
            if part.length < 2
              digit_conversion part
            else
              number_conversion part
            end
          end

        elsif rwy.braking_action.present?
          block " 0"
          number_conversion guess_friction_from_braking_action(rwy.braking_action)
        end

      end

    end

  end

  def guess_friction_from_braking_action(braking_action)
    keys = {
        poor: 10..25,
        poor_to_medium: 26..29,
        medium: 30..35,
        medium_to_good: 36..39,
        good: 40..70
    }

    keys[braking_action].to_a.sample

  end

end