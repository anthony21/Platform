import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    to: String
  }

  connect () {
    if (this.toValue) {
      window.location.href = this.toValue
    }
  }
}
