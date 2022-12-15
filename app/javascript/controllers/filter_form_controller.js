import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="filter-form"
export default class extends Controller {
  filter() {
    this.element.requestSubmit()
  }
}
