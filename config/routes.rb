Rails.application.routes.draw do
  get 'weather_reports/index'
  get '/weather_report', to: 'weather_reports#get_weather_report'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "weather_reports#index"
end
