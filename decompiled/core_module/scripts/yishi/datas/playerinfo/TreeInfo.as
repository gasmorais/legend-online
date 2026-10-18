package yishi.datas.playerinfo
{
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import water.events.WaterEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.WaterManager;
   import yishi.scene.SceneManager;
   
   [Event(name="gp_changed",type="water.events.WaterEvent")]
   [Event(name="grade_changed",type="water.events.WaterEvent")]
   public class TreeInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var waterCount:int;
      
      public var fruitCount:int;
      
      public var isFirstFruit:Boolean;
      
      public var nextPickTime:Date;
      
      public var lastWaterTime:Date;
      
      public var property1:int;
      
      public var property2:int;
      
      public var nickName:String;
      
      public var left_time:int;
      
      public var left_pickTime:int;
      
      public var notHasTree:Boolean;
      
      private var _timeId:int;
      
      private var _timePickId:int;
      
      private var _preRequestTime:Number;
      
      private var _requestTime:Number = 0;
      
      private var _gp:int;
      
      private var _treeGrades:int;
      
      public function TreeInfo()
      {
         super();
      }
      
      public function get gp() : int
      {
         return _gp;
      }
      
      public function set gp(param1:int) : void
      {
         if(_gp == param1)
         {
            return;
         }
         _gp = param1;
         dispatchEvent(new WaterEvent("gp_changed",null));
      }
      
      public function get treeGrades() : int
      {
         return _treeGrades;
      }
      
      public function set treeGrades(param1:int) : void
      {
         if(_treeGrades == param1)
         {
            return;
         }
         _treeGrades = param1;
         dispatchEvent(new WaterEvent("grade_changed",null));
      }
      
      public function set requestTime(param1:Number) : void
      {
         if(_requestTime == 0)
         {
            _preRequestTime = param1;
         }
         else
         {
            _preRequestTime = _requestTime;
         }
         _requestTime = param1;
      }
      
      public function get needRequiest() : Boolean
      {
         if(userId == thane.userId)
         {
            return false;
         }
         if(notHasTree)
         {
            return true;
         }
         return _requestTime - _preRequestTime > 1000;
      }
      
      public function set leftpickTime(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:TipMessageData = null;
         left_pickTime = param1;
         if(left_pickTime <= 0)
         {
            left_pickTime = 0;
            clearTimeout(_timePickId);
            _loc2_ = SceneManager.instance.currentType;
            if(userId == thane.userId && canPick && _loc2_ == "CASTLE_SCENE")
            {
               _loc3_ = new TipMessageData();
               _loc3_.title = LanguageMgr.GetTranslation("public.prompt");
               _loc3_.type = 14;
               TaskTraceTipManager.instance.showView(_loc3_);
            }
         }
         else
         {
            clearTimeout(_timePickId);
            _timePickId = 0;
            _timePickId = setTimeout(refreshPickTime,1000);
         }
      }
      
      private function refreshPickTime() : void
      {
         leftpickTime = left_pickTime - 1;
      }
      
      public function set timeLeft(param1:int) : void
      {
         left_time = param1;
         if(left_time <= 0)
         {
            left_time = 0;
            clearTimeout(_timeId);
         }
         else
         {
            clearTimeout(_timeId);
            _timeId = 0;
            _timeId = setTimeout(refreshTime,1000);
         }
      }
      
      private function refreshTime() : void
      {
         timeLeft = left_time - 1;
      }
      
      public function get remainWaerTime() : Number
      {
         if(!lastWaterTime)
         {
            return 0;
         }
         return (lastWaterTime.time + 600000 - (serverTime.time + getTimer())) / 1000;
      }
      
      public function get remainPickTime() : Number
      {
         var _loc1_:Number = serverTime.time + getTimer();
         var _loc2_:Date = new Date(serverTime.getFullYear(),serverTime.getMonth(),serverTime.getDate() + 1,0,0,0,0);
         if(_loc1_ - nextPickTime.time >= 0)
         {
            return 0;
         }
         return (_loc2_.time - _loc1_) / 1000;
      }
      
      public function get canPick() : Boolean
      {
         if(thane.userId != userId)
         {
            return false;
         }
         if(fruitCount <= 0)
         {
            return false;
         }
         if(left_pickTime > 0)
         {
            return false;
         }
         return true;
      }
      
      public function get canWater() : Boolean
      {
         if(!WaterManager.instance.isWatered(userId))
         {
            return false;
         }
         if(userId == thane.userId && left_time > 1)
         {
            return false;
         }
         if(fruitCount > 0)
         {
            return false;
         }
         return true;
      }
      
      public function get treeResource() : int
      {
         if(treeGrades <= 9)
         {
            return 1;
         }
         if(treeGrades <= 19)
         {
            return 2;
         }
         if(treeGrades <= 29)
         {
            return 3;
         }
         return 3;
      }
      
      private function get serverTime() : Date
      {
         var _loc1_:Date = new Date();
         _loc1_.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         return _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

