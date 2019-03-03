import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form","save","tab"]

  connect() {
  	var currentTab = 0;
		this.showTab(currentTab);
  }

  load() {

  }

  submit(e) {
  	e.preventDefault()
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

  job(e) {
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

  showTab(n) {
	  // This function will display the specified tab of the form ...

	  var x = document.getElementsByClassName("tab");
	  x[n].classList.toggle("d-none")
	  // ... and fix the Previous/Next buttons:
	  if (n == 0) {
	    document.getElementById("prevBtn").style.display = "none";
	  } else {
	    document.getElementById("prevBtn").style.display = "inline";
	  }
	  // if (n == (x.length - 1)) {
	  //   document.getElementById("nextBtn").innerHTML = "Submit";
	  // } else {
	  //   document.getElementById("nextBtn").innerHTML = "Next";
	  // }
	  // ... and run a function that displays the correct step indicator:
	  // this.fixStepIndicator(n)
	}


	next(e) {
    e.preventDefault()
    console.log(e.target)
    this.currentTab = e.target.getAttribute('data-signup-id')
    
    this.tabTargets.forEach((el, i) => {
    	i = i + 1
      if (this.currentTab == i) {
      	el.classList.toggle("d-none")
      	this.tabTargets[i].classList.toggle("d-none")
      } 
    })
  }

  get currentTab() {
     return this.data.get("current-tab")
  }

  set currentTab(id) {
    if (this.currentTab !== id) {
      this.data.set("current-tab", id)
    }
  }


	// fixStepIndicator(n) {
	//   // This function removes the "active" class of all steps...
	//   var i, x = document.getElementsByClassName("step");
	//   for (i = 0; i < x.length; i++) {
	//     x[i].className = x[i].className.replace(" active", "");
	//   }
	//   //... and adds the "active" class to the current step:
	//   x[n].className += " active";
	// }


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
