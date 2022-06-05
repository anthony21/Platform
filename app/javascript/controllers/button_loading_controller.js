import { Controller } from '@hotwired/stimulus'

import { hideElement, showElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static targets = ['icon', 'loadingIcon']

  connect () {
    document.querySelector('form').addEventListener('submit', this.showLoading)
  }

  showLoading = () => {
    this.disableButton()
    this.removeButtonClasses()
    this.addDisabledClasses()
    this.updateIcon()
  }

  disableButton () {
    this.element.disabled = true
  }

  removeButtonClasses () {
    const classesToRemove = []
    this.element.classList.forEach((cssClass) => {
      if (cssClass.includes('hover:') || cssClass === 'cursor-pointer') {
        classesToRemove.push(cssClass)
      }
    })
    this.element.classList.remove(...classesToRemove)
  }

  addDisabledClasses () {
    this.element.classList.add('cursor-not-allowed', 'opacity-50')
  }

  updateIcon () {
    if (this.hasIconTarget) {
      hideElement(this.iconTarget)
    }
    showElement(this.loadingIconTarget)
  }
}
