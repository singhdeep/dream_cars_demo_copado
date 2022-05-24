({
    openModalhandlertest : function(component, event, helper) {
        helper.toggleVisibility(component);
		var eventMethod=component.get("c.getEvents");
        eventMethod.setParams({ selectedDate : '' });
		if(x=100){
		}else{
			var x=100;
			alert("hi");
		}
    },
    
    closeModal : function(component, event, helper) {
        helper.toggleVisibility(component);
		console.log("hi");
		var s="hello";
    }
})