class AtisController < ApplicationController

  def home

    @token = Token.where(token: params[:token]).first if params[:token].present?
    @token ||= Token.new

  end

  def decode
    @message = ATIS::Message.new(params[:icao], metar_options_from_params)

    respond_to do |format|
      format.html
      format.text
    end
  end

  def metar

  end

  private

  def metar_options_from_params
    @token = Token.where(token: params[:token]).first if params[:token].present?

    options = ((@token && @token.params) || {}).with_indifferent_access
    options[:lang] = [@token.params[:pl], @token.params[:sl]].reject { |l| l.blank? } if @token.present?
    options.merge! params_split_to_arrays

    {
        arrival_runways: options[:arr],
        approach_types: options[:apptype],
        departure_runways: options[:dep],
        index: options[:info].try(:downcase),
        transition_level: options[:trlvl],
        extra: options[:extra],
        report_pressure_in: options[:pt],
        languages: options[:lang]
    }
  end

  def params_split_to_arrays
    [:arr, :apptype, :dep, :extra, :pt, :lang].each do |key|
      params[key] = params[key].split(",") if params[key].is_a?(String)
    end
    params
  end

end
