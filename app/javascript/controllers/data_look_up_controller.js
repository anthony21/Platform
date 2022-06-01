import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['resultsFrame']

  showLoading () {
    this.resultsFrameTarget.innerHTML = '<p class="text-center p-20">Searching...</p>'
  }
}
