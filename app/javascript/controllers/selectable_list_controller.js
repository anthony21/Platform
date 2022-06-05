import { Controller } from '@hotwired/stimulus'

import { fire } from 'utils/events'

export default class extends Controller {
  static targets = ['element']

  selectElement (event) {
    event.preventDefault()

    this.deselectElements()
    this.applySelectedStyle(event.currentTarget)

    const { elementValue } = event.currentTarget.dataset
    fire('selectableList.select', elementValue)
  }

  applySelectedStyle (element) {
    element.classList.remove('border-transparent')
    element.classList.add('border-blue', 'dark:border-blue', 'bg-gray-100', 'dark:bg-gray-700')
  }

  removeSelectedStyle (element) {
    element.classList.remove('border-blue', 'dark:border-blue', 'bg-gray-100', 'dark:bg-gray-700')
    element.classList.add('border-transparent')
  }

  deselectElements () {
    this.elementTargets.forEach(this.removeSelectedStyle)
  }
}
