import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form","save","tab"]

  initialize() {
    this.showCurrentTab()
  }

  next() {
		this.index++
  }

  previous(e) {
  	e.preventDefault()
    this.index--
  }

  showCurrentTab() {
    this.tabTargets.forEach((el, i) => {
    	if (this.index == i ){
	     el.classList.add("tab--current")
	     this.fixStepIndicator(i)
    	} else{
    		el.classList.remove("tab--current")
    	}
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
  	e.preventDefault()
  	if (this.validate()){
  		var that = this;
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
	       	that.next()
	      }
	    }).catch(function(error) {
	      alert(error)
	    });
  	}
  }


  submitJob(e) {
  	e.preventDefault()

  	var customercookie = this.getCookie("customer")
  	var totalprice = this.getCookie("totalprice")
  	var address = this.getCookie("address")

  	var that = this;

  	if (this.validate()){
	    fetch('/jobs',{
	      method: "POST",
	      credentials: 'include',
	      headers: {'Content-Type': 'application/json'},
	      body: JSON.stringify({
	      	job: {
		      	price: totalprice,
		      	address_id: address,
		      	customer_id: customercookie,
		      	date: document.getElementById('job-date').value,
		      	time: document.getElementById('job-time').value
	      	}
	      })
	    }).then(function(response) {
	      if(response.ok) {
	      	that.next()
	      }
	    }).catch(function(error) {
	      alert(error)
	    });
	  };
  }
  

  validate() {
	  var valid = true
	  this.formTargets.forEach((el, i) => {
	  	if (this.index == 1 ) {
	    	var y = el.getElementsByTagName("input")
	    	var error = el.getElementsByClassName("error")[0]
	    	for (i = 0; i < y.length; i++) {
			    // If a field is empty...
			    if (y[i].value == "") {
			      // add an "invalid" class to the field:
			      error.classList.add("bg-danger");
			      error.classList.remove("d-none");
			      // and set the current valid status to false:
			      valid = false;
			    }
			  }
	  	} else if (this.index == 2) {
	  		var y = el.getElementsByTagName("input")
	    	var error = el.getElementsByClassName("error")[1]
	    	for (i = 0; i < y.length; i++) {
			    // If a field is empty...
			    if (y[i].value == "") {
			      // add an "invalid" class to the field:
			      error.classList.add("bg-danger");
			      error.classList.remove("d-none");
			      // and set the current valid status to false:
			      valid = false;
			    }
			  }
	  	}
	  })

	  return valid
  }


	fixStepIndicator(n) {
	  // This function removes the "active" class of all steps...
	  var i, x = document.getElementsByClassName("step");
	  for (i = 0; i < x.length; i++) {
	    x[i].classList.remove("active");
	  }
	  //... and adds the "active" class to the current step:
	  if (n != 0){
		  x[n-1].classList.add("finish");
	  }
	  x[n].classList.add("active");
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
