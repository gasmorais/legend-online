package room.view.pve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.DungeoTurnManager;
   import managers.RoomManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import mediator.RoomTimeMediator;
   import mvc.module.armyII.UserArmy;
   import mvc.module.room.RoomInfo;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.selectcampaign.CampaignLandInfo;
   import room.net.RoomSocketOuterManager;
   import room.view.invite.RoomInviteFrame;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.community.BaseIconView;
   import yishi.view.component.MovieButton;
   import yishi.view.component.MovieButtonII;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class RoomRightView extends Sprite implements Disposeable
   {
      
      public static const NAME:String = "room.view.pve.RoomRightView";
      
      private var _model:RoomInfo;
      
      private var _bg:MutipleImage;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _lockBtn:SelectedIconButton;
      
      private var _selectInstanceBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _sortBtn:BaseButton;
      
      private var _buttonLine:Bitmap;
      
      private var _quickStartBtn:IconButton;
      
      private var _startStripView:StripView;
      
      private var _startBtn:MovieButtonII;
      
      private var _readyBtn:MovieButton;
      
      private var _cancelBtn:MovieButton;
      
      private var _roomNumberTxt:FilterFrameText;
      
      private var _peopleNumberTxt:FilterFrameText;
      
      private var _goods:DisplayObject;
      
      private var _mapIcon:BaseIconView;
      
      private var _selectSprite:Sprite;
      
      private var _selectBit:Bitmap;
      
      private var _spaceTimeGetBtn:TextButton;
      
      private var _DungeoTurnGetBtn:TextButton;
      
      private var _iconBackMc:MovieClip;
      
      private var _enterTimeBg:Bitmap;
      
      private var _enterTimedes:Bitmap;
      
      private var _enterTimeTxt:FilterFrameText;
      
      private var _mediatorKey:String;
      
      private var _incomeBtn:SelectedIconButton;
      
      private var _difText:FilterFrameText;
      
      private var _areaNameTxt:GradientText;
      
      private var recommendGrades:FilterFrameText;
      
      private var crossNeedPowerText:FilterFrameText;
      
      private var _optimzeText:FilterFrameText;
      
      private var _optimzeValueText:FilterFrameText;
      
      private var gradeTextARR:Array;
      
      private var _timeBG:Bitmap;
      
      private var _timeFont:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeNumber:int;
      
      private var _timer:Timer;
      
      private var isCross:Boolean = false;
      
      private var _selectedTemplate:CampaignTemplate;
      
      private var _preMapTempId:int = -1;
      
      private var kingTowerInstanceHard:int;
      
      private var _preClickTime:Number;
      
      private var first:Boolean = true;
      
      public function RoomRightView()
      {
         super();
         initView();
         initEvents();
         var _loc1_:Array = [RoomTimeMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"room.view.pve.RoomRightView");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("room.PveRoomRightBG");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("room.pveRightDescribeBackground");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.PveLockBtn");
         _selectInstanceBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.PveSelectInstanceBtn");
         _startStripView = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.startStripView");
         _startBtn = ComponentFactory.Instance.creatCustomObject("room.roomRight.crossPveStartBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.PveInviteBtn");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.TeamSortBtn");
         _buttonLine = ComponentFactory.Instance.creatBitmap("asset.room.roomRight.buttonLine");
         _quickStartBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.quickStartBtn");
         _readyBtn = ComponentFactory.Instance.creatCustomObject("room.roomRight.PveReadyBtn");
         _cancelBtn = ComponentFactory.Instance.creatCustomObject("room.roomRight.PveCancelBtn");
         _roomNumberTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.pveRoomNumber");
         _peopleNumberTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.PveroomPeopleNumber");
         _goods = ComponentFactory.Instance.creatCustomObject("room.PveFallGoodsView");
         _spaceTimeGetBtn = ComponentFactory.Instance.creatComponentByStylename("xmlui.baseroom.fla.spaceTimeGetBtn");
         _spaceTimeGetBtn.tipData = LanguageMgr.GetTranslation("spacetimefault.rewardBtnTip");
         _DungeoTurnGetBtn = ComponentFactory.Instance.creatComponentByStylename("xmlui.baseroom.fla.spaceTimeGetBtn");
         _DungeoTurnGetBtn.tipData = LanguageMgr.GetTranslation("duengeonturn.rewardBtnTip");
         _iconBackMc = ComponentFactory.Instance.creatCustomObject("room.intanceImage.iconBackMc");
         _optimzeText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.optimzeText");
         _optimzeValueText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.optimzeValueText");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("room.MapIcon",[loadComplete]);
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("roompve.roomRight.areaNameTxt");
         crossNeedPowerText = ComponentFactory.Instance.creatComponentByStylename("roompve.roomRight.crossNeedPowerText");
         recommendGrades = ComponentFactory.Instance.creatComponentByStylename("roompve.roomRight.recommendGrades");
         _difText = ComponentFactory.Instance.creatComponentByStylename("roompve.roomRight.difText");
         _enterTimeBg = ComponentFactory.Instance.creatBitmap("asset.water.Expback");
         _enterTimedes = ComponentFactory.Instance.creatBitmap("asset.room.TimeLeftBMD");
         _enterTimeTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.EnterTimeRecord");
         _incomeBtn = ComponentFactory.Instance.creatComponentByStylename("room.incomeBtn");
         _incomeBtn.tipData = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.incomePrompt");
         _selectSprite = new Sprite();
         _selectSprite.addChild(_mapIcon);
         _selectSprite.addChild(_areaNameTxt);
         _selectSprite.addChild(recommendGrades);
         _selectSprite.addChild(crossNeedPowerText);
         crossNeedPowerText.visible = false;
         _selectSprite.addChild(_iconBackMc);
         _selectSprite.addChild(_selectInstanceBtn);
         _selectInstanceBtn.visible = false;
         _iconBackMc.gotoAndStop(1);
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.room.pve.timeBG");
         _timeFont = ComponentFactory.Instance.creatBitmap("asset.room.pve.timeFontBG");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("roompve.roomRight.timeTxt");
         addChild(_bg);
         addChild(_bg1);
         addChild(_lockBtn);
         addChild(_startStripView);
         _startStripView.addChild(_startBtn);
         _startStripView.tipData = LanguageMgr.GetTranslation("room.roomRight.startStripView.tipdata");
         addChild(_inviteBtn);
         addChild(_buttonLine);
         addChild(_quickStartBtn);
         addChild(_sortBtn);
         addChild(_readyBtn);
         _readyBtn.visible = false;
         addChild(_cancelBtn);
         _cancelBtn.visible = false;
         addChild(_roomNumberTxt);
         addChild(_peopleNumberTxt);
         _roomNumberTxt.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.roomNumber",565);
         _peopleNumberTxt.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.peopleNumber","3/5");
         addChild(_selectSprite);
         addChild(_goods);
         _goods.visible = false;
         addChild(_timeBG);
         _timeBG.visible = false;
         addChild(_timeFont);
         _timeFont.visible = false;
         addChild(_timeTxt);
         _timeTxt.visible = false;
         _timer = new Timer(1000);
         _timer.stop();
         addChild(_enterTimeBg);
         _enterTimeBg.x = -3;
         _enterTimeBg.y = 421;
         addChild(_enterTimedes);
         addChild(_enterTimeTxt);
         var _loc2_:int = int(playerInfo.multiCopyMaxCount);
         var _loc1_:int = int(playerInfo.multiCopyCount);
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         _enterTimeTxt.text = _loc1_ + " / " + _loc2_;
         addChild(_optimzeText);
         addChild(_optimzeValueText);
         _lockBtn.tipData = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         addChild(_difText);
         addChild(_incomeBtn);
         _incomeBtn.autoSelect = false;
         _incomeBtn.visible = false;
         gradeTextARR = LanguageMgr.GetTranslation("room.InstanceItem.gradeText").split("|");
         _areaNameTxt.x = 13;
         _areaNameTxt.y = 46;
         _optimzeText.x = 147;
         _optimzeText.y = 226;
         _optimzeValueText.x = 216;
         _optimzeValueText.y = 223;
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      private function initEvents() : void
      {
         _lockBtn.addEventListener("click",__lockHandler);
         _startBtn.addEventListener("click",_startClick);
         _quickStartBtn.addEventListener("click",_startClick);
         _inviteBtn.addEventListener("click",_inviteClick);
         _sortBtn.addEventListener("click",__teamSortClick);
         _readyBtn.addEventListener("click",__readyClick);
         _cancelBtn.addEventListener("click",_cancelClick);
         _selectSprite.addEventListener("mouseOver",__selectSpriteOver);
         _selectSprite.addEventListener("mouseOut",__selectSpriteOut);
         _selectSprite.addEventListener("click",__selectInstance);
         _selectInstanceBtn.addEventListener("click",__selectInstance);
         _incomeBtn.addEventListener("click",__incomeBtnClickHandler);
         playerInfo.addEventListener("MUTICOPY_COUNT",__mutiCopyCountHandler);
         playerInfo.addEventListener("MUTICOPY_MAX_COUNT",__mutiCopyCountHandler);
         _timer.addEventListener("timer",__timerHandler);
         _spaceTimeGetBtn.addEventListener("click",_spaceTimeGetHandler);
         _DungeoTurnGetBtn.addEventListener("click",_dungeoTurnGetHandler);
         NotificationManager.instance.addEventListener("REFRESH_SPACE_TIME_RESTNUM",_refreshSpaceRestNumHandler);
         NotificationManager.instance.addEventListener("REFRESH_SPACE_TIME_HISTORY",refreshSpaceTimeBtnHandler);
         NotificationManager.instance.addEventListener("DUNGEO_GET_REWARD",refreshDungeonturnHandler);
         NotificationManager.instance.addEventListener("REFRESH_DUNGEO_RESTNUM",_refreshDungeoHandler);
         NotificationManager.instance.addEventListener("REFRESH_ELEMENTSILVA_NUM",_refreshForestHandler);
         NotificationManager.instance.addEventListener("REFRESH_fantasyMatrix_NUM",_refreshFantasyMatrixHandler);
         NotificationManager.instance.addEventListener("REFRESH_trialTower_RESTNUM",_refreshTrialTowerHandler);
         NotificationManager.instance.addEventListener("REFRESH_darkKIng_RESTNUM",_refreshDarkKIngHandler);
         NotificationManager.instance.addEventListener("REFRESH_raceAgainst_RESTNUM",_refreshRaceAgainstHandler);
      }
      
      private function removeEvents() : void
      {
         _lockBtn.removeEventListener("click",__lockHandler);
         _startBtn.removeEventListener("click",_startClick);
         _quickStartBtn.removeEventListener("click",_startClick);
         _inviteBtn.removeEventListener("click",_inviteClick);
         _sortBtn.removeEventListener("click",__teamSortClick);
         _readyBtn.removeEventListener("click",__readyClick);
         _cancelBtn.removeEventListener("click",_cancelClick);
         _selectSprite.removeEventListener("mouseOver",__selectSpriteOver);
         _selectSprite.removeEventListener("mouseOut",__selectSpriteOut);
         _selectSprite.removeEventListener("click",__selectInstance);
         _selectInstanceBtn.removeEventListener("click",__selectInstance);
         _model.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         _model.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomInfoHanlder);
         _model.removeEventListener("UPDATE_ROOM_MAP",__roomMapChangeHandler);
         _model.removeEventListener("room_HouseOwner_change",__roomMapChangeHandler);
         if(_incomeBtn)
         {
            _incomeBtn.removeEventListener("click",__incomeBtnClickHandler);
         }
         playerInfo.removeEventListener("MUTICOPY_COUNT",__mutiCopyCountHandler);
         playerInfo.removeEventListener("MUTICOPY_MAX_COUNT",__mutiCopyCountHandler);
         _timer.removeEventListener("timer",__timerHandler);
         _spaceTimeGetBtn.removeEventListener("click",_spaceTimeGetHandler);
         _DungeoTurnGetBtn.removeEventListener("click",_dungeoTurnGetHandler);
         NotificationManager.instance.removeEventListener("REFRESH_SPACE_TIME_RESTNUM",_refreshSpaceRestNumHandler);
         NotificationManager.instance.removeEventListener("REFRESH_SPACE_TIME_HISTORY",refreshSpaceTimeBtnHandler);
         NotificationManager.instance.removeEventListener("DUNGEO_GET_REWARD",refreshDungeonturnHandler);
         NotificationManager.instance.removeEventListener("REFRESH_DUNGEO_RESTNUM",_refreshDungeoHandler);
         NotificationManager.instance.removeEventListener("REFRESH_ELEMENTSILVA_NUM",_refreshForestHandler);
         NotificationManager.instance.removeEventListener("REFRESH_fantasyMatrix_NUM",_refreshFantasyMatrixHandler);
         NotificationManager.instance.removeEventListener("REFRESH_trialTower_RESTNUM",_refreshTrialTowerHandler);
         NotificationManager.instance.removeEventListener("REFRESH_darkKIng_RESTNUM",_refreshDarkKIngHandler);
         NotificationManager.instance.removeEventListener("REFRESH_raceAgainst_RESTNUM",_refreshRaceAgainstHandler);
      }
      
      private function _refreshRaceAgainstHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isRaceAgainstTime)
         {
            _loc3_ = int(playerInfo.raceAgainstTimeMaxCount);
            _loc4_ = _loc3_ - playerInfo.raceAgainstTimeLeftCount;
            _loc2_ = _loc3_ - _loc4_;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _enterTimeTxt.text = _loc2_ + " / " + _loc3_;
            updateIncomebtn();
         }
      }
      
      private function _refreshDarkKIngHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isDarkKing)
         {
            _loc3_ = int(playerInfo.darkKingMaxCount);
            _loc4_ = _loc3_ - playerInfo.darkKIngLeftCount;
            _loc2_ = _loc3_ - _loc4_;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _enterTimeTxt.text = _loc2_ + " / " + _loc3_;
            updateIncomebtn();
         }
      }
      
      private function _refreshTrialTowerHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isTrailTower)
         {
            _loc3_ = int(playerInfo.trialTowerCampaignMaxCount);
            _loc4_ = playerInfo.trialTowerCampaignMaxCount - playerInfo.trialTowerCampaignCount;
            _loc2_ = _loc3_ - _loc4_;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _enterTimeTxt.text = _loc2_ + " / " + _loc3_;
            updateIncomebtn();
         }
      }
      
      private function _refreshFantasyMatrixHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isFantasyMatrix)
         {
            _loc3_ = int(playerInfo.fantasyMatrixMaxNum);
            _loc4_ = _loc3_ - playerInfo.fantasyMatrixRestNum;
            _loc2_ = _loc3_ - _loc4_;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _enterTimeTxt.text = _loc2_ + " / " + _loc3_;
            updateIncomebtn();
         }
      }
      
      private function _refreshForestHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isForest)
         {
            _loc3_ = int(playerInfo.elementSilvaMaxCount);
            _loc4_ = _loc3_ - playerInfo.elementSilvaLeftCount;
            _loc2_ = _loc3_ - _loc4_;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _enterTimeTxt.text = _loc2_ + " / " + _loc3_;
            updateIncomebtn();
         }
      }
      
      private function _refreshDungeoHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isDungeoTurn)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoTurnMaxNum);
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoRestNum);
            _DungeoTurnGetBtn.text = "(" + _loc2_ + "/" + _loc3_ + ")";
         }
      }
      
      private function refreshDungeonturnHandler(param1:Event) : void
      {
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.dungeoHasReward)
         {
            _DungeoTurnGetBtn.enable = false;
         }
      }
      
      private function _refreshSpaceRestNumHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_selectedTemplate && _selectedTemplate.isSpacetimeFault)
         {
            _loc3_ = int(playerInfo.spacetimeRestNum);
            _loc2_ = int(playerInfo.spacetimeMaxNum);
            if(_spaceTimeGetBtn)
            {
               _spaceTimeGetBtn.text = LanguageMgr.GetTranslation("public.numPrecent",_loc3_,_loc2_);
            }
         }
      }
      
      private function refreshSpaceTimeBtnHandler(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc2_:String = PlayerManager.instance.currentPlayerModel.playerInfo.spacetimePassHistory;
         if(_loc2_ != "")
         {
            _loc3_ = _loc2_.split("|");
            if(_loc3_[1] != null && _loc3_[1] != "")
            {
               _spaceTimeGetBtn.enable = true;
            }
            else
            {
               _spaceTimeGetBtn.enable = false;
            }
         }
         else
         {
            _spaceTimeGetBtn.enable = false;
         }
      }
      
      private function _spaceTimeGetHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("spacetimefault",null);
      }
      
      private function _dungeoTurnGetHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungeonturn",3);
      }
      
      private function __mutiCopyCountHandler(param1:Event) : void
      {
         __updateRoomInfoHanlder(null);
         updateIncomebtn();
      }
      
      private function __roomMapChangeHandler(param1:RoomEvent) : void
      {
         MainToolBar.instance.switchToolsBarState(4);
      }
      
      private function __incomeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         if(_cancelBtn && _cancelBtn.visible == true)
         {
            param1.stopImmediatePropagation();
            _loc3_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.btntip");
            if(model.houseOwnerId == selfArmy.userId && _model.roomState == 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.btntip2");
            }
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         _incomeBtn.selected = !_incomeBtn.selected;
         var _loc2_:PlayerInfo = playerInfo;
         var _loc4_:int = int(_loc2_.userId);
         var _loc5_:CampaignArmy = model.getPlayerByUserId(_loc4_);
         if(_loc5_)
         {
            _loc5_.isNoGet = !_incomeBtn.selected;
         }
      }
      
      private function __updateRoomInfoHanlder(param1:RoomEvent) : void
      {
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         _roomNumberTxt.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.roomNumber",_model.id);
         var _loc7_:String = _model.playerCount + " / " + _model.capacity;
         _peopleNumberTxt.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.peopleNumber",_loc7_);
         _selectedTemplate = _model.mapTemplate;
         _difText.text = "";
         _mapIcon.filters = [];
         _enterTimeBg.visible = true;
         _enterTimedes.visible = true;
         _enterTimeTxt.visible = true;
         _spaceTimeGetBtn.visible = false;
         _DungeoTurnGetBtn.visible = false;
         if(_selectedTemplate)
         {
            _loc5_ = int(playerInfo.multiCopyMaxCount);
            _loc11_ = int(playerInfo.multiCopyCount);
            _incomeBtn.visible = true;
            _areaNameTxt.text = _selectedTemplate.CampaignName;
            if(_selectedTemplate.SonTypes != 0)
            {
               if(_selectedTemplate.isBloodyPandemoniue)
               {
                  _loc12_ = int(playerInfo.randomBossMaxCount);
                  _loc8_ = _loc12_ - playerInfo.randomBossCount;
               }
               else if(_selectedTemplate.isSpacetimeFault)
               {
                  _incomeBtn.visible = false;
                  _enterTimeBg.visible = false;
                  _enterTimedes.visible = false;
                  _enterTimeTxt.visible = false;
                  _spaceTimeGetBtn.visible = true;
                  addChild(_spaceTimeGetBtn);
                  _refreshSpaceRestNumHandler(null);
                  refreshSpaceTimeBtnHandler(null);
                  RoomManager.instance.requestSpacetimeInfo(1);
               }
               else if(_selectedTemplate.isMolongCampaign)
               {
                  _loc12_ = int(playerInfo.molongMaxNum);
                  _loc8_ = _loc12_ - playerInfo.molongRestNum;
               }
               else if(_selectedTemplate.isNaLan)
               {
                  _loc12_ = _loc6_ = int(playerInfo.teamMaxCount);
                  _loc8_ = _loc12_ - playerInfo.teamCount;
               }
               else if(_selectedTemplate.isTaila)
               {
                  _loc12_ = _loc13_ = int(playerInfo.tailaMaxCount);
                  _loc8_ = _loc12_ - playerInfo.tailaCount;
               }
               else if(_selectedTemplate.isWasteCampaign)
               {
                  _loc12_ = _loc14_ = int(playerInfo.wasteMaxCount);
                  _loc8_ = _loc12_ - playerInfo.wasteCount;
               }
               else if(_selectedTemplate.isSacristyCampaign)
               {
                  _loc2_ = int(playerInfo.petPveMaxCount);
                  _loc12_ = _loc2_;
                  _loc8_ = _loc12_ - playerInfo.petPveCount;
               }
               else if(_selectedTemplate.isFantasyMatrix)
               {
                  _loc3_ = int(playerInfo.fantasyMatrixMaxNum);
                  _loc12_ = _loc3_;
                  _loc8_ = _loc12_ - playerInfo.fantasyMatrixRestNum;
               }
               else if(_selectedTemplate.isChildWarCampaign)
               {
                  _loc12_ = _loc4_ = int(playerInfo.childWarMaxCount);
                  _loc8_ = _loc12_ - playerInfo.childWarCount;
                  _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text" + _selectedTemplate.DifficultyGrade * 2);
               }
               else if(_selectedTemplate.isTrailTower)
               {
                  _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text" + _selectedTemplate.DifficultyGrade * 2);
                  _loc12_ = int(playerInfo.trialTowerCampaignMaxCount);
                  _loc8_ = playerInfo.trialTowerCampaignMaxCount - playerInfo.trialTowerCampaignCount;
               }
               else if(_selectedTemplate.isDungeoTurn)
               {
                  _incomeBtn.visible = false;
                  _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoTurnMaxNum);
                  _loc11_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoRestNum);
                  _DungeoTurnGetBtn.visible = true;
                  if(!PlayerManager.instance.currentPlayerModel.playerInfo.dungeoHasReward)
                  {
                     _DungeoTurnGetBtn.enable = false;
                  }
                  _DungeoTurnGetBtn.text = "(" + _loc11_ + "/" + _loc5_ + ")";
                  addChild(_DungeoTurnGetBtn);
                  DungeoTurnManager.instance.model.fighting = false;
                  DungeoTurnManager.instance.model.canDispose = true;
                  DungeoTurnManager.instance.model.currentIndex = 0;
                  DungeoTurnManager.instance.model.rollNum = 0;
                  DungeoTurnManager.instance.model.hadPlayBossBoxLevelUp = false;
                  DungeoTurnManager.instance.model.hadPlayNormalBoxLevelUp = false;
               }
               else if(_selectedTemplate.isDeepPrison)
               {
                  _loc12_ = _loc10_ = int(playerInfo.deepPrisonMaxCount);
                  _loc8_ = _loc12_ - playerInfo.deepPrisonCount;
                  _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text" + _selectedTemplate.DifficultyGrade * 2);
               }
               else if(_selectedTemplate.isDarkKing)
               {
                  _loc12_ = int(playerInfo.darkKingMaxCount);
                  _loc8_ = _loc12_ - playerInfo.darkKIngLeftCount;
               }
               else if(_selectedTemplate.isRaceAgainstTime)
               {
                  _loc12_ = int(playerInfo.raceAgainstTimeMaxCount);
                  _loc8_ = _loc12_ - playerInfo.raceAgainstTimeLeftCount;
               }
               else if(_selectedTemplate.isForest)
               {
                  _loc12_ = int(playerInfo.elementSilvaMaxCount);
                  _loc8_ = _loc12_ - playerInfo.elementSilvaLeftCount;
               }
               else if(_selectedTemplate.isSkyStepCampaign)
               {
                  _loc12_ = _loc9_ = int(playerInfo.skyStepMaxCount);
                  _loc8_ = _loc12_ - playerInfo.skyStepCount;
               }
               _loc11_ = _loc12_ - _loc8_;
               if(_loc11_ < 0)
               {
                  _loc11_ = 0;
               }
               _enterTimeTxt.text = _loc11_ + " / " + _loc12_;
               _optimzeText.text = "";
               _optimzeValueText.text = "";
               crossNeedPowerText.visible = false;
            }
            else
            {
               checkOptimizeProfile(_selectedTemplate.CampaignId);
               crossNeedPowerText.visible = true;
               if(_loc11_ < 0)
               {
                  _loc11_ = 0;
               }
               _enterTimeTxt.text = _loc11_ + " / " + _loc5_;
               crossNeedPowerText.text = LanguageMgr.GetTranslation("roompve.roomRight.crossNeedPowerText.text",_selectedTemplate.NeedFightPower);
            }
            _goods.visible = true;
            _goods["data"] = _selectedTemplate.Item;
            if(_mapIcon.icon != PathManager.mapInstanceBigIconPath(_selectedTemplate.AreaId))
            {
               _mapIcon.icon = PathManager.mapInstanceBigIconPath(_selectedTemplate.AreaId);
               _iconBackMc.gotoAndStop(_selectedTemplate.DifficultyGrade);
               if(_selectedTemplate.DifficultyGrade != 1)
               {
                  _mapIcon.filters = [UIFilter.getRoomIconFilter()];
               }
            }
            if(_selectedTemplate.NeedFourTransfer)
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text6");
            }
            else if(_selectedTemplate.NeedThirdTransfer)
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text5");
            }
            else if(_selectedTemplate.NeedChangeJob)
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text4");
            }
            else if(_selectedTemplate.NeedTransfer)
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text1");
            }
            else if(_selectedTemplate.MinLevel == 80)
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text3",_selectedTemplate.MinLevel);
            }
            else
            {
               recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text2",_selectedTemplate.MinLevel,_selectedTemplate.MaxLevel);
            }
            if(_preMapTempId != _selectedTemplate.CampaignId)
            {
               this.updateIncomebtn();
            }
            _preMapTempId = _model.mapTemplate.CampaignId;
         }
         else
         {
            _goods.visible = false;
            _goods["data"] = null;
            _mapIcon.icon = null;
            _optimzeText.text = "";
            _optimzeValueText.text = "";
            crossNeedPowerText.visible = false;
            _enterTimeTxt.text = playerInfo.multiCopyCount + " / " + playerInfo.multiCopyMaxCount;
            recommendGrades.text = "";
            _areaNameTxt.text = "";
            _iconBackMc.gotoAndStop(1);
         }
         if(_model.roomState == 2)
         {
            __startTime();
            _inviteBtn.enable = false;
            _sortBtn.enable = false;
            _quickStartBtn.enable = false;
            MainToolBar.instance.switchToolsBarState(3);
            ResourcesBar.instance.armyBtnEnable(false);
         }
         else
         {
            __stopTime();
            _inviteBtn.enable = true;
            _sortBtn.enable = true;
            _quickStartBtn.enable = true;
            MainToolBar.instance.switchToolsBarState(4);
            ResourcesBar.instance.armyBtnEnable(true);
         }
         if(model.houseOwnerId == selfArmy.userId)
         {
            setHouseOwnerView();
         }
         else
         {
            setNormalView();
         }
         __updateSelectBtnState(_selectedTemplate);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
      }
      
      private function __startTime() : void
      {
         _timeBG.visible = true;
         _timeFont.visible = true;
         _timeTxt.visible = true;
         _timeTxt.text = "00:00";
         _timeNumber = 0;
         _timer.reset();
         _timer.start();
      }
      
      private function __stopTime() : void
      {
         _timeBG.visible = false;
         _timeFont.visible = false;
         _timeTxt.visible = false;
         _timer.stop();
      }
      
      private function setNormalView() : void
      {
         _selectSprite.mouseChildren = _selectSprite.mouseEnabled = false;
         _startBtn.visible = false;
         _startStripView.visible = false;
         _lockBtn.enable = false;
         _quickStartBtn.enable = false;
         _lockBtn.selected = !!_model.password;
         var _loc1_:CampaignArmy = _model.getPlayerByUserId(selfArmy.userId,"");
         if(_loc1_ && _loc1_.roomState == 0)
         {
            _readyBtn.enable = _readyBtn.visible = true;
            _cancelBtn.visible = false;
         }
         else
         {
            _readyBtn.visible = false;
            _cancelBtn.enable = _cancelBtn.visible = true;
         }
         if(_model.roomState == 2)
         {
         }
      }
      
      private function setHouseOwnerView() : void
      {
         _lockBtn.selected = !!_model.password;
         _readyBtn.visible = false;
         _cancelBtn.visible = false;
         _startStripView.visible = true;
         _startBtn.visible = true;
         _startBtn.enable = _model.allPlayerReader;
         _lockBtn.enable = true;
         if(_model.roomState == 2)
         {
            _startBtn.visible = false;
            _lockBtn.enable = false;
            _cancelBtn.enable = _cancelBtn.visible = true;
            _selectSprite.mouseChildren = _selectSprite.mouseEnabled = false;
         }
         else
         {
            _selectSprite.mouseChildren = _selectSprite.mouseEnabled = true;
         }
         if(_selectedTemplate && _selectedTemplate.SonTypes != 0)
         {
            _startBtn.enable = false;
         }
      }
      
      private function _quitClick(param1:MouseEvent) : void
      {
         CampaignSocketOutManager.instance.sendReturnCampaignRoom(selfArmy.id);
      }
      
      private function __lockHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _lockBtn.selected = !!_model.password;
         var _loc2_:RoomPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
         _loc2_.backCall = passwordInputBack;
         _loc2_.show(_model.id);
      }
      
      private function passwordInputBack(param1:int, param2:String) : void
      {
         RoomSocketOuterManager.sendLockCampaignRoom(param1,param2);
      }
      
      private function _startClick(param1:MouseEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("016",true);
         if(param1.currentTarget is IconButton && param1.currentTarget.stylename == "room.roomRight.quickStartBtn")
         {
            isCross = false;
         }
         else if(param1.currentTarget is MovieButtonII && param1.currentTarget.stylename == "room.roomRight.crossPveStartBtn")
         {
            isCross = true;
            _loc4_ = getTimer();
            if(_loc4_ - _preClickTime < 2000)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
               return;
            }
            _preClickTime = _loc4_;
         }
         if(!model)
         {
            return;
         }
         if(model.roomType == 0 && model.campaignId == 0)
         {
            __selectInstance(null);
            return;
         }
         if(!model.mapTemplate)
         {
            return;
         }
         if(!ChildManager.instance.model.getEnterWar() && Boolean(model.mapTemplate.isChildWarCampaign))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command09"));
            return;
         }
         if(!isCross && model.playerCount == 1)
         {
            _loc6_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.content");
            if(model.mapTemplate.EnterNumb > 1)
            {
               _loc6_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.content.newTxt1",model.mapTemplate.CampaignName,model.mapTemplate.EnterNumb);
               MessageTipManager.instance().show(_loc6_);
               return;
            }
            _loc6_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.content.newTxt",model.mapTemplate.CampaignName);
            SimpleAlertHelper.instance.data = [__alertResponse];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,false,true);
         }
         else
         {
            if(showThewAlert(startAlertBack))
            {
               return;
            }
            LayerManager.Instance.clearnGameDynamic();
            RoomSocketOuterManager.sendStartCampaignScene(_model.campaignId,0,null,getIsNoGet(),isCross);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(_model && param1 && _model.allPlayerReader)
         {
            if(showThewAlert(startAlertBack))
            {
               return;
            }
            RoomSocketOuterManager.sendStartCampaignScene(_model.campaignId,0,null,getIsNoGet());
         }
      }
      
      private function showThewAlert(param1:Function = null) : Boolean
      {
         var _loc8_:String = null;
         var _loc9_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc6_:Boolean = false;
         if(!_model || !_model.mapTemplate)
         {
            return true;
         }
         if(_model.mapTemplate.isTrailTower)
         {
            _loc6_ = Boolean(playerInfo.isTrailOverMaxCount);
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist09");
         }
         else if(_model.mapTemplate.isBloodyPandemoniue)
         {
            _loc6_ = bloodyIsOver;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist10");
         }
         else if(_model.mapTemplate.isMolongCampaign)
         {
            _loc6_ = playerInfo.molongRestNum <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist11");
         }
         else if(_model.mapTemplate.isNaLan)
         {
            _loc6_ = playerInfo.teamCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist12");
         }
         else if(_model.mapTemplate.isTaila)
         {
            _loc6_ = playerInfo.tailaCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist13");
         }
         else if(_model.mapTemplate.isWasteCampaign)
         {
            _loc6_ = playerInfo.wasteCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist14");
         }
         else if(_model.mapTemplate.isFantasyMatrix)
         {
            _loc6_ = playerInfo.fantasyMatrixRestNum <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist15");
         }
         else if(_model.mapTemplate.isChildWarCampaign)
         {
            _loc6_ = playerInfo.childWarCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist16");
         }
         else if(_model.mapTemplate.isSacristyCampaign)
         {
            _loc6_ = playerInfo.petPveCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist17");
         }
         else if(_model.mapTemplate.isSpacetimeFault)
         {
            _loc6_ = playerInfo.spacetimeRestNum <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist18");
         }
         else if(_model.mapTemplate.isDungeoTurn)
         {
            _loc6_ = playerInfo.dungeoRestNum <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist19");
         }
         else if(_model.mapTemplate.isDeepPrison)
         {
            _loc6_ = playerInfo.deepPrisonCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist20");
         }
         else if(_model.mapTemplate.isDarkKing)
         {
            _loc6_ = playerInfo.darkKIngLeftCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist21");
         }
         else if(_model.mapTemplate.isRaceAgainstTime)
         {
            _loc6_ = playerInfo.raceAgainstTimeLeftCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist22");
         }
         else if(_model.mapTemplate.isForest)
         {
            _loc6_ = playerInfo.elementSilvaLeftCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist23");
         }
         else if(_model.mapTemplate.isSkyStepCampaign)
         {
            _loc6_ = playerInfo.skyStepCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist24");
         }
         else
         {
            _loc6_ = playerInfo.multiCopyCount <= 0 ? true : false;
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist01");
         }
         var _loc4_:Date = SharedManager.instance.thewCheckDate;
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         var _loc7_:Boolean = Boolean(SharedManager.instance.thewCheck);
         if(!_loc7_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc6_ && _loc2_)
         {
            _loc9_ = ComponentFactory.Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc9_.containerY = 18;
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc9_.show(_loc8_,_loc3_,param1);
         }
         return _loc6_ && _loc2_;
      }
      
      public function get bloodyIsOver() : Boolean
      {
         return playerInfo.randomBossCount <= 0;
      }
      
      private function startAlertBack(param1:Boolean) : void
      {
         if(!model)
         {
            return;
         }
         readState(param1);
         if(!_incomeBtn)
         {
            return;
         }
         if(!_model.mapTemplate)
         {
            return;
         }
         RoomSocketOuterManager.sendStartCampaignScene(_model.campaignId,0,null,getIsNoGet(),isCross);
      }
      
      private function readState(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
      }
      
      private function readyAlertBack(param1:Boolean) : void
      {
         readState(param1);
         sendPlayerReady();
      }
      
      private function trailAlertBack(param1:Boolean) : void
      {
         readState(param1);
         sendPlayerReady();
      }
      
      private function getIsNoGet() : Boolean
      {
         var _loc1_:Boolean = !_incomeBtn.selected;
         var _loc2_:CampaignArmy = model.getPlayerByUserId(selfArmy.userId);
         if(_loc2_)
         {
            _loc2_.isNoGet = _loc1_;
         }
         if(_model.mapTemplate && _model.mapTemplate.isTrailTower)
         {
            if(playerInfo.isTrailOverMaxCount)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isBloodyPandemoniue)
         {
            if(bloodyIsOver)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isMolongCampaign)
         {
            if(playerInfo.molongRestNum <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isFantasyMatrix)
         {
            if(playerInfo.fantasyMatrixRestNum <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isNaLan)
         {
            if(playerInfo.teamCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isTaila)
         {
            if(playerInfo.tailaCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isWasteCampaign)
         {
            if(playerInfo.wasteCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isChildWarCampaign)
         {
            if(playerInfo.childWarCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isDungeoTurn)
         {
            if(playerInfo.dungeoRestNum <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isDeepPrison)
         {
            if(playerInfo.deepPrisonCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isDarkKing)
         {
            if(playerInfo.darkKIngLeftCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isRaceAgainstTime)
         {
            if(playerInfo.raceAgainstTimeLeftCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isForest)
         {
            if(playerInfo.elementSilvaLeftCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(_model.mapTemplate && _model.mapTemplate.isSkyStepCampaign)
         {
            if(playerInfo.skyStepCount <= 0)
            {
               _loc1_ = false;
            }
         }
         else if(playerInfo.multiCopyCount <= 0)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      private function get selfArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function _inviteClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!RoomManager.instance.roomInfo.existEmptyPos())
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:RoomInviteFrame = ComponentFactory.Instance.creatComponentByStylename("room.RoomInviteFrame");
         _loc3_.show();
      }
      
      private function __teamSortClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_selectedTemplate && _selectedTemplate.isDeepPrison)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.pve.sortTips"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("teammanager");
      }
      
      private function __readyClick(param1:MouseEvent) : void
      {
         var _loc4_:CampaignChapterInfo = null;
         var _loc3_:CampaignAreaInfo = null;
         var _loc8_:RankInfo = null;
         var _loc5_:RankInfo = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:String = "";
         if(!model.mapTemplate)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.houseOwnerId != thane.userId && model.mapTemplate.MinLevel > thane.grades)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(thane.vocationGrades <= 0 && Boolean(model.mapTemplate.NeedTransfer))
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command07");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!thane.isChangeJob && model.mapTemplate.NeedChangeJob)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command08");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!thane.isAvenger && model.mapTemplate.NeedThirdTransfer)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command10");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!thane.isHoly && Boolean(model.mapTemplate.NeedFourTransfer))
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command11");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!ChildManager.instance.model.getEnterWar() && Boolean(model.mapTemplate.isChildWarCampaign))
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command09");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_selectedTemplate.SonTypes == 0)
         {
            checkOptimizeProfile(_selectedTemplate.CampaignId);
         }
         var _loc10_:Dictionary = CampaignRankManager.instance.rankDic;
         var _loc7_:CampaignLandInfo = CampaignTemplateManager.instance.landDic[0] as CampaignLandInfo;
         if(_loc7_)
         {
            _loc4_ = _loc7_.getChapterById(_selectedTemplate.DungeonId);
         }
         if(_loc4_)
         {
            _loc3_ = _loc4_.getAreaInfoById(_selectedTemplate.AreaId);
         }
         if(model.mapTemplate.isBloodyPandemoniue)
         {
            _loc9_ = int(_selectedTemplate.MinLevel);
            _loc6_ = int(_selectedTemplate.MaxLevel);
            if(ArmyManager.instance.thane.grades > _loc6_ || ArmyManager.instance.thane.grades < _loc9_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command05"));
               return;
            }
         }
         else
         {
            if(_loc3_)
            {
               _loc8_ = _loc10_[_loc3_.getMapByDifficult(1).CampaignId];
               if(_loc3_.getMapByDifficult(2))
               {
                  _loc5_ = _loc10_[_loc3_.getMapByDifficult(2).CampaignId];
               }
            }
            if(model.houseOwnerId != thane.userId && !_loc8_ && _selectedTemplate.DifficultyGrade == 2)
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command04");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(model.houseOwnerId != thane.userId && !_loc5_ && _selectedTemplate.DifficultyGrade == 3)
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command06");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         if(showThewAlert(readyAlertBack))
         {
            return;
         }
         sendPlayerReady();
      }
      
      private function sendPlayerReady() : void
      {
         SoundManager.instance.play("016",true);
         if(!model)
         {
            return;
         }
         SoundManager.instance.play("016",true);
         RoomSocketOuterManager.sendPlayerState(1,getIsNoGet());
         MainToolBar.instance.switchToolsBarState(3);
         LayerManager.Instance.clearnGameDynamic();
         _readyBtn.enable = false;
      }
      
      private function _cancelClick(param1:MouseEvent) : void
      {
         if(_model.houseOwnerId == thane.userId)
         {
            RoomSocketOuterManager.sendRoomState(1);
         }
         else
         {
            RoomSocketOuterManager.sendPlayerState(0);
         }
         MainToolBar.instance.switchToolsBarState(4);
         _cancelBtn.enable = false;
         _startStripView.visible = true;
         _startBtn.visible = true;
         _startBtn.enable = true;
         _cancelBtn.visible = false;
      }
      
      private function __selectInstance(param1:MouseEvent) : void
      {
         SoundManager.instance.play("018",true);
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         RoomManager.instance.controller.openMultiCampaignSelectFrame(_model);
      }
      
      private function __updateSelectBtnState(param1:CampaignTemplate) : void
      {
         if(model.houseOwnerId != playerInfo.userId)
         {
            _selectInstanceBtn.visible = false;
            return;
         }
         if(param1)
         {
            __selectSpriteOut(null);
         }
         else
         {
            __selectSpriteOver(null);
         }
      }
      
      private function __selectSpriteOver(param1:MouseEvent) : void
      {
         if(model.houseOwnerId == playerInfo.userId)
         {
            _selectInstanceBtn.visible = true;
            _selectInstanceBtn.setFrame(2);
         }
      }
      
      private function __selectSpriteOut(param1:MouseEvent) : void
      {
         if(_model.mapTemplate)
         {
            _selectInstanceBtn.visible = false;
         }
         else
         {
            _selectInstanceBtn.setFrame(1);
         }
      }
      
      private function checkOptimizeProfile(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         _optimzeText.text = LanguageMgr.GetTranslation("InstanceRightView.optimzeText.text");
         _optimzeValueText.text = gradeTextARR[0];
         for each(var _loc3_:RankInfo in rankInfoList)
         {
            if(_loc3_.campaignId == param1)
            {
               _optimzeValueText.text = gradeTextARR[_loc3_.rank];
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function get rankInfoList() : SimpleDictionary
      {
         return CampaignRankManager.instance.rankDic;
      }
      
      public function set model(param1:RoomInfo) : void
      {
         if(_model)
         {
            _model.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
            _model.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomInfoHanlder);
            _model.removeEventListener("UPDATE_ROOM_MAP",__roomMapChangeHandler);
            _model.removeEventListener("room_HouseOwner_change",__roomMapChangeHandler);
         }
         _model = param1;
         _model.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         _model.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomInfoHanlder);
         _model.addEventListener("UPDATE_ROOM_MAP",__roomMapChangeHandler);
         _model.addEventListener("room_HouseOwner_change",__roomMapChangeHandler);
         updateIncomebtn();
         __updateRoomInfoHanlder(null);
      }
      
      private function updateIncomebtn() : void
      {
         var _loc2_:Boolean = false;
         if(!(model && _incomeBtn))
         {
            return;
         }
         var _loc1_:PlayerInfo = playerInfo;
         var _loc3_:int = int(_loc1_.userId);
         var _loc5_:CampaignArmy = model.getPlayerByUserId(_loc3_);
         var _loc4_:* = true;
         _incomeBtn.enable = true;
         if(_model.mapTemplate && _loc5_)
         {
            _loc4_ = !_loc5_.isNoGet;
            if(_model.mapTemplate.isTrailTower)
            {
               _loc2_ = Boolean(playerInfo.isTrailOverMaxCount);
            }
            else if(_model.mapTemplate.isBloodyPandemoniue)
            {
               _loc2_ = bloodyIsOver;
            }
            else if(_model.mapTemplate.isMolongCampaign)
            {
               _loc2_ = playerInfo.molongRestNum <= 0;
            }
            else if(_model.mapTemplate.isFantasyMatrix)
            {
               _loc2_ = playerInfo.fantasyMatrixRestNum <= 0;
            }
            else if(_model.mapTemplate.isNaLan)
            {
               _loc2_ = playerInfo.teamCount <= 0;
            }
            else if(_model.mapTemplate.isTaila)
            {
               _loc2_ = playerInfo.tailaCount <= 0;
            }
            else if(_model.mapTemplate.isWasteCampaign)
            {
               _loc2_ = playerInfo.wasteCount <= 0;
            }
            else if(_model.mapTemplate.isSacristyCampaign)
            {
               _loc2_ = playerInfo.petPveCount <= 0;
            }
            else if(_model.mapTemplate.isChildWarCampaign)
            {
               _loc2_ = playerInfo.childWarCount <= 0;
            }
            else if(_model.mapTemplate.isDungeoTurn)
            {
               _loc2_ = playerInfo.dungeoRestNum <= 0;
            }
            else if(_model.mapTemplate.isDeepPrison)
            {
               _loc2_ = playerInfo.deepPrisonCount <= 0;
            }
            else if(_model.mapTemplate.isDarkKing)
            {
               _loc2_ = playerInfo.darkKIngLeftCount <= 0;
            }
            else if(_model.mapTemplate.isRaceAgainstTime)
            {
               _loc2_ = playerInfo.raceAgainstTimeLeftCount <= 0;
            }
            else if(_model.mapTemplate.isForest)
            {
               _loc2_ = playerInfo.elementSilvaLeftCount <= 0;
            }
            else if(_model.mapTemplate.isSkyStepCampaign)
            {
               _loc2_ = playerInfo.skyStepCount <= 0;
            }
            else
            {
               _loc2_ = playerInfo.multiCopyCount <= 0 ? true : false;
            }
            if(_loc2_)
            {
               _loc4_ = false;
               _incomeBtn.enable = false;
            }
         }
         else
         {
            _loc4_ = _incomeBtn.enable = false;
         }
         _incomeBtn.selected = _loc4_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get model() : RoomInfo
      {
         return _model;
      }
      
      public function get selectInstanceBtn() : BaseButton
      {
         return _selectInstanceBtn;
      }
      
      public function get startBtn() : MovieButtonII
      {
         return _startBtn;
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvents();
         if(_mapIcon)
         {
            _mapIcon.dispose();
         }
         _mapIcon = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_startBtn)
         {
            ObjectUtils.disposeObject(_startBtn);
         }
         _startBtn = null;
         if(_inviteBtn)
         {
            ObjectUtils.disposeObject(_inviteBtn);
         }
         _inviteBtn = null;
         if(_sortBtn)
         {
            ObjectUtils.disposeObject(_sortBtn);
         }
         _sortBtn = null;
         if(_readyBtn)
         {
            ObjectUtils.disposeObject(_readyBtn);
         }
         _readyBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         if(_roomNumberTxt)
         {
            ObjectUtils.disposeObject(_roomNumberTxt);
         }
         _roomNumberTxt = null;
         if(_peopleNumberTxt)
         {
            ObjectUtils.disposeObject(_peopleNumberTxt);
         }
         _peopleNumberTxt = null;
         if(_goods)
         {
            ObjectUtils.disposeObject(_goods);
         }
         _goods = null;
         if(_selectSprite)
         {
            ObjectUtils.disposeObject(_selectSprite);
         }
         _selectSprite = null;
         if(_selectInstanceBtn)
         {
            ObjectUtils.disposeObject(_selectInstanceBtn);
         }
         _selectInstanceBtn = null;
         if(_iconBackMc)
         {
            ObjectUtils.disposeObject(_iconBackMc);
         }
         _iconBackMc = null;
         if(_buttonLine)
         {
            ObjectUtils.disposeObject(_buttonLine);
         }
         _buttonLine = null;
         if(_quickStartBtn)
         {
            ObjectUtils.disposeObject(_quickStartBtn);
         }
         _quickStartBtn = null;
         if(_startStripView)
         {
            ObjectUtils.disposeObject(_startStripView);
         }
         _startStripView = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         if(_timeBG)
         {
            ObjectUtils.disposeObject(_timeBG);
         }
         _timeBG = null;
         if(_timeFont)
         {
            ObjectUtils.disposeObject(_timeFont);
         }
         _timeFont = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(crossNeedPowerText)
         {
            ObjectUtils.disposeObject(crossNeedPowerText);
         }
         crossNeedPowerText = null;
         if(recommendGrades)
         {
            ObjectUtils.disposeObject(recommendGrades);
         }
         recommendGrades = null;
         if(_areaNameTxt)
         {
            ObjectUtils.disposeObject(_areaNameTxt);
         }
         _areaNameTxt = null;
         if(_optimzeText)
         {
            ObjectUtils.disposeObject(_optimzeText);
         }
         _optimzeText = null;
         if(_optimzeValueText)
         {
            ObjectUtils.disposeObject(_optimzeValueText);
         }
         _optimzeValueText = null;
         if(_difText)
         {
            ObjectUtils.disposeObject(_difText);
         }
         _difText = null;
         ObjectUtils.disposeObject(_spaceTimeGetBtn);
         _spaceTimeGetBtn = null;
         _model = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         MainToolBar.instance.switchToolsBarState(4);
      }
   }
}

