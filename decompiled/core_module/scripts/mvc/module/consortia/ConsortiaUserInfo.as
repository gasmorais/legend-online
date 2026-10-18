package mvc.module.consortia
{
   import yishi.utils.ClassFactory;
   
   public class ConsortiaUserInfo
   {
      
      public var consortiaId:int;
      
      public var userId:int;
      
      public var nickName:String;
      
      public var ratifierUserId:int;
      
      public var ratifierNickName:String;
      
      public var dutyID:int;
      
      public var isExist:Boolean;
      
      public var dayOffer:int;
      
      private var _lastDate:Object;
      
      public var totalOffer:int;
      
      public var todayOffer:int;
      
      public var altarCount:int;
      
      public var todaySpirit:Number;
      
      public var totalSpirit:Number;
      
      public var lastAltarDate:Object;
      
      public var secretOrder:int;
      
      public var secretScore:int;
      
      public function ConsortiaUserInfo()
      {
         super();
      }
      
      public function get lastDate() : Object
      {
         return _lastDate;
      }
      
      public function set lastDate(param1:Object) : void
      {
         _lastDate = ClassFactory.copyDateType(param1);
      }
   }
}

