package mvc.module.newfirstpay
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class NewFirstPayModel extends EventDispatcher
   {
      
      public var rewardState:Array = [];
      
      public var isOpen:Boolean = false;
      
      public var chargeNum:int;
      
      public function NewFirstPayModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get topRedNum() : int
      {
         var _loc3_:int = 0;
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < rewardState.length)
         {
            _loc1_ = rewardState[_loc3_];
            if(_loc1_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  if(_loc1_[_loc4_] == "1")
                  {
                     _loc2_++;
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

