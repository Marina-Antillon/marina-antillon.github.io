window.addEventListener("load", function() {
  
  document.getElementById("my-form-2").addEventListener("submit", formsubmit);
  
  async function formsubmit(e) {
    
    e.preventDefault();
    
    // get event-handler element
    const form = e.currentTarget;
    
    // get form url
    const url = form.action;
    
    // get form data as json string
    formdata = new FormData(form);
    const plainFormData = Object.fromEntries(formdata.entries());
    const jsonFormData = JSON.stringify(plainFormData);
    
    // send request and capture output
    out = await fetch(form.action, {
      method: 'POST',
      body: jsonFormData,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    });
    
    // notification of sent message
    alert("message sent to " + plainFormData.to);
    
  }
  
});
