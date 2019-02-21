import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "status" ]

  connect() {
  	this.timeout = null
  	this.duration = this.data.get("duration") || 1000
  }

  save() {
  	clearTimeout(this.timeout)

  	this.timeout = setTimeout(() => {
  		this.statusTarget.textContent = "Saving..."
  		Rails.fire(this.formTarget, 'submit')
  	}, this.duration);
  }

  success() {
  	this.statusTarget.textContent = "Saved!"
  	this.statusTarget.classList.add = "bg-success"

  	setTimeout(() => {
  		this.statusTarget.textContent = ""
  		this.statusTarget.classList.remove = "bg-success"
  	}, 3000)
  }

   error() {
  	this.statusTarget.textContent = "Error!"
  	this.statusTarget.classList.add = "bg-danger"

  	setTimeout(() => {
  		this.statusTarget.textContent = ""
  		this.statusTarget.classList.remove = "bg-danger"
  	}, 3000)
  }



}