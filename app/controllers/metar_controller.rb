class MetarController < ApplicationController


  def decode
    #params[:icao] = "ULLI 101630Z 20004MPS 170V230 R05L/P2000N R05R/P2000U 9999 -SN FEW008 BKN014 OVC066 M07/M07 Q1028 28////// 78290050 WS ALL RWY NOSIG RMK MOD TURB IAO"
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
