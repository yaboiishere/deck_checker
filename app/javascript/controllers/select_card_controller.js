import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "grid", "search"]

  connect() {
    this.selectedCard = null
  }

  select(event) {
    const card = event.currentTarget

    if (this.selectedCard) {
      this.selectedCard.classList.remove("scale-125")
    }

    card.classList.add("scale-125")
    this.selectedCard = card
  }

  deselect(_event) {
    this.selectedCard.classList.remove("scale-125")
    this.selectedCard = null
  }

  filter() {
    const term = this.searchTarget.value.trim().toLowerCase()
    const cards = this.gridTarget.children

    for (const card of cards) {
      const text = card.dataset.searchText || ""
      const match = text.toLowerCase().includes(term)
      card.style.display = match ? "" : "none"
    }
  }
}

