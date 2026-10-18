package chat.view
{
   import bag.helper.GoodsCheck;
   import battle.chat.BattleChatController;
   import chat.ChatManager;
   import chat.ChatModel;
   import chat.datas.ChatCellData;
   import chat.datas.ChatData;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.FishManager;
   import managers.FreedomTeamManager;
   import managers.GameHallManager;
   import managers.GoldRoadManager;
   import managers.GroupfbManager;
   import managers.MarryManager;
   import managers.MopupManager;
   import managers.SaleManager;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import mvc.controler.NewYearActController;
   import mvc.module.card.MagicCardInfo;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.groupfb.GroupfbSender;
   import mvc.module.marry.MarryCampaignInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.room.RoomInfo;
   import mvc.module.star.StarInfo;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.AlchemicalManager;
   import yishi.manager.ApexManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoomListSocketOutManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.BaseTip;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.goods.ChatEquipTips;
   import yishi.view.tips.goods.ChatFashionTips;
   import yishi.view.tips.goods.ChatMonsterAccesoriesTips;
   import yishi.view.tips.goods.ChatStarTip;
   import yishi.view.tips.goods.MountCardTip;
   import yishi.view.tips.goods.PropTips;
   import yishi.view.tips.goods.RuneTip;
   
   public class ChatOutputViewII extends Sprite implements IManualSize
   {
      
      private static var _intervalTime:Number = 0;
      
      private var _rectangle:Rectangle = new Rectangle(0,0,325,150);
      
      protected var _hBox:HBox;
      
      private var _back:ScaleBitmapImage;
      
      private var _chatList:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _allBtn:SelectedCheckButton;
      
      private var _worldBtn:SelectedCheckButton;
      
      private var _outyardBtn:SelectedCheckButton;
      
      private var _teamBtn:SelectedCheckButton;
      
      private var _consortiaBtn:SelectedCheckButton;
      
      private var _infoBtn:SelectedCheckButton;
      
      private var _toBottomBtn:BaseButton;
      
      private var _buttonMc:MovieClip;
      
      private var _cleanBtn:BaseButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _proptip:BaseTip;
      
      private var _starstip:ChatStarTip;
      
      private var _goodstip:ChatEquipTips;
      
      private var _fashiontip:ChatFashionTips;
      
      private var _monstertip:ChatMonsterAccesoriesTips;
      
      private var _btnDic:Dictionary;
      
      private var _btnArr:Array;
      
      private var _lastClickTime:int = 0;
      
      private var _roomKey:String;
      
      private var _menu:ChatItemMenu;
      
      public function ChatOutputViewII()
      {
         super();
         initView();
         showMinView();
         initEvent();
         _buttonGroup.selectIndex = 0;
         mouseEnabled = false;
         _chatList.mouseEnabled = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rectangle;
      }
      
      private function initView() : void
      {
         _btnDic = new Dictionary();
         _vBox = new VBox();
         _vBox.spacing = 0;
         _vBox.mouseEnabled = false;
         _chatList = ComponentFactory.Instance.creatComponentByStylename("chat.ChatList");
         _chatList.setView(_vBox,true);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputChannelBox");
         _back = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputBack");
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputAllBtn");
         _worldBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputWorldBtn");
         _outyardBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputOutyardBtn");
         _teamBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputTeamBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputConsortiaBtn");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputInfoBtn");
         _toBottomBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputToBottomBtn");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.BattlechatClean");
         _buttonMc = ComponentFactory.Instance.creatCustomObject("chatII.DownShineEffect");
         _buttonMc.gotoAndStop(1);
         _buttonMc["pos"].addChild(_toBottomBtn);
         _toBottomBtn.tipData = LanguageMgr.GetTranslation("chatII.view.ChatOutputViewII.toBottomBtn.tip");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command02");
         _back.mouseEnabled = false;
         addChild(_back);
         addChild(_chatList);
         addChild(_hBox);
         _btnDic[0] = _allBtn;
         _btnDic[10] = _worldBtn;
         _btnDic[109] = _outyardBtn;
         _btnDic[6] = _teamBtn;
         _btnDic[5] = _consortiaBtn;
         _btnDic[3] = _infoBtn;
         addChild(_buttonMc);
         addChild(_cleanBtn);
         _cleanBtn.visible = false;
         _allBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.AllChannel");
         _worldBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.WorldChannel");
         _outyardBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.OutyardChannel");
         _teamBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.TeamChannel");
         _consortiaBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.consortiaChannel");
         _infoBtn.text = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.InfoChannel");
         _buttonGroup = new SelectedButtonGroup();
      }
      
      private function initEvent() : void
      {
         _buttonGroup.addEventListener("change",__selectedChannelChangeHandler);
         _toBottomBtn.addEventListener("click",__clickHandler);
         _cleanBtn.addEventListener("click",__cleanHandler);
         _chatList.viewPort.addStateListener(__onViewportStateChanged);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__updateChatViewHandler);
         NotificationManager.instance.addEventListener("OUTPUT_CHANNEL_CHANGE",__channelChangeHandler);
         NotificationManager.instance.addEventListener("CHANNEL_CLICK",__channelClickHandler);
         NotificationManager.instance.addEventListener("PLAYER_NAME_CLICK",__playerNameClickHandler);
         NotificationManager.instance.addEventListener("CONSORTIA_CLICK",__consortiaClickHandler);
         NotificationManager.instance.addEventListener("ROOM_CLICK",__roomClickHandler);
         NotificationManager.instance.addEventListener("STAR_CLICK",__starClickHandler);
         NotificationManager.instance.addEventListener("EQUIP_CLICK",__equipClickHandler);
         NotificationManager.instance.addEventListener("PROP_CLICK",__propClickHandler);
         NotificationManager.instance.addEventListener("VIP_LINK_CLICK",__vipLinkClickHandler);
         NotificationManager.instance.addEventListener("APPELL_LINK_CLICK",__appellLinkClickHandler);
         NotificationManager.instance.addEventListener("ROSE_BACK_CLICK",__roseBackClickHandler);
         NotificationManager.instance.addEventListener("REINFORCE_CLICK",__reinforceClickHandler);
         NotificationManager.instance.addEventListener("SEEK_LINK_CLICK",__seekLinkClickHandler);
         NotificationManager.instance.addEventListener("CARD_CLICK",__cardClickHandler);
         NotificationManager.instance.addEventListener("FISH_CLICK",__fishClickHandler);
         NotificationManager.instance.addEventListener("GOLDROAD_CLICK",__goldRoadClickHandler);
         NotificationManager.instance.addEventListener("CARD_BACK_CLICK",__cardBackClickHandler);
         NotificationManager.instance.addEventListener("OUTER_CITY_BOSS_CLICK",onOuterCityBossClick);
         NotificationManager.instance.addEventListener("PLANES_DEAD_HELP_CLICK",__planesDeadHelpClick);
         NotificationManager.instance.addEventListener("OPEN_SALE_CLICK",__openSaleClick);
         NotificationManager.instance.addEventListener("OUTYARD_CHANNEL_CHANGE",__outyardChannelHandler);
         NotificationManager.instance.addEventListener("OPEN_TREASURE_CLICK",__openTreasureClick);
         NotificationManager.instance.addEventListener("SHARE_SPACE_TIME_CLICK",__openShareTimeClick);
         NotificationManager.instance.addEventListener("ALCHEMICAL_INVITE_CLICK",__alchemicalInviteClick);
         NotificationManager.instance.addEventListener("GODS_EVENING_GOTO",__godsEvenignGotoHandler);
         NotificationManager.instance.addEventListener("CRISIS_ATTACK_INVATE_CLICK",__crisisAttackInavteHandler);
         NotificationManager.instance.addEventListener("GAME_HALLK_INVATE_CLICK",__gameHallInavteHandler);
         NotificationManager.instance.addEventListener("APEX_TEAM_INVATE_CLICK",__apexTeamInvateHandler);
         NotificationManager.instance.addEventListener("CONSORTIA_NEW_BOSS_CLICK",_consortiaNewBossHandler);
         __outyardChannelHandler(null);
      }
      
      private function __openShareTimeClick(param1:NotificationEvent) : void
      {
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         if(_loc2_)
         {
            FrameControllerManager.instance.openControllerByInfo("spacetimefault",1,[_loc2_.nickName,_loc2_.data]);
         }
      }
      
      private function __alchemicalInviteClick(param1:NotificationEvent) : void
      {
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         if(_loc2_)
         {
            AlchemicalManager.instance.sendAlchemicalSharedByChat(_loc2_.userType);
         }
      }
      
      private function __outyardChannelHandler(param1:NotificationEvent) : void
      {
         var _loc2_:* = null;
         _hBox.removeAllChild();
         _buttonGroup.removeAllItem();
         if(!FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            _btnArr = [_allBtn,_worldBtn,_teamBtn,_consortiaBtn,_infoBtn];
            for each(_loc2_ in _btnArr)
            {
               _hBox.addChild(_loc2_);
            }
            for each(_loc2_ in _btnArr)
            {
               _buttonGroup.addSelectItem(_loc2_);
            }
            _buttonGroup.selectIndex = 0;
            _buttonGroup.selectIndex = _btnArr.indexOf(_worldBtn);
         }
         else
         {
            _btnArr = [_allBtn,_outyardBtn,_teamBtn,_consortiaBtn,_infoBtn];
            for each(_loc2_ in _btnArr)
            {
               _hBox.addChild(_loc2_);
            }
            for each(_loc2_ in _btnArr)
            {
               _buttonGroup.addSelectItem(_loc2_);
            }
            _buttonGroup.selectIndex = 0;
            _buttonGroup.selectIndex = _btnArr.indexOf(_outyardBtn);
         }
      }
      
      private function __planesDeadHelpClick(param1:NotificationEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 3000)
         {
            return;
         }
         _lastClickTime = _loc2_;
         SoundManager.instance.play("022");
         var _loc3_:ChatCellData = param1.data as ChatCellData;
         if(_loc3_.userId != playerInfo.userId)
         {
            PlanesWarManager.instance.sendPlanesOpMsg(34,[_loc3_.userId,playerInfo.userId]);
         }
      }
      
      private function __openSaleClick(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("022");
         if(SaleManager.instance.model && SaleManager.instance.model.isOpen)
         {
            FrameControllerManager.instance.openControllerByInfo("sale");
         }
      }
      
      private function __openTreasureClick(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("022");
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(getTimer() - _intervalTime < 3000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         ConsortiaManager.instance.model.treasureGroupInfo.helpOpenId = param1.data.userId;
         FrameControllerManager.instance.openControllerByInfo("consortia",11);
      }
      
      private function onOuterCityBossClick(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.bossinfo.SPACE_SCENE");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("035",true);
         SceneManager.instance.setScene("OUTER_CITY_SCENE");
      }
      
      protected function __onViewportStateChanged(param1:InteractiveEvent) : void
      {
         var _loc2_:Boolean = _chatList.height + _chatList.vScrollbar.scrollValue == _chatList.vScrollbar.maximum;
         if(_loc2_)
         {
            _buttonMc.gotoAndStop(1);
         }
      }
      
      private function __seekLinkClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("treasurehunt");
      }
      
      private function __selectedChannelChangeHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         for(var _loc2_:String in _btnDic)
         {
            if(_btnDic[_loc2_] == param1.currentTarget.getSelectedItem())
            {
               _loc3_ = int(_loc2_);
               break;
            }
         }
         model.currentOutChannel = _loc3_;
      }
      
      public function set currentOutChannel(param1:int) : void
      {
         if(!_buttonGroup)
         {
            return;
         }
         var _loc3_:SelectedCheckButton = _btnDic[param1] as SelectedCheckButton;
         var _loc2_:int = _buttonGroup.getIndexByItem(_loc3_);
         _buttonGroup.selectIndex = _loc2_;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _toBottomBtn)
         {
            _buttonMc.gotoAndStop(1);
            _chatList.invalidateViewport(true);
         }
      }
      
      private function __cleanHandler(param1:MouseEvent) : void
      {
         model.clean();
      }
      
      private function __channelChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ChatNotic = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _chatList.beginChanges();
         var _loc4_:Vector.<ChatData> = model.getChatsByOutputChannel();
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc3_ = ObjectPool.getObject(ChatNotic) as ChatNotic;
            _loc3_.data = _loc4_[_loc2_];
            _vBox.addChild(_loc3_);
            _loc2_++;
         }
         _vBox.refreshChildPos();
         _chatList.invalidateViewport(true);
         _chatList.commitChanges();
         if(model.currentOutChannel == 0 || model.currentOutChannel == 5)
         {
            _consortiaBtn.stop();
         }
         _buttonMc.gotoAndStop(1);
      }
      
      private function __updateChatViewHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChatNotic = null;
         var _loc2_:ChatData = param1.data as ChatData;
         if(_loc2_.channel == 5 && model.currentOutChannel != 0 && model.currentOutChannel != 5)
         {
            _consortiaBtn.play();
         }
         if(!checkShow(_loc2_))
         {
            return;
         }
         _chatList.beginChanges();
         while(_vBox.numChildren >= 50)
         {
            _loc3_ = _vBox.removeChildAt(0) as ChatNotic;
            ObjectPool.disposeObject(_loc3_);
            _loc3_ = null;
         }
         _loc3_ = ObjectPool.getObject(ChatNotic) as ChatNotic;
         _loc3_.data = _loc2_;
         _vBox.addChild(_loc3_);
         _vBox.refreshChildPos();
         playToBottom(_loc2_);
         _chatList.commitChanges();
      }
      
      private function checkShow(param1:ChatData) : Boolean
      {
         switch(model.currentOutChannel)
         {
            case 10:
               return param1.channel != 5 && param1.channel != 6 && param1.channel != 8 && param1.channel != 109;
            case 109:
               return param1.channel != 5 && param1.channel != 6 && param1.channel != 8 && param1.channel != 10;
            case 6:
               return param1.channel != 5 && param1.channel != 10 && param1.channel != 8 && param1.channel != 109;
            case 5:
               return param1.channel != 10 && param1.channel != 6 && param1.channel != 8 && param1.channel != 109;
            case 3:
               return param1.channel != 10 && param1.channel != 6 && param1.channel != 5 && param1.channel != 8 && param1.channel != 109;
            default:
               return true;
         }
      }
      
      private function playToBottom(param1:ChatData = null) : void
      {
         var _loc2_:Boolean = _chatList.height + _chatList.vScrollbar.scrollValue == _chatList.vScrollbar.maximum;
         if((!param1 || param1.uid != playerInfo.userId) && !_loc2_ && _chatList.vScrollbar.getThumbVisible())
         {
            _chatList.invalidateViewport();
            _buttonMc.play();
         }
         else
         {
            _chatList.invalidateViewport(true);
            _buttonMc.gotoAndStop(1);
         }
      }
      
      private function __channelClickHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",(param1.data as ChatCellData).channel);
      }
      
      private function __playerNameClickHandler(param1:NotificationEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         if(_loc2_.userId == playerInfo.userId)
         {
            if(!_loc2_.serverName)
            {
               return;
            }
            if(_loc2_.serverName == playerInfo.serviceName)
            {
               return;
            }
         }
         var _loc5_:String = SceneManager.instance.currentType;
         var _loc3_:Boolean = false;
         if(_loc2_.serverName && _loc2_.serverName != playerInfo.serviceName)
         {
            if(!CampaignManager.instance.exit && CampaignManager.instance.mapModel)
            {
               _loc3_ = CampaignManager.instance.mapModel.isCross;
            }
            else if(_loc2_.serverName != playerInfo.serviceName)
            {
               _loc3_ = true;
            }
         }
         if(playerInfo.consortiaID > 0)
         {
            _loc4_ = FrameControllerManager.instance.consortiaController.getRightsByIndex(9);
            _loc4_ = _loc4_ && _loc2_.consortiaId <= 0;
         }
         if(isCrossAllowTeam || _loc3_ || _loc2_.channel == 13)
         {
            showUseMenu(StageReferance.stage.mouseX,StageReferance.stage.mouseY,_loc2_.data.toString(),_loc2_.userId,_loc2_.grades,false,_loc2_.serverName,_loc2_.uuid);
         }
         else
         {
            showUseMenu(StageReferance.stage.mouseX,StageReferance.stage.mouseY,_loc2_.data.toString(),_loc2_.userId,_loc2_.grades,_loc4_);
         }
      }
      
      private function get isCrossAllowTeam() : Boolean
      {
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc1_)
         {
            if(WorldBossHelper.checkSvs(_loc1_.mapId))
            {
               return true;
            }
         }
         return false;
      }
      
      private function __consortiaClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ChatCellData = param1.data as ChatCellData;
         if(playerInfo.consortiaID != 0 || _loc3_.consortiaId == playerInfo.consortiaID)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         ConsortiaSocketOutManager.consortiaLink(_loc3_.consortiaId);
      }
      
      private function __gameHallInavteHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inLandMine.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.gemMazeController.isEnterGemMaze)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inGemMaze.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:GameHallGameInfo = (param1.data as ChatCellData).data as GameHallGameInfo;
         var _loc6_:String = WorldBossHelper.getCampaignTips();
         if(_loc6_ != "")
         {
            MessageTipManager.instance().show(_loc6_);
            return;
         }
         if(_loc5_)
         {
            SimpleAlertHelper.instance.data = [enterGameHall,_loc5_.teamId];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc8_ = LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.enterGameHall.confirm",_loc5_.teamId);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc3_,_loc4_,true,true,true);
         }
      }
      
      private function enterGameHall(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            GameHallManager.instance.teamInviteJoin(param3);
         }
      }
      
      private function __apexTeamInvateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inLandMine.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.gemMazeController.isEnterGemMaze)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inGemMaze.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:String = WorldBossHelper.getCampaignTips();
         if(_loc5_ != "")
         {
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         SimpleAlertHelper.instance.data = [enterApexTeam,(param1.data as ChatCellData).data];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("apex.team.str12");
         if(ApexManager.instance.model.myTeam)
         {
            _loc7_ += LanguageMgr.GetTranslation("apex.team.str14");
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true);
      }
      
      private function _consortiaNewBossHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         if(FreedomTeamManager.instance.hasTeam)
         {
            _loc2_ = LanguageMgr.GetTranslation("resourcebar.view.consortianewboss.inTeam");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inLandMine.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.gemMazeController.isEnterGemMaze)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inGemMaze.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:String = WorldBossHelper.getCampaignTips();
         if(_loc4_ != "")
         {
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         var _loc3_:ChatCellData = param1.data as ChatCellData;
         if(playerInfo.consortiaID == 0 || playerInfo.consortiaID != 0 && _loc3_.consortiaId != playerInfo.consortiaID)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
      }
      
      private function enterApexTeam(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            ApexManager.instance.sendJoinTeam(param3);
         }
      }
      
      private function __roomClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         var _loc6_:MarryCampaignInfo = null;
         var _loc5_:String = null;
         var _loc11_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "PLANES_WAR_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inPlanesWar.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inLandMine.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "STARAREA_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inStararea.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inSelfchess.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inSecret.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inSecretwar.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "THESE_PVP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inThesepvp.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inTheseMultipvp.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CHILD_NS_WAR_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inChildNswar.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc10_:RoomInfo = (param1.data as ChatCellData).data as RoomInfo;
         var _loc7_:String = WorldBossHelper.getCampaignTips();
         if(_loc7_ != "")
         {
            MessageTipManager.instance().show(_loc7_);
            return;
         }
         if(_loc10_)
         {
            if(_loc10_.roomType == 7)
            {
               if(FreedomTeamManager.instance.hasTeam || GroupfbManager.instance.model.hasGroupTeam)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChatOutputViewII.hasTeam"));
                  return;
               }
               if(thane.vocationGrades <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
                  return;
               }
               GroupfbSender.searchRoom(_loc10_.id,true);
            }
            RoomListSocketOutManager.sendSearchRoomState(_loc10_.id);
         }
         else
         {
            _loc6_ = (param1.data as ChatCellData).data as MarryCampaignInfo;
            if(_loc6_)
            {
               _roomKey = _loc6_.key;
               if(MarryManager.instance.model.roomDic[_roomKey])
               {
                  _loc5_ = MarryManager.instance.model.roomDic[_roomKey].nickNameA;
                  _loc11_ = MarryManager.instance.model.roomDic[_roomKey].nickNameB;
                  SimpleAlertHelper.instance.data = [enterWeddingCall];
                  _loc3_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc4_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc8_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc9_ = LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.enterWedding.confirm",_loc5_,_loc11_);
                  SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc3_,_loc4_,true,true,true);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.wedddingOutofDate"));
               }
            }
         }
      }
      
      private function enterWeddingCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(MarryManager.instance.model.roomDic[_roomKey])
            {
               MarrySender.enterWeddingRoom(_roomKey,"",true);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.wedddingOutofDate"));
            }
         }
         _roomKey = "";
      }
      
      private function __cardClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         var _loc2_:MagicCardInfo = (param1.data as ChatCellData).data as MagicCardInfo;
         if(_loc2_)
         {
            MagicCardManager.Instance.cardModel.isSelfCheck = false;
            FrameControllerManager.instance.openControllerByInfo("magiccard",1,_loc2_);
         }
      }
      
      private function __starClickHandler(param1:NotificationEvent) : void
      {
         tipDispose();
         var _loc2_:StarInfo = (param1.data as ChatCellData).data as StarInfo;
         _starstip = new ChatStarTip();
         _starstip.tipData = _loc2_;
         LayerManager.Instance.addToLayer(_starstip,3);
         _starstip.x = StageReferance.stage.mouseX;
         if(ChatBar.inBattleFlag)
         {
            BattleChatController.getInstance().adjustEquipTipPos(_starstip);
         }
         else
         {
            _starstip.x = 8 + width;
            _starstip.y = StageReferance.stage.stageHeight - _starstip.height;
         }
      }
      
      private function __equipClickHandler(param1:NotificationEvent) : void
      {
         tipDispose();
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         var _loc3_:GoodsInfo = _loc2_.data as GoodsInfo;
         if(_loc3_.templateInfo.SonType == 232)
         {
            _monstertip = new ChatMonsterAccesoriesTips();
            _monstertip.tipData = _loc3_;
            LayerManager.Instance.addToLayer(_monstertip,3);
            if(ChatBar.inBattleFlag)
            {
               BattleChatController.getInstance().adjustEquipTipPos(_monstertip);
            }
            else
            {
               _monstertip.x = 8 + width;
               _monstertip.y = StageReferance.stage.stageHeight - _monstertip.height - 31;
            }
         }
         else if(!GoodsCheck.isFashion(_loc3_.templateInfo))
         {
            _goodstip = new ChatEquipTips();
            _goodstip.tipData = _loc3_;
            LayerManager.Instance.addToLayer(_goodstip,3);
            if(ChatBar.inBattleFlag)
            {
               BattleChatController.getInstance().adjustEquipTipPos(_goodstip);
            }
            else
            {
               _goodstip.x = 8 + width;
               _goodstip.y = StageReferance.stage.stageHeight - _goodstip.height - 31;
            }
         }
         else
         {
            _fashiontip = new ChatFashionTips();
            _fashiontip.tipData = _loc3_;
            LayerManager.Instance.addToLayer(_fashiontip,3);
            if(ChatBar.inBattleFlag)
            {
               BattleChatController.getInstance().adjustEquipTipPos(_fashiontip);
            }
            else
            {
               _fashiontip.x = 8 + width;
               _fashiontip.y = StageReferance.stage.stageHeight - _fashiontip.height - 31;
            }
         }
      }
      
      private function __propClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         var _loc3_:GoodsInfo = _loc2_.data as GoodsInfo;
         if(_loc3_.templateInfo.SonType == 302)
         {
            _proptip = new RuneTip();
         }
         else if(_loc3_.templateInfo.SonType == 218)
         {
            _proptip = new MountCardTip();
         }
         else if(_loc3_.templateInfo.SonType == 600)
         {
            _proptip = new PropTips();
         }
         else
         {
            _proptip = new PropTips();
         }
         _proptip.tipData = _loc3_;
         LayerManager.Instance.addToLayer(_proptip,7);
         _proptip.x = StageReferance.stage.mouseX;
         if(ChatBar.inBattleFlag)
         {
            _proptip.y = StageReferance.stage.mouseY;
         }
         else
         {
            _proptip.y = StageReferance.stage.mouseY - _proptip.height - 5;
         }
      }
      
      private function __vipLinkClickHandler(param1:NotificationEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function __appellLinkClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(!VersionSwitch.APPELL)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.AppellLinkClickTipTxt1");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.AppellLinkClickTipTxt2");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:ChatCellData = param1.data as ChatCellData;
         var _loc3_:int = int(_loc4_.data);
         var _loc5_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(_loc3_);
         if(_loc5_.Job != 0 && _loc5_.Job != ThaneInfoHelper.getJob(ArmyManager.instance.thane.job))
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.AppellLinkClickTipTxt3");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("appell",null,_loc3_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __roseBackClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc3_:String = null;
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         var _loc4_:int = parseInt((param1.data as ChatCellData).itemId);
         if(_loc4_ == 0 || _loc4_ == 2170005 && GoodsManager.instance.getGoodsNumByTempId(_loc4_) <= 0 || _loc4_ != 2170005 && GoodsManager.instance.getGoodsNumByTempId(_loc4_) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.IMFrame.present.TipTxt"));
            return;
         }
         if(_loc4_ == 2170005)
         {
            _loc2_ = (param1.data as ChatCellData).nickName;
            _loc5_ = (param1.data as ChatCellData).userId;
            FrameControllerManager.instance.friendControler.startFrameByType(8,[_loc4_,_loc2_,_loc5_]);
         }
         else
         {
            _loc3_ = (param1.data as ChatCellData).nickName;
            FrameControllerManager.instance.friendControler.startFrameByType(5,[_loc4_,_loc3_]);
         }
      }
      
      private function __cardBackClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(GoodsManager.instance.getGoodsNumByTempId(2220001) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.IMFrame.present.TipTxt"));
            return;
         }
         var _loc3_:int = 2220001;
         var _loc2_:String = (param1.data as ChatCellData).nickName;
         FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.HANDLSEL,_loc2_);
      }
      
      private function __reinforceClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         var _loc6_:ChatCellData = param1.data as ChatCellData;
         var _loc8_:int = int(_loc6_.data.userId);
         var _loc5_:int = int(_loc6_.data.mapId);
         var _loc2_:int = _loc6_.data.posX * 20;
         var _loc3_:int = _loc6_.data.posY * 20;
         var _loc9_:String = _loc5_ + ",0";
         var _loc7_:Point = new Point(_loc2_,_loc3_);
         var _loc4_:Object = {
            "userId":_loc8_,
            "mapId":_loc5_,
            "posX":_loc2_,
            "posY":_loc3_
         };
         if(FreedomTeamManager.instance.inMyTeam(_loc8_))
         {
            if(MopupManager.instance.model.isMopup)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.ReinforceClickTipTxt1"));
            }
            else
            {
               if(_loc6_.type == 21)
               {
                  TreasureMapManager.instance.model.reinforceTarget = _loc4_;
               }
               SwitchPageHelp.walkToCrossMapTarget(_loc9_,_loc7_);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatOutputViewII.ReinforceClickTipTxt2"));
         }
      }
      
      private function __fishClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.outerCity"));
            return;
         }
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         var _loc3_:int = _loc2_.userId;
         FishManager.instance.model.fishPoolInfo.userId = _loc3_;
         FishManager.instance.fishAction(6,[_loc3_]);
         FishManager.instance.model.fishRefuseInvitation = SharedManager.instance.refuseInvitation;
         FishManager.instance.model.fishRefuseInvite = playerInfo.refuseInvite;
         FishManager.instance.model.fishRefuseTeamInvite = playerInfo.refuseTeamInvite;
         if(!FishManager.instance.model.fishRefuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!FishManager.instance.model.fishRefuseInvitation)
         {
            SharedManager.instance.refuseInvitation = !FishManager.instance.model.fishRefuseInvitation;
            SharedManager.instance.save();
         }
         if(!FishManager.instance.model.fishRefuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function __goldRoadClickHandler(param1:NotificationEvent) : void
      {
         if(ChatBar.inBattleFlag)
         {
            return;
         }
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.nowDate > ConfigManager.info.GOLDROAD_END_DATE.time)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         if(ArmyManager.instance.thane.grades < 18)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldRoad.goldRoadJoin.UnderLevel"));
            return;
         }
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldRoad.goldRoadJoin.inOuterCity"));
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldroad.goldRoadFrame.teamNotice"));
            return;
         }
         GoldRoadManager.instance.model.goldRoadRefuseInvitation = SharedManager.instance.refuseInvitation;
         GoldRoadManager.instance.model.goldRoadRefuseInvite = playerInfo.refuseInvite;
         GoldRoadManager.instance.model.goldRoadRefuseTeamInvite = playerInfo.refuseTeamInvite;
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
      }
      
      private function showUseMenu(param1:int, param2:int, param3:String, param4:int, param5:int, param6:Boolean, param7:String = null, param8:String = "") : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         var _loc9_:Boolean = FreedomTeamManager.instance.canInviteMember(param4,param5);
         if(param7 != null && param7 != "" && param7 != playerInfo.serviceName && !isCrossAllowTeam)
         {
            _loc9_ = false;
         }
         _menu = new ChatItemMenu(param3,param4,param6,param7,false,false,false,_loc9_,true,param8);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = param1;
         if(ChatBar.inBattleFlag)
         {
            _menu.y = param2;
         }
         else
         {
            _menu.y = param2 - _menu.height - 5;
         }
         if(_menu.y < 0)
         {
            _menu.y = 0;
         }
      }
      
      private function __godsEvenignGotoHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(!WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapId))
         {
            return;
         }
         var _loc3_:ChatCellData = param1.data as ChatCellData;
         var _loc4_:Object = Object(_loc3_.data);
         var _loc2_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc4_.armyId,_loc4_.serverName);
         if(_loc2_ && (_loc2_.isDie == 12 || _loc2_.isDie == 10) && (_loc2_.userId != thane.userId || _loc2_.baseHero.serviceName != playerInfo.serviceName))
         {
            GodsEveningManager.instance.model.selfFowllowingArmy = _loc2_;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_loc2_));
         }
      }
      
      private function __crisisAttackInavteHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType != "PLANE_CRISRIS")
         {
            return;
         }
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         var _loc3_:Array = _loc2_.data as Array;
         PlaneCrisisManager.Instance.acceptInvate(_loc3_);
      }
      
      private function tipDispose() : void
      {
         if(_goodstip)
         {
            _goodstip.dispose();
         }
         if(_proptip)
         {
            _proptip.dispose();
         }
         if(_starstip)
         {
            _starstip.dispose();
         }
         if(_fashiontip)
         {
            _fashiontip.dispose();
         }
         if(_monstertip)
         {
            _monstertip.dispose();
         }
      }
      
      public function showMaxView() : void
      {
         var _loc1_:Boolean = _chatList.height + _chatList.vScrollbar.scrollValue == _chatList.vScrollbar.maximum;
         _back.height = 303;
         _chatList.height = 234;
         _rectangle.height = 264;
         _hBox.y = 238;
         _buttonMc.y = 198;
         _chatList.invalidateViewport(_loc1_);
      }
      
      public function showBottomView() : void
      {
         var _loc1_:Boolean = true;
         if(_loc1_)
         {
            _chatList.scrollToTop();
         }
         _chatList.height = 63;
         _rectangle.height = 90;
         _hBox.y = 64;
         _back.height = 120;
         _buttonMc.y = 23;
         _chatList.vScrollbar.beginChanges();
         _chatList.vScrollbar.scrollValue = _chatList.vScrollbar.scrollValue;
         _chatList.vScrollbar.commitChanges();
         _chatList.invalidateViewport(_loc1_);
      }
      
      public function showMinView(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = _chatList.height + _chatList.vScrollbar.scrollValue == _chatList.vScrollbar.maximum;
         if(_loc2_)
         {
            _chatList.scrollToTop();
         }
         _chatList.height = 126;
         _rectangle.height = 156;
         _hBox.y = 130;
         if(param1)
         {
            _back.height = 155;
            _buttonMc.y = 112;
            _chatList.vScrollbar.height = 131;
         }
         else
         {
            _back.height = 195;
            _buttonMc.y = 90;
            _chatList.vScrollbar.height = 109;
         }
         _chatList.vScrollbar.beginChanges();
         _chatList.vScrollbar.scrollValue = _chatList.vScrollbar.scrollValue;
         _chatList.vScrollbar.commitChanges();
         _chatList.invalidateViewport(_loc2_);
      }
      
      public function playDefault() : void
      {
         _chatList.invalidateViewport(true);
         _buttonMc.gotoAndStop(1);
      }
      
      private function get model() : ChatModel
      {
         return ChatManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get hBox() : HBox
      {
         return _hBox;
      }
      
      public function get cleanBtn() : BaseButton
      {
         return _cleanBtn;
      }
      
      public function get back() : ScaleBitmapImage
      {
         return _back;
      }
      
      public function get chatList() : ScrollPanel
      {
         return _chatList;
      }
      
      public function get toBottomBtn() : BaseButton
      {
         return _toBottomBtn;
      }
      
      public function setHeight() : void
      {
         _chatList.height = 70;
         _rectangle.height = 106;
         _hBox.y = 80;
         _back.height = 115;
         _buttonMc.y = 42;
         _chatList.vScrollbar.height = 61;
         _chatList.vScrollbar.beginChanges();
         _chatList.vScrollbar.scrollValue = _chatList.vScrollbar.scrollValue;
         _chatList.vScrollbar.commitChanges();
         _chatList.invalidateViewport(true);
      }
   }
}

