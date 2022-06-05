import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['button', 'source']
  static values = {
    successDuration: Number
  }

  connect () {
    if (!this.hasButtonTarget) return

    this.originalContent = this.buttonTarget.innerHTML
    this.successDuration = this.successDurationValue || 2000
  }

  copy (event) {
    event.preventDefault()

    this.sourceTarget.select()
    document.execCommand('copy')

    this.copied()
  }

  copied () {
    if (!this.hasButtonTarget) return

    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    this.buttonTarget.innerHTML = this.data.get('successContent')

    this.timeout = setTimeout(() => {
      this.buttonTarget.innerHTML = this.originalContent
    }, this.successDuration)
  }
}
