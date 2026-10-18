package managers
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.active.DayActiveRspMsg;
   import com.road.yishi.proto.leed.ClickDatasRspMsg;
   import com.road.yishi.proto.leed.LeadRewardMsg;
   import com.road.yishi.proto.leed.LeedData;
   import com.road.yishi.proto.leed.LeedFinishedRspMsg;
   import com.road.yishi.proto.leed.LeedUpdatedRspMsg;
   import com.road.yishi.proto.player.DaySignInfoMsg;
   import events.DayGuideEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import mvc.module.dayGuide.DailyItemInfo;
   import mvc.module.dayGuide.DailyList;
   import mvc.module.dayGuide.DayActionInfo;
   import mvc.module.dayGuide.DayGuideCatecory;
   import mvc.module.dayGuide.DaySignInfoData;
   import mvc.module.dayGuide.LeedInfo;
   import sandbox.SandboxManager;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DayGuideHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DayGuideManager extends EventDispatcher
   {
      
      private static var _instance:DayGuideManager;
      
      private var _cate:DayGuideCatecory;
      
      private var _callback:Function;
      
      private var _dayActiveList:Array = [];
      
      private var _dailyInfoList:Array = [];
      
      public var isVipInfoUpdate:Boolean;
      
      public var isShowNoActive:Boolean;
      
      public var page:int = -1;
      
      public var daySignInfo:DaySignInfoData;
      
      private var oldRvrInfo:DailyItemInfo;
      
      private var newRvrInfo:DailyItemInfo;
      
      public function DayGuideManager()
      {
         super();
      }
      
      public static function get instance() : DayGuideManager
      {
         if(!_instance)
         {
            _instance = new DayGuideManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         addEvent();
         _cate = new DayGuideCatecory();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4177,__signHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4152,__onLeedUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4150,__onLeedReceiveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4393,__dayActivityHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4412,__dailyCount);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4936,__luckDrawHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_FINISH",__finishRewardTaskHandler);
      }
      
      private function __dailyCount(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ClickDatasRspMsg = new ClickDatasRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ClickDatasRspMsg;
         var _loc7_:Array = _loc2_.info;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            switch(_loc7_[_loc5_].keys)
            {
               case "5001":
                  _loc4_ = "1";
                  break;
               case "match":
                  _loc4_ = "2";
                  break;
               case "5002":
                  _loc4_ = "3";
                  break;
               case "4001":
               case "4002":
                  _loc4_ = "4";
                  break;
               case "5003":
                  _loc4_ = "5";
                  break;
               case "reward":
                  _loc4_ = "9";
                  break;
               case "vehicle":
                  _loc4_ = "12";
                  break;
               case "minefield":
                  _loc4_ = "13";
                  break;
               case "pet":
                  _loc4_ = "14";
                  break;
               case "petboss_1":
                  _loc4_ = "20";
                  break;
               case "petboss_2":
                  _loc4_ = "21";
                  break;
               case "7701":
                  _loc4_ = "27";
                  break;
               default:
                  _loc4_ = "";
            }
            for each(var _loc8_:DailyItemInfo in dailyList)
            {
               if(_loc8_.TemplateId == _loc4_)
               {
                  if(_loc4_ == "4")
                  {
                     _loc3_ += _loc7_[_loc5_].keyData;
                     _loc8_.currentFinsh = _loc3_ > _loc8_.MaxCount ? _loc8_.MaxCount : _loc3_;
                  }
                  else
                  {
                     _loc8_.currentFinsh = _loc7_[_loc5_].keyData > _loc8_.MaxCount ? _loc8_.MaxCount : _loc7_[_loc5_].keyData;
                  }
               }
               if(_loc8_.TemplateId == "10" && _loc4_ == "2")
               {
                  _loc8_.currentFinsh = _loc7_[_loc5_].keyData > _loc8_.MaxCount ? _loc8_.MaxCount : _loc7_[_loc5_].keyData;
               }
            }
            _loc5_++;
         }
         dispatchEvent(new DayGuideEvent("DAILY_ITEM_REFRESH"));
      }
      
      public function get remainRewardCount() : int
      {
         for each(var _loc1_:DailyItemInfo in dailyList)
         {
            if(_loc1_.TemplateId == "9")
            {
               return _loc1_.MaxCount - _loc1_.currentFinsh;
            }
         }
         return 0;
      }
      
      private function __finishRewardTaskHandler(param1:Event) : void
      {
         for each(var _loc2_:DailyItemInfo in dailyList)
         {
            if(_loc2_.TemplateId == "9" && _loc2_.currentFinsh < _loc2_.MaxCount)
            {
               _loc2_.currentFinsh++;
            }
         }
      }
      
      public function set maxRewardCount(param1:int) : void
      {
         for each(var _loc2_:DailyItemInfo in dailyList)
         {
            if(_loc2_.TemplateId == "9")
            {
               _loc2_.MaxCount = param1;
            }
         }
         dispatchEvent(new DayGuideEvent("DAILY_ITEM_REFRESH"));
      }
      
      public function get dailyList() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:DailyList = null;
         if(_dailyInfoList.length == 0)
         {
            _loc2_ = new DailyList();
            _dailyInfoList = _loc2_.infoList;
         }
         for each(var _loc3_:DailyItemInfo in _dailyInfoList)
         {
            switch(_loc3_.ActiveType - 1)
            {
               case 0:
               case 1:
                  break;
               case 2:
                  _loc3_.currentFinsh = Math.max(_loc3_.MaxCount - Math.max(playerInfo.warFieldCount,0),0);
                  oldRvrInfo = _loc3_;
                  break;
               case 3:
                  break;
               case 4:
                  _loc3_.currentFinsh = _loc3_.MaxCount - playerInfo.multiCopyCount;
                  if(_loc3_.currentFinsh < 0)
                  {
                     _loc3_.currentFinsh = 0;
                  }
            }
            switch(_loc3_.TemplateId)
            {
               case "6":
                  _loc3_.currentFinsh = _loc3_.MaxCount - playerInfo.multiCopyCount;
                  if(_loc3_.currentFinsh < 0)
                  {
                     _loc3_.currentFinsh = 0;
                  }
                  break;
               case "7":
                  _loc3_.currentFinsh = playerInfo.seminaryCount;
                  break;
               case "8":
                  _loc3_.currentFinsh = BuildingManager.instance.model.getOrderById(10000).currentCount;
                  break;
               case "9":
                  _loc3_.currentFinsh = OfferRewardManager.instance.model.maxRewardCount - OfferRewardManager.instance.model.remainRewardCount;
                  break;
               case "11":
                  _loc3_.currentFinsh = playerInfo.trialTowerCampaignMaxCount - playerInfo.trialTowerCampaignCount;
                  break;
               case "15":
                  _loc3_.currentFinsh = RingTaskManager.instance.model.rewardNum - 1;
                  break;
               case "16":
                  _loc3_.currentFinsh = TreasureMapManager.instance.model.rewardCount;
                  break;
               case "17":
                  _loc3_.currentFinsh = SinglePassManager.instance.model.count;
                  break;
               case "19":
                  _loc3_.currentFinsh = 1 - playerInfo.molongRestNum;
                  break;
               case "25":
                  _loc3_.currentFinsh = playerInfo.monopolyCampaignNum;
                  break;
               case "1600":
                  _loc3_.currentFinsh = playerInfo.randomBossCount;
            }
            if(_loc3_.currentFinsh > _loc3_.MaxCount)
            {
               _loc3_.currentFinsh = _loc3_.MaxCount;
            }
         }
         _loc1_ = _dailyInfoList.indexOf(oldRvrInfo);
         if(_loc1_ != -1)
         {
            _dailyInfoList.splice(_loc1_,1);
         }
         _loc1_ = _dailyInfoList.indexOf(newRvrInfo);
         if(_loc1_ != -1)
         {
            _dailyInfoList.splice(_loc1_,1);
         }
         if(oldRvrInfo != null)
         {
            _dailyInfoList.push(oldRvrInfo);
         }
         return _dailyInfoList;
      }
      
      private function __dayActivityHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc7_:DayActionInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:DayActiveRspMsg = new DayActiveRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as DayActiveRspMsg;
         var _loc3_:Array = _loc2_.dayActiveRspInfo;
         var _loc4_:int = int(_loc3_.length);
         _dayActiveList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new DayActionInfo();
            _loc7_.endDate = DateFormatter.parse(_loc3_[_loc5_].endDate,"YYYY-MM-DD hh:mm:ss").time;
            _loc7_.startDate = DateFormatter.parse(_loc3_[_loc5_].startDate,"YYYY-MM-DD hh:mm:ss").time;
            _loc7_.sort = _loc3_[_loc5_].sort;
            _loc7_.title = _loc3_[_loc5_].title;
            _loc7_.activeId = _loc3_[_loc5_].activeId;
            _loc7_.contents = _loc3_[_loc5_].contents;
            _loc7_.description = _loc3_[_loc5_].description;
            _loc7_.awardContent = _loc3_[_loc5_].awardContent;
            _loc7_.actionTimeContent = _loc3_[_loc5_].actionTimeContent;
            _dayActiveList.push(_loc7_);
            _loc5_++;
         }
         _dayActiveList.sortOn("sort",16);
      }
      
      public function get dayActiveList() : Array
      {
         return _dayActiveList;
      }
      
      private function __signHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DaySignInfoMsg = new DaySignInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DaySignInfoMsg;
         if(daySignInfo == null)
         {
            daySignInfo = new DaySignInfoData();
         }
         if(_loc2_.hasSignTimes)
         {
            daySignInfo.signTimes = _loc2_.signTimes;
         }
         if(_loc2_.hasSignCycle)
         {
            daySignInfo.signCycle = _loc2_.signCycle;
         }
         if(_loc2_.hasRewardTag)
         {
            daySignInfo.rewardTag = _loc2_.rewardTag;
         }
         if(_loc2_.hasResetDate)
         {
            daySignInfo.resetDate = _loc2_.resetDate;
         }
         if(_loc2_.hasTodayIndex)
         {
            daySignInfo.todayIndex = _loc2_.todayIndex;
         }
         NotificationManager.instance.sendNotification("DAY_SIGN_INFO");
      }
      
      protected function __onLeedUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:LeedUpdatedRspMsg = new LeedUpdatedRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as LeedUpdatedRspMsg;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.leed.length)
         {
            addLeedData(DayGuideHelper.readLeedInfo(_loc2_.leed[_loc3_] as LeedData));
            _loc3_++;
         }
         _cate.beginChange();
         _cate.leedProcess = _loc2_.leedProcess;
         _cate.active = _loc2_.totalNum;
         _cate.weekActive = _loc2_.weekTotalNum;
         _cate.weekLeedProcess = _loc2_.weekLeedProcess;
         _cate.buffStopDate = _loc2_.buffStopDate;
         PlayerManager.instance.currentPlayerModel.playerInfo.leadExtractTimes = _loc2_.leadExtractTimes;
         _cate.conmmitChange();
      }
      
      protected function __onLeedReceiveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LeedFinishedRspMsg = new LeedFinishedRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LeedFinishedRspMsg;
         _cate.beginChange();
         if(_loc2_.isWeek)
         {
            _cate.weekLeedProcess = _loc2_.leedProcess;
         }
         else
         {
            _cate.leedProcess = _loc2_.leedProcess;
         }
         _cate.conmmitChange();
      }
      
      private function __luckDrawHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LeadRewardMsg = new LeadRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LeadRewardMsg;
         _cate.beginChange();
         _cate.rewardTemplateId = _loc2_.templateId;
         _cate.leadExtractTimes = _loc2_.leadExtractTimes;
         PlayerManager.instance.currentPlayerModel.playerInfo.leadExtractTimes = _loc2_.leadExtractTimes;
         _cate.conmmitChange();
      }
      
      private function addLeedData(param1:LeedInfo) : void
      {
         if(_cate.allList.hasOwnProperty(param1.templateId))
         {
            update(param1);
         }
         else
         {
            _cate.allList[param1.templateId] = param1;
         }
      }
      
      private function update(param1:LeedInfo) : void
      {
         var _loc2_:LeedInfo = _cate.allList[param1.templateId];
         _loc2_.currentCount = param1.currentCount;
         _loc2_.isComplete = param1.isComplete;
      }
      
      public function get cate() : DayGuideCatecory
      {
         return _cate;
      }
      
      public function switchScene(param1:int) : void
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
               break;
            case 2:
            case 3:
            case 7:
            case 25:
            case 26:
               if(PlayerManager.instance.newbieProcess <= 25000)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               openWaterFrame();
               break;
            case 4:
               if(PlayerManager.instance.newbieProcess <= 23000)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("selectcampaign");
               break;
            case 5:
            case 99:
            case 100:
               if(ArmyManager.instance.thane.grades < 20)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               if(checkCampainOpen())
               {
                  SwitchPageHelp.goSpaceAndFind(2);
               }
               break;
            case 54:
               if(ArmyManager.instance.thane.grades < 20)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!PlayerManager.instance.currentPlayerModel.playerInfo.isOpenCrossMutiCampaign)
               {
                  _loc2_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click03");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               if(checkCampainOpen())
               {
                  SwitchPageHelp.goSpaceAndFind(2);
               }
               break;
            case 28:
               if(ArmyManager.instance.thane.grades < 20)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 46)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 6:
               SwitchPageHelp.gotoStoreFrame("STORE_PANEL_INTENSIFY");
               break;
            case 8:
               SwitchPageHelp.gotoConsortiaFrame();
               break;
            case 12:
               SwitchPageHelp.gotoConsortiaFrame(4);
               break;
            case 13:
               SwitchPageHelp.gotoPvpFrame();
               break;
            case 15:
               SwitchPageHelp.gotoShopFrame();
               break;
            case 16:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",(10).toString());
               break;
            case 17:
               SwitchPageHelp.gotoStarFrame();
               break;
            case 18:
            case 62:
            case 63:
               SwitchPageHelp.gotoWorldBossFrame();
               break;
            case 19:
               SwitchPageHelp.gotoColosseumFrame();
               break;
            case 20:
               FrameControllerManager.instance.openControllerByInfo("task",null,callBack);
               break;
            case 22:
               SwitchPageHelp.gotoHookRoom();
               break;
            case 23:
            case 35:
               SwitchPageHelp.gotoMazeFrame();
               break;
            case 24:
               SwitchPageHelp.gotoOfferRewardFrame();
               break;
            case 27:
            case 32:
               SwitchPageHelp.gotoWorldFightFrame();
               break;
            case 29:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 25)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",25);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("minefield");
               break;
            case 30:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 50)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",50);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(3);
               break;
            case 56:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 35)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",35);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(17);
               break;
            case 40:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 60)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",60);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(20);
               break;
            case 34:
               if(!checkScene())
               {
                  return;
               }
               if(thane.vocationGrades <= 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command02",80);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 33:
               if(thane.grades < 41)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",41);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("seminarybless");
               break;
            case 46:
               if(thane.grades < 32)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",32);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("magicpub");
               break;
            case 9:
            case 10:
               if(PlayerManager.instance.newbieProcess <= 22000)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.gotoOuterCity();
               break;
            case 64:
               SwitchPageHelp.gotoOuterArchaeology();
               break;
            case 31:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.gotoMonopolyFrame();
               break;
            case 39:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 50)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",50);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(31);
               break;
            case 42:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.gotoTransferFrame();
               break;
            case 43:
               if(!checkScene())
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("childpve");
               break;
            case 47:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.gotoChildArenaFrame();
               break;
            case 44:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.gotoMounts();
               break;
            case 45:
               if(!checkScene())
               {
                  return;
               }
               if(thane.grades < 50)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",50);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               SwitchPageHelp.openPetFrame(1);
               break;
            case 50:
               if(thane.grades < 55)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",55);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("faterotary");
               break;
            case 51:
               if(thane.grades < 55)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(ChildManager.instance.model.childList.length <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("childpatrol",1);
               break;
            case 52:
               if(thane.grades < 38)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 53:
               if(thane.grades < 50)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 55:
               if(ArmyManager.instance.thane.grades < 13)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SandboxManager.instance.requestState();
               break;
            case 57:
            case 58:
            case 59:
            case 60:
               if(ArmyManager.instance.thane.grades < 13)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("consortia",1,5);
               break;
            case 61:
               if(petBossModel.isOpen)
               {
                  if(ArmyManager.instance.thane.grades < 50)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("tasktracetip.view.PetBossTipView.LevelTips"));
                     return;
                  }
                  SwitchPageHelp.walkToCrossMapTarget(petBossModel.mapId + "," + petBossModel.nodeId);
                  break;
               }
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.DailyItem.PetBossUnOpen"));
               return;
               break;
            case 65:
               if(PlayerManager.instance.newbieProcess <= 25000)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("cathouse");
               break;
            case 66:
               if(ArmyManager.instance.thane.grades < 80)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",80);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("navigation",1);
               break;
            case 68:
               if(thane.grades < 38)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 67:
            case 101:
            case 102:
            case 104:
               if(!checkScene())
               {
                  return;
               }
               TopToolsBar.instance.enterOutyardScene();
               break;
            case 69:
               SwitchPageHelp.openPerkinLabFrame();
               break;
            case 70:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(19);
               break;
            case 71:
               if(thane.grades < 13)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",13);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("consortia",11);
               break;
            case 72:
               SwitchPageHelp.openTitanTemple();
               break;
            case 73:
               SwitchPageHelp.openShuttleFrame();
               break;
            case 74:
               SwitchPageHelp.openAbysmFrame();
               break;
            case 75:
               SwitchPageHelp.openAlchemicalFrame();
               break;
            case 77:
               SwitchPageHelp.openUnrealShootingFrame();
               break;
            case 78:
               SwitchPageHelp.walkToCrossMapTarget("10000,44");
               break;
            case 79:
               if(thane.vocationGrades <= 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command02",80);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 80:
               SwitchPageHelp.walkToCrossMapTarget("10000,44");
               break;
            case 81:
               SwitchPageHelp.openRevengeRoad();
               break;
            case 82:
               SwitchPageHelp.openGuildWantedFrame();
               break;
            case 83:
               SwitchPageHelp.openMonsterExploreFrame();
               break;
            case 84:
               FrameControllerManager.instance.openControllerByInfo("star");
               break;
            case 85:
               SwitchPageHelp.openDemonLandFrame();
               break;
            case 86:
               SwitchPageHelp.openTimeVortexFrame();
               break;
            case 87:
               SwitchPageHelp.openLordTrailFrame();
               break;
            case 88:
               SwitchPageHelp.openEclipticPalaceFrame();
               break;
            case 89:
               SwitchPageHelp.openGuildFbFrame();
               break;
            case 90:
               SwitchPageHelp.openRedemptionRoad();
               break;
            case 91:
               SwitchPageHelp.openIncreasinglyRoad();
               break;
            case 92:
               SwitchPageHelp.openSpiritExpeditionFrame();
               break;
            case 93:
               SwitchPageHelp.openYLExpeditionFrame();
               break;
            case 94:
               SwitchPageHelp.openShadowLandFrame();
               break;
            case 95:
               SwitchPageHelp.openChildEsalFrame();
               break;
            case 96:
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(49);
               break;
            case 97:
               if(thane.grades < 13)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",13);
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
               break;
            case 103:
               if(thane.grades < 28)
               {
                  _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!checkScene())
               {
                  return;
               }
               SwitchPageHelp.goSpaceAndFind(44);
         }
      }
      
      private function get petBossModel() : PetBossModel
      {
         return CampaignManager.instance.petBossModel;
      }
      
      private function callBack() : void
      {
         var _loc2_:Frame = FrameControllerManager.instance.taskControler.frame;
         if(TaskManage.instance.cate.completedList.length > 0)
         {
            return;
         }
         var _loc1_:Array = TaskManage.instance.cate.commonTaskList;
         if(_loc2_.parent)
         {
            _loc1_.sortOn(["isCompleted","Sort"],[2,16]);
            _loc2_["selectedByInfo"] = _loc1_[0];
         }
      }
      
      private function checkCampainOpen() : Boolean
      {
         if(thane.grades >= 20)
         {
            return true;
         }
         showFaildMes();
         return false;
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:String = WorldBossHelper.getCampaignTips();
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         if(SceneManager.instance.currentType == "PVE_ROOM_SCENE" || SceneManager.instance.currentType == "PVP_ROOM_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command03");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      private function openWaterFrame() : void
      {
         if(!checkScene())
         {
            return;
         }
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            NotificationManager.instance.addEventListener("SWITCH_SCENE",__sceneSwitchHandler);
            _callback = openWaterFrame;
            SceneManager.instance.setScene("CASTLE_SCENE");
            return;
         }
         if(thane.grades >= 12)
         {
            FrameControllerManager.instance.openControllerByInfo("farm","CastleBuildingView.FarmEnterNewFrame");
         }
         else
         {
            showFaildMes();
         }
      }
      
      private function __sceneSwitchHandler(param1:Event) : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__sceneSwitchHandler);
         if(_callback != null && SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            _callback();
         }
         _callback = null;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showFaildMes(param1:String = "") : void
      {
         if(param1 == "")
         {
            param1 = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command04");
         }
         MessageTipManager.instance().show(param1);
      }
      
      public function getCurrConditionType() : String
      {
         if(thane.grades >= 55)
         {
            if(playerInfo.vocationGrades > 0)
            {
               return "024";
            }
            return "023";
         }
         return "013";
      }
   }
}

