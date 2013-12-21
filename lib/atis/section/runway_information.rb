class ATIS::Section::RunwayInformation < ATIS::Section::Base

  def en_runway_condition_for(runway)

    handler = ATIS::Section::RunwayCondition.new(@message)
    handler.render_in :en, if: -> rwy { rwy.runway == :all or rwy.runway == runway or rwy.runway == runway.split(/(L)/)[0] }

  end

  def ru_runway_condition_for(runway)

    handler = ATIS::Section::RunwayCondition.new(@message)
    handler.render_in :ru, if: -> rwy { rwy.runway == :all or rwy.runway == runway or rwy.runway == runway.split(/(L)/)[0] }

  end

end