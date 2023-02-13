require 'net/http'
require 'json'

module OpenweatherApi
  class Base
    extend Api

    attr_reader :url, :options, :weather_info, :status, :message

    def initialize(url, options)
      @status  = false
      @url = url
      @options = extract_options!(options)
    end

    def retrieve(url=nil)
      response = send_request url unless @options.empty?
      parse_response(response)
      # TODO: Handle error responses.
        # Additional module associated with openweathermaps API client
        # Global helper module for all API clients based off of status code 
      return self
    end

    def success?
      @status == 200
    end

    private

    def extract_options!(options)
      valid_options = [ :APPID, :zip, :units ]

      options.keys.each { |k| options.delete(k) unless valid_options.include?(k) }

      options
    end

    def parse_response(response)
      return if response.nil?
      @weather_info = JSON.parse(response)
      @status = @weather_info['cod']
      @message = @weather_info['message'] unless @status
    end

    def send_request(url=nil)
      url = url || @url
      uri = URI(url)
      uri.query = URI.encode_www_form(options)
      Rails.cache.fetch(uri, expires_in: 30.minutes) do
        Net::HTTP.get(uri)
      end
    end
  end
end