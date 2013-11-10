class ATIS::Message::Block::Rvr < ATIS::Message::Block

  format :en do
    "English visibility stuff"
  end

  format :ru do
    blocks = [":prefix"]
    metar.rvr.each do |rvr|
      blocks << rvr.runway_number
      blocks << ":#{rvr.runway_suffix.downcase}"
      blocks << ":peak" if rvr.peak?
      blocks << ":minimum" if rvr.minimum?
      if rvr.variable?
        blocks << ":from"
        blocks << rvr.visibility.min
        blocks << ":to"
        blocks << rvr.visibility.max
      else
        blocks << rvr.visibility
      end
    end

    blocks.map { |b| "[#{b}]" }.join(" ")
  end

end