class MetarController < ApplicationController


  def decode
    #params[:icao] = "UUEE 090230Z 33006MPS 9999 OVC005 M05/M07 Q1005 88530335 TEMPO OBST OBSC QBB060"
    @message = ATIS::Message.new(params[:icao], metar_options_from_params)
  end

  private

  def metar_options_from_params
    {
        arrival_runways: params[:arr] && params[:arr].split(","),
        approach_types: params[:apptype] && params[:apptype].split(","),
        departure_runways: params[:dep] && params[:dep].split(","),
        index: params[:info].try(:downcase),
        transition_level: params[:trlvl],
        extra: params[:extra] && params[:extra].split(",")
    }
  end

end
