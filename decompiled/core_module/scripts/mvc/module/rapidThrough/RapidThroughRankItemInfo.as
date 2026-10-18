package mvc.module.rapidThrough
{
   public class RapidThroughRankItemInfo
   {
      
      public var nickName:String;
      
      public var order:int;
      
      private var _passTime:String;
      
      public var job:int;
      
      public function RapidThroughRankItemInfo()
      {
         super();
      }
      
      public function get passTime() : String
      {
         return _passTime;
      }
      
      public function setPassTime(param1:int) : void
      {
         _passTime = "";
         var _loc3_:int = param1 / 60;
         var _loc2_:int = param1 % 60;
         if(_loc3_ < 10)
         {
            _passTime = "0" + _loc3_ + ":";
         }
         else
         {
            _passTime = _loc3_ + ":";
         }
         if(_loc2_ < 10)
         {
            _passTime += "0" + _loc2_;
         }
         else
         {
            _passTime += _loc2_;
         }
      }
   }
}

