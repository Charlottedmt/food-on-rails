import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import { initLoader } from '../components/loader';
const addCoordToForm = (coordinates) => {
  const lats = document.querySelectorAll(".hidden-lat")
  lats.forEach((input) => {
    input.value = coordinates.latitude
  })
  const lons = document.querySelectorAll(".hidden-lon")
  lons.forEach((input) => {
    input.value = coordinates.longitude
  })
}
const userCurrentPosition = (map, mapElement) => {
  navigator.geolocation.getCurrentPosition((location) => {
    const current_position = JSON.parse(mapElement.dataset.current_position);
    const popup = new mapboxgl.Popup().setHTML(current_position.infoWindow);
    console.log(popup);
    // Create a HTML element for your custom marker
    const element = document.createElement('div');
    element.className = 'current_position';
    element.style.backgroundImage = `url('${current_position.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';
    // Pass the element as an argument to the new marker
    const user_position = new mapboxgl.Marker(element)
      .setLngLat([location.coords.longitude, location.coords.latitude])
      .setPopup(popup)
      .addTo(map);
    addCoordToForm(location.coords);
  });
};
const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const fitMapToMarkers = (map, markers, current_position) => {
      const bounds = new mapboxgl.LngLatBounds();
      console.log(markers);
      markers.forEach(marker => bounds.extend([marker.lng, marker.lat, current_position.longitude, current_position.latitude]));
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
      initLoader();
    };
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      // Create a HTML element for your custom marker
      const icon = document.createElement('div');
      icon.className = 'marker';
      icon.style.backgroundImage = `url('${marker.image_url}')`;
      icon.style.backgroundSize = 'contain';
      icon.style.width = '35px';
      icon.style.height = '35px';
      icon.style.backgroundRepeat = 'no-repeat';
      new mapboxgl.Marker(icon)
        .setLngLat([marker.lng, marker.lat])
        .addTo(map);
    })
    navigator.geolocation.getCurrentPosition((location) => {
      const test = location.coords
      console.log(test);

      fitMapToMarkers(map, markers, test);
    });
    userCurrentPosition(map, mapElement);
  }
};
export { initMapbox };
