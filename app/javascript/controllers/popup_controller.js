import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popup" ]

  toggle() {
    this.popupTarget.open ? this.popupTarget.close() : this.popupTarget.showModal()
  }

  close() {
    this.popupTarget.close()
  }
}
