import { Controller } from '@hotwired/stimulus'
import TableFilter from 'tablefilter'

export default class extends Controller {
  connect () {
    this.tableFilter = new TableFilter(this.element, { base_path: '/tablefilter/' })
    this.tableFilter.init()
  }
}
