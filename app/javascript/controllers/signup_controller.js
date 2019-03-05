import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form","save","tab"]

  initialize() {
    this.showCurrentTab()
  }

  next(e) {
  	e.preventDefault()
	  this.index++
  }

  previous(e) {
  	e.preventDefault()
    this.index--
  }

  showCurrentTab() {
    this.tabTargets.forEach((el, i) => {
	     el.classList.toggle("tab--current", this.index == i)
    })
  }

  get index() {
    return parseInt(this.data.get("index"))
  }

  set index(value) {
    this.data.set("index", value)
    this.showCurrentTab()
  }


  submitCustomer(e) {
    fetch('/signup',{
      method: "POST",
      credentials: 'include',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
      	customer: {
	      	email: document.getElementById('email').value,
	      	password:document.getElementById('password').value,
	      	first_name: document.getElementById('first').value,
	      	last_name: document.getElementById('last').value,
	      	mobile: document.getElementById('mobile').value
      	}
      })
    }).then(function(response) {
      if(response.ok) {
       
      }
    }).catch(function(error) {
      alert(error)
    });

  }


  submitJob(e) {
  	e.preventDefault()

  	var customercookie = this.getCookie("customer")
  	
    fetch('/jobs',{
      method: "POST",
      credentials: 'include',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
      	job: {
	      	price: document.getElementById('job-price').value,
	      	address_id:document.getElementById('job-address-id').value,
	      	customer_id: customercookie,
	      	date: document.getElementById('job-date').value,
	      	time: document.getElementById('job-time').value
      	}
      })
    }).then(function(response) {
      if(response.ok) {
      }
    }).catch(function(error) {
      alert(error)
    });
  }


	fixStepIndicator(n) {
	  // This function removes the "active" class of all steps...
	  var i, x = document.getElementsByClassName("step");
	  for (i = 0; i < x.length; i++) {
	    x[i].className = x[i].className.replace(" active", "");
	  }
	  //... and adds the "active" class to the current step:
	  x[n].className += " active";
	}


	getCookie(cname) {
	  var name = cname + "=";
	  var ca = document.cookie.split(';');
	  for(var i = 0; i < ca.length; i++) {
	    var c = ca[i];
	    while (c.charAt(0) == ' ') {
	      c = c.substring(1);
	    }
	    if (c.indexOf(name) == 0) {
	      return c.substring(name.length, c.length);
	    }
	  }
	  return "";
	}



  success() {
  	alert("success")

  }

  error() {
  	alert("error")
  }

}
