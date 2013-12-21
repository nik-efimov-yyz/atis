class MetarController < ApplicationController


  def decode
    #params[:icao] = "ULAA 211830Z 22003MPS 180V250 9999 OVC010CB 00/00 Q0998 BECMG 4000 SHSN BR BKN005CB RMK QFE747/0996 SC040"
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
