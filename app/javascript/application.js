import * as ActiveStorage from '@rails/activestorage'
import Rails from '@rails/ujs'
import '@hotwired/turbo-rails'
import 'alpine-turbo-drive-adapter'
import Alpine from 'alpinejs'
import LocalTime from 'local-time'

import 'controllers'

Rails.start()
ActiveStorage.start()
<<<<<<< HEAD
LocalTime.start() 

window.Alpine = Alpine
Alpine.start()
=======
LocalTime.start()

window.Alpine = Alpine
Alpine.start()
>>>>>>> origin/main
