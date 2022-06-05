import { Controller } from '@hotwired/stimulus'

import { listen, ignore, fire } from 'utils/events'

export const REMOVE_BREAKDOWN_EVENT = 'REMOVE_BREAKDOWN'

export default class extends Controller {
  static targets = ['hidden']

  get breakdowns () {
    return JSON.parse(this.hiddenTarget.value)
  }

  set breakdowns (breakdowns) {
    this.hiddenTarget.value = JSON.stringify(breakdowns)
  }

  connect () {
    listen(REMOVE_BREAKDOWN_EVENT, this.onRemoveBreakdown)
  }

  disconnect () {
    ignore(REMOVE_BREAKDOWN_EVENT, this.onRemoveBreakdown)
  }

  onRemoveBreakdown = (event) => {
    const field = event.detail

    this.breakdowns = JSON.stringify(this.breakdowns.filter(o => o !== field))
  }

  onBreakdownChange (event) {
    const { field } = event.target.dataset
    let breakdowns = this.breakdowns

    if (breakdowns.includes(field)) {
      breakdowns = breakdowns.filter(o => o !== field)
    } else {
      breakdowns.push(field)
    }

    this.breakdowns = breakdowns
    fire('submit-count')
  }
}
