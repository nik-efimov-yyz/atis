class TokensController < ApplicationController

  def create
    token = Token.new(params: token_params)
    token.save
    redirect_to home_with_token_path(token: token.token)
  end

  def update
    token = Token.find(params[:id])
    token.update_attributes! params: token_params
    redirect_to home_with_token_path(token: token.token)
  end

  private

  def token_params
    params.permit(:pl, :sl, :trlvl, pt: [], apptype: [], extra: [])
  end

end