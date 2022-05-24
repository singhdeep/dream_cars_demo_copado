/*
author: Manish Puri
This class will be used to get the City and State details based on ZIP Code
devOps demo
Comment added on 1/18/2017
3:50 PM Changes
*/
public class getLocationDetails{

    public Static String getLocation(String strZipCode){
        String resCityandState = '';
        http h = new http();
        httprequest req = new httprequest();       
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
        req.setMethod('POST');
        req.setBody('USZip='+EncodingUtil.urlEncode(strZipCode, 'UTF-8'));
        req.setEndpoint('http://www.webservicex.net/uszip.asmx/GetInfoByZIP');
    
        String s = '';
        
        //MAKE CALLOUT IF NOT RUNNING TEST
        if(Test.isRunningTest() == false){
            httpresponse res = h.send(req);
            
            //parsing the response
            s = res.getbody();
            system.debug(s);
            Dom.Document docx = new Dom.Document();
            docx.load(s);
            dom.XmlNode xroot = docx.getrootelement() ;
            system.debug(xroot );
            if(xroot.getChildElement('Table', null) != null){
                List<dom.XmlNode> xTable = xroot.getChildElement('Table', null).getChildElements();
                String city = xTable[0].gettext();
                String state = xTable[1].gettext();
                system.debug('City is: '+city+' and state is : '+state);
                resCityandState = city + ','+ state;
            }
        }
        
        return resCityandState;
    }
}