import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["loader", "spinner", "button"]

  connect() {
    this.offset = parseInt(this.loaderTarget.dataset.offset, 10) || 0
    this.perPage = 40
    this.loading = false
    this.endReached = false
    this.query = new URLSearchParams(window.location.search).get("q") || ""
    //get the rails controller path from the URL
    this.railsPath = window.location.pathname.split("/")[1] || "cards"
  }

  async loadMore() {
    if (this.loading || this.endReached) return

    this.loading = true
    this.spinnerTarget.classList.remove("hidden")
    this.buttonTarget.disabled = true

    let url = ""

    if (this.query != "") {
      url = `/${this.railsPath}/load_more?q=${this.query}&offset=${this.offset}`
    } else {
      url = `/${this.railsPath}/load_more?offset=${this.offset}`
    }

    const response = await fetch(url)
    const html = await response.text()


    if (html.trim() === "") {
      this.endReached = true
      if (this.hasLoaderTarget) this.loaderTarget.remove()

      return
    } else {
      this.loaderTarget.insertAdjacentHTML("beforebegin", html)
      this.offset += this.perPage
      this.loaderTarget.dataset.offset = this.offset
    }

    this.spinnerTarget.classList.add("hidden")
    this.buttonTarget.disabled = false
    this.loading = false
  }

  loadMoreIfVisible() {
    if (!this.hasLoaderTarget || this.loading || this.endReached) return

    const rect = this.loaderTarget.getBoundingClientRect()
    if (rect.top < window.innerHeight) {
      this.loadMore()
    }
  }
}

