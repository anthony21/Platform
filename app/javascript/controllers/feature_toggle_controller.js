import { Controller } from '@hotwired/stimulus'

import { listen, ignore } from 'utils/events'
import { TOGGLE_EVENT } from 'controllers/toggle_controller'

export default class extends Controller {
  static targets = ['form']

  static values = {
    id: String,
    enabled: Boolean
  }

  connect () {
    listen(TOGGLE_EVENT, this.onToggle)
  }

  disconnect () {
    ignore(TOGGLE_EVENT, this.onToggle)
  }

  onToggle = (event) => {
    const { detail: id } = event

    if (id === this.idValue) {
      this.formTarget.submit()
    }
  }
}
