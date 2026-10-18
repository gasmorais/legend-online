package managers
{
   import com.road.yishi.proto.leed.ServenDayLeadMsg;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.guidetask.GuideTaskInfo;
   import mvc.module.guidetask.GuideTaskUpgradeInfo;
   import mvc.module.guidetask.SimpleTaskInfo;
   import mvc.module.guidetask.SingleDayInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class GuideTaskManager extends EventDispatcher
   {
      
      public static var TASK:int = 1;
      
      public static var LEVEL:int = 2;
      
      private static var _instance:GuideTaskManager;
      
      private var _model:GuideTaskInfo;
      
      private var _defaultView:int;
      
      public function GuideTaskManager()
      {
         super();
      }
      
      public static function get instance() : GuideTaskManager
      {
         if(!_instance)
         {
            _instance = new GuideTaskManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _model = new GuideTaskInfo();
      }
      
      private function initEvent() : void
      {
      }
      
      private function _initGuideTask(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ServenDayLeadMsg = new ServenDayLeadMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ServenDayLeadMsg;
         _model.startTime = DateFormatter.parse(_loc2_.beginTime,"YYYY-MM-DD hh:mm:ss");
         _model.statu = _loc2_.statu;
         if(_loc2_.singleDay && _loc2_.singleDay.length > 0)
         {
            _model.singleDayArr = _loc2_.singleDay;
         }
         var _loc5_:Frame = FrameControllerManager.instance.guideTaskController.frame;
         if(_loc5_)
         {
            _loc5_.initData();
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOWBTN",_loc2_.statu));
         var _loc3_:Boolean = isShowEff();
         if(_loc3_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOWEFF"));
         }
      }
      
      public function getReward(param1:int) : void
      {
      }
      
      public function isShowEff() : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:SingleDayInfo = null;
         var _loc2_:Boolean = false;
         var _loc1_:Array = _model.singleDayArr;
         var _loc3_:int = int(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc5_];
            _loc2_ = getRewardFlagByDay(_loc5_);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function getHasGetRewardByDay(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:SingleDayInfo = null;
         var _loc2_:Array = _model.singleDayArr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as SingleDayInfo;
            if(_loc4_.day == param1 + 1)
            {
               if(_loc4_.isGetReward == 1)
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getRewardFlagByDay(param1:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:SingleDayInfo = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:SimpleTaskInfo = null;
         var _loc2_:Boolean = false;
         var _loc6_:Array = _model.singleDayArr;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc8_ = _loc6_[_loc7_] as SingleDayInfo;
            if(_loc8_.day == param1 + 1)
            {
               if(_loc8_.isGetReward == 1)
               {
                  _loc2_ = false;
                  break;
               }
               _loc3_ = _loc8_.simpleTaskArr;
               _loc5_ = int(_loc3_.length);
               _loc9_ = 0;
               while(_loc9_ < _loc5_)
               {
                  _loc4_ = _loc3_[_loc9_] as SimpleTaskInfo;
                  if(_loc4_.isComplete < 1)
                  {
                     _loc2_ = false;
                     break;
                  }
                  _loc2_ = true;
                  _loc9_++;
               }
            }
            _loc7_++;
         }
         return _loc2_;
      }
      
      public function getCurrDay() : int
      {
         var _loc1_:int = DateFormatter.compareDay(_model.startTime);
         if(_loc1_ > 7)
         {
            _loc1_ = 7;
         }
         if(_loc1_ < 1)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      public function getCanSee(param1:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:SingleDayInfo = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:SimpleTaskInfo = null;
         var _loc10_:int = getCurrDay();
         var _loc2_:Boolean = false;
         var _loc6_:Array = _model.singleDayArr;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc8_ = _loc6_[_loc7_] as SingleDayInfo;
            if(_loc8_.day == _loc10_)
            {
               _loc3_ = _loc8_.simpleTaskArr;
               _loc5_ = int(_loc3_.length);
               _loc9_ = 0;
               while(_loc9_ < _loc5_)
               {
                  _loc4_ = _loc3_[_loc9_] as SimpleTaskInfo;
                  if(_loc4_.isComplete == 0)
                  {
                     _loc2_ = false;
                     break;
                  }
                  _loc2_ = true;
                  _loc9_++;
               }
            }
            _loc7_++;
         }
         if(_loc2_)
         {
            if(param1 > _loc10_ + 1)
            {
               return false;
            }
            return true;
         }
         if(param1 > _loc10_)
         {
            return false;
         }
         return true;
      }
      
      public function getTaskArrByDay(param1:int) : Array
      {
         var _loc3_:SingleDayInfo = _model.singleDayArr[param1 - 1];
         return _loc3_.simpleTaskArr;
      }
      
      public function getSomethingCanToDo() : Array
      {
         var _loc1_:Array = [];
         var _loc6_:GuideTaskUpgradeInfo = new GuideTaskUpgradeInfo();
         _loc6_.type = 1;
         _loc6_.param1 = playerinfo.multiCopyCount;
         _loc6_.desc = LanguageMgr.GetTranslation("managers.GuideTaskManager.CanToDoSomething.type01",_loc6_.param1);
         var _loc5_:GuideTaskUpgradeInfo = new GuideTaskUpgradeInfo();
         _loc5_.type = 2;
         _loc5_.param1 = playerinfo.trialTowerCampaignCount;
         _loc5_.desc = LanguageMgr.GetTranslation("managers.GuideTaskManager.CanToDoSomething.type02",_loc5_.param1);
         var _loc4_:GuideTaskUpgradeInfo = new GuideTaskUpgradeInfo();
         _loc4_.type = 3;
         _loc4_.param1 = towerInfo.maxEnterCount - towerInfo.enterCount;
         _loc4_.desc = LanguageMgr.GetTranslation("managers.GuideTaskManager.CanToDoSomething.type03",_loc4_.param1);
         var _loc3_:GuideTaskUpgradeInfo = new GuideTaskUpgradeInfo();
         _loc3_.type = 4;
         _loc3_.param1 = rewardModel.remainRewardCount;
         _loc3_.desc = LanguageMgr.GetTranslation("managers.GuideTaskManager.CanToDoSomething.type04",_loc3_.param1);
         var _loc2_:GuideTaskUpgradeInfo = new GuideTaskUpgradeInfo();
         _loc2_.type = 5;
         _loc2_.param1 = playerinfo.weary;
         _loc2_.desc = LanguageMgr.GetTranslation("managers.GuideTaskManager.CanToDoSomething.type05",_loc2_.param1);
         if(_loc6_.param1 > 0 && thaneInfo.grades >= 20)
         {
            _loc1_.push(_loc6_);
         }
         if(_loc5_.param1 > 0 && thaneInfo.grades >= 40)
         {
            _loc1_.push(_loc5_);
         }
         if(_loc4_.param1 > 0 && thaneInfo.grades >= 23)
         {
            _loc1_.push(_loc4_);
         }
         if(_loc3_.param1 > 0 && thaneInfo.grades >= 17)
         {
            _loc1_.push(_loc3_);
         }
         if(_loc2_.param1 > 20)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getRewardByDay(param1:int) : Array
      {
         return TempleteManager.instance.servenLeadRewardTemplateCate.getArrayByDay(param1 - 1 + "");
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function get model() : GuideTaskInfo
      {
         return _model;
      }
      
      public function get defaultView() : int
      {
         return _defaultView;
      }
      
      public function set defaultView(param1:int) : void
      {
         _defaultView = param1;
      }
   }
}

