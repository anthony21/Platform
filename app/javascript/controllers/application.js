import { Application } from '@hotwired/stimulus'

const application = Application.start()

//Configure stimulus development experience
application.debug = false
window.Stimulus = application

export { application }