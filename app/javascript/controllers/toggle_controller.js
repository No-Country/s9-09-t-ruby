import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static classes = ["active"]
  static targets = ["hide"]

  toggleClass(event) {
    // Remove activa class in each hide target
    this.hideTargets.forEach(
      (t) => t.classList.remove(this.activeClass)
    );
    // then toggle class in click event target
    event.target.classList.toggle(this.activeClass)
  }
}
