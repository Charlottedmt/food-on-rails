import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

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
    const fitMapToMarkers = (map, markers) => {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    };

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    })

    userCurrentPosition(map, mapElement);
    fitMapToMarkers(map, markers);
  }
};
export { initMapbox };
