package mvc.module
{
   import managers.RoomManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class DungeoTurnModel
   {
      
      public var currentIndex:int = 0;
      
      public var selectCount:int;
      
      public var isLeader:Boolean;
      
      public var blue:int;
      
      public var red:int;
      
      public var green:int;
      
      public var bossBox:int;
      
      public var normal:int;
      
      public var posStatusMsg:Array;
      
      public var playerInfo:Array;
      
      public var controlNum:int;
      
      public var currentControlNum:int;
      
      public var beginNodeId:int = 4202101;
      
      public var endNodeId:int = 4202110;
      
      public var bossBoxLevel:int;
      
      public var normalBoxLevel:int;
      
      public var doubleNormalBox:Boolean;
      
      public var rollNum:int;
      
      public var rewardInfo:String;
      
      public var hasGeted:Boolean;
      
      public var hasReward:Boolean;
      
      public var normalBoxNum:int;
      
      public var bossBoxNum:int;
      
      public var isByControl:Boolean;
      
      public var hadPlayBossBoxLevelUp:Boolean = false;
      
      public var hadPlayNormalBoxLevelUp:Boolean = false;
      
      public var needPlayBossBoxLevelUp:Boolean;
      
      public var needPlayNormalBoxLevelUp:Boolean;
      
      public var hp:int;
      
      public var canDispose:Boolean = true;
      
      public var fighting:Boolean;
      
      public function DungeoTurnModel()
      {
         super();
      }
      
      public function get currentHp() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc2_ = 0;
         while(_loc2_ < playerInfo.length)
         {
            if(_loc1_ == playerInfo[_loc2_].userId)
            {
               return hp = playerInfo[_loc2_].hpPercent;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get isRoomOwner() : Boolean
      {
         var _loc1_:int = RoomManager.instance.roomInfo.houseOwnerId;
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId == _loc1_;
      }
      
      public function getneedPlayBossBoxLevelUp() : Boolean
      {
         if(!hadPlayBossBoxLevelUp && blue >= 100)
         {
            hadPlayBossBoxLevelUp = true;
            return true;
         }
         return false;
      }
      
      public function getneedPlayNormalBoxLevelUp() : Boolean
      {
         if(!hadPlayNormalBoxLevelUp && green >= 100)
         {
            hadPlayNormalBoxLevelUp = true;
            return true;
         }
         return false;
      }
      
      public function calcReward() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         if(rewardInfo == null)
         {
            normalBoxNum = 0;
            bossBoxNum = 0;
            normalBoxLevel = 1;
            bossBoxLevel = 1;
            return;
         }
         var _loc3_:Array = rewardInfo.split("|");
         if(_loc3_.length < 2)
         {
            normalBoxNum = 0;
            bossBoxNum = 0;
            normalBoxLevel = 1;
            bossBoxLevel = 1;
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc1_ = _loc3_[_loc2_].split(",");
               switch(_loc1_[0])
               {
                  case "2060901":
                     normalBoxLevel = 1;
                     normalBoxNum = parseInt(_loc1_[1]);
                     break;
                  case "2060902":
                     normalBoxLevel = 2;
                     normalBoxNum = parseInt(_loc1_[1]);
                     break;
                  case "2060911":
                     bossBoxLevel = 1;
                     bossBoxNum = parseInt(_loc1_[1]);
                     break;
                  case "2060912":
                     bossBoxLevel = 2;
                     bossBoxNum = parseInt(_loc1_[1]);
               }
               _loc2_++;
            }
         }
      }
      
      public function get isOpen() : Boolean
      {
         return FrameControllerManager.checkFrame("dungeonController","DungeonTurnFrame");
      }
      
      public function calcBox() : void
      {
         if(red >= 100)
         {
            doubleNormalBox = true;
         }
         else
         {
            doubleNormalBox = false;
         }
         if(green >= 100)
         {
            normalBoxLevel = 2;
         }
         else
         {
            normalBoxLevel = 1;
         }
         if(blue >= 100)
         {
            bossBoxLevel = 2;
         }
         else
         {
            bossBoxLevel = 1;
         }
      }
   }
}

