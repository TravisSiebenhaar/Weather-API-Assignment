class WeatherReportsController < ApplicationController
  APPID = Rails.application.credentials.openweathermap

  def index
  end

  def get_weather_report
    response = openweather_api_client

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          'weather_report',
          partial: 'weather_response_container',
          locals: { 
            weather_report: response.weather_info, 
            weather_type: params[:weather_type],
            success: response.success?
          }
        )
      }

      format.html { redirect_back fallback_location: :root }
    end
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
