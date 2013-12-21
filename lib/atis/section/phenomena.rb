class ATIS::Section::Phenomena < ATIS::Section::Base

  uses :metar, group: :phenomena

  format :en do
    source.each do |p|
      block p.intensity if p.intensity.present?
      block :vicinity if p.vicinity?

      order = [:descriptor, :phenomena]
      order.reverse! if p.descriptor == "SH"

      order.each do |o|
        block p.send(o).downcase.to_sym if p.send(o).present?
      end
    end
  end

  format :ru do

    source.each do |p|
      block :vc if p.vicinity?

      add_russian_phenomena_blocks_for p
    end

  end


  private

  def add_russian_phenomena_blocks_for(atis_node)

    overrides = {
        BL: %w(SN DU SA),
        TS: %w(RA SN GR DS),
        SH: %w(GR),
        DR: %w(DU SA SN)
    }

    descriptor,  phenomena = nil

    overrides.each_pair do |d, phenomenas|
      if atis_node.descriptor == d.to_s and phenomenas.include?(atis_node.phenomena)
        descriptor = :override
        phenomena = "#{d}#{atis_node.phenomena}".downcase
      end
    end

    gender = :f if %w(BL TS).include?(atis_node.descriptor) or %w(DZ DU DS GS SS GSRA).include?(atis_node.phenomena)
    gender = :p if atis_node.phenomena == "SG"

    gender = :m if atis_node.descriptor == "DR" and atis_node.phenomena == "DU"
    gender ||= :m
    intensity ||= atis_node.intensity
    descriptor ||= atis_node.descriptor.try(:downcase)
    phenomena ||= atis_node.phenomena.downcase

    block "#{intensity}.#{gender}".to_sym if intensity.present? and intensity != :override
    block "#{descriptor}.#{gender}".to_sym if descriptor.present? and descriptor != :override
    block phenomena.to_sym
  end


end