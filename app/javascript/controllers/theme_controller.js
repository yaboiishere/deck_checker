import { Controller } from "@hotwired/stimulus"

// app/javascript/controllers/theme_controller.js
export default class extends Controller {
  connect() {
    const saved = localStorage.getItem("theme")
    if (saved === "dark") document.documentElement.classList.add("dark")
  }

  toggle() {
    const html = document.documentElement
    const enabled = html.classList.toggle("dark")
    localStorage.setItem("theme", enabled ? "dark" : "light")
  }
}

