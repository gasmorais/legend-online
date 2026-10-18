package yishi.datas.templates
{
   public class OldPlayerReturnRewardTempInfo
   {
      
      public var Id:int;
      
      public var RewardType:int;
      
      public var RewardNum:int;
      
      public var NeedCount:int;
      
      public var RewardItem1:int;
      
      public var RewardItemNum1:int;
      
      public var RewardItem2:int;
      
      public var RewardItemNum2:int;
      
      public var RewardItem3:int;
      
      public var RewardItemNum3:int;
      
      public var RewardItem4:int;
      
      public var RewardItemNum4:int;
      
      public var RewardItem5:int;
      
      public var RewardItemNum5:int;
      
      public var RewardItem6:int;
      
      public var RewardItemNum6:int;
      
      public function OldPlayerReturnRewardTempInfo()
      {
         super();
      }
      
      public function get rewardsArr() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc2_ = {};
            if(this["RewardItem" + _loc3_] != 0)
            {
               _loc2_.itemId = this["RewardItem" + _loc3_];
               _loc2_.count = this["RewardItemNum" + _loc3_];
               _loc1_.push(_loc2_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

