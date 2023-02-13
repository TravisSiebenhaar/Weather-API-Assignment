class WeatherReportsController < ApplicationController
  APPID = Rails.application.credentials.openweathermap

  def index
  end

  def get_weather_report
    response = openweather_api_client
    Rails.logger.info(response.weather_info)

    redirect_back fallback_location: :root
  end

  private

  def openweather_api_client
    case params[:weather_type]
    when 'forecast'
      @openweather_api_client ||= OpenweatherApi::Forecast.zip(params[:address][:zip], { APPID: APPID, units: 'imperial' })
    when 'weather'
      @openweather_api_client ||= OpenweatherApi::Current.zip(params[:address][:zip], { APPID: APPID, units: 'imperial' })
    else
      false
    end
  end

  def weather_report_params
    params.permit(:weather_type, address: [:city, :state, :zip, :street])
  end
end
