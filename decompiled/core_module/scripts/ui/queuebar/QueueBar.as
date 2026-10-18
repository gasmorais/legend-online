package ui.queuebar
{
   import battle.utils.Int64Utils;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import managers.ChallengeManager;
   import managers.ChildManager;
   import managers.DayGuideManager;
   import managers.GloryroadManager;
   import managers.MopupManager;
   import managers.PetChallengeManager;
   import managers.TimeVortexManager;
   import managers.VIPManager;
   import mvc.controler.BuildingControler;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.gloryroad.GloryRoadModel;
   import mvc.module.heroroad.AchievementTaskInfo;
   import mvc.module.upgradepresent.UpgradePresentModel;
   import mvc.module.vip.VIPModel;
   import ui.queuebar.view.QueueItem;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ExpBackManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.QueueBarManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.manager.UpgradePresentManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class QueueBar extends Sprite
   {
      
      public static const BUILD:int = 1;
      
      public static const TEC:int = 2;
      
      private static var _instance:QueueBar;
      
      private var _back:ScaleBitmapImage;
      
      private var _list:Vector.<QueueItem>;
      
      private var _tips:Bitmap;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _expBackBtn:BaseButton;
      
      private var _heroRoadBtn:BaseButton;
      
      private var _upgradePresentBtn:BaseButton;
      
      private var _upgradePresentCountMc:MovieClip;
      
      private var _heroRoadBtn2:BaseButton;
      
      private var _popBtn:BaseButton;
      
      private var _countTime:TimeDownView;
      
      private var _vBoxChilds:int;
      
      private var _recycleList:Array;
      
      public function QueueBar()
      {
         super();
         initEvent();
      }
      
      public static function get instance() : QueueBar
      {
         if(!_instance)
         {
            _instance = new QueueBar();
         }
         return _instance;
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function playItemEffect(param1:int) : void
      {
         for each(var _loc2_:QueueItem in _list)
         {
            if(param1 == 0 && !_loc2_.data)
            {
               _loc2_.playEffect();
               break;
            }
            if(_loc2_.data && _loc2_.data.orderType == param1)
            {
               _loc2_.playEffect();
               break;
            }
         }
      }
      
      public function show() : void
      {
         if(thane.grades < 5)
         {
            return;
         }
         if(SceneManager.instance.currentType == "SANDBOX_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "PLANE_CRISRIS")
         {
            return;
         }
         if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CROSS_GUILD_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "THESE_PVP_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CHILD_NS_WAR_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
         {
            return;
         }
         var _loc3_:Boolean = FrameControllerManager.instance.outyardControler.isOutyardMapApply;
         if(_loc3_)
         {
            return;
         }
         if(SceneManager.instance.currentType == "PVP_ROOM_SCENE" || SceneManager.instance.currentType == "PVE_ROOM_SCENE" || SceneManager.instance.currentType == "MULTILORDS_ROOM" || SceneManager.instance.currentType == "OUTER_CITY_SCENE" || SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM" || SceneManager.instance.currentType == "STARAREA_SCENE")
         {
            return;
         }
         var _loc4_:Boolean = FrameControllerManager.instance.gemMazeController.isEnterGemMaze;
         if(_loc4_)
         {
            return;
         }
         var _loc2_:Boolean = SceneManager.instance.isEnterFullScene;
         if(_loc2_)
         {
            return;
         }
         var _loc1_:String = ComponentSetting.getUISourcePath("tasktracebar");
         LoaderManagerII.instance.load(_loc1_,3,8,__completehandler);
      }
      
      private function __completehandler(param1:LoaderInfo, param2:Object) : void
      {
         CheckUIModuleUtil.instance.tryCall("queuebar",showImp);
         this.visible = true;
      }
      
      private function __UpvipInfoHandler(param1:VIPEvent) : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            for each(var _loc2_:QueueItem in _list)
            {
               if(_loc2_.data && _loc2_.data.remainTime > 0 && _loc2_.type != 9)
               {
                  _loc2_.dispatchEvent(new MouseEvent("click"));
               }
            }
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:BuildInfo = null;
         var _loc3_:QueueItem = param1.currentTarget as QueueItem;
         _loc3_.stopEffect();
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         switch(_loc3_.type - 5)
         {
            case 0:
               FrameControllerManager.instance.openControllerByInfo("newactiveleed");
               break;
            case 4:
               switch(_loc3_.data.orderId - 1)
               {
                  case 0:
                     DayGuideManager.instance.switchScene(12);
                     break;
                  case 1:
                     DayGuideManager.instance.switchScene(24);
                     break;
                  case 2:
                     TopToolsBar.instance.enterOutyardScene();
                     break;
                  case 3:
                     FrameControllerManager.instance.openControllerByInfo("navigation",1);
                     break;
                  case 4:
                     if(_loc3_.data.remainTime > 0)
                     {
                        coolColosseItemPet(_loc3_.data);
                     }
                     else
                     {
                        FrameControllerManager.instance.openControllerByInfo("petchallenge",2);
                     }
                     break;
                  case 5:
                     if(_loc3_.data.remainTime > 0)
                     {
                        coolColosseItem(_loc3_.data);
                     }
                     else if(_loc3_.data.remainCount > 0 || _loc3_.data.remainBuyCount > 0)
                     {
                        if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
                        {
                           _loc2_ = LanguageMgr.GetTranslation("yishi.SwitchPageHelp.movePrompt");
                           MessageTipManager.instance().show(_loc2_);
                           break;
                        }
                        ChallengeManager.instance.enterScene = SceneManager.instance.currentType;
                        SceneManager.instance.setScene("CHANLLENGE_ROOM_SCENE");
                     }
                     break;
                  case 6:
                     DayGuideManager.instance.switchScene(43);
                     break;
                  case 7:
                     DayGuideManager.instance.switchScene(40);
                     break;
                  case 8:
                     DayGuideManager.instance.switchScene(5);
                     break;
                  case 9:
                     DayGuideManager.instance.switchScene(64);
                     break;
                  case 10:
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
                     if(!SwitchPageHelp.checkScene())
                     {
                        return;
                     }
                     FrameControllerManager.instance.openControllerByInfo("childpatrol",1);
                     break;
                  case 11:
                     _loc4_ = BuildingManager.instance.getBuildingInfoBySonType(1511);
                     FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc4_),null,_loc4_);
                     break;
                  case 12:
                     TopToolsBar.instance.enterOutyardScene();
                     break;
                  case 13:
                     FrameControllerManager.instance.openControllerByInfo("gloryroad");
                     break;
                  case 14:
                     SwitchPageHelp.openShuttleFrame();
                     break;
                  case 15:
                     SwitchPageHelp.openSpiritExpeditionFrame();
               }
               break;
            case 5:
               FrameControllerManager.instance.openControllerByInfo("dayguide",1);
               break;
            case 6:
               SwitchPageHelp.openTimeVortexFrame();
         }
      }
      
      public function enterOutyardScene() : void
      {
         var stateMsg:HugeHeadStateMsg;
         var mySignInMsg:HugeHeadMySignInStateMsg;
         var config:int;
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var nextOpenTime:Number;
         var start:Date;
         var timeStr:String;
         var timeId:int;
         if(playerInfo.consortiaID == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.noConsortia"));
            return;
         }
         stateMsg = OutyardManager.instance.model.stateMsg;
         mySignInMsg = OutyardManager.instance.model.signInMsg;
         if(!stateMsg || !mySignInMsg)
         {
            return;
         }
         if(!mySignInMsg.guildSignIn)
         {
            if(stateMsg.canSignIn)
            {
               if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.chairmanID == playerInfo.userId)
               {
                  SimpleAlertHelper.instance.data = [__alertOutyardHandler];
                  config = ConfigInfoManager.instance.getStackHeadJoinFee();
                  confirm = LanguageMgr.GetTranslation("public.confirm");
                  cancel = LanguageMgr.GetTranslation("public.cancel");
                  prompt = LanguageMgr.GetTranslation("public.prompt");
                  content = LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.openTxt.text",config);
                  SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,true);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.consortiaSignup"));
               }
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.cannotReportToday"));
            }
            return;
         }
         nextOpenTime = stateMsg && stateMsg.hugeHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(stateMsg.hugeHeadNextOpenTime[0].startTime) : 0;
         if(nextOpenTime == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.noOpenToday"));
            return;
         }
         start = new Date(nextOpenTime);
         timeStr = DateFormatter.timeFormat1(start);
         if(stateMsg.hugeHeadState == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",timeStr));
            return;
         }
         if(stateMsg.hugeHeadState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.gatherToday"));
            return;
         }
         if(!mySignInMsg.guildJoin)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",timeStr));
            return;
         }
         if(!mySignInMsg.selfJoin)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.selfJoinNextOpenDate",timeStr));
            return;
         }
         if(thane.vocationGrades <= 0)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("outyard",3);
         timeId = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            if(TimeVortexManager.instance.model.openDragon)
            {
               FrameControllerManager.instance.openControllerByInfo("timevortex",1);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("timevortex",0);
            }
         },1000));
      }
      
      private function __alertOutyardHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateMapOutyard(11);
         }
      }
      
      private function __upgradeHandler(param1:PlayerEvent) : void
      {
         if(param1.prevGrade < 16 && thane.grades >= 16)
         {
            refreshView();
         }
         upgradePresentModel.setModelData(true);
         __updateMsgBackHandler(null,null);
      }
      
      private function get buildManager() : BuildingManager
      {
         return BuildingManager.instance;
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         if(!param1)
         {
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < 100)
         {
            RechargeAlertMannager.show();
            return;
         }
         param4 = param2 == false ? 1 : 0;
         BuildingSocketOutManager.sendBuyOrder(param4);
      }
      
      private function buyQueueItem() : void
      {
         var _loc4_:int = int(TempleteManager.instance.getConfigInfoByConfigName("Order_NeedPay").ConfigValue);
         var _loc1_:String = LanguageMgr.GetTranslation("mainBar.QueueBar.content",_loc4_);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("mainBar.QueueBar.prompt");
         SimpleAlertHelper.instance.data = [buyCallBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc1_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendCoolColosseun(param3,param4);
         }
      }
      
      private function coolColosseItem(param1:BuildingOrderInfo) : void
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc4_:VipCoolDownFrame = null;
         if(!param1)
         {
            return;
         }
         if(param1.remainTime == 0)
         {
            return;
         }
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            coolColosseBack(true,param1.orderId);
         }
         else
         {
            _loc6_ = Math.ceil(param1.remainTime / 60);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.prompt");
            _loc7_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.content",_loc6_);
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc4_.initData(_loc5_,_loc7_,param1.orderId,_loc6_,_loc6_,coolColosseBack,_loc2_,_loc3_);
            _loc4_.show();
         }
      }
      
      private function coolColosseItemPet(param1:BuildingOrderInfo) : void
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc4_:VipCoolDownFrame = null;
         if(!param1)
         {
            return;
         }
         if(param1.remainTime == 0)
         {
            return;
         }
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            PetChallengeManager.instance.coolDownChallengeCD();
         }
         else
         {
            _loc6_ = Math.ceil(param1.remainTime / 60);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.prompt");
            _loc7_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.content",_loc6_);
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc4_.initData(_loc5_,_loc7_,param1.orderId,_loc6_,_loc6_,coolColosseBackPet,_loc2_,_loc3_);
            _loc4_.show();
         }
      }
      
      private function coolColosseBackPet(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            PetChallengeManager.instance.coolDownChallengeCD(param4);
         }
      }
      
      private function coolItem(param1:BuildingOrderInfo) : void
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc4_:VipCoolDownFrame = null;
         if(!param1)
         {
            return;
         }
         if(param1.remainTime == 0)
         {
            return;
         }
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            BuildingManager.instance.allCoolBack(true,param1.orderId);
         }
         else
         {
            _loc6_ = Math.ceil(param1.remainTime / 600);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.prompt");
            _loc7_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.content",_loc6_);
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc4_.initData(_loc5_,_loc7_,param1.orderId,_loc6_,_loc6_,BuildingManager.instance.allCoolBack,_loc2_,_loc3_);
            _loc4_.show();
         }
      }
      
      private function init() : void
      {
      }
      
      private function initEvent() : void
      {
         thane.addEventListener("THANE_LEVEL_UPDATE",__upgradeHandler);
         vipModel.addEventListener("upframeview_change",__UpvipInfoHandler);
         NotificationManager.instance.addEventListener("RECOVER_EXP",__recoverExpChangeHandler);
         MsgMan.addObserver("UPGRADE_PRESNET_INFO_CHANGE",this,__updateMsgBackHandler);
         QueueBarManager.instance.addEventListener("ACTIVE_ORDERID_CHANGE",__activeOrderidChange);
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_CLOSE_GIFTFRAME",_closeGiftFrameHandler);
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_ITEM_UPDATE",_closeGiftFrameHandler);
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
         NotificationManager.instance.addEventListener("ACTIVITY_INFO_EVENT",__userDataUpdateHandler);
         NotificationManager.instance.addEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
      }
      
      private function __userDataUpdateHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      protected function __activeOrderidChange(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshPosition() : void
      {
         _vBoxChilds <= 6 ? (x = 20) : (x = 0);
      }
      
      private function __recoverExpChangeHandler(param1:NotificationEvent) : void
      {
         if(!parent)
         {
            return;
         }
         if(VersionSwitch.RECOVER_BAK && thane.grades >= 40 && ExpBackManager.Instance.backExp > 0)
         {
            _expBackBtn.visible = true;
            _expBackBtn.addEventListener("click",__expBackClickHandler);
         }
         else
         {
            _expBackBtn.visible = false;
         }
      }
      
      private function __updateMsgBackHandler(param1:String, param2:Object) : void
      {
         if(!parent)
         {
            return;
         }
         if(VersionSwitch.UPGRADE_PRESENT && upgradePresentModel.isShowBtn)
         {
            _upgradePresentBtn.visible = true;
            _upgradePresentCountMc.visible = true;
            _upgradePresentCountMc.txt.text = upgradePresentModel.infoTipNum;
            _upgradePresentBtn.addEventListener("click",__upgradePresentClickHandler);
         }
         else
         {
            _upgradePresentBtn.visible = false;
            _upgradePresentCountMc.visible = false;
         }
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = HeroRoadManager.instance.currentPopTemplateId;
         if(HeroRoadManager.instance.taskDictionary[_loc2_])
         {
            if(_countTime)
            {
               _countTime.timeCount = HeroRoadManager.instance.currentLeftSecond;
               _countTime.visible = true;
            }
         }
         else if(_countTime)
         {
            _countTime.timeCount = 0;
         }
      }
      
      private function _closeGiftFrameHandler(param1:NotificationEvent) : void
      {
         if(HeroRoadManager.instance.popTaskArr.length == 0)
         {
            _popBtn.visible = false;
            _countTime.visible = false;
         }
      }
      
      private function _timerCompleteHandler(param1:Event) : void
      {
         if(_countTime)
         {
            _countTime.timeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            if(HeroRoadManager.instance.currentPopTemplateId > 0)
            {
               if(HeroRoadManager.instance.popTaskArr.length == 1)
               {
                  _popBtn.visible = false;
                  _countTime.visible = false;
               }
               HeroRoadManager.instance.popTaskArr.shift();
               HeroRoadManager.instance.currentPopTemplateId = 0;
               HeroRoadManager.instance.currentLeftSecond = 0;
               HeroRoadManager.instance.count = 0;
            }
         }
      }
      
      private function __expBackClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("expback");
      }
      
      private function __heroRoadClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("heroroad");
      }
      
      private function __popBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc3_:String = SceneManager.instance.currentType;
         var _loc2_:AchievementTaskInfo = HeroRoadManager.instance.popTaskInfo;
         if(_loc2_ && (_loc3_ == "SPACE_SCENE" || _loc3_ == "CASTLE_SCENE"))
         {
            FrameControllerManager.instance.openControllerByInfo("heroroad",2,_loc2_);
         }
      }
      
      private function __upgradePresentClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("upgradepresent");
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("queueBar.Back");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("queueBar.Vbox");
         _tips = ComponentFactory.Instance.creatBitmap("asset.queueBar.tipsImg");
         _expBackBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.expBackBtn");
         _heroRoadBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.heroRoadBtn");
         _upgradePresentBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.upgradePresentBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("queueBar.ScrollPanel");
         _upgradePresentCountMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _upgradePresentCountMc.mouseChildren = _upgradePresentCountMc.mouseEnabled = false;
         _upgradePresentCountMc.visible = false;
         _upgradePresentCountMc.x = 45;
         _upgradePresentCountMc.y = 5;
         _heroRoadBtn2 = ComponentFactory.Instance.creatComponentByStylename("queueBar.heroRoadBtn2");
         _popBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.popBtn");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("queueBar.countTime");
         addChild(_back);
         addChild(_vBox);
         addChild(_tips);
         addChild(_expBackBtn);
         if(VersionSwitch.ACHIEVEMENT)
         {
            addChild(_heroRoadBtn2);
            addChild(_popBtn);
            addChild(_countTime);
         }
         else
         {
            addChild(_heroRoadBtn);
         }
         _popBtn.visible = _countTime.visible = false;
         addChild(_upgradePresentBtn);
         _upgradePresentBtn.addChild(_upgradePresentCountMc);
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         _list = new Vector.<QueueItem>();
         addChild(_scrollPanel);
      }
      
      private function clean() : void
      {
         var _loc1_:QueueItem = null;
         _recycleList = [];
         while(_list.length > 0)
         {
            _loc1_ = _list.shift() as QueueItem;
            _loc1_.type = -1;
            _loc1_.data = null;
            _loc1_.removeEventListener("click",__itemClickHandler);
            _recycleList.push(_loc1_);
         }
         _vBox.removeAllChild();
         _vBoxChilds = 0;
         if(_expBackBtn)
         {
            _expBackBtn.removeEventListener("click",__expBackClickHandler);
         }
         if(_heroRoadBtn)
         {
            _heroRoadBtn.removeEventListener("click",__heroRoadClickHandler);
         }
         if(_heroRoadBtn2)
         {
            _heroRoadBtn2.removeEventListener("click",__heroRoadClickHandler);
         }
         if(_popBtn)
         {
            _popBtn.removeEventListener("click",__popBtnHandler);
         }
         if(_upgradePresentBtn)
         {
            _upgradePresentBtn.removeEventListener("click",__upgradePresentClickHandler);
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:QueueItem = null;
         var _loc3_:BuildingOrderInfo = null;
         var _loc13_:BuildingOrderInfo = null;
         var _loc11_:BuildingOrderInfo = null;
         var _loc12_:GloryRoadModel = null;
         var _loc4_:BuildingOrderInfo = null;
         var _loc9_:QueueItem = null;
         var _loc5_:QueueItem = null;
         var _loc6_:QueueItem = null;
         if(!parent)
         {
            return;
         }
         var _loc7_:Array = BuildingManager.instance.model.activeOrderList;
         var _loc10_:int = ArmyManager.instance.thane.grades;
         clean();
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         if(_loc10_ >= 55 && VersionSwitch.PLANES_WAR)
         {
            _loc3_ = BuildingManager.instance.model.getActiveOrderById(12);
            if(!_loc3_)
            {
               _loc3_ = new BuildingOrderInfo();
               _loc3_.orderId = 12;
               _loc3_.orderType = 4;
               BuildingManager.instance.model.addNewOrder(_loc3_);
            }
         }
         if(_loc10_ >= 70)
         {
            _loc13_ = BuildingManager.instance.model.getActiveOrderById(11);
            if(!_loc13_)
            {
               _loc13_ = new BuildingOrderInfo();
               _loc13_.orderId = 11;
               _loc13_.orderType = 4;
               BuildingManager.instance.model.addNewOrder(_loc13_);
            }
         }
         if(_loc10_ >= 15)
         {
            _loc11_ = BuildingManager.instance.model.getActiveOrderById(14);
            if(!_loc11_)
            {
               _loc11_ = new BuildingOrderInfo();
               _loc11_.orderId = 14;
               _loc11_.orderType = 4;
               BuildingManager.instance.model.addNewOrder(_loc11_);
            }
            _loc12_ = GloryroadManager.instance.model;
            _loc11_.currentCount = _loc12_.leftAmount;
            _loc11_.totalCount = 15;
         }
         if(_loc10_ >= 20)
         {
            _loc4_ = BuildingManager.instance.model.getActiveOrderById(9);
            if(!_loc4_)
            {
               _loc4_ = new BuildingOrderInfo();
               _loc4_.orderId = 9;
               _loc4_.orderType = 4;
               _loc4_.currentCount = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyCount;
               _loc4_.totalCount = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyMaxCount;
               BuildingManager.instance.model.addNewOrder(_loc4_);
            }
            else
            {
               _loc4_.currentCount = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyCount;
               _loc4_.totalCount = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyMaxCount;
            }
         }
         if(thane.grades >= 6)
         {
            _loc9_ = _recycleList[_loc8_++];
            if(!_loc9_)
            {
               _loc9_ = new QueueItem();
            }
            _loc9_.type = 5;
            _loc9_.data = new BuildingOrderInfo();
            _vBox.addChild(_loc9_);
            _vBoxChilds = _vBoxChilds + 1;
            _list.push(_loc9_);
            _loc9_.visible = true;
            _loc9_.addEventListener("click",__itemClickHandler);
         }
         if(thane.grades >= 6)
         {
            _loc5_ = _recycleList[_loc8_++];
            if(!_loc5_)
            {
               _loc5_ = new QueueItem();
            }
            _loc5_.type = 10;
            _loc5_.data = new BuildingOrderInfo();
            _vBox.addChild(_loc5_);
            _vBoxChilds = _vBoxChilds + 1;
            _list.push(_loc5_);
            _loc5_.visible = true;
            _loc5_.addEventListener("click",__itemClickHandler);
         }
         if(thane.grades >= 6 && thane.vocationGrades > 0)
         {
            _loc6_ = _recycleList[_loc8_++];
            if(!_loc6_)
            {
               _loc6_ = new QueueItem();
            }
            _loc6_.type = 11;
            _loc6_.data = new BuildingOrderInfo();
            _vBox.addChild(_loc6_);
            _vBoxChilds = _vBoxChilds + 1;
            _list.push(_loc6_);
            _vBoxChilds = _vBoxChilds + 1;
            _loc6_.visible = true;
            _loc6_.addEventListener("click",__itemClickHandler);
         }
         _loc2_ = 0;
         while(_loc2_ < _loc7_.length)
         {
            _loc1_ = _recycleList[_loc8_++];
            if(!_loc1_)
            {
               _loc1_ = new QueueItem();
            }
            _loc1_.type = 9;
            _loc1_.data = _loc7_[_loc2_];
            switch(_loc1_.data.orderId - 1)
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
               case 6:
               case 7:
               case 8:
               case 9:
               case 10:
               case 11:
               case 12:
               case 13:
               case 14:
               case 15:
                  addQueueItem(_loc1_);
            }
            _loc2_++;
         }
         refreshPosition();
         if(VersionSwitch.RECOVER_BAK && thane.grades >= 40 && ExpBackManager.Instance.backExp > 0)
         {
            _expBackBtn.visible = true;
            _expBackBtn.addEventListener("click",__expBackClickHandler);
         }
         else
         {
            _expBackBtn.visible = false;
         }
         if(VersionSwitch.UPGRADE_PRESENT && upgradePresentModel.isShowBtn)
         {
            _upgradePresentBtn.visible = true;
            _upgradePresentCountMc.visible = true;
            _upgradePresentCountMc.txt.text = upgradePresentModel.infoTipNum;
            _upgradePresentBtn.addEventListener("click",__upgradePresentClickHandler);
         }
         else
         {
            _upgradePresentBtn.visible = false;
            _upgradePresentCountMc.visible = false;
         }
         initHeroRoadBtn();
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _scrollPanel.invalidateViewport();
      }
      
      public function initHeroRoadBtn() : void
      {
         if(!_heroRoadBtn)
         {
            return;
         }
         _popBtn.visible = false;
         _countTime.visible = false;
         _heroRoadBtn.visible = false;
         _heroRoadBtn2.visible = false;
         if(thane.grades >= 11)
         {
            if(VersionSwitch.ACHIEVEMENT)
            {
               _heroRoadBtn2.visible = true;
               _heroRoadBtn2.addEventListener("click",__heroRoadClickHandler);
               if(HeroRoadManager.instance.currentPopTemplateId > 0)
               {
                  _countTime.visible = true;
                  _popBtn.visible = true;
                  if(_countTime)
                  {
                     _countTime.addEventListener("timerDown_complete",_timerCompleteHandler);
                  }
                  _popBtn.addEventListener("click",__popBtnHandler);
               }
            }
            else
            {
               _heroRoadBtn.visible = true;
               _heroRoadBtn.addEventListener("click",__heroRoadClickHandler);
            }
         }
      }
      
      public function setCountTime(param1:int) : void
      {
         if(_countTime)
         {
            _countTime.timeCount = param1;
         }
      }
      
      private function addQueueItem(param1:QueueItem) : void
      {
         if(param1.data.currentCount <= 0 && (param1.data.orderId == 1 || param1.data.orderId == 2 || param1.data.orderId == 5 || param1.data.orderId == 7 || param1.data.orderId == 8 || param1.data.orderId == 10 || param1.data.orderId == 9 || param1.data.orderId == 14))
         {
            return;
         }
         if(param1.data.orderId == 5 && thane.grades < 50)
         {
            return;
         }
         if(param1.data.orderId == 10 && thane.grades < 15)
         {
            return;
         }
         if(param1.data.orderId == 1 && playerInfo.consortiaID == 0)
         {
            return;
         }
         if(param1.data.orderId == 6 && thane.grades < 16)
         {
            return;
         }
         if(param1.data.orderId == 6 && param1.data.remainCount == 0)
         {
            return;
         }
         if(param1.data.orderId == 3 && param1.data.property1 == 0)
         {
            return;
         }
         if(param1.data.orderId == 15 && !ArmyManager.instance.thane.isChangeJob)
         {
            return;
         }
         if(param1.data.orderId == 13 && (param1.data.property1 == 0 || param1.data.property1 == 1))
         {
            return;
         }
         if((param1.data.orderId == 3 || param1.data.orderId == 13) && param1.data.property2 == false)
         {
            return;
         }
         if(param1.data.orderId == 4 && int(param1.data.info.strength) == 0)
         {
            return;
         }
         if(param1.data.orderId == 16)
         {
            if(!VersionSwitch.SPIRIT_EXPEDITION || !ArmyManager.instance.thane.isAvenger)
            {
               return;
            }
         }
         _vBox.addChild(param1);
         _vBoxChilds = _vBoxChilds + 1;
         _list.push(param1);
         param1.visible = true;
         param1.addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("THANE_LEVEL_UPDATE",__upgradeHandler);
         vipModel.removeEventListener("upframeview_change",__UpvipInfoHandler);
         NotificationManager.instance.removeEventListener("RECOVER_EXP",__recoverExpChangeHandler);
         QueueBarManager.instance.removeEventListener("ACTIVE_ORDERID_CHANGE",__activeOrderidChange);
         MsgMan.removeObserver("UPGRADE_PRESNET_INFO_CHANGE",this,__updateMsgBackHandler);
         if(_countTime)
         {
            _countTime.removeEventListener("timerDown_complete",_timerCompleteHandler);
         }
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_CLOSE_GIFTFRAME",_closeGiftFrameHandler);
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_ITEM_UPDATE",_closeGiftFrameHandler);
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
         NotificationManager.instance.removeEventListener("ACTIVITY_INFO_EVENT",__userDataUpdateHandler);
         NotificationManager.instance.removeEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
      }
      
      private function showImp() : void
      {
         if(!this.parent)
         {
            initView();
            y = 159;
            LayerManager.Instance.addToLayer(this,4,false,false,0,0);
         }
         refreshPosition();
         refreshView();
      }
      
      public function getQueueItemByType(param1:int) : QueueItem
      {
         for each(var _loc2_:QueueItem in _list)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get upgradePresentModel() : UpgradePresentModel
      {
         return UpgradePresentManager.instance.model;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
   }
}

