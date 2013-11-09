class ATIS::Group::Phenomena < ATIS::Group::Base

  DESCRIPTORS = %w(MI BC PR DR BL SH TS FZ)
  PHENOMENA = %w(DZ RA SN SG IC PL GR GS UP BR FG FU VA DU SA HZ PO SQ FC SS DS)

  property :qualifier do
    match[1]
  end

  property :descriptor do
    match[2]
  end

  property :phenomena do
    match[3]
  end

end
