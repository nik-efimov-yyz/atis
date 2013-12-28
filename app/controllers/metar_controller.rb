class MetarController < ApplicationController


  def decode
    #params[:icao] = "URRR 281300Z 10005MPS 070V130 9999 OVC005 02/01 Q1027 04110060 NOSIG RMK QBB160 MAST OBSC"
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
