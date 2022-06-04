# frozen_string_literal: true

# Rails
pin 'application', preload: true
pin '@rails/activestorage', to: 'activestorage.esm.js'
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.1/lib/assets/compiled/rails-ujs.js'
pin '@hotwired/turbo-rails', to: 'turbo.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/utils', under: 'utils'

# Dropzone
pin 'cropperjs', to: 'https://ga.jspm.io/npm:cropperjs@1.5.12/dist/cropper.js'
pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@5.9.2/dist/dropzone.js'
pin 'utif', to: 'https://ga.jspm.io/npm:utif@3.1.0/UTIF.js'
pin 'pako', to: 'https://ga.jspm.io/npm:pako@1.0.11/index.js'
pin 'process', to: 'https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.17/nodelibs/browser/process-production.js'

# Misc
pin 'alpine-turbo-drive-adapter', to: 'https://ga.jspm.io/npm:alpine-turbo-drive-adapter@2.0.0/dist/alpine-turbo-drive-adapter.esm.js'
pin 'alpinejs', to: 'https://ga.jspm.io/npm:alpinejs@3.8.1/dist/module.esm.js'
pin 'local-time', to: 'https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js'
pin 'lodash', to: 'https://ga.jspm.io/npm:lodash@4.17.21/lodash.js'
pin 'nouislider', to: 'https://ga.jspm.io/npm:nouislider@15.5.1/dist/nouislider.js'
pin 'tablefilter', to: 'https://ga.jspm.io/npm:tablefilter@0.7.0/index.js'
