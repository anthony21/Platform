import { Controller } from '@hotwired/stimulus'

import { listen, ignore, fire } from 'utils/events'

export const REMOVE_OMISSION_EVENT = 'REMOVE_OMISSION'

export default class extends Controller {
  static targets = ['hidden']

  get omissions () {
    return JSON.parse(this.hiddenTarget.value).filter(o => o.length > 0)
  }

  set omissions (omissions) {
    this.hiddenTarget.value = JSON.stringify(omissions)
    fire('submit-count')
  }

  connect () {
    listen(REMOVE_OMISSION_EVENT, this.onRemoveOmission)
  }

  disconnect () {
    ignore(REMOVE_OMISSION_EVENT, this.onRemoveOmission)
  }

  onRemoveOmission = (event) => {
    const field = event.detail

    this.hiddenTarget.value = this.omissions.filter(o => o !== field)
  }

  onOmitChange (event) {
    const { field } = event.target.dataset

    if (this.omissions.includes(field)) {
      this.removeOmission(event)
    } else {
      this.addOmission(event)
    }
  }

  addOmission (event) {
    this.omissions = this.omissions.concat([event.target.dataset.field])
  }

  removeOmission (event) {
    const { field } = event.target.dataset
    this.omissions = this.omissions.filter(o => o !== field)
  }
}
