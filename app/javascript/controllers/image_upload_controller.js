import { Controller } from '@hotwired/stimulus'

import { hideElement, showElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static targets = ['button', 'image', 'field', 'fileNameLabel']

  get fileName () {
    return this.fieldTarget.value.split('\\').slice(-1)
  }

  onFileChosen () {
    if (this.fieldTarget.value.length === 0) {
      return
    }

    if (this.hasImageTarget) {
      hideElement(this.imageTarget)
    }

    this.fileNameLabelTarget.innerText = this.fileName
    showElement(this.fileNameLabelTarget)

    this.buttonTarget.innerText = 'Change'
  }

  chooseFile (event) {
    event.preventDefault()

    this.fieldTarget.click()
  }
}
