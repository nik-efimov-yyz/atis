class METAR::Node::Windshear < METAR::Node::Base

  property :runway do
    case match[1]
      when "ALL RWY"
        :all
      else
        match[2]
    end
  end

end