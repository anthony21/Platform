import { Controller } from '@hotwired/stimulus'

import { listen, ignore } from 'utils/events'
import { SELECT_IMAGE_EVENT } from 'controllers/image_gallery_controller'

export default class extends Controller {
  static targets = ['field', 'fileNameLabel', 'image', 'galleryField']

  static values = {
    id: String
  }

  get fileName () {
    return this.fieldTarget.value.split('\\').slice(-1)
  }

  connect () {
    listen(SELECT_IMAGE_EVENT, this.onSelectImage)
  }

  disconnect () {
    ignore(SELECT_IMAGE_EVENT, this.onSelectImage)
  }

  onFileChosen () {
    if (this.fieldTarget.value.length === 0) { return }

    if (this.hasGalleryFieldTarget) {
      this.galleryFieldTarget.value = null
    }

    this.imageTarget.classList.add('hidden')

    this.fileNameLabelTarget.innerText = this.fileName
    this.fileNameLabelTarget.classList.remove('hidden')
  }

  chooseFile (event) {
    event.preventDefault()

    this.fieldTarget.click()
  }

  onSelectImage = (event) => {
    const { imageInputId, name, src } = event.detail
    if (this.idValue !== imageInputId) { return }

    this.galleryFieldTarget.value = name

    this.imageTarget.style = 'max-width: 300px; max-height: 300px;'
    this.imageTarget.src = src
    this.imageTarget.classList.remove('hidden')

    this.fileNameLabelTarget.classList.add('hidden')
  }
}
