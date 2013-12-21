class MetarController < ApplicationController


  def decode
    #params[:icao] = "ULLI 101727Z 20004MPS 170V230 0350 R05L/P2000N R16/0800V1500D R05R/P2000U 9999 -SN FEW008 BKN041 OVC066 M07/M07 Q1028 28////// 78290050 WS RWY05L"
    @message = ATIS::Message.new(params[:icao], metar_options_from_params)

    respond_to do |format|
      format.html
      format.text
    end
  end

  private

  def metar_options_from_params
    {
        arrival_runways: params[:arr] && params[:arr].split(","),
        approach_types: params[:apptype] && params[:apptype].split(","),
        departure_runways: params[:dep] && params[:dep].split(","),
        index: params[:info].try(:downcase),
        transition_level: params[:trlvl],
        extra: params[:extra] && params[:extra].split(","),
        report_pressure_in: params[:pt] && params[:pt].split(","),
        languages: params[:lang] && params[:lang].split(",")
    }
  end

end
