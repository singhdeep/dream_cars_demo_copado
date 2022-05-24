({
    getBarCode:function(cmp,evt,result){
    	$A.util.removeClass(cmp.find('_barCode'),"slds-hide");
    	var _result = JSON.parse(result.data);
        console.log('***result = ' +JSON.stringify(_result));
        var barCode;
 		try{
            //console.log('try called***');
            barCode = _result.codeResult.code;
            console.log('***'+_result.codeResult );
            
        }catch(e){
            console.log('result is :', +barCode);
        }
        cmp.set('v.barCode',barCode);
        $A.util.addClass(cmp.find('_spinner'),"slds-hide");
    }
})