public class aAttachment{
        public Attachment  att{get; set;}
        public Boolean selected {get; set;}
        public String docType{get; set;}
        public String Source{get; set;}
         public Id ReferenceId{get; set;}
    public Decimal bodyLength{get;set;}

        public aAttachment(Attachment b,String sorce, String fromSrc) {
            att= b;
            selected = false;
            Source=fromSrc+sorce;
        }
    }