import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["street", "city", "state", "zip"];

  connect() {
    console.log("places_controller.js initialized");
    // TODO: Discover better way to handle google-maps-callback-event
    const event = new CustomEvent("google-maps-callback-event");
    window.dispatchEvent(event);
  }

  initAutocomplete() {
    console.log("google_maps initialized");
    let controller = this;

    this.autocomplete = new google.maps.places.Autocomplete(
      document.getElementById("address[street]"),
      {
        types: ["geocode"],
        componentRestrictions: { country: ["US"] },
        fields: ["address_component"],
      }
    );

    this.autocomplete.addListener("place_changed", function () {
      controller.selectAutoComplete();
    });
  }

  selectAutoComplete() {
    let place = this.autocomplete.getPlace();
    let address = this.convertPlaceToAddress(place);
    this.fillAddressFields(address);
  }

  convertPlaceToAddress(place) {
    let address = {};

    for (let i = 0; i < place.address_components.length; i++) {
      let addressComponent = place.address_components[i];
      for (let j = 0; j < addressComponent.types.length; j++) {
        let type = addressComponent.types[j];
        address[type] = {};
        address[type].shortName = addressComponent.short_name;
        address[type].longName = addressComponent.long_name;
      }
    }

    return address;
  }

  fillAddressFields(address) {
    let street = `${address.street_number.longName} ${address.route.longName}`;
    let city = address.locality.longName;
    let state = address.administrative_area_level_1.shortName;
    let zip = address.postal_code.shortName;

    this.streetTarget.value = street;
    this.cityTarget.value = city;
    this.stateTarget.value = state;
    this.zipTarget.value = zip;
  }

  preventSubmit(e) {
    if (e.keyCode == 13) {
      e.preventDefault();
    }
  }
}
