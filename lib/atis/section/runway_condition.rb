class ATIS::Section::RunwayCondition < ATIS::Section::Base

  uses :metar, group: :runway_condition

  format :ru do |f, options|

    source.each do |rwy|

      next if options[:if].present? and !instance_exec(rwy, &options[:if])

      unless rwy.condition == :clear_and_dry or rwy.condition.nil?
        f.block :covered_in unless [:damp, :wet].include? rwy.condition
        f.block rwy.condition
      end

      case rwy.condition

        when :damp

        when :wet
          if rwy.depth > 0
            f.block :patches_of
            f.block :water
          end

        else

          if rwy.coverage.present? and rwy.depth > 0
            f.block :patches_of
            f.block :to
            f.block rwy.depth
            f.block :mm
          end

      end

      if rwy.condition != :clear_and_dry || rwy.friction_index.to_f <= 0.6

        f.block :friction_index

        if rwy.friction_index.present?

          rwy.friction_index.to_s.split(".").each do |part|
            f.block part
          end

        elsif rwy.braking_action.present?
          f.text guess_friction_from_braking_action(rwy.braking_action)
        end

      end

    end

  end

  def guess_friction_from_braking_action(braking_action)
    keys = {
        poor: 0..25,
        poor_to_medium: 26..29,
        medium: 30..35,
        medium_to_good: 36..39,
        good: 40..90
    }

    keys[braking_action].to_a.sample

  end

end