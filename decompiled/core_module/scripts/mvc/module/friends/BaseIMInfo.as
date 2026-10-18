package mvc.module.friends
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class BaseIMInfo
   {
      
      public var userId:int;
      
      public var nickName:String;
      
      public var toId:int;
      
      public var msg:String;
      
      public var date:Date;
      
      public var sendResult:int;
      
      public var imThane:ThaneInfo;
      
      public var channel:int;
      
      public function BaseIMInfo()
      {
         super();
      }
   }
}

