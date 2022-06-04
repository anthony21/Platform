import { Controller } from '@hotwired/stimulus'
import _ from 'lodash'

import { listen, ignore } from 'utils/events'

export default class extends Controller {
  static targets = ['input', 'hidden']

  connect () {
    listen('resize-input', this.resize)
    this.resize()
  }

  disconnect () {
    ignore('resize-input', this.resize)
  }

  resize = _.debounce(
    () => {
      const { placeholder, value } = this.inputTarget

      // Use the placeholder if it's longer than the currently entered value. This is so that
      // the input doesn't possibly move back up to the previous line once the user starts typing,
      // which is pretty jarring.
      this.hiddenTarget.textContent = placeholder.length > value.length ? placeholder : value

      this.inputTarget.style.width = `${this.hiddenTarget.offsetWidth}px`
    },
    0,
    { leading: true }
  )
}
