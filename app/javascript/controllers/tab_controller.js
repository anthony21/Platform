import { Controller } from '@hotwired/stimulus'

import { showHiddenId, hideHiddenId } from 'controllers/hidden_controller'
import { fire } from 'utils/events'

export default class extends Controller {
  static targets = ['link', 'linkArrow', 'select', 'option']

  static values = {
    activeTab: String,
    activeClass: String,
    inactiveClass: String,
    useQueryParams: Boolean
  }

  get activeTabIndex () {
    return this.linkTargets.findIndex((l) => l.dataset.tabId === this.activeTabValue)
  }

  get activeClasses () {
    return this.activeClassValue.split(' ')
  }

  get inactiveClasses () {
    return this.inactiveClassValue.split(' ')
  }

  connect () {
    // Set the first tab as selected if there is no active tab yet
    const activeTab = this.activeTabValue || this.linkTargets[0].dataset.tabId

    showHiddenId(`tab.${activeTab}`)
    this.activeTabValue = activeTab
    this.removeClasses(activeTab, this.inactiveClasses)
    this.addClasses(activeTab, this.activeClasses)
    this.showLinkArrow(activeTab)
    this.updateSelectIndex()

    this.linkTargets.forEach((link) => {
      if (link.dataset.tabId !== activeTab) {
        this.addClasses(link.dataset.tabId, this.inactiveClasses)
      }
    })

    this.showTabFromQueryParams()
  }

  showTabFromQueryParams () {
    if (!this.useQueryParamsValue) {
      return
    }

    const urlParams = new URLSearchParams(window.location.search)
    const tabId = urlParams.get('tab')

    if (tabId) {
      this.showTab(tabId)
    }
  }

  show (event) {
    event.preventDefault()

    this.showTab(event.currentTarget.dataset.tabId)
  }

  showTab (tabId) {
    hideHiddenId(`tab.${this.activeTabValue}`)
    showHiddenId(`tab.${tabId}`)

    // Update active link
    this.hideLinkArrow(this.activeTabValue)
    this.removeClasses(this.activeTabValue, this.activeClasses)
    this.addClasses(this.activeTabValue, this.inactiveClasses)

    this.showLinkArrow(tabId)
    this.removeClasses(tabId, this.inactiveClasses)
    this.addClasses(tabId, this.activeClasses)

    this.activeTabValue = tabId
    this.updateSelectIndex()

    // Resize any inputs that may be appearing for the first time on this tab.
    fire('resize-input')

    if (this.useQueryParamsValue) {
      // Set active tab in query params
      const urlSplit = window.location.href.split('?')
      const state = { Title: document.title, Url: urlSplit[0] + `?tab=${tabId}` }
      history.pushState(state, state.Title, state.Url)
    }

    fire('after:show-tab', this.activeTabValue)
  }

  updateSelectIndex () {
    if (this.hasSelectTarget) {
      const selectedIndex = this.optionTargets.findIndex((o) => o.dataset.tabId === this.activeTabValue)
      this.selectTarget.selectedIndex = selectedIndex
    }
  }

  hideLinkArrow (tabId) {
    const linkArrows = this.linkArrowTargets.filter(a => a.dataset.tabId === tabId)
    linkArrows.forEach(linkArrow => linkArrow.classList.replace('absolute', 'hidden'))
  }

  showLinkArrow (tabId) {
    const linkArrows = this.linkArrowTargets.filter(a => a.dataset.tabId === tabId)
    linkArrows.forEach(linkArrow => linkArrow.classList.replace('hidden', 'absolute'))
  }

  addClasses (tabId, classes) {
    this.getLink(tabId).classList.add(...classes)
  }

  removeClasses (tabId, classes) {
    this.getLink(tabId).classList.remove(...classes)
  }

  getLink (tabId) {
    return this.linkTargets.find((link) => link.dataset.tabId === tabId)
  }

  updateFromSelect () {
    const selectedOption = this.optionTargets[this.selectTarget.selectedIndex]
    const { tabId } = selectedOption.dataset
    this.showTab(tabId)
  }

  previousTab (event) {
    event.preventDefault()

    const { activeTabIndex } = this
    const prevTabIndex = activeTabIndex - 1 < 0 ? this.linkTargets.length - 1 : activeTabIndex - 1
    const prevTab = this.linkTargets[prevTabIndex].dataset.tabId

    this.showTab(prevTab)
  }

  nextTab (event) {
    event.preventDefault()

    const { activeTabIndex } = this
    const nextTabIndex = activeTabIndex + 1 >= this.linkTargets.length ? 0 : activeTabIndex + 1
    const nextTab = this.linkTargets[nextTabIndex].dataset.tabId

    this.showTab(nextTab)
  }
}
