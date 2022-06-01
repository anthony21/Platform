import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['hiddenField']

  static values = {
    activeClass: String
  }

  get activeClasses () {
    return this.activeClassValue.split(' ')
  }

  toggle (event) {
    const { append } = event.currentTarget.dataset
    let appends = JSON.parse(this.hiddenFieldTarget.value)

    if (appends.includes(append)) {
      appends = appends.filter(a => a !== append)
      event.currentTarget.classList.remove(...this.activeClasses)
    } else {
      appends.push(append)
      event.currentTarget.classList.add(...this.activeClasses)
    }

    this.hiddenFieldTarget.value = JSON.stringify(appends)
  }
}
