class MetarController < ApplicationController

  def decode
    @metar = ATIS::METAR.new params[:icao]
  end

end
