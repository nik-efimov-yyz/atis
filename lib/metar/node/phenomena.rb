class METAR::Node::Phenomena < METAR::Node::Base

  DESCRIPTORS = %w(MI BC PR DR BL SH TS FZ)
  PHENOMENA = %w(DZ RA RASN SN SNRA SG IC PL GR GS GSRA UP BR FG FU VA DU SA HZ PO SQ FC SS DS PE)

  property(:qualifier) { match[1] }
  property(:descriptor) { match[2] }
  property(:phenomena) { match[3] }
  property(:vicinity?) { match[1] == "VC" }

  property :intensity do
    case match[1]
      when "+"
        :heavy
      when "-"
        :light
      else
        nil
    end
  end

end
