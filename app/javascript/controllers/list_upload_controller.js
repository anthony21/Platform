import { Controller } from '@hotwired/stimulus'

import { fetchTurbo } from 'utils/turbo'
import readSomeLines from 'utils/read_some_lines'
import { listen, ignore } from 'utils/events'
import { hideElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static targets = ['turboFrame', 'saveButton']

  static values = {
    url: String
  }

  fileUploaded = false

  connect () {
    listen('listUploadAdded', this.onFileAdded)
    listen('listUploadSuccess', this.onFileUploaded)
  }

  disconnect () {
    ignore('listUploadAdded', this.onFileAdded)
    ignore('listUploadSuccess', this.onFileUploaded)
  }

  onFileAdded = async (event) => {
    hideElement(document.querySelector('.dz-message'))

    const { file } = event.detail

    readSomeLines(file, 1, (line) => {
      this.fetchMappingForm(file.name, line)
    })
  }

  onFileUploaded = () => {
    this.fileUploaded = true
    this.enableSaveButton()
  }

  fetchMappingForm = (name, firstLine) => {
    fetchTurbo({
      url: this.urlValue,
      body: { name, first_line: firstLine }
    }).then(() => {
      setTimeout(() => {
        if (this.fileUploaded) {
          this.enableSaveButton()
        }
      }, 1000)
    })
  }

  enableSaveButton () {
    if (this.hasSaveButtonTarget) {
      this.saveButtonTarget.disabled = false
    }
  }
}
