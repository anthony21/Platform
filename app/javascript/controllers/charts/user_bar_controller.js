import { Controller } from '@hotwired/stimulus'

import { updateAmchartsTheme } from 'utils/amcharts'

export default class extends Controller {
  static targets = ['chart']

  static values = {
    url: String
  }

  connect () {
    updateAmchartsTheme()

    const chart = am4core.create(this.chartTarget, am4charts.XYChart)
    chart.hiddenState.properties.opacity = 0
    chart.dataSource.url = this.urlValue

    const categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis())
    categoryAxis.renderer.grid.template.location = 0
    categoryAxis.dataFields.category = 'initials'
    categoryAxis.dataFields.userName = 'name'
    categoryAxis.renderer.minGridDistance = 60
    categoryAxis.renderer.inversed = true
    categoryAxis.renderer.grid.template.disabled = true

    const label = categoryAxis.renderer.labels.template
    label.truncate = true
    label.maxWidth = 100
    label.tooltipText = '{userName}'

    const valueAxis = chart.yAxes.push(new am4charts.ValueAxis())
    valueAxis.min = 0
    valueAxis.extraMax = 0.1
    valueAxis.renderer.minGridDistance = 30
    valueAxis.renderer.baseGrid.disabled = true

    const series = chart.series.push(new am4charts.ColumnSeries())
    series.dataFields.categoryX = 'initials'
    series.dataFields.categoryName = 'name'
    series.dataFields.valueY = 'value'
    series.columns.template.tooltipText = '{categoryName}: [bold]{valueY.value}'
    series.columns.template.tooltipY = 0
    series.columns.template.strokeOpacity = 0
    series.columns.template.column.cornerRadiusTopRight = 10
    series.columns.template.column.cornerRadiusTopLeft = 10

    const labelBullet = series.bullets.push(new am4charts.LabelBullet())
    labelBullet.label.verticalCenter = 'bottom'
    labelBullet.label.dy = -10
    labelBullet.label.text = "{values.valueY.workingValue.formatNumber('#.')}"

    series.columns.template.adapter.add('fill', function (fill, target) {
      return chart.colors.getIndex(target.dataItem.index)
    })
  }
}
