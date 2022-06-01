import { Controller } from '@hotwired/stimulus'
import _ from 'lodash'

import getCSRFToken from 'utils/csrf'
import { listen, ignore, fire } from 'utils/events'
import { hideElement, showElement } from 'controllers/hidden_controller'

export default class extends Controller {
  static targets = ['form', 'results', 'loading', 'error']

  static values = {
    path: String
  }

  connect () {
    listen('submit-count', this.submitCount)
    listen('save-audience', this.submitForm)
  }

  disconnect () {
    ignore('submit-count', this.submitCount)
    ignore('save-audience', this.submitForm)
  }

  submitCount = _.debounce((event) => {
    event.preventDefault()

    hideElement(this.errorTarget)

    this.stopCurrentRequest()
    this.abortController = new AbortController()
    const { signal } = this.abortController

    const showLoading = setTimeout(() => {
      showElement(this.loadingTarget)
    }, 500)

    fetch(this.pathValue, {
      method: 'PUT',
      body: new FormData(this.formTarget),
      headers: {
        'X-CSRF-Token': getCSRFToken()
      },
      signal
    })
      .then((response) => {
        if (!response.ok) {
          throw Error(response.statusText)
        }
        return response
      })
      .then((response) => response.text())
      .then((response) => {
        clearTimeout(showLoading)
        this.resultsTarget.innerHTML = response
        fire('after:submit-count')
      })
      .catch(() => {
        clearTimeout(showLoading)

        if (!signal.aborted) {
          hideElement(this.loadingTarget)
          showElement(this.errorTarget)
        }
      })
  }, 200, { leading: true })

  stopCurrentRequest () {
    if (this.abortController) {
      this.abortController.abort()
    }
  }

  submitForm = () => {
    this.formTarget.submit()
  }
}
