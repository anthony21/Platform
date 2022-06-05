import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['input', 'change']

  changeElement () {
    this.changeTarget.innerHTML = this.inputTarget.value
  }
}
