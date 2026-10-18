package mvc.module.minos
{
   import flash.utils.Dictionary;
   
   public class MinosPlayerInfo
   {
      
      public var feat:int;
      
      public var challengeCount:int;
      
      public var buyCount:int;
      
      private var _levelRewardInfo:String;
      
      private var _levelRewardGets:Dictionary = new Dictionary();
      
      private var _featRewardInfo:String;
      
      private var _featList:Array = [];
      
      public function MinosPlayerInfo()
      {
         super();
      }
      
      public function set featRewardInfo(param1:String) : void
      {
         if(_featRewardInfo == param1)
         {
            return;
         }
         _featRewardInfo = param1;
         _featList = _featRewardInfo.split(",");
      }
      
      public function get featList() : Array
      {
         return _featList;
      }
      
      public function set levelRewardInfo(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         if(_levelRewardInfo == param1)
         {
            return;
         }
         _levelRewardInfo = param1;
         if(_levelRewardInfo != null && _levelRewardInfo != "")
         {
            _loc4_ = _levelRewardInfo.split("|");
            _loc5_ = int(_loc4_ ? _loc4_.length : 0);
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc6_ = _loc4_[_loc7_];
               _loc2_ = _loc6_.split(",");
               _loc3_ = _loc2_.shift();
               _levelRewardGets[_loc3_] = _loc2_;
               _loc7_++;
            }
         }
      }
      
      public function get levelRewardGets() : Dictionary
      {
         return _levelRewardGets;
      }
   }
}

