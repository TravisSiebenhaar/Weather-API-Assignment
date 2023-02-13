
module OpenweatherApi
  module Api
    # Zip format : Eg, 90210
    # Usage Example: OpenWeather::Current.zip('90210')
    def zip(zip, options = {})
      new(options.merge(zip: zip)).retrieve
    end
  end
end