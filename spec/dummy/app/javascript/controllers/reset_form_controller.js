import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  reset() {
    console.log("Resetting form");
    this.element.reset();
  }
}
