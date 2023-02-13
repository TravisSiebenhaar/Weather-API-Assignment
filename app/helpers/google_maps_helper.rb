module GoogleMapsHelper
  def google_maps_tag
    "https://maps.googleapis.com/maps/api/js?key=#{Rails.application.credentials.google[:maps]}&libraries=places&callback=initAutocomplete"
  end
end