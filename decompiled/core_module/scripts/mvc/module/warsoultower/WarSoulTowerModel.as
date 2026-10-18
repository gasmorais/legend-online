package mvc.module.warsoultower
{
   import com.road.yishi.proto.warsoultower.RewardRspMsg;
   import yishi.manager.TempleteManager;
   
   public class WarSoulTowerModel
   {
      
      private static const OPEN:int = 1;
      
      private static const REPEAT:int = 2;
      
      private static const CURRENT:int = 3;
      
      private static const CLOSE:int = 4;
      
      public var currentLevel:int = 1;
      
      public var highestLevel:int = 0;
      
      public var challengeTimes:int = 1;
      
      public var isNewRecord:Boolean = false;
      
      public var highestUnLockLevel:int;
      
      public var startLevel:int;
      
      public var overLevel:int;
      
      public var repeatRewardsArr:Array;
      
      public var passRewardsArr:Array;
      
      public var stageRewardsArr:Array;
      
      public function WarSoulTowerModel()
      {
         super();
         repeatRewardsArr = [];
         passRewardsArr = [];
         stageRewardsArr = [];
      }
      
      public function set rewards(param1:Array) : void
      {
         var _loc2_:RewardRspMsg = null;
         var _loc3_:int = 0;
         repeatRewardsArr = [];
         passRewardsArr = [];
         stageRewardsArr = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_] as RewardRspMsg;
            if(_loc2_.state == 0)
            {
               passRewardsArr.push(_loc2_.level);
               stageRewardsArr.push(_loc2_.level);
            }
            else if(_loc2_.state == 1)
            {
               repeatRewardsArr.push(_loc2_.level);
            }
            else
            {
               passRewardsArr.push(_loc2_.level);
            }
            _loc3_++;
         }
      }
      
      public function getState(param1:int) : int
      {
         if(param1 < currentLevel)
         {
            return 1;
         }
         if(param1 <= highestLevel)
         {
            return 2;
         }
         if(param1 == highestLevel + 1)
         {
            return 3;
         }
         return 4;
      }
      
      public function get beginLevel() : int
      {
         if(isMax)
         {
            return max - 14;
         }
         return level - 7 < 1 ? 1 : level - 7;
      }
      
      public function get endLevel() : int
      {
         if(isMin)
         {
            return 15;
         }
         return level + 7 > max ? max : level + 7;
      }
      
      public function get isMin() : Boolean
      {
         return level - 7 <= 1;
      }
      
      public function get isMax() : Boolean
      {
         return level + 7 >= max;
      }
      
      public function get level() : int
      {
         return highestLevel + 1;
      }
      
      public function get max() : int
      {
         return TempleteManager.instance.warSoulTowerLevelTempCate.max;
      }
   }
}

