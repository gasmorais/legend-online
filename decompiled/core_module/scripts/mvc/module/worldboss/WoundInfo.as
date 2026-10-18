package mvc.module.worldboss
{
   import flash.events.EventDispatcher;
   
   public class WoundInfo extends EventDispatcher
   {
      
      public var index:int;
      
      public var nickName:String;
      
      public var wound:Number = 0;
      
      public var userId:int;
      
      public var job:int;
      
      public var isJoining:Boolean;
      
      private var _totalHp:Number = 0;
      
      public function WoundInfo(param1:int = 0)
      {
         super();
         index = param1;
      }
      
      public function get totalHp() : Number
      {
         return _totalHp;
      }
      
      public function get woundAddation() : Number
      {
         var _loc1_:Number = wound * 100 / _totalHp;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > 100)
         {
            _loc1_ = 100;
         }
         return _loc1_;
      }
      
      public function set totalHp(param1:Number) : void
      {
         _totalHp = param1;
      }
      
      public function reset() : void
      {
         nickName = "";
         wound = _totalHp = 0;
         userId = 0;
      }
   }
}

