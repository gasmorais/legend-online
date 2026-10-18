package mvc.module.consortia
{
   import events.ConsortiaEvent;
   import flash.events.EventDispatcher;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class ConsortiaSecretInfo extends EventDispatcher
   {
      
      public static const GIVE_POWER_STATE:int = 1;
      
      public static const Call_STATE:int = 2;
      
      public static const NO_OPER_STATE:int = 3;
      
      public static const STATE_CLOSE:int = 0;
      
      public static const STATE_READY:int = 1;
      
      public static const STATE_COLLECT:int = 2;
      
      public static const STATE_EXP:int = 3;
      
      public static const TREE_STATE:String = "TREE_STATE";
      
      public static const COUNT_DOWN:String = "COUNT_DOWN";
      
      public var consortiaId:int;
      
      public var membersNum:int;
      
      public var rate:Number;
      
      public var treeGrade:int;
      
      public var treeGp:int;
      
      public var givePowerCount:int;
      
      public var oper:int;
      
      private var _treeState:int;
      
      public var secretState:int;
      
      private var _countDown:int;
      
      public var collectRate:Number;
      
      private var _changeObj:SimpleDictionary;
      
      public var rankList:Array;
      
      public function ConsortiaSecretInfo()
      {
         super();
         _changeObj = new SimpleDictionary();
         rankList = [];
      }
      
      public function get treeState() : int
      {
         return _treeState;
      }
      
      public function set treeState(param1:int) : void
      {
         if(_treeState == param1)
         {
            return;
         }
         _treeState = param1;
         _changeObj["TREE_STATE"] = true;
      }
      
      public function get countDown() : int
      {
         return _countDown;
      }
      
      public function set countDown(param1:int) : void
      {
         if(_countDown == param1)
         {
            return;
         }
         _countDown = param1;
         _changeObj["COUNT_DOWN"] = true;
      }
      
      public function clear() : void
      {
         consortiaId = 0;
         membersNum = 0;
         rate = 0;
         treeGrade = 1;
         treeGp = 0;
         givePowerCount = 0;
         oper = 3;
         treeState = 3;
         collectRate = 0;
         _countDown = 0;
         secretState = 0;
         rankList.length = 0;
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function commitChanges() : void
      {
         if(_changeObj["TREE_STATE"])
         {
            dispatchEvent(new ConsortiaEvent("TREE_STATE_UPDATE"));
         }
         if(_changeObj["COUNT_DOWN"])
         {
            dispatchEvent(new ConsortiaEvent("PICK_TIME_UPDATE"));
         }
         dispatchEvent(new ConsortiaEvent("SECRET_UPDATE"));
      }
      
      public function commitSortChange() : void
      {
         dispatchEvent(new ConsortiaEvent("SECRET_SORT_UPDATE"));
      }
      
      public function get mySelfSortInfo() : ConsortiaUserInfo
      {
         for each(var _loc1_:ConsortiaUserInfo in rankList)
         {
            if(_loc1_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
   }
}

