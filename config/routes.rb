Vatatis::Application.routes.draw do
  root to: "metar#decode"
  get "/:icao", to: "metar#decode"
end
