import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'button', 'cards' ];

  // submitOnEnter(event) {
  //   if (event.key === 'Enter' && !event.shiftKey) {
  //     event.preventDefault()
  //     this.formTarget.style.height = "0"
  //     Rails.fire(this.formTarget, 'submit')
  //   }
  // }

  loadMore(event) {
    this.cardsTarget.classList.remove("hidden");
    event.currentTarget.remove();
    }
}

  // connect() {
  //   this.formTarget.style.height = "0"
  //   this.formTarget.style.overflow = "hidden"
  //   this.formTarget.style.transition = "height 0.2s ease-in"
  // }