import { Controller } from '@hotwired/stimulus'

import { fire } from 'utils/events'

export default class extends Controller {
  fire (event) {
    event.preventDefault()

    const { eventName, eventDetail } = event.currentTarget.dataset
    fire(eventName, eventDetail)
  }
}
