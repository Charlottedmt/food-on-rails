// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "link" ]

  connect() {
    console.log('Thanks Trouni!');
    navigator.geolocation.getCurrentPosition((location) => {

const newLinkUrl = new URL(this.linkTarget.href);
// Copy the existing href from the existing link
// Append the params to that url using JavaScript's searchParams.append
newLinkUrl.searchParams.append("lat", location.coords.latitude);
newLinkUrl.searchParams.append("lon", location.coords.longitude);
this.linkTarget.href = newLinkUrl
});
  }
}