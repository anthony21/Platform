import { Controller } from '@hotwired/stimulus'

import { updateAmchartsTheme } from 'utils/amcharts'

export default class extends Controller {
  static targets = ['chart']

  static values = {
    data: Array
  }

  connect () {
    updateAmchartsTheme()

    this.chart = am4core.create(this.chartTarget, am4charts.PieChart3D)
    this.chart.radius = am4core.percent(50)

    this.chart.data = this.dataValue

    const pieSeries = this.chart.series.push(new am4charts.PieSeries3D())
    pieSeries.dataFields.value = 'value'
    pieSeries.dataFields.category = 'key'
    pieSeries.labels.template.maxWidth = 130
    pieSeries.labels.template.wrap = true
    pieSeries.labels.template.fontSize = 12

    const grouper = pieSeries.plugins.push(new am4plugins_sliceGrouper.SliceGrouper())
    grouper.threshold = 1
    grouper.groupName = 'Other'
    grouper.clickBehavior = 'break'

    // This creates initial animation
    pieSeries.hiddenState.properties.opacity = 1
    pieSeries.hiddenState.properties.endAngle = -90
    pieSeries.hiddenState.properties.startAngle = -90
    this.chart.hiddenState.properties.radius = am4core.percent(0)
  }

  disconnect () {
    this.chart.dispose()
  }
}
