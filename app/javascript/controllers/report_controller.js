import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "status", "item", "image", "next" ]

  connect() {
  	this.timeout = null
  	this.duration = this.data.get("duration") || 1000
     this.load()
  }


  load() {
    var url = this.data.get("url") + "&question=" + this.data.get("section")
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
    }

  save() {
  	clearTimeout(this.timeout)

  	this.timeout = setTimeout(() => {
  		this.statusTarget.textContent = "Saving..."
  		Rails.fire(this.formTarget, 'submit')
  	}, this.duration);
  }

  // clear(){
  //   this.itemTarget.value = ''
  //   this.itemTarget.removeAttribute("disabled")
  // }

  success() {
  	this.statusTarget.textContent = "Saved!"
  	this.statusTarget.setAttribute("class", "bg-success")

   
    if (this.itemTarget.value) {
      var url = this.data.get("url") + "&question=" + this.data.get("section")

      fetch(url)
        .then(response => response.text())
        .then(html => {
          this.element.innerHTML = html
        })

      this.itemTarget.value = ""
      this.itemTarget.removeAttribute("disabled")
    }



  	setTimeout(() => {
  		this.statusTarget.textContent = ""
  		this.statusTarget.removeAttribute("class", "bg-success")
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


  next(e){
    e.preventDefault()
    var num = parseInt(this.data.get("section"))
    this.data.set("section", num+1)

    var url = this.data.get("url") + "&question=" + this.data.get("section")
    console.log(url)
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
        window.scrollTo(0,0)
      })
    
  }

  back(e){
    e.preventDefault()
    var num = parseInt(this.data.get("section"))
    this.data.set("section", num-1)

    var url = this.data.get("url") + "&question=" + this.data.get("section")
    console.log(url)
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
        window.scrollTo(0,0)
      })
    
  }



  choose(e) {
    e.preventDefault()
    this.currentItem = e.target.getAttribute('data-id')

    this.imageTargets.forEach((el, i) => {
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