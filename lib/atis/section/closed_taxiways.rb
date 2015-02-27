class ATIS::Section::ClosedTaxiways < ATIS::Section::Base

  uses :closed_taxiways

  format :en do

    message.closed_taxiways.each do |twy|

      block :taxiway, scope: :extrainformation


      suffix, taxiway_number   = twy.match(/([a-zA-Z])?(\d{1,})?/).captures

      text suffix.to_s.to_sym.upcase if suffix.present?
      text taxiway_number

    end

    block :closed, scope: :extrainformation

  end


  format :ru do
    count = 0
    message.closed_taxiways.each do |twy|

      block :taxiway, scope: :extrainformation

      suffix, taxiway_number = twy.match(/([a-zA-Z])?(\d{1,})?/).captures

      text suffix.to_s.to_sym.upcase if suffix.present?
      rwy_number_conversion taxiway_number

      count += 1
    end

    if count >= 2
      block :closed_plural, scope: :extrainformation
    else
      block :closed_singular, scope: :extrainformation
    end


  end

end