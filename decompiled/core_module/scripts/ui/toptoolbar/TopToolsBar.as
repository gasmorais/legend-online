package ui.toptoolbar
{
   import battle.utils.Int64Utils;
   import com.greensock.TweenLite;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.pet.PetRankRewardMsg;
   import com.road.yishi.proto.player.ChallengeRankRewardMsg;
   import com.road.yishi.proto.remotepet.RemoteItemMsg;
   import com.road.yishi.proto.remotepet.RemotePetOpMsg;
   import events.QuestionnaireEvent;
   import events.VIPEvent;
   import events.WorldBossEvent;
   import feedback.FeedBackEvent;
   import feedback.datas.FeedBackData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import funny.FunnyEvent;
   import funny.FunnyHelper;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import mainBar.view.ForbidConsortiaView;
   import mainBar.view.PlayerBufferItem;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import managers.ChildManager;
   import managers.CustomizedVipManager;
   import managers.DarkMazeManager;
   import managers.ExchargeRankManager;
   import managers.FeedBackManager;
   import managers.FoisonHornManager;
   import managers.FreedomTeamManager;
   import managers.FundManager;
   import managers.FunnyManager;
   import managers.GodDessManager;
   import managers.GoldRoadManager;
   import managers.KingContractManager;
   import managers.LotteryManager;
   import managers.LuckyLotteryManager;
   import managers.MagicSpringManager;
   import managers.MarryManager;
   import managers.MonthCardManager;
   import managers.MvpShopManager;
   import managers.NewFirstPayManager;
   import managers.NewMemoryCardManager;
   import managers.OldBackerManager;
   import managers.PetChallengeManager;
   import managers.RemotePetManager;
   import managers.SevenYearManager;
   import managers.SlotManager;
   import managers.SqMemoryManger;
   import managers.StokesOreManager;
   import managers.VIPManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PetBossModel;
   import map.campaign.event.UnrealShootingEvent;
   import map.space.event.SpaceEvent;
   import mvc.controler.NewYearActController;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.children.ChildSender;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaViewHelper;
   import mvc.module.godsevening.GodsEveningModel;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.lottery.LotteryModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.petchallenge.PetChallengeObjectData;
   import mvc.module.pvp.TransportBufferInfo;
   import mvc.module.vip.VIPModel;
   import ui.toptoolbar.view.ExtraBufferItem;
   import ui.toptoolbar.view.TargetSelectView;
   import ui.toptoolbar.view.TimeActiveBoxOpenTime;
   import ui.toptoolbar.view.TopBtnActiveBoxView;
   import utils.LogicUtils;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.TopToolBtnTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ApexManager;
   import yishi.manager.AppellManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.CultureActiveManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.GoldenSheepManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.LandMineManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.QuestionnaireManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.SumCampaignManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TopToolsBar extends Sprite
   {
      
      private static var _instance:TopToolsBar;
      
      private static const SHOW_NUM1:int = 16;
      
      private static const SHOW_NUM2:int = 10;
      
      private static const REFRESH_SECOND:int = 300000;
      
      private static const WIDTH_SIZE:int = 1200;
      
      private var _btnPointDic:Dictionary = new Dictionary();
      
      private var _isMin:Boolean = false;
      
      private var _i:int = 0;
      
      private var isFirstLogin:Boolean = false;
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _targetView:TargetSelectView;
      
      private var _activeContainer:SimpleTileList;
      
      private var _curActiveBtnDic:Dictionary;
      
      private var _topCondenseBtn:BaseButton;
      
      private var _topExtrudeBtn:BaseButton;
      
      private var _timeTxt1:FilterFrameText;
      
      private var _timeTxt2:FilterFrameText;
      
      private var _bufferContain:SimpleTileList;
      
      private var _bufferMask:Shape;
      
      private var _bufferBack:Scale9CornerImage;
      
      private var _bufferHideBtn:SelectedButton;
      
      private var _itemBufferDic:SimpleDictionary;
      
      private var _itemBufferViewDic:Dictionary;
      
      private var _bloodSprite:Sprite;
      
      private var _bloodItem:BaseIconView;
      
      private var _bloodEnableIcon:Bitmap;
      
      private var _bloodEnable:Boolean = true;
      
      private var _worldProsperityItem:ExtraBufferItem;
      
      private var _numberBg:Bitmap;
      
      private var preBtn:BaseButton;
      
      private var nextBtn:BaseButton;
      
      private var pageHbox:HBox;
      
      private var pageImageList:Vector.<ScaleFrameImage>;
      
      private var allTempCount:int = 0;
      
      private var pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var itemList:Vector.<TopBtnItemView>;
      
      private var btnTimeId:int;
      
      private var curShowNum:int = 16;
      
      private var preShowNum:int;
      
      private var _firstBufferIndex:int = 0;
      
      private var _firstShow:Boolean = true;
      
      private var _buffCount:int;
      
      private var _forbidConsortiaView:ForbidConsortiaView;
      
      private var _extralItem:ExtraBufferItem;
      
      private var _shine:IEffect;
      
      private var _isLoaded:Boolean = false;
      
      private var needShowDataTipsBtnObj:Object = {};
      
      private var _matelordsState:int;
      
      private var _areslordsState:int;
      
      private var _braveLegState:int;
      
      private var _unrealshootingState:int;
      
      private var _darkmazeStatus:int;
      
      private var _apexState:int;
      
      private var _dayLightState:int;
      
      private var _kingbackState:int;
      
      private var _allManExchangeState:int;
      
      private var _godsEveningLightState:int;
      
      public function TopToolsBar()
      {
         super();
      }
      
      public static function get instance() : TopToolsBar
      {
         if(!_instance)
         {
            _instance = new TopToolsBar();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _targetView = ComponentFactory.Instance.creatCustomObject("toptoolbar.TargetSelectView");
         _bufferBack = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.bufferBack");
         _bufferHideBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.bufferHideBtn");
         _bufferContain = ComponentFactory.Instance.creatCustomObject("toptoolbar.Container2",[5]);
         _timeTxt1 = ComponentFactory.Instance.creatComponentByStylename("onlinereward.timeText");
         _timeTxt2 = ComponentFactory.Instance.creatComponentByStylename("onlinereward.timeText");
         _topCondenseBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.condenseBtn");
         _topExtrudeBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.extrudeBtn");
         preBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.preBtn");
         nextBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.nextBtn");
         pageHbox = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.pageHbox");
         _bloodSprite = new Sprite();
         _bloodItem = ComponentFactory.Instance.creatCustomObject("resourcesBar.BaseItemView");
         _bloodEnableIcon = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.ForbidIcon");
         _bloodItem.tipStyle = "yishi.view.tips.OneLineTip";
         _bloodSprite.graphics.beginFill(0,0);
         _bloodSprite.graphics.drawRect(0,0,36,37);
         _bloodSprite.graphics.endFill();
         _bloodSprite.addChild(_bloodItem);
         addChild(_topCondenseBtn);
         addChild(_topExtrudeBtn);
         _topExtrudeBtn.visible = false;
         addChild(_bufferBack);
         _bufferBack.addChild(_bufferHideBtn);
         _bufferBack.alpha = 0;
         addChild(_bufferContain);
         addChild(preBtn);
         addChild(nextBtn);
         addChild(pageHbox);
         allTempCount = TopBtnCheckShowHelper.instance.allTempCount;
         resetBtnListView();
         setBuffMask();
         __onVocationGradesChangeHandler(null);
      }
      
      private function resetBtnListView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:TopBtnItemView = null;
         var _loc5_:int = 0;
         var _loc3_:ScaleFrameImage = null;
         curShowNum = StageReferance.stageWidth > 1200 ? 16 : 10;
         preShowNum = curShowNum;
         LogicUtils.disposeDisplayCollection(_curActiveBtnDic);
         LogicUtils.disposeDisplayCollection(itemList);
         LogicUtils.disposeDisplayCollection(pageImageList);
         ObjectUtils.disposeObject(_activeContainer);
         _activeContainer = null;
         var _loc6_:int = curShowNum / 2;
         _activeContainer = ComponentFactory.Instance.creatCustomObject("toptoolbar.Container1",[_loc6_]);
         _activeContainer.align = "align_right";
         addChild(_activeContainer);
         itemList = new Vector.<TopBtnItemView>();
         _curActiveBtnDic = new Dictionary();
         _loc2_ = 0;
         while(_loc2_ < curShowNum)
         {
            _loc4_ = new TopBtnItemView();
            _activeContainer.addChild(_loc4_);
            itemList.push(_loc4_);
            _loc2_++;
         }
         pageImageList = new Vector.<ScaleFrameImage>();
         var _loc1_:int = Math.ceil(allTempCount / curShowNum);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.pageImage");
            pageImageList.push(_loc3_);
            _loc5_++;
         }
      }
      
      private function initData() : void
      {
         _itemBufferDic = new SimpleDictionary(true);
         _itemBufferViewDic = new Dictionary(true);
         if(thane.grades >= 22)
         {
            sendMatch();
         }
         if(CultureActiveManager.instance.openCultureActive)
         {
            CultureActiveManager.instance.OperateCultureReq(1,0,1);
         }
         if(FeedBackManager.instance.needShine && _curActiveBtnDic["feedback"])
         {
            _curActiveBtnDic["feedback"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         RemotePetManager.instance.model.addEventListener("COMMIT",show);
         PlayerBufferManager.instance.addEventListener("ITEM_BUFFER_UPDATE",show);
         PlayerBufferManager.instance.addEventListener("CAMPAIGN_BUFFER_UPDATE",show);
         playerInfo.addEventListener("IS_AUTO_CHANGE",show);
         playerInfo.addEventListener("CONSORTIA_CHANGE",show);
         playerInfo.addEventListener("CONSORTIA_STUDY",show);
         playerInfo.addEventListener("CONSORTIA_STUDY_UPGRADE",show);
         playerInfo.addEventListener("SEMINARY_EFFECT",show);
         playerInfo.addEventListener("VOCATION_INDEX",show);
         playerInfo.addEventListener("WORLDPROSPERITY",show);
         thane.addEventListener("BLOOD_VISIBLE_UPDATE",show);
         thane.addEventListener("FIGHTINGCAPACITY_CHANGE",show);
         playerInfo.addEventListener("GVGISOPEN",show);
         playerInfo.addEventListener("MINERAL",show);
         NotificationManager.instance.addEventListener("UPDATE_EXTRABUFFER",show);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",show);
         playerInfo.addEventListener("CROSS_SCORE_RAWARD",show);
         playerInfo.addEventListener("VEHICLESTART",show);
         NotificationManager.instance.addEventListener("SEMINARY_BLESS",show);
         NotificationManager.instance.addEventListener("KING_CONTRACT",show);
         NotificationManager.instance.addEventListener("TRANSPORT_STATE",show);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",show);
         FundManager.instance.addEventListener("SHOWTOPBTN",show);
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",show);
         NotificationManager.instance.addEventListener("FUND_VEIN_INFO_REFRESH",show);
         NotificationManager.instance.addEventListener("ANSWER_SWITCH",show);
         LotteryManager.Instance.addEventListener("LOTTERY_STATE",show);
         NotificationManager.instance.addEventListener("NEWYEARLOGINREFRESH",show);
         NotificationManager.instance.addEventListener("GODDESS_EQUIMENT_DOUBLE",show);
         FrameControllerManager.instance.svsController.model.addEventListener("SVS_INFO_CHANGE",show);
         thane.addEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpdateHandler);
         thane.addEventListener("BLOOD_UPDATE",__updateBloodHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshAllBtnHandler);
         playerInfo.addEventListener("FIRSTCHARGE",__firstChargeHandler);
         playerInfo.addEventListener("WORLDBOSSSTATE",__worldbossStateHandler);
         playerInfo.addEventListener("ISPVPSTART",__pvpStateHandlet);
         NotificationManager.instance.addEventListener("UPDATE_WARFIGHT_STATE_LIST",__warFightStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4243,__challengeTakeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4967,__remotePetHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4482,__pvpTakeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4613,__petRankRewardHandler);
         FeedBackManager.instance.addEventListener("FEEDBACK_RECEIVE_USERINFO",__feedBackHandler);
         QuestionnaireManager.instance.model.addEventListener("QUESTIONNAIRE_CHANGE",__questionnaireChange);
         FunnyManager.instance.addEventListener("ITEM_CANGET",__playFunnyBtnHandler);
         FunnyManager.instance.addEventListener("SHOWTIROEFFECT",__showTiroEffectHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeSecondHandler);
         _topCondenseBtn.addEventListener("click",__condenseHandler);
         _topExtrudeBtn.addEventListener("click",__extrudeHandler);
         ExchargeRankManager.instance.addEventListener("EXCHARGE_RANK",__showExchargeHandler);
         if(thane.grades < 22)
         {
            NotificationManager.instance.addEventListener("HERO_LEVELUP_CLOSE",__onLevelHandler);
         }
         playerModel.addEventListener("TARGET_CHANGE",__spaceTargetChangeHandler);
         _bufferHideBtn.addEventListener("select",__hideBufferHandler);
         _bufferBack.addEventListener("rollOver",__bufferBackOverHandler);
         _bufferBack.addEventListener("rollOut",__bufferBackOutHandler);
         playerInfo.addEventListener("VOCATION_GRADES",__onVocationGradesChangeHandler);
         playerInfo.addEventListener("DRAGON_SOUL_TRANSFER",__onVocationGradesChangeHandler);
         consortiaModel.addEventListener("CROSSGUILDOPEN",show);
         NotificationManager.instance.addEventListener("REFRESH_NEWYEAR_BTN",show);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         NotificationManager.instance.addEventListener("SHOWTIMEBUYEFF",showTimeBuyEff);
         NotificationManager.instance.addEventListener("REGRESS_SHINE",showRegressShine);
         if(!playerModel.isOpenAppellAddition)
         {
            playerModel.addEventListener("OPEN_ADDITION",show);
         }
         MsgMan.addObserver("yishi.datas.consant.GET_QUESTION_IS_OPNE_EVENT",this,getIsOpenHandler);
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",this,getIsOpenHandler);
         NotificationManager.instance.addEventListener("RECHARGE_EFF",showRechargeBtnEff);
         FunnyManager.instance.addEventListener("REFRESH_REGRESS_REWARD",show);
         MsgMan.addObserver("ChildEvent.APPLY_INFO",this,__childApplyInfo);
         SlotManager.Instance.model.addEventListener("SLOTSATECHANGE",show);
         MagicCardManager.Instance.addEventListener("MAGICCARD_CAMPAIGN_BUFF",show);
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",onBtnTipsUpdate);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_SWITCH",show);
         NotificationManager.instance.addEventListener("MailCheckEvent.STATE_UPDATE",show);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",show);
         NotificationManager.instance.addEventListener("UPDATE_AAS_CONFIG",show);
         NotificationManager.instance.addEventListener("BALL_EFFECT",__ballEffectHandler);
         FunnyManager.instance.addEventListener("CROSS_PAY_CANGET",__playCrossPayBtnHandler);
         MsgMan.addObserver("RAVE_PARTY_OPENSTATE_UPDTAE",this,__updateRavePartyOpenStateHandler);
         MsgMan.addObserver("ENCO_GOLD_OPENSTATE_UPDTAE",this,__updateEncoGoldOpenStateHandler);
         NotificationManager.instance.addEventListener("LUCKY_TEMP_CHANGE",show);
         FunnyManager.instance.addEventListener("CROSS_COSTITEM_CANGET",show);
         FunnyManager.instance.addEventListener("CROSS_COST_TEMP",show);
         preBtn.addEventListener("click",__preClickHandler);
         nextBtn.addEventListener("click",__nextClickHandler);
         MsgMan.addObserver("TOPTOOLBAR_BUTTON_CLICK",this,__onTopBtnClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_UPDATE_STATE",this,__updateChildArenaStateHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_REWARD",this,__updateChildArenaRewardHandler);
         NotificationManager.instance.addEventListener("REFRESH_OLDBACKER_SHOW",show);
         FrameControllerManager.instance.unrealShootingController.model.addEventListener("UNREAL_SHOOTING_ACTIVE_STATE_CHANGE",__showUnrealShootingHandler);
         playerInfo.addEventListener("PLAYER_OLDBACKER_BUFF_CHANGE",show);
         GodsEveningManager.instance.addEventListener("BUFF_LORD_KILLDE",show);
         GodsEveningManager.instance.addEventListener("IS_SHOWICON",show);
         GoldenSheepManager.instance.model.addEventListener("STATE_UPDATE",show);
         NotificationManager.instance.addEventListener("WHOLE_REBATE_SHOW",show);
         MsgMan.addObserver("INFO_CHANGE_BACK",this,__onMagicSpringBufferHandler);
         MsgMan.addObserver("MAKE_SUCCESS_BACK",this,__onMagicSpringBufferHandler);
         MsgMan.addObserver("MONTH_INFO_CHANGE",this,__monthCardInfoChangeHandler);
         MsgMan.addObserver("FOISONHORN_INFO_CHANGE",this,__foisonHornInfoChangeHandler);
         MsgMan.addObserver("LAND_MINE_INFO_CHANGE",this,__landMineInfoChangeHandler);
         MsgMan.addObserver("MVPSHOP_INFO_CHANGE",this,__mvpShopInfoChangeHandler);
         MsgMan.addObserver("MVPSHOP_POINT_CHANGE",this,__mvpShopPointChangeHanlder);
         MsgMan.addObserver("CROSS_GUILD_MAIN_CHANGE",this,__crossguildStateChangeHandler);
         StokesOreManager.instance.model.addEventListener("UPDATE_STATUS",show);
         MsgMan.addObserver("CUSTOMIZED_INFO_CHANGE",this,__updateCustomizedVipHanlder);
         vipModel.addEventListener("upframeview_change",__updateCustomizedVipTips);
         MsgMan.addObserver("NEW_MEMORYCARD_UPDATE",this,__updateMemoryCardHandler);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",onBtnTipsUpdate);
         ChristmasManager.instance.addEventListener("ANSWER_UPDATE",onBtnTipsUpdate);
         ChristmasManager.instance.addEventListener("christmas.TASK_UPDATE",onBtnTipsUpdate);
         MsgMan.addObserver("SKYTREASURE1",this,__updateCustomizedVipHanlder);
      }
      
      private function __updateMemoryCardHandler(param1:String, param2:Object) : void
      {
         onBtnTipsUpdate();
      }
      
      public function __updateCustomizedVipTips(param1:VIPEvent) : void
      {
         CustomizedVipManager.instance.model.resetFlicker();
         show();
      }
      
      private function __preClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshCurActiveBtn(false);
      }
      
      private function __nextClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshCurActiveBtn(false);
      }
      
      private function __crossguildStateChangeHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __childApplyInfo(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function getIsOpenHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __updateCustomizedVipHanlder(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CampaignMapModel = null;
         _posY = 0;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = CampaignManager.instance.mapModel;
            if(_loc2_)
            {
               if(WorldBossHelper.checkFlameTemple(_loc2_.mapId))
               {
                  _posY = 60;
               }
               else if(WorldBossHelper.checkSvs(_loc2_.mapId))
               {
                  _posY = 60;
               }
            }
         }
      }
      
      private function __onVocationGradesChangeHandler(param1:PlayerEvent) : void
      {
         show();
      }
      
      private function __bufferBackOverHandler(param1:MouseEvent) : void
      {
         _bufferBack.alpha = 1;
      }
      
      private function __bufferBackOutHandler(param1:MouseEvent) : void
      {
         _bufferBack.alpha = 0;
      }
      
      public function extrudeActivity() : void
      {
         if(!_isMin)
         {
            __extrudeHandler(null);
         }
      }
      
      private function __crossGuildOpenStateHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __updateRavePartyOpenStateHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __updateEncoGoldOpenStateHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __extrudeHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(_curActiveBtnDic["funny"])
         {
            _loc2_ = _btnPointDic["funny"];
            TweenLite.to(_curActiveBtnDic["funny"],0.5,{
               "x":_loc2_.x,
               "y":_loc2_.y
            });
         }
         for(var _loc3_:String in _curActiveBtnDic)
         {
            toMax(_curActiveBtnDic[_loc3_],_loc3_);
         }
         _isMin = false;
         _topCondenseBtn.visible = true;
         _topExtrudeBtn.visible = false;
         preBtn.visible = true;
         nextBtn.visible = true;
         pageHbox.visible = true;
         TweenLite.to(_topCondenseBtn,0.5,{"alpha":1});
         TweenLite.to(_topExtrudeBtn,0.5,{"alpha":0});
      }
      
      private function __condenseHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_curActiveBtnDic["funny"])
         {
            if(!_isMin)
            {
               _loc2_ = _posX - _loc3_ * 75;
               TweenLite.to(_curActiveBtnDic["funny"],0.5,{
                  "x":_loc2_,
                  "y":0
               });
               _loc3_++;
            }
         }
         _i = _loc3_;
         for(var _loc4_:String in _curActiveBtnDic)
         {
            if(_loc4_ != "funny")
            {
               toMin(_curActiveBtnDic[_loc4_]);
            }
         }
         _isMin = true;
         _topCondenseBtn.visible = false;
         _topExtrudeBtn.visible = true;
         preBtn.visible = false;
         nextBtn.visible = false;
         pageHbox.visible = false;
         TweenLite.to(_topCondenseBtn,0.5,{"alpha":0});
         TweenLite.to(_topExtrudeBtn,0.5,{"alpha":1});
         _topExtrudeBtn.x = _activeContainer.x + _activeContainer.width - 67;
         _topExtrudeBtn.y = 80;
      }
      
      private function __hideBufferHandler(param1:Event) : void
      {
         setBuffMask();
      }
      
      private function setBuffMask() : void
      {
         if(!_bufferMask)
         {
            _bufferMask = new Shape();
            _bufferMask.y = 8;
            addChild(_bufferMask);
            _bufferContain.mask = _bufferMask;
         }
         _bufferMask.graphics.clear();
         _bufferMask.graphics.beginFill(0);
         if(_bufferHideBtn.selected)
         {
            _bufferMask.graphics.drawRect(0,0,184,_bufferContain.height - 3);
         }
         else
         {
            _bufferMask.graphics.drawRect(0,0,184,47);
         }
         _bufferMask.graphics.endFill();
         _bufferBack.height = _bufferMask.height + 10;
      }
      
      private function __spaceTargetChangeHandler(param1:SpaceEvent) : void
      {
         var _loc2_:BaseArmy = param1.data as BaseArmy;
         if(_loc2_)
         {
            _targetView.data = _loc2_;
            addChild(_targetView);
         }
         else if(_targetView && _targetView.parent)
         {
            _targetView.parent.removeChild(_targetView);
         }
      }
      
      private function __reward360Handler(param1:NotificationEvent) : void
      {
         show();
      }
      
      private function __refreshAllBtnHandler(param1:NotificationEvent) : void
      {
         show();
      }
      
      private function __timeSecondHandler(param1:PlayerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         if(FunnyManager.instance.model.onLineCurrentData == null)
         {
            _timeTxt1.text = LanguageMgr.GetTranslation("tasktracetip.view.HookTipView.text2");
            _timeTxt1.setFrame(2);
            if(_curActiveBtnDic["online"])
            {
               _curActiveBtnDic["online"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
            }
         }
         else
         {
            _loc4_ = FunnyManager.instance.model.onLineCurrentData.remainTime;
            if(_loc4_ <= 0)
            {
               _timeTxt1.text = LanguageMgr.GetTranslation("tasktracetip.view.HookTipView.text1");
               _timeTxt1.setFrame(2);
               if(_curActiveBtnDic["online"])
               {
                  _curActiveBtnDic["online"].movieBtn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(_curActiveBtnDic["online"])
            {
               if(_curActiveBtnDic["online"])
               {
                  _curActiveBtnDic["online"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               _timeTxt1.setFrame(1);
               _timeTxt1.text = DateFormatter.getCountDate(_loc4_);
               FunnyManager.instance.model.onLineCurrentData.remainTime -= 1;
            }
            else
            {
               FunnyManager.instance.model.onLineCurrentData.remainTime -= 1;
            }
         }
         if(_timeTxt1.parent)
         {
            _timeTxt1.parent.removeChild(_timeTxt1);
         }
         if(_curActiveBtnDic["online"])
         {
            if(!_timeTxt1.parent)
            {
               _curActiveBtnDic["online"].movieBtn.addChild(_timeTxt1);
            }
         }
         else if(_timeTxt1.parent)
         {
            _timeTxt1.text = "";
         }
         var _loc5_:FunnyData = FunnyManager.instance.model.findDataByType(50);
         var _loc2_:FunnyBagData = FunnyManager.instance.model.timingBagData;
         if(_loc2_)
         {
            if(_loc2_.status == 1)
            {
               _timeTxt2.text = LanguageMgr.GetTranslation("tasktracetip.view.VipGiftGetTipView.BtnTxt");
               if(_curActiveBtnDic["timing"])
               {
                  _curActiveBtnDic["timing"].movieBtn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else
            {
               _timeTxt2.text = FunnyManager.instance.model.timingStr;
               if(_curActiveBtnDic["timing"])
               {
                  _curActiveBtnDic["timing"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               _loc3_ = _loc5_.bagList.indexOf(_loc2_);
               if(_loc3_ <= 0)
               {
                  _loc3_ = _loc5_.startTime;
               }
               else
               {
                  _loc3_ = _loc5_.startTime + _loc5_.bagList[_loc3_ - 1].conditionList[0].value * 60000;
               }
               if(_loc3_ < playerModel.nowDate - 120000)
               {
                  FunnyManager.instance.sendGetBag(1);
               }
            }
            if(_timeTxt2.parent)
            {
               _timeTxt2.parent.removeChild(_timeTxt2);
            }
            if(_curActiveBtnDic["timing"])
            {
               if(!_timeTxt2.parent)
               {
                  _curActiveBtnDic["timing"].movieBtn.addChild(_timeTxt2);
               }
            }
            else if(_timeTxt2.parent)
            {
               _timeTxt2.text = "";
            }
         }
         checkSevenYear();
         setDarkMazeTips();
      }
      
      private function setDarkMazeTips() : void
      {
         var _loc1_:String = null;
         var _loc2_:Date = null;
         var _loc3_:Date = null;
         var _loc4_:Object = null;
         if(_curActiveBtnDic["darkmaze"])
         {
            _loc1_ = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + DarkMazeManager.instance.model.startGameStr + "-" + DarkMazeManager.instance.model.endGameStr;
            _loc2_ = DarkMazeManager.instance.model.findNearResetTime();
            _loc3_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            if(_loc2_)
            {
               _loc4_ = DateFormatter.compareDate4(_loc3_,_loc2_);
               if(_loc4_.hour > 0)
               {
                  _loc1_ = _loc1_ + "\n" + LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.darkmaze1",_loc4_.hour);
               }
               else
               {
                  _loc1_ = _loc1_ + "\n" + LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.darkmaze2",_loc4_.min);
               }
            }
            _curActiveBtnDic["darkmaze"].movieBtn.tipData = _loc1_;
         }
      }
      
      private function checkSevenYear() : void
      {
      }
      
      private function __ballEffectHandler(param1:NotificationEvent) : void
      {
         if(_curActiveBtnDic["bingo"])
         {
            _curActiveBtnDic["bingo"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __showUnrealShootingHandler(param1:UnrealShootingEvent) : void
      {
         if(!VersionSwitch.UNREALSHOOTING)
         {
            return;
         }
         if(FrameControllerManager.instance.unrealShootingController.model.showUnrealShootingBtn)
         {
            if(_curActiveBtnDic["unrealshooting"])
            {
               _curActiveBtnDic["unrealshooting"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
         else if(_curActiveBtnDic["unrealshooting"])
         {
            _curActiveBtnDic["unrealshooting"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         }
      }
      
      private function __updateChildArenaRewardHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __updateChildArenaStateHandler(param1:String, param2:Object) : void
      {
         if(ChildManager.instance.arenaModel.curstate == 4)
         {
            if(_curActiveBtnDic["childArena"])
            {
               _curActiveBtnDic["childArena"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
         else if(_curActiveBtnDic["childArena"])
         {
            _curActiveBtnDic["childArena"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         }
      }
      
      private function __playFunnyBtnHandler(param1:FunnyEvent) : void
      {
         if(_curActiveBtnDic["funny"])
         {
            _curActiveBtnDic["funny"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __playCrossPayBtnHandler(param1:FunnyEvent) : void
      {
         if(_curActiveBtnDic["exchargeall"] && !FrameControllerManager.instance.exchargeAllControler.isOpenCrossPayFrame)
         {
            _curActiveBtnDic["exchargeall"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __showTiroEffectHandler(param1:FunnyEvent) : void
      {
         if(_curActiveBtnDic["tiro"] && !FunnyManager.isOpenTiroFunnyFrame)
         {
            _curActiveBtnDic["tiro"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function showTimeBuyEff(param1:NotificationEvent) : void
      {
         if(_curActiveBtnDic["limitbuy"])
         {
            _curActiveBtnDic["limitbuy"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function showRegressShine(param1:NotificationEvent) : void
      {
         if(_curActiveBtnDic["regress"])
         {
            _curActiveBtnDic["regress"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __updateBloodHandler(param1:PlayerEvent) : void
      {
         setBloodTip();
      }
      
      private function __showExchargeHandler(param1:FunnyEvent) : void
      {
         show();
      }
      
      private function __onMagicSpringBufferHandler(param1:String, param2:Object) : void
      {
         show();
      }
      
      private function __monthCardInfoChangeHandler(param1:String, param2:Object) : void
      {
         show();
         if(_curActiveBtnDic["monthcard"])
         {
            if(MonthCardManager.instance.model.openChange || MonthCardManager.instance.model.hasReward)
            {
               _curActiveBtnDic["monthcard"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
      }
      
      private function __foisonHornInfoChangeHandler(param1:String, param2:Object) : void
      {
         show();
         if(_curActiveBtnDic["foisonhorn"])
         {
            if(FoisonHornManager.instance.model.openChange)
            {
               _curActiveBtnDic["foisonhorn"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
      }
      
      private function __mvpShopInfoChangeHandler(param1:String, param2:Object) : void
      {
         show();
         if(_curActiveBtnDic["mvpshop"])
         {
            if(MvpShopManager.instance.model.openChange)
            {
               _curActiveBtnDic["mvpshop"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
      }
      
      private function __mvpShopPointChangeHanlder(param1:String, param2:Object) : void
      {
         if(_curActiveBtnDic["mvpshop"])
         {
            _curActiveBtnDic["mvpshop"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __landMineInfoChangeHandler(param1:String, param2:Object) : void
      {
         show();
         if(_curActiveBtnDic["landmine"])
         {
            if(LandMineManager.instance.model.hasRewardCount)
            {
               _curActiveBtnDic["landmine"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
            else
            {
               _curActiveBtnDic["landmine"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
            }
         }
      }
      
      private function __onTopBtnClickHandler(param1:String, param2:Object) : void
      {
         var _loc3_:String = null;
         var _loc9_:PackageOut = null;
         var _loc7_:RemotePetOpMsg = null;
         var _loc4_:ChallengeRankRewardMsg = null;
         var _loc5_:PetBossModel = null;
         var _loc8_:FunnyData = null;
         var _loc6_:TopToolBtnTempInfo;
         switch((_loc6_ = param2 as TopToolBtnTempInfo).BtnKey)
         {
            case "renotereward":
               _loc9_ = new PackageOut(9544);
               _loc7_ = new RemotePetOpMsg();
               _loc7_.op = 11;
               SocketManager.instance.socket.sendProtobuffer(_loc9_,_loc7_);
               break;
            case "exchargeall":
               FrameControllerManager.instance.openControllerByInfo("exchargeall");
               break;
            case "first":
               FrameControllerManager.instance.openControllerByInfo("firstpay");
               break;
            case "recharge":
               if(thane.grades < 11)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
                  MessageTipManager.instance().show(_loc3_);
                  show();
               }
               else if(FunnyManager.instance.model.rechargeBagData == null)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click01");
                  MessageTipManager.instance().show(_loc3_);
                  show();
               }
               else if(!FunnyManager.instance.model.findDataByType(15))
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04");
                  MessageTipManager.instance().show(_loc3_);
                  show();
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("rechargetime");
               }
               break;
            case "matelords":
               FrameControllerManager.instance.openControllerByInfo("matelords");
               break;
            case "question":
               FrameControllerManager.instance.openControllerByInfo("questionnaire");
               break;
            case "feedback":
               if(thane.grades >= 6 && FeedBackManager.instance.allReceived && feedBackData.endTime > playerModel.sysCurTimeBySecond)
               {
                  FrameControllerManager.instance.openControllerByInfo("feedback");
               }
               break;
            case "skytreasure1":
               FrameControllerManager.instance.openControllerByInfo("skytreasure1");
               break;
            case "online":
               if(thane.grades < 11)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               if(FunnyManager.instance.model.onLineCurrentData == null)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.onlineBtn.AllGet");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("onlinereward",14);
               break;
            case "timing":
               if(thane.grades < 11)
               {
                  _loc3_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command03");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               if(FunnyManager.instance.model.timingBagData == null)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.onlineBtn.AllGet");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("onlinereward",50);
               break;
            case "karneval":
               if(FunnyManager.instance.model.findDataByType(51))
               {
                  FrameControllerManager.instance.openControllerByInfo("onlinereward",51);
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
                  MessageTipManager.instance().show(_loc3_);
                  show();
               }
               break;
            case "funny":
               if(thane.grades < 6)
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
                  MessageTipManager.instance().show(_loc3_);
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("funny");
               }
               break;
            case "tiro":
               FunnyManager.instance.sendGetBag(1);
               FrameControllerManager.instance.openControllerByInfo("funny",2);
               break;
            case "crosspvpreward":
               _loc9_ = new PackageOut(8590);
               _loc4_ = new ChallengeRankRewardMsg();
               SocketManager.instance.socket.sendProtobuffer(_loc9_,_loc4_);
               break;
            case "bottle":
               BottleManager.instance.sendOpenInfo(4,0);
               break;
            case "petweedreward":
               if(LoaderManagerII.instance.hasPrority(10))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.resourceLoading"));
               }
               else
               {
                  PetChallengeManager.instance.sendPetRankOperate(2);
               }
               break;
            case "fund":
               FundManager.instance.fundOperate();
               FundManager.instance.isUseOpen = true;
               FundManager.instance.isNewbie = false;
               break;
            case "fundnewbie":
               FrameControllerManager.instance.openControllerByInfo("fundnewbie");
               break;
            case "regression1":
               _loc9_ = new PackageOut(8634);
               SocketManager.instance.socket.sendProtobuffer(_loc9_,null);
               FunnyManager.instance.backPlayerBtnEnable = false;
               show();
               break;
            case "regression2":
               FunnyManager.instance.sendReturnOption(2);
               break;
            case "lottery":
               if(lotteryModel.info.isOpen)
               {
                  FrameControllerManager.instance.openControllerByInfo("lottery");
               }
               break;
            case "newyear":
               FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.CONTINOUSLOGIN);
               break;
            case "newyearlottery":
               FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.LOTTERY);
               break;
            case "crossgvg":
               ConsortiaViewHelper.instance.openCrossGuildHandler();
               break;
            case "petboss":
               _loc5_ = CampaignManager.instance.petBossModel;
               if(thane.grades >= 50)
               {
                  FrameControllerManager.instance.openControllerByInfo("petboss");
               }
               break;
            case "limitbuy":
               FrameControllerManager.instance.openControllerByInfo("timebuy");
               break;
            case "crosscost":
               FrameControllerManager.instance.openControllerByInfo("crosscost");
               break;
            case "answer":
               if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
               {
                  _loc3_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.answerBtn.errinfo");
                  MessageTipManager.instance().show(_loc3_);
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("answer");
               }
               break;
            case "goldroad":
               if(FreedomTeamManager.instance.hasTeam)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldroad.goldRoadFrame.teamNotice"));
                  return;
               }
               GoldRoadManager.instance.model.goldRoadRefuseInvitation = SharedManager.instance.refuseInvitation;
               GoldRoadManager.instance.model.goldRoadRefuseInvite = playerModel.playerInfo.refuseInvite;
               GoldRoadManager.instance.model.goldRoadRefuseTeamInvite = playerModel.playerInfo.refuseTeamInvite;
               if(!GoldRoadManager.instance.model.goldRoadRefuseInvite)
               {
                  SocketSendManager.instance.sendRefuseInvite();
               }
               if(!GoldRoadManager.instance.model.goldRoadRefuseInvitation)
               {
                  SharedManager.instance.refuseInvitation = !GoldRoadManager.instance.model.goldRoadRefuseInvitation;
                  SharedManager.instance.save();
               }
               if(!GoldRoadManager.instance.model.goldRoadRefuseTeamInvite)
               {
                  SocketSendManager.instance.sendRefuseTeamInvite();
               }
               FrameControllerManager.instance.openControllerByInfo("goldroad");
               break;
            case "loginactive":
               FrameControllerManager.instance.openControllerByInfo("loginactive");
               break;
            case "slot":
               if(FreedomTeamManager.instance.hasTeam)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.teamNotice"));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("slot");
               SlotManager.Instance.model.slotRefuseInvitation = SharedManager.instance.refuseInvitation;
               SlotManager.Instance.model.slotRefuseInvite = playerModel.playerInfo.refuseInvite;
               SlotManager.Instance.model.slotRefuseTeamInvite = playerModel.playerInfo.refuseTeamInvite;
               if(!SlotManager.Instance.model.slotRefuseInvite)
               {
                  SocketSendManager.instance.sendRefuseInvite();
               }
               if(!SlotManager.Instance.model.slotRefuseInvitation)
               {
                  SharedManager.instance.refuseInvitation = !SlotManager.Instance.model.slotRefuseInvitation;
                  SharedManager.instance.save();
               }
               if(!SlotManager.Instance.model.slotRefuseTeamInvite)
               {
                  SocketSendManager.instance.sendRefuseTeamInvite();
               }
               break;
            case "hallfame":
               _loc8_ = FunnyManager.instance.model.findDataByType(146);
               if(_loc8_)
               {
                  FrameControllerManager.instance.openControllerByInfo("hallfame");
               }
               show();
               break;
            case "auctionsale":
               FrameControllerManager.instance.openControllerByInfo("sale");
               break;
            case "mailcheck":
               FrameControllerManager.instance.openControllerByInfo("mailcheck",1);
               break;
            case "blackjack":
               FrameControllerManager.instance.openControllerByInfo("blackjack",1);
               break;
            case "artifact":
               FrameControllerManager.instance.openControllerByInfo("artifact");
               break;
            case "regress":
               if(OldBackerManager.instance.model.backerType == 1)
               {
                  FrameControllerManager.instance.openControllerByInfo("oldbacker",1);
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("oldbacker",2);
               }
               break;
            case "bingo":
               FrameControllerManager.instance.openControllerByInfo("bingo");
               break;
            case "outyard":
               enterOutyardScene();
               break;
            case "luckyexchange":
               FrameControllerManager.instance.openControllerByInfo("luckyexchange");
               break;
            case "outyardreward":
               if(OutyardManager.instance.model.reward.length)
               {
                  OutyardManager.instance.OperateMapOutyard(7);
               }
               break;
            case "publicchairs":
               FrameControllerManager.instance.openControllerByInfo("publicchairs");
               break;
            case "cultureactive":
               FrameControllerManager.instance.openControllerByInfo("cultureactive");
               break;
            case "goldendionysia":
               FrameControllerManager.instance.openControllerByInfo("goldendionysia",1);
               break;
            case "publicegg_total":
               FrameControllerManager.instance.openControllerByInfo("publicegg");
               break;
            case "publicegg_egg":
               FrameControllerManager.instance.openControllerByInfo("publicegg",1);
               break;
            case "publicegg_sumgift":
               FrameControllerManager.instance.openControllerByInfo("publicegg",2);
               break;
            case "pandora":
               FrameControllerManager.instance.openControllerByInfo("pandora");
               break;
            case "chargelottery":
               FrameControllerManager.instance.openControllerByInfo("chargelottery");
               break;
            case "sumcampaign":
               SumCampaignManager.instance.OperateSunEnter();
               break;
            case "registwelfare":
               FrameControllerManager.instance.openControllerByInfo("registwelfare");
               break;
            case "continuepayrrbate":
               FrameControllerManager.instance.openControllerByInfo("continuepayrebate");
               break;
            case "wedding":
               FrameControllerManager.instance.openControllerByInfo("marry","QUALITY_SELECT");
               break;
            case "areslords":
               AresLordsManager.instance.requestViewInfo();
               break;
            case "braveleg":
               BraveLegManager.instance.requestViewInfo();
               break;
            case "discountshop":
               FrameControllerManager.instance.openControllerByInfo("discountshop");
               break;
            case "daylight":
               SwitchPageHelp.gotoDayLight();
               break;
            case "raveparty":
               FrameControllerManager.instance.openControllerByInfo("raveparty");
               break;
            case "encoGold":
               FrameControllerManager.instance.openControllerByInfo("encogold");
               break;
            case "pvp":
               if(!checkIsOpen(0))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("pvproomlist");
               break;
            case "rvr1":
               FrameControllerManager.instance.openControllerByInfo("worldboss",3);
               break;
            case "worldboss":
               if(!checkIsOpen(2))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("worldboss",1);
               break;
            case "vehicel":
               if(!checkIsOpen(3))
               {
                  return;
               }
               if(SwitchPageHelp.checkScene())
               {
                  FrameControllerManager.instance.openControllerByInfo("vehicleroomlist");
               }
               break;
            case "crossmuticampaign":
               if(!checkIsOpen(4))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("pveroomlist");
               break;
            case "childArena":
               SwitchPageHelp.gotoChildArenaFrame();
               break;
            case "poker":
               if(!checkIsRightScene())
               {
                  return;
               }
               if(!checkIsOpen(6))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("poker");
               break;
            case "giftwill":
               if(thane.grades < 32)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",32));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("magicpub",0,3);
               break;
            case "childarenareward":
               if(!ChildManager.instance.arenaModel.hasReward)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("childarena.getReward.noRewardlert"));
                  return;
               }
               ChildSender.requestChildArenaOp(4);
               break;
            case "unrealshooting":
               FrameControllerManager.instance.openControllerByInfo("unrealshooting");
               break;
            case "pumpingjoy":
               SwitchPageHelp.openPumpingJoyFrame();
               break;
            case "godsevening":
               FrameControllerManager.instance.openControllerByInfo("godsevening");
               break;
            case "wholerebate":
               FrameControllerManager.instance.openControllerByInfo("wholerebate");
               break;
            case "magicspring":
               FrameControllerManager.instance.openControllerByInfo("magicspring");
               break;
            case "monthcard":
               FrameControllerManager.instance.openControllerByInfo("monthcard");
               break;
            case "foisonhorn":
               FrameControllerManager.instance.openControllerByInfo("foisonhorn");
               break;
            case "landmine":
               FrameControllerManager.instance.openControllerByInfo("landmine",2);
               break;
            case "mvpshop":
               FrameControllerManager.instance.openControllerByInfo("mvpshop");
               break;
            case "apex":
               ApexManager.instance.sendOpenMainView();
               break;
            case "allmanexchange":
               FrameControllerManager.instance.openControllerByInfo("allmanexchange");
               break;
            case "luckylottery":
               if(checkLuckyLotteryIsEnd())
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04"));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("luckylottery");
               break;
            case "dreamarena":
               FrameControllerManager.instance.openControllerByInfo("dreamarena");
               break;
            case "stokesore":
               FrameControllerManager.instance.openControllerByInfo("stokesore");
               break;
            case "gamehall":
               FrameControllerManager.instance.openControllerByInfo("gamehall");
               break;
            case "wishpool":
               FrameControllerManager.instance.openControllerByInfo("wishpool");
               break;
            case "supersignincard":
               FrameControllerManager.instance.openControllerByInfo("supersignincard");
               break;
            case "kingback":
               FrameControllerManager.instance.openControllerByInfo("kingback");
               break;
            case "sevenyear":
               FrameControllerManager.instance.openControllerByInfo("yearactive","Enter");
               break;
            case "platinum":
               FrameControllerManager.instance.openControllerByInfo("platinum");
               break;
            case "customizedvip":
               FrameControllerManager.instance.openControllerByInfo("customizedvip");
               break;
            case "darkmaze":
               if(DarkMazeManager.instance.model.checkDarkMaze())
               {
                  SwitchPageHelp.openDarkMaze();
               }
               break;
            case "timebox1":
               creatTopActiveBox(_loc6_.BtnKey);
               break;
            case "newfirstpay":
               FrameControllerManager.instance.openControllerByInfo("newfirstpay");
               break;
            case "newquestion":
               FrameControllerManager.instance.openControllerByInfo("question");
               break;
            case "newmemorycard":
               FrameControllerManager.instance.openControllerByInfo("newmemorycard");
               break;
            case "carnival":
               FrameControllerManager.instance.openControllerByInfo("carnival");
               break;
            case "sqmomery":
               SqMemoryManger.Instance.doSomething();
               break;
            case "oldplayerreturn":
               FrameControllerManager.instance.openControllerByInfo("oldplayerreturn");
               break;
            case "oldplayerreturn2":
               FrameControllerManager.instance.openControllerByInfo("oldplayerreturn");
               break;
            case "secretwar":
               if(thane.isAvenger)
               {
                  FrameControllerManager.instance.openControllerByInfo("secretwar");
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("SecretwarEnterFrame.open.text"));
               }
               break;
            case "christmas":
               FrameControllerManager.instance.openControllerByInfo("christmas");
         }
      }
      
      private function creatTopActiveBox(param1:String) : void
      {
         var _loc3_:Point = null;
         var _loc4_:TopBtnActiveBoxView = null;
         var _loc2_:TopBtnItemView = _curActiveBtnDic[param1];
         if(_loc2_.data)
         {
            _loc3_ = new Point(_loc2_.displayWidth / 2,0);
            _loc3_ = _loc2_.localToGlobal(_loc3_);
            _loc4_ = _loc2_.data.boxView;
            if(_loc4_ == null || _loc4_.isDie)
            {
               _loc4_ = new TopBtnActiveBoxView();
               _loc2_.data.boxView = _loc4_;
            }
            _loc4_.refreshView(_loc2_.data.boxItemList);
            _loc4_.x = _loc3_.x - 157;
            _loc4_.y = _loc3_.y + 75;
            _loc4_.show();
         }
      }
      
      private function checkLuckyLotteryIsEnd() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc1_:String = LuckyLotteryManager.instance.model.endDate;
         var _loc4_:Number = DateFormatter.parse(_loc1_,"YYYY-MM-DD hh:mm:ss").getTime();
         var _loc2_:Number = playerModel.nowDate;
         if(_loc2_ > _loc4_)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function checkIsRightScene() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("TimeActiveBoxView.notInRightScene.alert"));
         return false;
      }
      
      public function checkIsOpen(param1:int) : Boolean
      {
         var _loc2_:int = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(param1);
         var _loc3_:int = int(TopBtnType.TIME_ACTIVE_GRADES[param1]);
         if(thane.grades < _loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",_loc3_));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[3])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.overTip"));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
         {
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.unopenTip"));
         return false;
      }
      
      public function enterOutyardScene() : void
      {
         var _loc7_:int = 0;
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(playerInfo.consortiaID == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.noConsortia"));
            return;
         }
         var _loc3_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         var _loc4_:HugeHeadMySignInStateMsg = OutyardManager.instance.model.signInMsg;
         if(!_loc3_ || !_loc4_)
         {
            return;
         }
         if(!_loc4_.guildSignIn)
         {
            if(_loc3_.canSignIn)
            {
               if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.chairmanID == playerInfo.userId || FrameControllerManager.instance.consortiaController.getRightsByNum(46))
               {
                  SimpleAlertHelper.instance.data = [__alertOutyardHandler];
                  _loc7_ = ConfigInfoManager.instance.getStackHeadJoinFee();
                  _loc1_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc8_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc9_ = LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.openTxt.text",_loc7_);
                  SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc1_,_loc2_,true);
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
         var _loc10_:Number = _loc3_ && _loc3_.hugeHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(_loc3_.hugeHeadNextOpenTime[0].startTime) : 0;
         if(_loc10_ == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.noOpenToday"));
            return;
         }
         var _loc5_:Date = new Date(_loc10_);
         var _loc6_:String = DateFormatter.timeFormat1(_loc5_);
         if(_loc3_.hugeHeadState == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",_loc6_));
            return;
         }
         if(_loc3_.hugeHeadState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.gatherToday"));
            return;
         }
         if(!_loc4_.guildJoin)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",_loc6_));
            return;
         }
         if(!_loc4_.selfJoin)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.selfJoinNextOpenDate",_loc6_));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("outyard",3);
      }
      
      private function __alertOutyardHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateMapOutyard(11);
         }
      }
      
      private function openVehicleRoomList() : void
      {
         FrameControllerManager.instance.openControllerByInfo("vehicleroomlist");
      }
      
      private function __feedBackHandler(param1:FeedBackEvent) : void
      {
         if(_curActiveBtnDic["feedback"] && FeedBackManager.instance.needShine)
         {
            _curActiveBtnDic["feedback"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __firstChargeHandler(param1:PlayerEvent) : void
      {
         SimpleAlertHelper.instance.data = [];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("toptoolbar.FirstChargeContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc2_,"",true);
         show();
      }
      
      private function __worldbossStateHandler(param1:PlayerEvent) : void
      {
         show();
      }
      
      private function __warFightStateHandler(param1:WorldBossEvent) : void
      {
         if(param1.data.open)
         {
            if(_curActiveBtnDic["rvr1"])
            {
               _curActiveBtnDic["rvr1"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
         else if(_curActiveBtnDic["rvr1"])
         {
            _curActiveBtnDic["rvr1"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         }
         show();
      }
      
      private function __challengeTakeHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeRankRewardMsg = new ChallengeRankRewardMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ChallengeRankRewardMsg;
         playerInfo.isChallReward = _loc2_.isTake;
         var _loc9_:int = _loc2_.param1;
         var _loc10_:int = _loc2_.param2;
         var _loc5_:int = _loc2_.param3;
         var _loc7_:int = _loc2_.param4;
         var _loc3_:String = LanguageMgr.GetTranslation("mainBar.TopToolsBar.str01",_loc9_);
         if(_loc10_ > 0)
         {
            _loc3_ += LanguageMgr.GetTranslation("mainBar.TopToolsBar.str02",_loc10_);
         }
         if(_loc5_ > 0)
         {
            _loc3_ += LanguageMgr.GetTranslation("mainBar.TopToolsBar.str03",_loc5_);
         }
         _loc3_ += LanguageMgr.GetTranslation("mainBar.TopToolsBar.str04",_loc7_);
         _loc3_ += ".";
         SimpleAlertHelper.instance.data = [];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc3_,_loc4_,"",false,true,true);
         show();
      }
      
      private function __remotePetHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:Array = null;
         var _loc3_:Array = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc9_:String = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemoteItemMsg = new RemoteItemMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as RemoteItemMsg;
         if(_loc2_.type == 1)
         {
            _loc6_ = _loc2_.items.split("|");
            _loc3_ = _loc6_[0].split(",");
            _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc3_[0])).TemplateName;
            _loc4_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.remotePetContent",_loc2_.count,_loc7_,_loc3_[1]);
            SimpleAlertHelper.instance.data = [];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc9_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.remotePetTips");
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc4_,_loc5_,"",false,true,true);
            show();
         }
      }
      
      private function __pvpTakeHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeRankRewardMsg = new ChallengeRankRewardMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ChallengeRankRewardMsg;
         playerInfo.canAcceptCrossScoreAward = false;
         var _loc10_:int = _loc2_.param1;
         var _loc11_:int = _loc2_.param2;
         var _loc6_:int = _loc2_.param3;
         var _loc8_:int = _loc2_.param4;
         var _loc3_:String = "";
         var _loc5_:String = "";
         if(_loc8_ == 1)
         {
            _loc3_ = LanguageMgr.GetTranslation("crossscore.txt02",LanguageMgr.GetTranslation("crossscore.name01"));
         }
         if(_loc6_ <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("crossscore.txt04");
            _loc3_ = LanguageMgr.GetTranslation("crossscore.txt",_loc11_) + _loc3_;
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("crossscore.txt03",_loc6_);
            _loc3_ = LanguageMgr.GetTranslation("crossscore.txt",_loc11_) + _loc5_ + _loc3_;
         }
         SimpleAlertHelper.instance.data = [];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc3_,_loc4_,"",false,true,true);
         show();
      }
      
      private function __petRankRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PetChallengeObjectData = null;
         var _loc3_:Object = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetRankRewardMsg = new PetRankRewardMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PetRankRewardMsg;
         if(_loc2_.type == 2)
         {
            if(_loc2_.status == 1)
            {
               playerInfo.canAcceptPetChallWeekReward = false;
               _loc5_ = new PetChallengeObjectData();
               _loc5_.score = _loc2_.score;
               _loc5_.ranking = _loc2_.rank;
               _loc3_ = {
                  "rank":_loc5_,
                  "type":_loc2_.type
               };
               FrameControllerManager.instance.openControllerByInfo("petchallenge",1,_loc3_);
            }
            show();
         }
      }
      
      private function __pvpStateHandlet(param1:PlayerEvent) : void
      {
         if(playerInfo.isPVPStart)
         {
            if(_curActiveBtnDic["pvp"])
            {
               _curActiveBtnDic["pvp"].movieBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
         else if(_curActiveBtnDic["pvp"])
         {
            _curActiveBtnDic["pvp"].movieBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         }
         show();
      }
      
      private function __onLevelHandler(param1:NotificationEvent) : void
      {
         if(thane.grades == 22)
         {
            sendMatch();
            NotificationManager.instance.removeEventListener("HERO_LEVELUP_CLOSE",__onLevelHandler);
         }
         if(thane.grades >= 4 && thane.preGrade < 4)
         {
            show();
         }
      }
      
      private function setBloodTip() : void
      {
         _bloodItem.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.blood",thane.blood);
      }
      
      public function set setBloodIconEnable(param1:Boolean) : void
      {
         if(!_bloodSprite)
         {
            return;
         }
         if(!param1)
         {
            _bloodSprite.addChild(_bloodEnableIcon);
            _bufferContain.addChild(_bloodSprite);
         }
         else
         {
            if(_bloodEnableIcon && _bloodEnableIcon.parent)
            {
               _bloodEnableIcon.parent.removeChild(_bloodEnableIcon);
            }
            if(_bloodSprite && _bloodSprite.parent)
            {
               _bloodSprite.parent.removeChild(_bloodSprite);
            }
         }
         _bloodEnable = param1;
         refreshBufferView();
      }
      
      private function setBloodIcon() : void
      {
         if(_bloodEnable)
         {
            return;
         }
         var _loc1_:Boolean = ArmyManager.instance.army.baseHero.blood > 0;
         if(_loc1_)
         {
            _bloodItem.icon = IconFactory.getCommonIconPath("/blood_01.png");
            _bufferContain.addChild(_bloodSprite);
            _firstBufferIndex = _firstBufferIndex + 1;
            if(_bloodEnableIcon.parent)
            {
               _bloodSprite.addChild(_bloodEnableIcon);
            }
         }
         setBloodTip();
      }
      
      private function showWorldProsperityIcon() : void
      {
         if(playerInfo.worldProsperity > 0)
         {
            if(!_worldProsperityItem)
            {
               _worldProsperityItem = new ExtraBufferItem();
               _worldProsperityItem.mouseEnabled = false;
               _worldProsperityItem.setButtonMode(false);
            }
            _worldProsperityItem.setData(6,[playerInfo.worldProsperity]);
            _bufferContain.addChild(_worldProsperityItem);
         }
         else if(_worldProsperityItem)
         {
            if(_worldProsperityItem.parent)
            {
               _worldProsperityItem.parent.removeChild(_worldProsperityItem);
            }
            _worldProsperityItem.dispose();
            _worldProsperityItem = null;
         }
      }
      
      private function __questionnaireChange(param1:QuestionnaireEvent) : void
      {
         show();
      }
      
      private function refreshBufferView() : void
      {
         var _loc2_:ExtraBufferItem = null;
         var _loc18_:String = null;
         var _loc11_:CampaignArmy = null;
         var _loc14_:int = 0;
         var _loc5_:TransportBufferInfo = null;
         var _loc1_:Array = null;
         var _loc6_:PlayerBufferInfo = null;
         var _loc4_:PlayerBufferItem = null;
         var _loc20_:KingContractInfo = null;
         var _loc12_:KingContractInfo = null;
         if(_bloodSprite && _bloodSprite.parent)
         {
            _bloodSprite.parent.removeChild(_bloodSprite);
         }
         _bufferContain.disposeAllChildren();
         _worldProsperityItem = null;
         _forbidConsortiaView = null;
         if(isInFullscreenFrame)
         {
            return;
         }
         var _loc16_:String = SceneManager.instance.currentType;
         if(_loc16_ == "FARM" || _loc16_ == "BATTLE_SCENE" || _loc16_ == "VEHICLE" || _loc16_ == "CHANLLENGE_ROOM_SCENE" || _loc16_ == "CROSS_GUILD_SCENE")
         {
            return;
         }
         _firstBufferIndex = 0;
         setBloodIcon();
         consortiaView();
         var _loc15_:Array = playerInfo.getConsortiaSkills();
         if(_loc15_.length > 0 && playerInfo.consortiaID > 0)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(1,_loc15_);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         var _loc8_:Array = BuildingManager.instance.model.allExistTec();
         if(_loc8_.length > 0)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(2,_loc8_);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         var _loc17_:Array = MagicCardManager.Instance.cardModel.cardCampBuffList;
         if(_loc17_.length > 0)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(10,_loc17_);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         if(AppellManager.instance.model.isOpenAppellAddition)
         {
            _loc18_ = AppellManager.instance.model.getAppellSummaryTipContent();
            if(_loc18_)
            {
               _loc2_ = new ExtraBufferItem();
               _loc2_.setData(21,[_loc18_]);
               _bufferContain.addChild(_loc2_);
               _firstBufferIndex = _firstBufferIndex + 1;
            }
         }
         if(playerInfo.isBackPlayer)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(30000,[LanguageMgr.GetTranslation("mainBar.TopToolsBar.regressBufferTip")]);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         var _loc3_:Boolean = GodDessManager.instance.model.doubleOpen;
         if(_loc3_)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(40008,[]);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         var _loc10_:Array = KingContractManager.Instance.model.kingContractInfos.getList();
         var _loc19_:Boolean = VersionSwitch.KING_CONTRACT;
         if(CampaignManager.instance.mapModel)
         {
            _loc11_ = CampaignManager.instance.mapModel.selfMemberData;
            if(_loc11_)
            {
               _loc14_ = _loc11_.isDie;
               if((_loc14_ == 3 || _loc14_ == 2) && WorldBossHelper.checkPvp(CampaignManager.instance.mapId))
               {
                  _loc5_ = new TransportBufferInfo();
                  _loc5_.infoContent = LanguageMgr.GetTranslation("mainBar.TopToolsBar.TransportTip2");
                  _loc2_ = new ExtraBufferItem();
                  _loc1_ = new Array(_loc5_);
                  _loc2_.setData(5,_loc1_);
                  _bufferContain.addChild(_loc2_);
                  _firstBufferIndex = _firstBufferIndex + 1;
               }
            }
         }
         _loc6_ = PlayerBufferManager.instance.getItemBufferInfo(20000);
         if(_loc6_ && thane.grades >= 10)
         {
            _loc2_ = new ExtraBufferItem();
            _loc2_.setData(20000,[_loc6_.description]);
            _bufferContain.addChild(_loc2_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         _loc6_ = PlayerBufferManager.instance.basePropertyBuffer;
         if(_loc6_)
         {
            _loc4_ = new PlayerBufferItem();
            _loc4_.data = _loc6_;
            _bufferContain.addChild(_loc4_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         for each(_loc6_ in PlayerBufferManager.instance.basePropertyBufferList)
         {
            _loc4_ = new PlayerBufferItem();
            _loc4_.data = _loc6_;
            _bufferContain.addChild(_loc4_);
            _firstBufferIndex = _firstBufferIndex + 1;
         }
         for each(_loc6_ in PlayerBufferManager.instance.itemBufferList)
         {
            if(_loc6_.bufferType != 20000)
            {
               _loc4_ = new PlayerBufferItem();
               _loc4_.data = _loc6_;
               if(_loc6_.bufferType == -3 || _loc6_.bufferType == -5 || _loc6_.bufferType == 40005 || _loc6_.bufferType == 40006)
               {
                  _bufferContain.addChildAt(_loc4_,_firstBufferIndex);
               }
               else
               {
                  _bufferContain.addChild(_loc4_);
               }
            }
         }
         var _loc9_:Vector.<PlayerBufferInfo> = PlayerBufferManager.instance.campaignBufferList;
         for each(_loc6_ in _loc9_)
         {
            _loc4_ = new PlayerBufferItem();
            _loc4_.data = _loc6_;
            _bufferContain.addChild(_loc4_);
         }
         if(godsEveningModel.bossDebuffShowFlag == 0)
         {
            _loc6_ = new PlayerBufferInfo();
            _loc6_.templateId = godsEveningModel.bossDebuffId;
            _loc6_.bufferType = 0;
            _loc4_ = new PlayerBufferItem();
            _loc4_.data = _loc6_;
            _bufferContain.addChild(_loc4_);
         }
         if(_loc19_)
         {
            _loc20_ = KingContractManager.Instance.model.getInfoById(6);
            _loc12_ = KingContractManager.Instance.model.getInfoById(7);
            if(_loc20_.leftTime > 0 && _loc12_.leftTime > 0)
            {
               _loc6_ = new PlayerBufferInfo();
               _loc6_.templateId = -2;
               _loc6_.bufferType = -2;
               _loc6_.leftTime = _loc12_.leftTime;
               _loc4_ = new PlayerBufferItem();
               _loc4_.data = _loc6_;
               _bufferContain.addChild(_loc4_);
               NotificationManager.instance.sendNotification("KING_CONTRACT_BUFF_GET");
            }
         }
         var _loc7_:int = CrossGuildManager.instance.model.crossGuildBufferLeftTime;
         if(_loc7_ > 0)
         {
            _loc6_ = new PlayerBufferInfo();
            _loc6_.bufferType = 40004;
            _loc6_.leftTime = _loc7_;
            _loc4_ = new PlayerBufferItem();
            _loc4_.data = _loc6_;
            _bufferContain.addChild(_loc4_);
         }
         var _loc13_:Array = MagicSpringManager.instance.model.slotList;
         if(_loc13_.length > 0)
         {
            for each(var _loc21_:MagicSpringSlotInfo in _loc13_)
            {
               if(_loc21_.validCountDown > 0)
               {
                  _loc6_ = new PlayerBufferInfo();
                  _loc6_.templateId = _loc21_.tempId;
                  _loc6_.bufferType = 40007;
                  _loc6_.leftTime = _loc21_.validCountDown;
                  _loc4_ = new PlayerBufferItem();
                  _loc4_.data = _loc6_;
                  _bufferContain.addChild(_loc4_);
               }
            }
         }
         showWorldProsperityIcon();
         if(_buffCount == 0)
         {
            _buffCount = _bufferContain.numChildren;
         }
         if(_bufferContain.numChildren > 5 && visible)
         {
            _bufferBack.visible = true;
            if(_bufferContain.numChildren > _buffCount)
            {
               _bufferHideBtn.selected = true;
            }
         }
         else
         {
            _bufferBack.visible = false;
         }
         if(_firstShow)
         {
            _firstShow = false;
            _bufferHideBtn.selected = true;
         }
         if(_bufferContain.numChildren % 5 <= 1)
         {
            setBuffMask();
         }
         _buffCount = _bufferContain.numChildren;
      }
      
      private function consortiaView() : void
      {
         var _loc1_:Number = playerInfo.lastOutConsortia;
         var _loc2_:Boolean = playerInfo.isAuto;
         if(_loc2_ == false || _loc1_ + 86400 < playerModel.sysCurTimeBySecond || _loc1_ == 0)
         {
            disposeForbidConsortiaView();
            return;
         }
         if(_forbidConsortiaView == null)
         {
            _forbidConsortiaView = new ForbidConsortiaView(_loc1_);
         }
         _bufferContain.addChild(_forbidConsortiaView);
         _firstBufferIndex = _firstBufferIndex + 1;
      }
      
      public function disposeForbidConsortiaView() : void
      {
         if(_forbidConsortiaView)
         {
            _forbidConsortiaView.dispose();
            _forbidConsortiaView = null;
         }
      }
      
      private function get isInFullscreenFrame() : Boolean
      {
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply || FrameControllerManager.instance.svsController.isInSvsFrame || FrameControllerManager.instance.gemMazeController.isEnterGemMaze || FrameControllerManager.instance.sacrificeController.isInSacrificeFrame || FrameControllerManager.instance.steelController.isInSteelFrame || FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame || FrameControllerManager.instance.unrealShootingController.isInUnrealShootingFrame || FrameControllerManager.instance.godsEveningController.isInGodsEveningFrame || FrameControllerManager.instance.landMineController.isInLandMineFrame || FrameControllerManager.instance.spiritExpeditionControl.isInSpiritExpeditionFrame || SceneManager.instance.isEnterFullScene)
         {
            return true;
         }
         return false;
      }
      
      private function refreshActiveBtn() : void
      {
         var _loc2_:String = null;
         var _loc3_:CampaignMapModel = null;
         var _loc1_:Boolean = false;
         _targetView.visible = true;
         if(isInFullscreenFrame)
         {
            hide();
            _targetView.visible = false;
         }
         else
         {
            _loc2_ = SceneManager.instance.currentType;
            switch(_loc2_)
            {
               case "BATTLE_SCENE":
               case "EMPTY_SCENE":
               case "FARM":
               case "VEHICLE":
               case "CHANLLENGE_ROOM_SCENE":
               case "SKYBOX_ROAD_SCENE":
               case "FINAL_DEFENSE_SCENE":
               case "INCREASINGLY_ROAD_SCENE":
               case "DARK_MAZE_SCENE":
               case "THESE_Double_PVP_SCENE":
                  hide();
                  break;
               case "CAMPAIGN_MAP_SCENE":
                  _loc3_ = CampaignManager.instance.mapModel;
                  if(_loc3_)
                  {
                     _loc1_ = WorldBossHelper.checkWedding(_loc3_.mapId) || WorldBossHelper.checkInHouse(_loc3_.mapId) || WorldBossHelper.checkUnrealShooting(_loc3_.mapId) || WorldBossHelper.checkSteel(_loc3_.mapId);
                  }
                  else
                  {
                     _loc1_ = false;
                  }
                  if(_loc1_)
                  {
                     hide();
                  }
                  else
                  {
                     visible = true;
                     refreshCurActiveBtn(true);
                  }
                  break;
               default:
                  visible = true;
                  refreshCurActiveBtn(true);
            }
         }
      }
      
      private function refreshCurActiveBtn(param1:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc13_:ScaleFrameImage = null;
         var _loc8_:TopBtnItemView = null;
         var _loc11_:TopToolBtnTempInfo = null;
         var _loc15_:String = null;
         var _loc2_:Array = null;
         var _loc5_:TopBtnActiveBoxView = null;
         clearTimeout(btnTimeId);
         btnTimeId = 0;
         _curActiveBtnDic = new Dictionary();
         if(param1)
         {
            currentPageNum = 1;
         }
         var _loc4_:int = curAllShowList.length - 1;
         pageNumMax = Math.ceil(_loc4_ / (curShowNum - 1));
         updatePageInfo();
         pageHbox.removeAllChild();
         _loc7_ = 0;
         while(_loc7_ < pageNumMax)
         {
            _loc13_ = _loc7_ < pageImageList.length ? pageImageList[_loc7_] : null;
            if(_loc13_ != null)
            {
               currentPageNum == _loc7_ + 1 ? _loc13_.setFrame(1) : _loc13_.setFrame(2);
               pageHbox.addChild(_loc13_);
            }
            _loc7_++;
         }
         var _loc6_:int = 0;
         var _loc10_:Array = currentPageList;
         var _loc9_:Dictionary = new Dictionary();
         var _loc16_:Dictionary = new Dictionary();
         var _loc14_:Array = TopBtnCheckShowHelper.instance.boxActiveList;
         var _loc12_:int = int(_loc14_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            _loc11_ = _loc14_[_loc6_];
            _loc15_ = _loc6_ < _loc14_.length && _loc11_ ? _loc11_.BtnKey : "";
            if(_loc11_)
            {
               _loc8_ = new TopBtnItemView();
               _loc2_ = _loc16_[_loc11_.BoxTypeTo];
               if(_loc2_ == null)
               {
                  _loc2_ = [];
                  _loc16_[_loc11_.BoxTypeTo] = _loc2_;
               }
               _loc2_.push(_loc8_);
               _loc8_.data = _loc11_;
               _curActiveBtnDic[_loc11_.BtnKey] = _loc8_;
               addBtnTips(_loc15_,_loc8_);
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < curShowNum)
         {
            _loc8_ = itemList[_loc6_];
            _loc11_ = _loc10_[_loc6_];
            _loc15_ = _loc6_ < _loc10_.length && _loc11_ ? _loc11_.BtnKey : "";
            if(_loc11_ && _loc11_.BoxType > 0)
            {
               _loc9_[_loc11_.BoxType] = _loc11_;
            }
            _loc8_.data = _loc11_;
            if(_loc11_)
            {
               _curActiveBtnDic[_loc11_.BtnKey] = _loc8_;
            }
            addBtnTips(_loc15_,_loc8_);
            if(_isMin && !StringHelper.isNullOrEmpty(_loc15_) && _loc15_ != "funny")
            {
               toMin(_loc8_);
            }
            _loc6_++;
         }
         for(var _loc3_:String in _loc9_)
         {
            _loc11_ = _loc9_[_loc3_];
            _loc2_ = _loc16_[_loc3_];
            _loc5_ = _loc11_.boxView;
            if(_loc5_ && !_loc5_.isDie)
            {
               _loc5_.refreshView(_loc2_);
            }
            _loc11_.boxItemList = _loc2_;
            refreshActiveBoxState(_loc11_.BtnKey);
         }
         _activeContainer.resetArrange();
         setBtnPoint();
         onBtnTipsUpdate();
         if(currentPageNum != 1)
         {
            btnTimeId = setTimeout(onBtnChangeHandler,300000);
         }
      }
      
      private function onBtnChangeHandler() : void
      {
         show();
      }
      
      private function showRechargeBtnEff(param1:Event) : void
      {
         if(_curActiveBtnDic["recharge"] && thane.grades >= 11 && FunnyManager.instance.model.rechargeBagData)
         {
            _curActiveBtnDic["recharge"].movieBtn.movie.movie["effect"]["effect_01"].play();
         }
      }
      
      private function __completehandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!_isLoaded)
         {
            _isLoaded = true;
            initView();
            initEvent();
            initData();
            LayerManager.Instance.addToLayer(this,4,false,false,0,0);
            show();
         }
      }
      
      private function __thaneLevelUpdateHandler(param1:Event) : void
      {
         InfoTipsManager.instance.dealData(22);
         show(param1);
      }
      
      public function doShineIcon() : void
      {
         _extralItem.visible = true;
         _shine = EffectManager.Instance.creatEffect(2,_extralItem,{"color":"yellow"});
         _shine.play();
         _extralItem.addEventListener("click",__stopShineHandler);
      }
      
      private function __moveComplete(param1:BaseItemView) : void
      {
         param1.dispose();
         _extralItem.visible = true;
         _shine = EffectManager.Instance.creatEffect(2,_extralItem,{"color":"yellow"});
         _shine.play();
         _extralItem.addEventListener("click",__stopShineHandler);
      }
      
      private function __stopShineHandler(param1:MouseEvent) : void
      {
         _extralItem.removeEventListener("click",__stopShineHandler);
         _shine.stop();
         _shine.dispose();
      }
      
      public function doMoveIcon(param1:BaseItemView) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Point = _extralItem.localToGlobal(new Point(0,0));
         LayerManager.Instance.addToLayer(param1,3);
         TweenLite.to(param1,1.5,{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "onComplete":__moveComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function resizeHandler(param1:Event) : void
      {
         curShowNum = StageReferance.stageWidth > 1200 ? 16 : 10;
         if(preShowNum != curShowNum)
         {
            resetBtnListView();
         }
         preShowNum = curShowNum;
         show();
      }
      
      public function show(param1:Event = null) : void
      {
         var _loc3_:String = null;
         if(BraveLegManager.instance.hasTeam())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess < 15000)
         {
            return;
         }
         if(SceneManager.instance.currentType == "PLANES_WAR_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM")
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
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
            {
               return;
            }
         }
         if(CampaignManager.instance.mapModel)
         {
            if(WorldBossHelper.checkSacrificeRoom(CampaignManager.instance.mapModel.mapId) || WorldBossHelper.checkFarm(CampaignManager.instance.mapModel.mapId) || WorldBossHelper.checkAirGarden(CampaignManager.instance.mapModel.mapId) || WorldBossHelper.checkActiveVehicle(CampaignManager.instance.mapModel.mapId))
            {
               return;
            }
         }
         if(SceneManager.instance.currentType == "STARAREA_SCENE")
         {
            return;
         }
         if(!_isLoaded)
         {
            _loc3_ = ComponentSetting.getUISourcePath("toptoolbar");
            LoaderManagerII.instance.load(_loc3_,3,8,__completehandler);
            return;
         }
         if(MarryManager.instance.model.lockScreen)
         {
            return;
         }
         _activeContainer.visible = true;
         _topCondenseBtn.visible = true;
         _topExtrudeBtn.visible = true;
         preBtn.visible = nextBtn.visible = pageHbox.visible = !_isMin;
         x = 332;
         y = _posY;
         refreshBufferView();
         var _loc2_:int = StageReferance.gameStageWidth;
         var _loc5_:Number = _loc2_ - 520;
         var _loc7_:Number = 165;
         var _loc6_:Number = 280;
         var _loc4_:Number = _loc5_ - _loc6_ - _loc7_;
         _activeContainer.beginChanges();
         refreshActiveBtn();
         _activeContainer.commitChanges();
         _activeContainer.x = _loc5_ - _activeContainer.width - 35;
         _topCondenseBtn.x = _activeContainer.x + (_activeContainer.width - 60) / 2;
         _topCondenseBtn.y = _activeContainer.rowNum * 71 + 30;
         _topExtrudeBtn.x = _activeContainer.x + _activeContainer.width - 67;
         _topExtrudeBtn.y = 80;
         preBtn.x = _topCondenseBtn.x - 25;
         nextBtn.x = _topCondenseBtn.x + 80;
         preBtn.y = nextBtn.y = _topCondenseBtn.y;
         pageHbox.x = _activeContainer.x + (_activeContainer.width - pageHbox.width) / 2;
         pageHbox.y = _topCondenseBtn.y - 22;
         _posX = _activeContainer.width - 75;
         if(_isMin)
         {
            _topCondenseBtn.visible = false;
            _topExtrudeBtn.visible = true;
         }
         else
         {
            _topCondenseBtn.visible = true;
            _topExtrudeBtn.visible = false;
         }
         if(_bufferContain.numChildren > 5)
         {
            _bufferBack.visible = true;
         }
         else
         {
            _bufferBack.visible = false;
         }
         if(needHideActiove)
         {
            hideActioveContain();
         }
      }
      
      private function refreshActiveBoxState(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc3_:TopBtnItemView = _curActiveBtnDic[param1];
         if(_loc3_ && _loc3_.data)
         {
            _loc3_.data.boxFlash = false;
            _loc4_ = _loc3_.data.boxItemList;
            for each(var _loc2_:TopBtnItemView in _loc4_)
            {
               if(_loc2_ && _loc2_.data && _loc2_.data.isOpen)
               {
                  _loc3_.data.boxFlash = true;
                  _loc3_.checkActiveFlash();
                  break;
               }
            }
         }
      }
      
      private function get needHideActiove() : Boolean
      {
         var _loc1_:int = CampaignManager.instance.mapId;
         if(WorldBossHelper.checkWorldBoss(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkPvp(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkDuskArea(_loc1_) || WorldBossHelper.checkIceFireTemple(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkFlameTemple(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkSvs(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkMolong(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkInQuizActivity(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkMonopoly(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkFarm(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkGodsEvening(_loc1_))
         {
            return true;
         }
         if(WorldBossHelper.checkConsortiaEmeDream(_loc1_))
         {
            return true;
         }
         if(SceneManager.instance.currentType == "PVE_ROOM_SCENE")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "PVP_ROOM_SCENE")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "MATELORDS_ROOM")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "ARESLORDS_ROOM")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "APEX_ROOM")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "GLORY_GAME_SCENE")
         {
            return true;
         }
         return false;
      }
      
      private function setBtnPoint() : void
      {
         for(var _loc1_:String in _curActiveBtnDic)
         {
            _btnPointDic[_loc1_] = new Point(_curActiveBtnDic[_loc1_].x,_curActiveBtnDic[_loc1_].y);
         }
      }
      
      private function toMin(param1:TopBtnItemView) : void
      {
         var target:TopBtnItemView = param1;
         if(target)
         {
            TweenLite.killTweensOf(target);
            TweenLite.to(target,0.5,{
               "x":_posX,
               "y":0,
               "alpha":0,
               "onComplete":function():void
               {
                  target.visible = false;
               }
            });
         }
      }
      
      private function toMax(param1:TopBtnItemView, param2:String) : void
      {
         var _loc3_:Point = null;
         if(param1)
         {
            param1.visible = true;
            param1.x = _posX;
            _loc3_ = _btnPointDic[param2];
            if(_loc3_)
            {
               TweenLite.killTweensOf(param1);
               TweenLite.to(param1,0.5,{
                  "x":_loc3_.x,
                  "y":_loc3_.y,
                  "alpha":1
               });
            }
         }
      }
      
      private function addBtnTips(param1:String, param2:TopBtnItemView) : void
      {
         var _loc3_:MovieClip = null;
         switch(param1)
         {
            case "crosspvpreward":
            case "bottle":
            case "goldroad":
            case "rvr1":
            case "pvp":
            case "petboss":
            case "funny":
            case "worldboss":
            case "feedback":
            case "tiro":
            case "fundnewbie":
            case "registwelfare":
            case "cultureactive":
            case "kingback":
            case "customizedvip":
            case "newfirstpay":
            case "newmemorycard":
            case "christmas":
            case "skytreasure1":
               _loc3_ = needShowDataTipsBtnObj[param1];
               if(_loc3_ == null)
               {
                  _loc3_ = getBtnTipView();
                  needShowDataTipsBtnObj[param1] = _loc3_;
               }
               param2.addShowChild(_loc3_);
         }
      }
      
      public function onBtnTipsUpdate(param1:Event = null) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         for(var _loc2_:String in needShowDataTipsBtnObj)
         {
            _loc3_ = needShowDataTipsBtnObj[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.visible = false;
            }
            switch(_loc2_)
            {
               case "crosspvpreward":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(15);
                  break;
               case "bottle":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(7);
                  break;
               case "goldroad":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(8);
                  break;
               case "rvr1":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(9);
                  break;
               case "pvp":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(10);
                  break;
               case "petboss":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(18);
                  break;
               case "funny":
                  _loc4_ = FunnyHelper.showNumer;
                  break;
               case "worldboss":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(20);
                  break;
               case "feedback":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(21);
                  break;
               case "tiro":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(23);
                  break;
               case "fundnewbie":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(22);
                  break;
               case "registwelfare":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(28);
                  break;
               case "cultureactive":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(31);
                  break;
               case "kingback":
                  _loc4_ = InfoTipsManager.instance.getValueByKey(32);
                  break;
               case "customizedvip":
                  _loc4_ = CustomizedVipManager.instance.model.isTopBtnFlicker ? 1 : 0;
                  break;
               case "skytreasure1":
                  _loc4_ = SkyTreasureManager.Instance.modelNew.getAllred() ? 1 : 0;
                  break;
               case "newfirstpay":
                  _loc4_ = NewFirstPayManager.instance.model.topRedNum;
                  break;
               case "newmemorycard":
                  _loc4_ = NewMemoryCardManager.instance.model.step;
                  break;
               case "christmas":
                  _loc4_ = ChristmasManager.instance.model.redCount;
                  break;
               case "skytreasure1":
                  _loc4_ = SkyTreasureManager.Instance.modelNew.getAllred() ? 1 : 0;
            }
            if(_loc4_ > 0 && _loc3_)
            {
               _loc3_.visible = true;
               _loc3_.txt.text = _loc4_ > 99 ? "99+" : _loc4_.toString();
            }
         }
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.visible = false;
         _loc1_.x = 50;
         _loc1_.y = 1;
         return _loc1_;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      public function hideActioveContain() : void
      {
         if(_bufferContain)
         {
            _bufferContain.visible = true;
         }
         if(_activeContainer)
         {
            _activeContainer.visible = false;
         }
         if(_topCondenseBtn)
         {
            _topCondenseBtn.visible = false;
         }
         if(_topExtrudeBtn)
         {
            _topExtrudeBtn.visible = false;
         }
         if(preBtn)
         {
            preBtn.visible = false;
         }
         if(nextBtn)
         {
            nextBtn.visible = false;
         }
         if(pageHbox)
         {
            pageHbox.visible = false;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return playerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get consortiaModel() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function get feedBackData() : FeedBackData
      {
         return FeedBackManager.instance.data;
      }
      
      private function sendMatch() : void
      {
         var _loc1_:PackageOut = new PackageOut(8294);
         SocketManager.instance.socket.send(_loc1_);
      }
      
      private function get lotteryModel() : LotteryModel
      {
         return LotteryManager.Instance.model;
      }
      
      public function mopupIng() : void
      {
         for each(var _loc1_:Object in _bufferContain)
         {
            if(_loc1_.enable)
            {
               _loc1_.enable = false;
            }
         }
         for(var _loc2_:String in _curActiveBtnDic)
         {
            if(isUnEnableType(_loc2_))
            {
               _curActiveBtnDic[_loc2_].movieBtn.enable = false;
            }
         }
      }
      
      public function mopupEnd() : void
      {
         for(var _loc2_:String in _curActiveBtnDic)
         {
            _curActiveBtnDic[_loc2_].movieBtn.enable = true;
         }
         for each(var _loc1_:Object in _bufferContain)
         {
            _loc1_.enable = true;
         }
      }
      
      public function isUnEnableType(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case "pvp":
            case "worldboss":
            case "matelords":
            case "vehicel":
            case "petboss":
            case "crossgvg":
            case "rvr1":
            case "godsevening":
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function get matelordsState() : int
      {
         return _matelordsState;
      }
      
      public function set matelordsState(param1:int) : void
      {
         if(_matelordsState == param1)
         {
            return;
         }
         _matelordsState = param1;
         show();
      }
      
      public function get areslordsState() : int
      {
         return _areslordsState;
      }
      
      public function set areslordsState(param1:int) : void
      {
         if(_areslordsState == param1)
         {
            return;
         }
         _areslordsState = param1;
         show();
      }
      
      public function get braveLegState() : int
      {
         return _braveLegState;
      }
      
      public function set braveLegState(param1:int) : void
      {
         if(_braveLegState == param1)
         {
            return;
         }
         _braveLegState = param1;
         show();
      }
      
      public function get unrealshootingState() : int
      {
         return _unrealshootingState;
      }
      
      public function set unrealshootingState(param1:int) : void
      {
         if(_unrealshootingState == param1)
         {
            return;
         }
         _unrealshootingState = param1;
         show();
      }
      
      public function get darkmazeStatus() : int
      {
         return _darkmazeStatus;
      }
      
      public function set darkmazeStatus(param1:int) : void
      {
         if(_darkmazeStatus == param1)
         {
            return;
         }
         _darkmazeStatus = param1;
         show();
         MsgMan.notifyObserver("REFRESH_BTN_TEXT","darkmaze");
      }
      
      public function get apexState() : int
      {
         return _apexState;
      }
      
      public function set apexState(param1:int) : void
      {
         _apexState = param1;
         show();
         MsgMan.notifyObserver("REFRESH_BTN_TEXT","apex");
      }
      
      public function get dayLightState() : int
      {
         return _dayLightState;
      }
      
      public function set dayLightState(param1:int) : void
      {
         if(_dayLightState == param1)
         {
            return;
         }
         _dayLightState = param1;
         show();
      }
      
      public function get kingbackState() : int
      {
         return _kingbackState;
      }
      
      public function set kingbackState(param1:int) : void
      {
         if(_kingbackState == param1)
         {
            return;
         }
         _kingbackState = param1;
         show();
      }
      
      public function get allManExchangeState() : int
      {
         return _allManExchangeState;
      }
      
      public function set allManExchangeState(param1:int) : void
      {
         _allManExchangeState = param1;
         show();
      }
      
      public function get godsEveningLightState() : int
      {
         return _godsEveningLightState;
      }
      
      public function set godsEveningLightState(param1:int) : void
      {
         if(_godsEveningLightState == param1)
         {
            return;
         }
         _godsEveningLightState = param1;
         show();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(preBtn)
         {
            preBtn.enable = currentPageNum > 1;
         }
         if(nextBtn)
         {
            nextBtn.enable = currentPageNum < pageNumMax;
         }
      }
      
      private function get currentPageList() : Array
      {
         var _loc1_:Array = curAllShowList;
         var _loc5_:TopToolBtnTempInfo = _loc1_.shift();
         var _loc3_:Array = [_loc5_];
         var _loc2_:int = (currentPageNum - 1) * (curShowNum - 1);
         var _loc4_:int = Math.min(_loc2_ + curShowNum - 1,_loc1_.length);
         var _loc6_:Array = _loc1_.slice(_loc2_,_loc4_);
         return _loc3_.concat(_loc6_);
      }
      
      private function get curAllShowList() : Array
      {
         return TopBtnCheckShowHelper.instance.curShowList;
      }
      
      private function get godsEveningModel() : GodsEveningModel
      {
         return GodsEveningManager.instance.model;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function showSevenYearBtn() : void
      {
      }
   }
}

