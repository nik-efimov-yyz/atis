module ApplicationHelper

  def euroscope_url
    str = home_with_token_url(token: @token.token)
    str += "/$atisairport.txt?arr=$arrrwy($atisairport)&dep=$deprwy($atisairport)&info=$atiscode"
    str

  end

end
