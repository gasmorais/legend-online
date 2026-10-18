package mvc.module.childseal
{
   import flash.events.EventDispatcher;
   import yishi.datas.ConfigInfoManager;
   
   public class ChildesalModel extends EventDispatcher
   {
      
      public var starCount:int;
      
      public var countNum:int;
      
      public var sealsList:Array = [];
      
      public var invokeList:Array = [];
      
      public var choseList:Array = [];
      
      public var rewardList:Vector.<ChildesalRewardInfo> = new Vector.<ChildesalRewardInfo>();
      
      public function ChildesalModel()
      {
         super();
      }
      
      public function get maxCount() : int
      {
         return ConfigInfoManager.instance.getKeyToInt("child_seal_max_count");
      }
      
      public function get maxStarNum() : int
      {
         return ConfigInfoManager.instance.getKeyToInt("child_seal_max_star");
      }
      
      public function get refreshIconNeedGold() : int
      {
         return ConfigInfoManager.instance.getKeyToInt("child_seal_flush_option_point");
      }
      
      public function get refreshRewardNeedGold() : int
      {
         return ConfigInfoManager.instance.getKeyToInt("child_seal_flush_reward_point");
      }
      
      public function isInviteByIndexId(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(invokeList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(invokeList[_loc3_] == param1)
            {
               return true;
            }
            _loc3_ += 1;
         }
         return false;
      }
      
      public function isHaveIndexId(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = int(sealsList.length);
         var _loc2_:Boolean = isInviteByIndexId(param1);
         if(_loc2_)
         {
            return false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(sealsList[_loc4_] == param1)
            {
               return true;
            }
            _loc4_ += 1;
         }
         return false;
      }
      
      public function get isHasGiftNum() : Boolean
      {
         return maxCount != countNum;
      }
   }
}

