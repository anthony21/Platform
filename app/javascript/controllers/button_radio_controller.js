import { Controller } from '@hotwired/stimulus'

import { fire } from 'utils/events'

export default class extends Controller {
  static targets = ['option']

  static values = {
    field: String,
    deselectedClass: String,
    selectedClass: String
  }

  get deselectedClasses () {
    return this.deselectedClassValue.split(' ')
  }

  get selectedClasses () {
    return this.selectedClassValue.split(' ')
  }

  applySelectedStyle (event) {
    const { option } = event.currentTarget.dataset
    fire('button-radio:change', { field: this.fieldValue, option })

    this.optionTargets.forEach((optionTarget) => {
      if (optionTarget.dataset.option === option) {
        optionTarget.classList.remove(...this.deselectedClasses)
        optionTarget.classList.add(...this.selectedClasses)
      } else {
        optionTarget.classList.remove(...this.selectedClasses)
        optionTarget.classList.add(...this.deselectedClasses)
      }
    })
  }
}
