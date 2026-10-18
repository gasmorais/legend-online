package mvc.module.marry
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import map.campaign.CampaignManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class MarryTreeInfo
   {
      
      public var userIdA:int;
      
      public var nickNameA:String;
      
      public var jobA:int;
      
      public var userIdB:int;
      
      public var nickNameB:String;
      
      public var jobB:int;
      
      public var stateValue:int;
      
      public var feedCount:int;
      
      public var trainACount:int;
      
      public var trainBCount:int;
      
      public var trainAType:int;
      
      public var trainBType:int;
      
      public var isGetA:Boolean;
      
      public var isGetB:Boolean;
      
      public var treeState:String;
      
      public var feedId:int;
      
      private var _startTime:Number;
      
      private var _endTime:Number;
      
      private var _timer:Timer;
      
      private var _flag:Boolean = false;
      
      public function MarryTreeInfo()
      {
         super();
      }
      
      public function startTimer() : void
      {
         stopTimer();
         if(isSelf)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
      }
      
      public function stopTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:TipMessageData = null;
         if(playerModel.sysCurTimeBySecond > _endTime)
         {
            stopTimer();
            _flag = true;
            if(canPick())
            {
               _loc2_ = new TipMessageData();
               _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
               _loc2_.type = 41;
               _loc2_.data = {};
               _loc2_.data.showType = 2;
               TaskTraceTipManager.instance.showView(_loc2_);
            }
         }
      }
      
      public function canPick() : Boolean
      {
         var _loc1_:Boolean = false;
         if(isGetA && userIdA == playerModel.playerInfo.userId)
         {
            _loc1_ = false;
         }
         else if(isGetB && userIdB == playerModel.playerInfo.userId)
         {
            _loc1_ = false;
         }
         else if(isSelf && checkScene())
         {
            _loc1_ = true;
         }
         return _loc1_ && _flag && _startTime > 0 && _endTime > 0;
      }
      
      private function get isSelf() : Boolean
      {
         return playerModel.playerInfo.userId == userIdA || playerModel.playerInfo.userId == userIdB;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get totalTime() : Number
      {
         return _endTime - _startTime;
      }
      
      public function get startTime() : Number
      {
         return _startTime;
      }
      
      public function set startString(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            _startTime = 0;
            return;
         }
         _startTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time / 1000;
      }
      
      public function get endTime() : Number
      {
         return _endTime;
      }
      
      public function set endString(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            _endTime = 0;
            return;
         }
         _endTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time / 1000;
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = SceneManager.instance.currentType;
         switch(_loc2_)
         {
            case "CASTLE_SCENE":
            case "SPACE_SCENE":
               _loc1_ = true;
               break;
            default:
               _loc1_ = false;
         }
         if(WorldBossHelper.checkMineral(CampaignManager.instance.mapId))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

