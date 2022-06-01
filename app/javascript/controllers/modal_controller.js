import { Controller } from '@hotwired/stimulus'

import { listen, ignore, fire } from 'utils/events'
import wait from 'utils/wait'

export default class extends Controller {
  static targets = ['container', 'background', 'panel']

  static values = {
    id: String
  }

  connect () {
    listen('show-modal', this.show)
    listen('hide-modal', this.onHide)
  }

  disconnect () {
    ignore('show-modal', this.show)
    ignore('hide-modal', this.onHide)
  }

  show = (event) => {
    const modalId = event.detail
    if (modalId !== this.idValue) {
      return
    }

    this.containerTarget.classList.replace('hidden', 'sm:flex')

    wait(0).then(() => {
      this.backgroundTarget.classList.replace('ease-in', 'ease-out')
      this.backgroundTarget.classList.replace('duration-200', 'duration-300')
      this.backgroundTarget.classList.replace('opacity-0', 'opacity-100')

      this.panelTarget.classList.replace('ease-in', 'ease-out')
      this.panelTarget.classList.replace('duration-200', 'duration-300')
      this.panelTarget.classList.replace('opacity-0', 'opacity-100')
      this.panelTarget.classList.replace('translate-y-4', 'translate-y-0')
      this.panelTarget.classList.remove('sm:translate-y-0')
      this.panelTarget.classList.replace('sm:scale-95', 'sm:scale-100')

      fire('after:show-modal', this.idValue)
    })
  }

  hide (event) {
    event.preventDefault()

    fire('before:hideModal', this.idValue)

    this.backgroundTarget.classList.replace('ease-out', 'ease-in')
    this.backgroundTarget.classList.replace('duration-300', 'duration-200')
    this.backgroundTarget.classList.replace('opacity-100', 'opacity-0')

    this.panelTarget.classList.replace('ease-out', 'ease-in')
    this.panelTarget.classList.replace('duration-300', 'duration-200')
    this.panelTarget.classList.replace('opacity-100', 'opacity-0')
    this.panelTarget.classList.replace('translate-y-0', 'translate-y-4')
    this.panelTarget.classList.add('sm:translate-y-0')
    this.panelTarget.classList.replace('sm:scale-100', 'sm:scale-95')

    wait(200).then(() => {
      this.containerTarget.classList.replace('sm:flex', 'hidden')
    })
  }

  onHide = (event) => {
    const modalId = event.detail

    if (modalId === this.idValue) {
      this.hide(event)
    }
  }
}
