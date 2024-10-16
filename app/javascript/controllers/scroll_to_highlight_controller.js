import { Controller } from "@hotwired/stimulus"
import { nextFrame } from "helpers/timing_helpers"

export default class extends Controller {
  async connect() {
    await nextFrame()
    this.element.getElementsByTagName("mark")[0].scrollIntoView({ behavior: "smooth", block: "center" })
  }
}
