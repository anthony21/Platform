import { Controller } from '@hotwired/stimulus'

import { listen, ignore, fire } from 'utils/events'

export const SELECT_IMAGE_EVENT = 'SELECT_IMAGE'
const SHOW_IMAGE_GALLERY_EVENT = 'SHOW_IMAGE_GALLERY'

export default class extends Controller {
  static values = {
    imageInputId: String
  }

  connect () {
    listen(SHOW_IMAGE_GALLERY_EVENT, this.onShowImageGallery)
  }

  disconnect () {
    ignore(SHOW_IMAGE_GALLERY_EVENT, this.onShowImageGallery)
  }

  onShowImageGallery = (event) => {
    this.imageInputIdValue = event.detail
    fire('show-modal', 'image-gallery')
  }

  selectImage (event) {
    const imageTile = event.target

    fire(SELECT_IMAGE_EVENT, {
      imageInputId: this.imageInputIdValue,
      name: imageTile.dataset.image,
      src: imageTile.src
    })
  }
}
