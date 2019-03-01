import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "status", "item", "image", "next" ]

  connect() {
  	this.timeout = null
  	this.duration = this.data.get("duration") || 1000
    this.load()
  }


  load() {
    document.getElementById("loader").classList.toggle("d-none")
    var url = this.data.get("url") + "&question=" + this.data.get("section")
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
        document.getElementById("loader").classList.toggle("d-none")
      })
    }

  save() {
  	clearTimeout(this.timeout)

  	this.timeout = setTimeout(() => {
      this.statusTarget.setAttribute("class", "bg-light text-center py-3 w100")
  		this.statusTarget.textContent = "Saving..."
  		Rails.fire(this.formTarget, 'submit')
  	}, this.duration);
  }


  success() {
  	this.statusTarget.setAttribute("class", "bg-success text-center py-3 w100")
    this.statusTarget.textContent = "Saved!"


    this.itemTargets.forEach((el, i) => {
      if (el.value) {
        var url = this.data.get("url") + "&question=" + this.data.get("section")
        fetch(url)
          .then(response => response.text())
          .then(html => {
            this.element.innerHTML = html
          })

        this.itemTarget.value = ""
        this.itemTarget.removeAttribute("disabled")
      }
    })



  	setTimeout(() => {
  		this.statusTarget.textContent = ""
  		this.statusTarget.removeAttribute("class", "bg-success")
  	}, 3000)
  }

  error() {
  	this.statusTarget.classList.add = "bg-danger text-center py-3 w100"
    this.statusTarget.textContent = "Error!"

  	setTimeout(() => {
  		this.statusTarget.textContent = ""
  		this.statusTarget.classList.remove = "bg-danger"
  	}, 3000)
  }


  next(e){
    e.preventDefault()
    window.scrollTo(0,0)
    document.getElementById("loader").classList.toggle("d-none")
    var num = parseInt(this.data.get("section"))
    this.data.set("section", num+1)

    var url = this.data.get("url") + "&question=" + this.data.get("section")
    console.log(url)
    fetch(url)
      .then(response => response.text(
      ))
      .then(html => {
        this.element.innerHTML = html
        
        document.getElementById("loader").classList.toggle("d-none")
      })
    
  }

  back(e){
    e.preventDefault()
    window.scrollTo(0,0)
    document.getElementById("loader").classList.toggle("d-none")

    var num = parseInt(this.data.get("section"))
    this.data.set("section", num-1)

    var url = this.data.get("url") + "&question=" + this.data.get("section")
    console.log(url)
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
        document.getElementById("loader").classList.toggle("d-none")
      })
    
  }



  choose(e) {
    e.preventDefault()
    this.currentItem = e.target.getAttribute('data-id')
    e.target.classList.add("deleting")
    this.imageTargets.forEach((el, i) => {
      if (this.currentItem === el.getAttribute("data-id")) {
        fetch('/delete_image',{
          method: "DELETE",
          credentials: 'include',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({id: el.getAttribute('data-id')})
        }).then(function(response) {
          if(response.ok) {
            el.remove()
          }
        }).catch(function(error) {
           e.target.classList.remove("deleting")
        });
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