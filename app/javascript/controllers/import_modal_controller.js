import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  open() {
    this.modalTarget.classList.remove("hidden")
    console.log("Modal opened")
  }

  close(event) {
    if (event.target === this.modalTarget || event.target.dataset.close === "true") {
      this.modalTarget.classList.add("hidden")
    }
  }
}
