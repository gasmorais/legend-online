package mvc.module.consortia
{
   import flash.events.EventDispatcher;
   
   public class ConsortiaInviteInfo extends EventDispatcher
   {
      
      public var id:int;
      
      public var consortiaId:int;
      
      public var consortiaName:String;
      
      public var createDate:Date;
      
      public var userId:int;
      
      public var userNickName:String;
      
      public var inviteId:int;
      
      public var inviteNickName:String;
      
      public var chairmanName:String;
      
      public var inviteDate:Date;
      
      public var fromType:Boolean;
      
      public var isExist:Boolean;
      
      public function ConsortiaInviteInfo()
      {
         super();
      }
   }
}

