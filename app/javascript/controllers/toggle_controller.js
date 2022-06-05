import { Controller } from '@hotwired/stimulus'

import { fire } from 'utils/events'

export const TOGGLE_EVENT = 'toggle.toggle'

export default class extends Controller {
  static targets = [
    'hiddenField'
  ]

  static values = {
    id: String,
    enabled: Boolean
  }

  toggle (event) {
    event.preventDefault()

    this.enabledValue = !this.enabledValue
    this.hiddenFieldTarget.value = this.enabledValue

    fire(TOGGLE_EVENT, this.idValue)
  }
}
