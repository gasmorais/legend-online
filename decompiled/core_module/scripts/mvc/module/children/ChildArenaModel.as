package mvc.module.children
{
   import flash.events.EventDispatcher;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class ChildArenaModel extends EventDispatcher
   {
      
      public static const STATE_INIT:int = -1;
      
      public static const STATE_SIGN_UP:int = 0;
      
      public static const STATE_GROUP:int = 1;
      
      public static const STATE_BET:int = 2;
      
      public static const STATE_BEFORE_FIGHT:int = 3;
      
      public static const STATE_FIGHT:int = 4;
      
      public static const STATE_REWARD:int = 5;
      
      public static const STATE_FINISH:int = 6;
      
      public static const GUESS_NOT:int = -1;
      
      public static const GUESS_0:int = 0;
      
      public static const GUESS_1:int = 1;
      
      public static const GUESS_2:int = 2;
      
      public static const GUESS_3:int = 3;
      
      public static const GUESS_4:int = 4;
      
      public var isInChildArena:Boolean;
      
      private var _hasReward:Boolean = false;
      
      private var _curstate:int;
      
      public var isSign:Boolean;
      
      public var arenaType:int = 2;
      
      public var guessIndex:int = -1;
      
      public var nextWarLeftTime:int;
      
      public var currentTurn:int;
      
      public var autoSignState:int;
      
      public var arenaVsPlayerList:Array;
      
      public var itemData16:Array;
      
      public var itemData8:Array;
      
      public var itemData4:Array;
      
      public var itemData2:Array;
      
      public var childAreanFromationList:Array;
      
      public function ChildArenaModel()
      {
         super();
         if(itemData16 == null)
         {
            itemData16 = [];
         }
         if(itemData8 == null)
         {
            itemData8 = [];
         }
         if(itemData4 == null)
         {
            itemData4 = [];
         }
         if(itemData2 == null)
         {
            itemData2 = [];
         }
         if(arenaVsPlayerList == null)
         {
            arenaVsPlayerList = [];
         }
         if(childAreanFromationList == null)
         {
            childAreanFromationList = [];
         }
      }
      
      public function getPlayerInfoByPosAndVsList(param1:int, param2:Array, param3:int) : ChildArenaPlayerInfo
      {
         for each(var _loc4_:ChildArenaPlayerInfo in param2)
         {
            if(Math.ceil(_loc4_.teamPos / param3) == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function get maxWinCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:ChildArenaPlayerInfo in arenaVsPlayerList)
         {
            if(_loc1_.winCount > _loc2_)
            {
               _loc2_ = _loc1_.winCount;
            }
         }
         return _loc2_;
      }
      
      public function getPlayerListByWinCount(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:ChildArenaPlayerInfo in arenaVsPlayerList)
         {
            if(_loc2_.winCount == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("teamPos",16);
         return _loc3_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get childPvpTimeArr() : Array
      {
         return ConfigInfoManager.instance.getChildPvpTimes();
      }
      
      public function commitListData() : void
      {
         itemData16 = [];
         itemData8 = [];
         itemData4 = [];
         itemData2 = [];
         for each(var _loc1_:ChildArenaPlayerInfo in arenaVsPlayerList)
         {
            if(_loc1_.winCount >= 3)
            {
               itemData2.push(_loc1_);
            }
            if(_loc1_.winCount >= 2)
            {
               itemData4.push(_loc1_);
            }
            if(_loc1_.winCount >= 1)
            {
               itemData8.push(_loc1_);
            }
            if(_loc1_.winCount >= 0)
            {
               itemData16.push(_loc1_);
            }
         }
         itemData16.sortOn("teamPos",16);
         itemData8.sortOn("teamPos",16);
         itemData4.sortOn("teamPos",16);
         itemData2.sortOn("teamPos",16);
      }
      
      public function getChildFormationInfoById(param1:int) : ChildCommonFormationInfo
      {
         for each(var _loc2_:ChildCommonFormationInfo in childAreanFromationList)
         {
            if(_loc2_.childId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function changePos(param1:ChildCommonFormationInfo, param2:ChildCommonFormationInfo) : void
      {
         var _loc5_:int = param1.standPos;
         var _loc3_:int = param2.standPos;
         for each(var _loc4_:ChildCommonFormationInfo in childAreanFromationList)
         {
            if(_loc4_.childId == param1.childId)
            {
               _loc4_.standPos = _loc3_;
            }
            else if(_loc4_.childId == param2.childId)
            {
               _loc4_.standPos = _loc5_;
            }
         }
      }
      
      public function get isGuessState() : Boolean
      {
         if(curstate == 2)
         {
            return true;
         }
         if(curstate == 3)
         {
            return true;
         }
         return false;
      }
      
      public function get curstate() : int
      {
         return _curstate;
      }
      
      public function set curstate(param1:int) : void
      {
         if(curstate == param1)
         {
            return;
         }
         _curstate = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_ARENA_UPDATE_STATE");
      }
      
      public function get betLeftTime() : int
      {
         var _loc6_:int = playerModel.sysCurtime.month + 1;
         var _loc1_:String = playerModel.sysCurtime.fullYear + "";
         var _loc5_:String = _loc6_ >= 10 ? "" + _loc6_ : "0" + _loc6_;
         var _loc2_:String = playerModel.sysCurtime.date >= 10 ? "" + playerModel.sysCurtime.date : "0" + playerModel.sysCurtime.date;
         var _loc7_:String = _loc1_ + "-" + _loc5_ + "-" + _loc2_ + " " + childPvpTimeArr[3] + ":00";
         var _loc3_:Date = DateFormatter.parse(_loc7_,"YYYY-MM-DD hh:mm:ss");
         var _loc4_:int = _loc3_.time / 1000 - playerModel.sysCurTimeBySecond;
         return _loc4_ > 0 ? _loc4_ : 0;
      }
      
      public function get nextWarLeftCount() : int
      {
         var _loc1_:int = nextWarLeftTime - playerModel.sysCurTimeBySecond;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get hasReward() : Boolean
      {
         return _hasReward;
      }
      
      public function set hasReward(param1:Boolean) : void
      {
         if(_hasReward == param1)
         {
            return;
         }
         _hasReward = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_ARENA_REWARD");
      }
      
      public function get canSignUp() : Boolean
      {
         var _loc8_:int = playerModel.sysCurtime.month + 1;
         var _loc1_:String = playerModel.sysCurtime.fullYear + "";
         var _loc7_:String = _loc8_ >= 10 ? "" + _loc8_ : "0" + _loc8_;
         var _loc2_:String = playerModel.sysCurtime.date >= 10 ? "" + playerModel.sysCurtime.date : "0" + playerModel.sysCurtime.date;
         var _loc4_:String = _loc1_ + "-" + _loc7_ + "-" + _loc2_ + " " + childPvpTimeArr[1] + ":00";
         var _loc3_:String = _loc1_ + "-" + _loc7_ + "-" + _loc2_ + " " + childPvpTimeArr[0] + ":00";
         var _loc5_:Date = DateFormatter.parse(_loc4_,"YYYY-MM-DD hh:mm:ss");
         var _loc6_:Date = DateFormatter.parse(_loc3_,"YYYY-MM-DD hh:mm:ss");
         if(playerModel.sysCurTimeBySecond > _loc5_.time / 1000 && playerModel.sysCurTimeBySecond < _loc6_.time / 1000)
         {
            return false;
         }
         return true;
      }
   }
}

