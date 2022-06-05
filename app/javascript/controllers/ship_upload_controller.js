import { Controller } from '@hotwired/stimulus'

import { listen, ignore } from 'utils/events'
import { hideElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static targets = ['saveButton']

  connect () {
    listen('shipUploadAdded', this.onFileAdded)
    listen('shipUploadSuccess', this.onFileUploaded)
  }

  disconnect () {
    ignore('shipUploadAdded', this.onFileAdded)
    ignore('shipUploadSuccess', this.onFileUploaded)
  }

  onFileAdded = () => {
    hideElement(document.querySelector('.dz-message'))
  }

  onFileUploaded = () => {
    this.saveButtonTarget.disabled = false
  }
}
