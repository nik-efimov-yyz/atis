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
        rwy.friction_index.to_s.split(".").each do |part|
          f.block part
        end

      end

    end

  end

end