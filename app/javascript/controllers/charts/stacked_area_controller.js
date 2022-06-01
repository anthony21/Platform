import { Controller } from '@hotwired/stimulus'

import { updateAmchartsTheme } from 'utils/amcharts'

export default class extends Controller {
  static targets = ['chart']

  static values = {
    url: String,
    series: Array
  }

  connect () {
    updateAmchartsTheme()

    const chart = am4core.create(this.chartTarget, am4charts.XYChart)
    chart.hiddenState.properties.opacity = 0
    chart.dataSource.url = this.urlValue

    const dateAxis = chart.xAxes.push(new am4charts.DateAxis())
    dateAxis.renderer.minGridDistance = 60
    dateAxis.startLocation = 0.5
    dateAxis.endLocation = 0.5
    dateAxis.baseInterval = {
      timeUnit: 'day',
      count: 1
    }

    const valueAxis = chart.yAxes.push(new am4charts.ValueAxis())
    valueAxis.tooltip.disabled = true

    this.seriesValue.forEach(({ name, key }) => {
      const series = chart.series.push(new am4charts.LineSeries())
      series.dataFields.dateX = 'date'
      series.name = name
      series.dataFields.valueY = key
      series.tooltipText = `${name}: {valueY}`
      series.fillOpacity = 0.6
      series.strokeWidth = 2
      series.stacked = true
    })

    chart.cursor = new am4charts.XYCursor()
    chart.cursor.xAxis = dateAxis

    // Add a legend
    chart.legend = new am4charts.Legend()
    chart.legend.position = 'top'
  }
}
