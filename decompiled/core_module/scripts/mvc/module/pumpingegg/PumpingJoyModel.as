package mvc.module.pumpingegg
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class PumpingJoyModel
   {
      
      public var isOpen:Boolean;
      
      public var startDateNum:Number;
      
      public var endDateNum:Number;
      
      public var exchangeEndDateNum:Number;
      
      public var totalScore:int;
      
      public var oneNeedPoint:int;
      
      public var tenNeedPoint:int;
      
      public var floorNeedPumps:int;
      
      public var luckyLeftCount:int;
      
      public var rewardList:Array;
      
      public var luckyList:Array;
      
      public function PumpingJoyModel()
      {
         super();
         rewardList = [];
         luckyList = [];
      }
      
      public function getShowListByType(param1:int, param2:Boolean = false) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:PumpingJoyRewardInfo in rewardList)
         {
            if(_loc4_.types == param1)
            {
               if(param1 == 1)
               {
                  if(_loc4_.isShow || param2)
                  {
                     _loc3_.push(_loc4_);
                  }
               }
               else
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         _loc3_.sortOn("profile",2);
         return _loc3_;
      }
      
      public function getRewardInfoById(param1:int) : PumpingJoyRewardInfo
      {
         for each(var _loc2_:PumpingJoyRewardInfo in rewardList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get curLuckyInfo() : PumpingJoyLuckyInfo
      {
         for each(var _loc1_:PumpingJoyLuckyInfo in luckyList)
         {
            if(_loc1_.timeOutDateNum > playerModel.sysCurTimeBySecond)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get luckyNum() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:PumpingJoyLuckyInfo in luckyList)
         {
            if(_loc2_.timeOutDateNum > playerModel.sysCurTimeBySecond)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get isCanJoy() : Boolean
      {
         var _loc1_:Number = playerModel.sysCurTimeBySecond;
         if(_loc1_ >= startDateNum && _loc1_ < endDateNum)
         {
            return true;
         }
         return false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

