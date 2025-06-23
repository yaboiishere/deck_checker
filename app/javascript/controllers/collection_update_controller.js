import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "CollectionsChannel" },
      {
        received: (data) => {
          // Insert or replace the collections list HTML
          const collectionsList = document.getElementById("collections-list")
          if (collectionsList) {
            collectionsList.innerHTML = data
          }
        }
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      consumer.subscriptions.remove(this.subscription)
    }
  }
}

