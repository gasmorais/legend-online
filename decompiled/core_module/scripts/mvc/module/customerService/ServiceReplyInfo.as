package mvc.module.customerService
{
   import yishi.utils.DateFormatter;
   
   public class ServiceReplyInfo
   {
      
      public var questionId:String;
      
      public var type:int;
      
      public var userId:String;
      
      public var Site:String;
      
      public var title:String;
      
      public var content:String;
      
      public var replayUserName:String;
      
      public var replayContent:String;
      
      public var stopReply:String;
      
      public var employ:String;
      
      public var date:Date;
      
      public function ServiceReplyInfo()
      {
         super();
      }
      
      public function set commitTime(param1:String) : void
      {
         date = DateFormatter.parse(param1,"YYYY-MM-DD");
      }
   }
}

