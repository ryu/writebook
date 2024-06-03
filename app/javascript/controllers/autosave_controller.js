import { Controller } from "@hotwired/stimulus"

const AUTOSAVE_INTERVAL = 5000

export default class extends Controller {
  static classes = [ "dirty" ]

  #timer

  submit() {
    this.#resetTimer()
  }

  change() {
    if (!this.#timer) {
      this.#timer = setTimeout(() => this.#save(), AUTOSAVE_INTERVAL)
      this.element.classList.add(this.dirtyClass)
    }
  }

  #save() {
    this.#resetTimer()
    this.element.requestSubmit()
    this.element.classList.remove(this.dirtyClass)
  }

  #resetTimer() {
    clearTimeout(this.#timer)
    this.#timer = null
  }
}
