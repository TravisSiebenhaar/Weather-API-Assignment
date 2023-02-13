require "test_helper"

class WeatherReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather_reports_index_url
    assert_response :success
  end
end
