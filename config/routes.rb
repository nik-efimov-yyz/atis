Vatatis::Application.routes.draw do
  root to: "atis#home"

  get "/metar", to: "atis#metar", as: :metar
  post "/metar", to: "atis#decode"
  get "/:token", to: "atis#home", as: :home_with_token
  get "/:token/:icao", to: "atis#decode", as: :atis_with_token
  get "/atis/:icao", to: "atis#decode", as: :atis

  resources :tokens

end
