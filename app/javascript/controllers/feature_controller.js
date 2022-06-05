import { Controller } from '@hotwired/stimulus'

import { showElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static values = {
    feature: String
  }

  connect () {
    fetch(`/features/${this.featureValue}`)
      .then(response => response.json())
      .then(response => {
        if (response.enabled) {
          showElement(this.element)
        } else {
          this.element.remove()
        }
      })
  }
}
