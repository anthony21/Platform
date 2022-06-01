import { Controller } from '@hotwired/stimulus'

import { listen, ignore, fire } from 'utils/events'

export const toggleHidden = (element, force) => {
  element.classList.toggle('hidden', force)
}

export const hideElement = (element) => {
  toggleHidden(element, true)
}

export const showElement = (element) => {
  toggleHidden(element, false)
}

export const showHiddenId = (hiddenId) => {
  fire('show-element', hiddenId)
}

export const hideHiddenId = (hiddenId) => {
  fire('hide-element', hiddenId)
}

export const toggleHiddenId = (hiddenId) => {
  fire('toggle-hidden', hiddenId)
}

export default class extends Controller {
  static targets = ['element']

  get hiddenElement () {
    return this.hasElementTarget ? this.elementTarget : this.element
  }

  connect () {
    listen('show-element', this.onShowElement)
    listen('hide-element', this.onHideElement)
    listen('toggle-hidden', this.onToggleHidden)
  }

  disconnect () {
    ignore('show-element', this.onShowElement)
    ignore('hide-element', this.onHideElement)
    ignore('toggle-hidden', this.onToggleHidden)
  }

  onShowElement = (event) => {
    this.applyHiddenClasses(event.detail, false)
  }

  onHideElement = (event) => {
    this.applyHiddenClasses(event.detail, true)
  }

  onToggleHidden = (event) => {
    this.applyHiddenClasses(event.detail)
  }

  showElement (event) {
    event.preventDefault()
    event.stopPropagation()

    this.applyHiddenClasses(event.currentTarget.dataset.hiddenTargetId, false)
  }

  hideElement (event) {
    event.preventDefault()
    event.stopPropagation()

    this.applyHiddenClasses(event.currentTarget.dataset.hiddenTargetId, true)
  }

  toggleHidden (event) {
    event.preventDefault()
    event.stopPropagation()

    this.applyHiddenClasses(event.currentTarget.dataset.hiddenTargetId)
  }

  applyHiddenClasses (hiddenId, force) {
    if (hiddenId) {
      const hiddenIds = hiddenId.split(' ')

      this.elementTargets.forEach((element) => {
        if (hiddenIds.includes(element.dataset.hiddenId)) {
          toggleHidden(element, force)
        }
      })
    } else {
      this.hiddenElement.classList.toggle('hidden', force)
    }
  }
}
