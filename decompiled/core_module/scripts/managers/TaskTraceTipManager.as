package managers
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Disposeable;
   import events.VIPEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.ExternalInterfaceManager;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import mvc.module.task.TaskTemplate;
   import tasktracetip.data.TipMessageData;
   import yishi.actions.base.AlertTipAction;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.WorldBossHelper;
   
   public class TaskTraceTipManager
   {
      
      public static var showVipTipView:Boolean = false;
      
      public static var showKingContractTipView:Boolean = false;
      
      private static var _instance:TaskTraceTipManager;
      
      private static const NO_ALERT_TYPE:Array = [11,17,20,21,27,31,32,36,40];
      
      private var betterComposeAlertCount:int;
      
      private var _viewList:Vector.<Sprite>;
      
      private var _array:Array;
      
      private var mountOpenTipView:Sprite;
      
      private var isLoader:int = 1;
      
      private var _needLoadCount:int = 2;
      
      private var _currentLoadCount:int = 0;
      
      private var _tempDataList:Array = [];
      
      public function TaskTraceTipManager()
      {
         super();
         _viewList = new Vector.<Sprite>();
         _array = [];
      }
      
      public static function get instance() : TaskTraceTipManager
      {
         if(!_instance)
         {
            _instance = new TaskTraceTipManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         GoodsManager.instance.addEventListener("ADD_GOODS",__addGoodsHandler);
         GoodsManager.instance.addEventListener("NEW_GOODS",__newGoodsHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpdateHandler);
         playerInfo.addEventListener("WEARY_CHANGE",__wearyChangeHandler);
         VIPManager.Instance.model.addEventListener("vip_recharge_tip",__vipRechargeHandler);
         NotificationManager.instance.addEventListener("NEXT_TASK_TRACETIPVIEW",__checkNextViewHandler);
      }
      
      private function __checkNextViewHandler(param1:NotificationEvent) : void
      {
         if(_array.length == 0)
         {
            return;
         }
         showView(null);
      }
      
      private function __vipRechargeHandler(param1:VIPEvent) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = param1.data.type;
         _loc2_.title = param1.data.title;
         showView(_loc2_);
      }
      
      private function __addGoodsHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(thane.grades <= 20 && _loc2_ && _loc2_.bagType == 1 && _loc2_.templateInfo.SonType == 292)
         {
            DelayActionsUtils.instance.addAction(new AlertTipAction({
               "type":_loc2_.templateInfo.SonType,
               "data":_loc2_
            },vipCardHandler));
         }
      }
      
      private function __newGoodsHandler(param1:BagEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         if(FrameControllerManager.instance.vipController.model.curOpenVipBox)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc6_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < param1.list.length)
         {
            _loc5_ = param1.list[_loc4_] as GoodsInfo;
            if(thane.grades <= 20 && _loc5_.templateInfo.SonType == 203 && _loc5_.templateInfo.Property1 == 5 && playerInfo.weary == 0)
            {
               DelayActionsUtils.instance.addAction(new AlertTipAction(_loc5_,useWearyHandler));
            }
            else
            {
               if(thane.grades == 5 && _loc5_.templateInfo.SonType == 298)
               {
                  checkNoviceBoxTip();
               }
               if(showVipTipView && GoodsCheck.isVipExperienceCard(_loc5_))
               {
                  showVipTipView = false;
                  DelayActionsUtils.instance.addAction(new AlertTipAction({
                     "type":_loc5_.templateId,
                     "data":_loc5_
                  },vipCardHandler));
               }
               else if(showKingContractTipView && GoodsCheck.isKingCard(_loc5_))
               {
                  showKingContractTipView = false;
                  DelayActionsUtils.instance.addAction(new AlertTipAction(_loc5_,kingContractCardHandler));
               }
               else
               {
                  if(isFashionGoods(_loc5_.templateInfo) && !FashionManager.instance.fashionModel.isInBookList(_loc5_.templateId))
                  {
                     _loc6_ = true;
                  }
                  if(GoodsCheck.checkGoodsBetterThanHero(_loc5_))
                  {
                     _loc2_.push(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
         if(_loc6_)
         {
            FashionManager.instance.getFashionBook();
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = copyGoods(_loc2_[_loc2_.length - 1] as GoodsInfo);
            if(GoodsCheck.isFashion(_loc3_.templateInfo))
            {
               return;
            }
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_[_loc2_.length - 1],betterGoodsHandler));
         }
         _loc2_ = null;
      }
      
      private function isFashionGoods(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1.SonType == 112 || param1.SonType == 110 || param1.SonType == 111 || param1.SonType == 109)
         {
            return true;
         }
         return false;
      }
      
      private function __levelUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc2_:TipMessageData = null;
         var _loc3_:TaskTemplate = null;
         var _loc4_:PlayerBufferInfo = null;
         showBetterGoods();
         checkNoviceBoxTip();
         if(thane.grades == 40)
         {
            _loc2_ = new TipMessageData();
            _loc2_.type = 27;
            _loc2_.title = LanguageMgr.GetTranslation("tasktracetip.view.PawnCharacteristicsTipView.title");
            showView(_loc2_);
         }
         if(thane.preGrade < 55 && thane.grades >= 55)
         {
            _loc2_ = new TipMessageData();
            _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
            _loc2_.type = 31;
            _loc2_.content = LanguageMgr.GetTranslation("tasktracetip.view.FateGuardOpenview.content");
            showView(_loc2_);
         }
         var _loc5_:Boolean = ConfigManager.info.CLIENT_DOWNLAND;
         if(_loc5_ && thane.preGrade < 10 && thane.grades >= 10)
         {
            _loc2_ = new TipMessageData();
            _loc2_.type = 18;
            _loc3_ = TaskManage.instance.getTaskByID(150);
            _loc2_.content = _loc3_.Detail;
            _loc2_.title = _loc3_.Title;
            _loc2_.data = _loc3_;
            showView(_loc2_);
         }
         if(thane.preGrade < 10 && thane.grades >= 10)
         {
            _loc4_ = PlayerBufferManager.instance.getItemBufferInfo(20000);
            if(_loc4_)
            {
               alertFashionIndentityBufferTipView(_loc4_.description);
            }
         }
      }
      
      public function alertFashionIndentityBufferTipView(param1:String) : void
      {
         if(thane.grades < 10)
         {
            return;
         }
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = 44;
         _loc2_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         _loc2_.content = param1;
         TaskTraceTipManager.instance.showView(_loc2_);
      }
      
      private function __wearyChangeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = null;
         if(thane.grades < 20 && playerInfo.weary == 0)
         {
            _loc3_ = GoodsManager.instance.getGoodsBySonType(203);
            for each(var _loc4_:GoodsInfo in _loc3_)
            {
               if(_loc4_.templateInfo.Property1 == 5)
               {
                  DelayActionsUtils.instance.addAction(new AlertTipAction(_loc4_,useWearyHandler));
               }
            }
         }
      }
      
      private function checkNoviceBoxTip() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:Array = BoxManager.instance.gradeBoxList;
         for each(var _loc1_:int in _loc3_)
         {
            if(thane.grades >= _loc1_ && !BoxManager.instance.isRecviedByGrade(_loc1_))
            {
               _loc2_ = GoodsManager.instance.getGeneralBagGoodsBySonType(298)[0];
               if(_loc2_ && _loc2_.templateInfo && _loc2_.templateInfo.NeedGrades == _loc1_)
               {
                  DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_,noviceBoxAlertTip));
               }
            }
         }
      }
      
      private function noviceBoxAlertTip(param1:GoodsInfo) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc2_.goods = param1;
         _loc2_.type = 10;
         showView(_loc2_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function startLoader(param1:TipMessageData) : void
      {
         if(isLoader == 2)
         {
            return;
         }
         _tempDataList.push(param1);
         var _loc2_:String = ComponentSetting.getProjectSourcePath("16.png");
         LoaderManagerII.instance.load(_loc2_,3,8,__loadCompleteHandler);
         var _loc3_:String = ComponentSetting.getUISourcePath("tasktracebar");
         LoaderManagerII.instance.load(_loc3_,3,8,__loadCompleteHandler);
         isLoader = 3;
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:TipMessageData = null;
         _currentLoadCount = _currentLoadCount + 1;
         if(_currentLoadCount < _needLoadCount)
         {
            return;
         }
         isLoader = 2;
         while(_tempDataList.length > 0)
         {
            _loc3_ = _tempDataList.pop() as TipMessageData;
            showView(_loc3_);
         }
      }
      
      public function showView(param1:TipMessageData) : void
      {
         if(BraveLegManager.instance.hasTeam())
         {
            return;
         }
         if(FrameControllerManager.instance.sacrificeController.isInSacrificeFrame)
         {
            return;
         }
         if(SceneManager.instance.currentType == "STARAREA_SCENE")
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
         if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(findViewList(param1))
         {
            return;
         }
         if(param1)
         {
            for each(var _loc5_ in _array)
            {
               if(_loc5_.type == param1.type)
               {
                  _array.splice(_array.indexOf(_loc5_),1);
               }
            }
            if(NO_ALERT_TYPE.indexOf(param1.type) == -1)
            {
               if(checkIsAntaeusTaskTraceTip(param1))
               {
                  _array.unshift(param1);
               }
               else
               {
                  _array.push(param1);
               }
            }
            for each(var _loc2_ in _viewList)
            {
               if(_loc2_.data.isFource)
               {
                  return;
               }
               _viewList.splice(_viewList.indexOf(_loc2_),1);
               _array.splice(_array.length - 2,0,_loc2_.data as TipMessageData);
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         else
         {
            param1 = _array.pop();
            _loc4_ = true;
         }
         if(_viewList.length >= 1)
         {
            return;
         }
         if(!checkShowTaskTraceTip(param1))
         {
            return;
         }
         var _loc3_:Sprite = getViewByType(param1.type);
         if(!_loc3_)
         {
            if(isLoader == 1)
            {
               startLoader(param1);
               return;
            }
            return;
         }
         _loc3_.data = param1;
         _loc3_.show();
         if(!_loc4_)
         {
            _array.pop();
         }
      }
      
      private function findViewList(param1:TipMessageData) : Boolean
      {
         for each(var _loc2_ in _viewList)
         {
            if(_loc2_.data && param1.type == _loc2_.data.type)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkIsAntaeusTaskTraceTip(param1:TipMessageData) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(PlayerManager.instance.newbieProcess <= 15500)
         {
            return false;
         }
         if(param1.type == 58 || param1.type == 59)
         {
            return true;
         }
         return false;
      }
      
      private function checkShowTaskTraceTip(param1:TipMessageData) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         if(PlayerManager.instance.newbieProcess <= 15500)
         {
            return false;
         }
         if(FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame)
         {
            return false;
         }
         switch(SceneManager.instance.currentType)
         {
            case "BATTLE_SCENE":
            case "VEHICLE":
            case "PLANES_WAR_SCENE":
            case "SKYBOX_ROAD_SCENE":
            case "FINAL_DEFENSE_SCENE":
            case "INCREASINGLY_ROAD_SCENE":
               break;
            case "MULTILORDS_ROOM":
               if(param1.type != 3 && param1.type != 1 && param1.type != 45)
               {
                  return false;
               }
            default:
               if(CampaignManager.CampaignOverState)
               {
                  return false;
               }
               if(CampaignManager.instance.mapModel)
               {
                  _loc2_ = CampaignManager.instance.mapModel.mapId;
                  if(WorldBossHelper.checkPvp(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkFlameTemple(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkSvs(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkFarm(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkUnrealShooting(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkSacrificeRoom(_loc2_))
                  {
                     return false;
                  }
                  if(WorldBossHelper.checkGodsEvening(_loc2_))
                  {
                     return false;
                  }
                  if((WorldBossHelper.checkDuskArea(_loc2_) || WorldBossHelper.checkIceFireTemple(_loc2_)) && param1.type != 1)
                  {
                     return false;
                  }
               }
               return true;
         }
         return false;
      }
      
      private function vipCardHandler(param1:Object) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         var _loc3_:* = param1.type;
         if(292 !== _loc3_)
         {
            _loc2_.type = 20;
            _loc2_.isFource = true;
         }
         else
         {
            _loc2_.type = 13;
            _loc2_.content = LanguageMgr.GetTranslation("tasktracetip.view.OpenBagTipView.vipcoin");
         }
         _loc2_.goods = param1.data;
         showView(_loc2_);
      }
      
      private function kingContractCardHandler(param1:GoodsInfo) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.title = LanguageMgr.GetTranslation("KingContractTipView.title");
         _loc2_.goods = param1;
         _loc2_.content = LanguageMgr.GetTranslation("KingContractTipView.content");
         _loc2_.btnTxt = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.text02");
         _loc2_.type = 24;
         showView(_loc2_);
      }
      
      private function showBetterGoods() : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "BATTLE_SCENE")
         {
            return;
         }
         var _loc1_:Array = [];
         var _loc6_:Array = GoodsManager.instance.getGoodsByBagType(1);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_] as GoodsInfo;
            if(GoodsCheck.checkGoodsBetterThanHero(_loc5_))
            {
               _loc1_.push(_loc5_);
            }
            _loc4_++;
         }
         if(_loc1_.length && PlayerManager.instance.newbieProcess > 15500)
         {
            _loc3_ = copyGoods(_loc1_[_loc1_.length - 1] as GoodsInfo);
            if(GoodsCheck.isFashion(_loc3_.templateInfo))
            {
               return;
            }
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc1_[_loc1_.length - 1],betterGoodsHandler));
         }
         _loc1_ = null;
      }
      
      private function betterGoodsHandler(param1:Object) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc2_.goods = param1 as GoodsInfo;
         if(thane.grades >= 10)
         {
            _loc2_.type = 13;
            if(FrameControllerManager.instance.fashionCodeController.model.isFashion(_loc2_.goods))
            {
               _loc2_.content = LanguageMgr.GetTranslation("tasktracetip.view.OpenBagTipView.newFashion");
            }
            else
            {
               _loc2_.content = LanguageMgr.GetTranslation("tasktracetip.view.OpenBagTipView.text");
            }
         }
         else
         {
            _loc2_.type = 2;
         }
         showView(_loc2_);
      }
      
      private function useWearyHandler(param1:Object) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc2_.goods = param1 as GoodsInfo;
         _loc2_.type = 16;
         showView(_loc2_);
      }
      
      private function copyGoods(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.id = param1.id;
         _loc2_.pos = param1.pos;
         _loc2_.objectId = param1.objectId;
         _loc2_.templateId = param1.templateId;
         _loc2_.isBinds = param1.isBinds;
         _loc2_.validDate = param1.validDate;
         _loc2_.beginDate = param1.beginDate;
         _loc2_.join1 = param1.join1;
         _loc2_.join2 = param1.join2;
         _loc2_.join3 = param1.join3;
         _loc2_.randomSkill1 = param1.randomSkill1;
         _loc2_.randomSkill2 = param1.randomSkill2;
         _loc2_.randomSkill3 = param1.randomSkill3;
         _loc2_.randomSkill4 = param1.randomSkill4;
         _loc2_.randomSkill5 = param1.randomSkill5;
         return _loc2_;
      }
      
      private function __disposeFromListHandler(param1:Event) : void
      {
         var _loc2_:Object = param1.currentTarget;
         _loc2_.removeEventListener("dispose",__disposeFromListHandler);
         var _loc3_:int = _viewList.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            _viewList.splice(_loc3_,1);
         }
      }
      
      public function clean() : void
      {
         var _loc1_:Disposeable = null;
         while(_viewList.length > 0)
         {
            _loc1_ = _viewList.pop();
            _loc1_.dispose();
         }
      }
      
      public function cleanByType(param1:int) : void
      {
         for each(var _loc2_ in _viewList)
         {
            if(_loc2_.data && _loc2_.data.type == param1)
            {
               _viewList.splice(_viewList.indexOf(_loc2_),1);
               _loc2_.dispose();
               _loc2_ = null;
               break;
            }
         }
      }
      
      public function getViewByType(param1:int) : Sprite
      {
         var _loc2_:Sprite = getLinkClass(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(_loc2_)
         {
            _loc2_.addEventListener("dispose",__disposeFromListHandler);
            _viewList.push(_loc2_);
         }
         return _loc2_;
      }
      
      private function getLinkClass(param1:int) : Sprite
      {
         var _loc3_:* = undefined;
         var _loc2_:Sprite = null;
         var _loc4_:String = "";
         switch(param1)
         {
            case 1:
               _loc4_ = "AddPawnTipView";
               break;
            case 2:
               _loc4_ = "BetterGoodsTipsView";
               break;
            case 3:
               _loc4_ = "BuyBloodTipView";
               break;
            case 4:
               _loc4_ = "IntensifyTipView";
               break;
            case 5:
               _loc4_ = "MountTipView";
               break;
            case 6:
               _loc4_ = "UpgradePawnTipView";
               break;
            case 7:
               _loc4_ = "TaskEquipTipView";
               break;
            case 10:
               _loc4_ = "GradeBoxTipView";
               break;
            case 8:
               _loc4_ = "StarTipView";
               break;
            case 9:
               _loc4_ = "MilitaryTecTipView";
               break;
            case 11:
               _loc4_ = "HookTipView";
               break;
            case 13:
               _loc4_ = "OpenBagTipView";
               break;
            case 14:
               _loc4_ = "TreeCanPickTipView";
               break;
            case 19:
               ExternalInterfaceManager.instance.initNews("04");
               _loc4_ = "FarmCanPickTipView";
               break;
            case 16:
               _loc4_ = "UseWearyTipView";
               break;
            case 18:
               _loc4_ = "TaskTipView";
               break;
            case 20:
               _loc4_ = "VIPCardTipView";
               break;
            case 21:
               _loc4_ = "VipUpGradeTipView";
               break;
            case 22:
               _loc4_ = "VipGiftGetTipView";
               break;
            case 23:
               _loc4_ = "VipRechargeTipView";
               break;
            case 34:
               _loc4_ = "VipMountActivityTipView";
               break;
            case 35:
               _loc4_ = "VipMountLoseTipView";
               break;
            case 24:
               _loc4_ = "KingContractTipView";
               break;
            case 25:
               ExternalInterfaceManager.instance.initNews("05");
               _loc4_ = "SecretTreeTipView";
               break;
            case 27:
               _loc4_ = "PawnCharacteristicsTipView";
               break;
            case 28:
               _loc4_ = "MountOpenTipView";
               break;
            case 26:
               ExternalInterfaceManager.instance.initNews("06");
               _loc4_ = "DemonOpenTipView";
               break;
            case 29:
               _loc4_ = "RegressionTipView";
               break;
            case 32:
               _loc4_ = "PetAddPointTip";
               break;
            case 33:
               ExternalInterfaceManager.instance.initNews("07");
               _loc4_ = "ShopTimeBuyTipView";
               break;
            case 36:
               _loc4_ = "TreasureMapTipView";
               break;
            case 1000:
               _loc4_ = "ExpBackTipView";
               break;
            case 38:
               _loc4_ = "CampaignCardTipView";
               break;
            case 39:
               _loc4_ = "VIPCustomTipView";
               break;
            case 40:
               _loc4_ = "DragonSoulTipView";
               break;
            case 41:
               _loc4_ = "MarryTreeTipView";
               break;
            case 42:
               _loc4_ = "PetBossTipView";
               break;
            case 43:
               _loc4_ = "SinglepassHasBugleYipsView";
               break;
            case 45:
               _loc4_ = "MultilordsBetTipView";
               break;
            case 46:
               _loc4_ = "ConsortiaBossTipView";
               break;
            case 44:
               _loc4_ = "FashionIdentityBufferTipView";
               break;
            case 48:
               _loc4_ = "ConsortiaSkillTipView";
               break;
            case 49:
               _loc4_ = "MountPropertyTipView";
               break;
            case 50:
               _loc4_ = "RefreshTipView";
               break;
            case 1001:
               _loc4_ = "PerkinlabCanPickTipView";
               break;
            case 1002:
               _loc4_ = "ChildPatrolTaskTipView";
               break;
            case 1003:
               _loc4_ = "StoreComposeBetterEquipTipView";
               break;
            case 51:
               _loc4_ = "ConsortiaTreasureTipView";
               break;
            case 57:
               _loc4_ = "ApexStartTipView";
               break;
            case 58:
               if(VersionSwitch.ANTAEUS)
               {
                  _loc4_ = "AntaeusBattleFailureTipView";
               }
               break;
            case 59:
               if(VersionSwitch.ANTAEUS)
               {
                  _loc4_ = "AntaeusMeetTipView";
               }
               break;
            case 60:
               _loc4_ = "EmeDreamTipView";
               break;
            case 61:
               _loc4_ = "ConsortiaNewBossTipView";
            case 62:
               _loc4_ = "ConsortiaTreeTipView";
         }
         if(_loc4_ != "")
         {
            _loc4_ = "tasktracetip.view." + _loc4_;
            if(DisplayLoader.Context.applicationDomain.hasDefinition(_loc4_))
            {
               _loc3_ = DisplayLoader.Context.applicationDomain.getDefinition(_loc4_);
               try
               {
                  _loc2_ = new _loc3_() as Sprite;
               }
               catch(e:Error)
               {
                  return null;
               }
               _loc3_ = null;
               return _loc2_;
            }
         }
         return null;
      }
      
      public function showBetterGoodsAlertTip() : void
      {
         var _loc1_:TipMessageData = null;
         if(betterComposeAlertCount > 3)
         {
            return;
         }
         if(inCastle() || inSpace())
         {
            if(FrameControllerManager.instance.storeController.checkHasBetterAlert)
            {
               _loc1_ = new TipMessageData();
               _loc1_.title = LanguageMgr.GetTranslation("public.prompt");
               _loc1_.type = 1003;
               _loc1_.content = LanguageMgr.GetTranslation("tasktracetip.view.StoreComposeBetterEquipTipView.Content");
               TaskTraceTipManager.instance.showView(_loc1_);
               betterComposeAlertCount = betterComposeAlertCount + 1;
            }
         }
      }
      
      private function inCastle() : Boolean
      {
         return SceneManager.instance.currentType == "CASTLE_SCENE";
      }
      
      private function inSpace() : Boolean
      {
         return SceneManager.instance.currentType == "SPACE_SCENE";
      }
      
      public function addBufferDisapearTip(param1:PlayerBufferInfo) : void
      {
         DelayActionsUtils.instance.addAction(new AlertTipAction(param1,bufferDisapearTip));
      }
      
      private function bufferDisapearTip(param1:PlayerBufferInfo) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc2_.data = param1;
         _loc2_.type = 17;
         showView(_loc2_);
      }
   }
}

