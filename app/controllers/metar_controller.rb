class MetarController < ApplicationController

  def decode
    params[:icao] = "UAAA 081630Z 21002MPS 1000 R23R/P2000V3000N R23L/P2000D -SN BR BKN005CB OVC018 M01/M02 Q1031 882/0150 TEMPO 0300 -SN FZFG VV002 RMK QBB160"
    @message = ATIS::Message.new(params[:icao])
  end

end
