class WeatherReportsController < ApplicationController
  def index
  end

  def get_weather_report
    Rails.logger.info('*' * 100)
  end
end
