import { Controller } from '@hotwired/stimulus'

import { hideElement, showElement } from 'controllers/hidden_controller'

const MINIMUM_INPUT_VALUE_LENGTH = 3
const SAN_LENGTH = 18

export default class extends Controller {
  static targets = [
    'approveRadio',
    'acceptTermsCheckbox',
    'nameInput',
    'jobTitleInput',
    'submitButton',
    'approvalDetails',
    'combinedSanInput',
    'sanExpirationInput',
    'sanLicenseeInput',
    'sanAuthnameInput',
    'sanAuthtitleInput',
    'sanExemptCheckbox'
  ]

  static values = {
    disabledButtonText: String,
    approveButtonText: String,
    rejectButtonText: String
  }

  approvalCompleted () {
    return this.approveRadioTarget.checked &&
      this.acceptTermsCheckboxTarget.checked &&
      this.nameInputTarget.value.length >= MINIMUM_INPUT_VALUE_LENGTH &&
      this.jobTitleInputTarget.value.length >= MINIMUM_INPUT_VALUE_LENGTH
  }

  sanCompleted () {
    if (!this.hasCombinedSanInputTarget) {
      return true
    }

    return this.sanFieldsFilled() || this.sanExempt()
  }

  sanFieldsFilled () {
    return this.combinedSanInputTarget.value.length === SAN_LENGTH &&
      this.sanExpirationInputTarget.value !== '' &&
      this.sanLicenseeInputTarget.value !== '' &&
      this.sanAuthnameInputTarget.value !== '' &&
      this.sanAuthtitleInputTarget.value !== ''
  }

  sanExempt () {
    return this.sanExemptCheckboxTarget.checked
  }

  enableApproveButton () {
    if (this.approvalCompleted() && this.sanCompleted()) {
      this.submitButtonTarget.disabled = false
      this.submitButtonTarget.innerHTML = this.approveButtonTextValue
    } else {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.innerHTML = this.disabledButtonTextValue
    }
  }

  enableRejectButton () {
    this.submitButtonTarget.disabled = false
    this.submitButtonTarget.innerHTML = this.rejectButtonTextValue
  }

  showApprovalDetails () {
    showElement(this.approvalDetailsTarget)
    this.submitButtonTarget.innerHTML = this.disabledButtonTextValue
  }

  hideApprovalDetails () {
    hideElement(this.approvalDetailsTarget)
    this.submitButtonTarget.disabled = false
    this.submitButtonTarget.innerHTML = this.rejectButtonTextValue
  }
}
