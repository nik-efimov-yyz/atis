class ATIS::Section::ClosedTaxiways < ATIS::Section::Base

  uses :closed_taxiways

  format :en do

    message.closed_taxiways.each do |twy|

      block :taxiway, scope: :extrainformation

      taxiway_number, suffix = twy.split(/([a-zA-Z])/)
      text taxiway_number
      text suffix.upcase.to_sym if suffix.present?

    end

    block :closed, scope: :extrainformation

  end


  format :ru do
    count = 0
    message.closed_taxiways.each do |twy|

      block :taxiway, scope: :extrainformation

      taxiway_number, suffix = twy.split(/([a-zA-Z])/)
      rwy_number_conversion taxiway_number
      text suffix.upcase.to_sym if suffix.present?
      count += 1
    end

    if count >= 2
      block :closed_plural, scope: :extrainformation
    else
      block :closed_singular, scope: :extrainformation
    end


  end

end