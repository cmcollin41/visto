import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "item", "image" ]

  connect() {
  	this.timeout = null
  	this.duration = this.data.get("duration") || 1000
    // this.load()
  }


  // load() {
  //   fetch(this.data.get("url"))
  //     .then(response => response.text())
  //     .then(html => {
  //       this.element.innerHTML = html
  //     })
  //   }


  choose(e) {
    e.preventDefault()
    this.currentItem = e.target.getAttribute('data-id')

    this.itemTargets.forEach((el, i) => {
      if (this.currentItem === el.getAttribute("data-id")) {
        fetch('/delete_image',{
          method: "DELETE",
          credentials: 'include',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({id: el.getAttribute('data-id')})
        })

        el.remove()
      }
    })
  }

  get currentItem(){
     return this.data.get("current-image")
  }

  set currentItem(id) {
    if (this.currentItem !== id) {
      this.data.set("current-image", id)
    }
  }




}