package room.view.invite
{
   import chat.ChatSocketOutManager;
   import chat.utils.ChatHelper;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.GroupfbManager;
   import managers.MarryManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.pveroomlist.ThsesusRoomListModel;
   import mvc.module.room.RoomInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.events.PlayerEvent;
   import yishi.manager.ApexManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.tips.MessageTipManager;
   
   public class QuickInviteFrame extends Frame
   {
      
      public static const MAX_CONTENT:int = 84;
      
      private var _backBorder:ScaleBitmapImage;
      
      private var _inputDarkBg:ScaleFrameImage;
      
      private var _inputBg:ScaleFrameImage;
      
      private var _inviteTitle:FilterFrameText;
      
      private var _inviteContent:FilterFrameText;
      
      private var _tempContent:String = "";
      
      private var _notice:FilterFrameText;
      
      private var _downBg:ScaleLeftRightImage;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _defaultContent:String = "";
      
      private var _testField:FilterFrameText;
      
      private var _defaultWidth:int = 290;
      
      private var _filter:ColorMatrixFilter;
      
      private var _apos:String = "&apos;";
      
      private var _selfAreaBtn:SelectedIconButton;
      
      private var _crossAreaBen:SelectedIconButton;
      
      private var _areaSelectedGroup:SelectedButtonGroup;
      
      private var _showType:int = 0;
      
      private var _quickInviteFlag:Boolean;
      
      private var _vipOpenView:NewVipOpenView;
      
      private var _roomInfo:RoomInfo;
      
      public function QuickInviteFrame()
      {
         super();
         initInviteContent();
         initView();
         initEvents();
         _areaSelectedGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _backBorder = ComponentFactory.Instance.creatComponentByStylename("invite.backBorder");
         _inputDarkBg = ComponentFactory.Instance.creatComponentByStylename("invite.DarkBackGroundInput");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("invite.BackGroundInput");
         _inviteTitle = ComponentFactory.Instance.creatComponentByStylename("invite.InviteTitle");
         _inviteContent = ComponentFactory.Instance.creatComponentByStylename("invite.InviteContent");
         _notice = ComponentFactory.Instance.creatComponentByStylename("invite.Notice");
         _downBg = ComponentFactory.Instance.creatComponentByStylename("invite.QuickInviteFrame.BackGroundDown");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("invite.ConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("invite.CancelBtn");
         _testField = ComponentFactory.Instance.creatComponentByStylename("invite.InviteContent");
         _testField.width = _defaultWidth;
         _testField.multiline = true;
         _testField.wordWrap = true;
         titleText = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.title");
         _inviteTitle.text = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteTitle");
         _selfAreaBtn = ComponentFactory.Instance.creatComponentByStylename("invite.selfAreaBtn");
         _crossAreaBen = ComponentFactory.Instance.creatComponentByStylename("invite.crossAreaBtn");
         _inviteContent.text = thane.inviteContent ? thane.inviteContent : _defaultContent;
         _filter = new ColorMatrixFilter([1.41,-0.37,-0.05,0,100,-0.19,1.23,-0.05,0,100,-0.19,-0.37,1.55,0,100,0,0,0,1,0]);
         _inviteContent.setFrame(1);
         _inputBg.filters = [];
         _vipOpenView = new NewVipOpenView(204);
         _vipOpenView.x = 152;
         _vipOpenView.y = 10;
         addToContent(_backBorder);
         addToContent(_selfAreaBtn);
         addToContent(_crossAreaBen);
         _crossAreaBen.enable = false;
         addToContent(_inputDarkBg);
         _inputDarkBg.setFrame(1);
         addToContent(_inputBg);
         _inputBg.setFrame(1);
         addToContent(_inviteTitle);
         addToContent(_inviteContent);
         addToContent(_notice);
         addToContent(_downBg);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_vipOpenView);
         _areaSelectedGroup = new SelectedButtonGroup();
         _areaSelectedGroup.addSelectItem(_selfAreaBtn);
         _areaSelectedGroup.addSelectItem(_crossAreaBen);
         updateNotice(contentLength);
      }
      
      private function get model() : ThsesusRoomListModel
      {
         return FrameControllerManager.instance.theseusRoomListControler.model;
      }
      
      private function initInviteContent() : void
      {
         var _loc8_:String = null;
         var _loc4_:CampaignTemplate = null;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:GameHallGameInfo = null;
         var _loc1_:MarryQualityData = null;
         var _loc2_:String = "";
         if(groupfbModel.isCaptain)
         {
            _defaultContent = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice.groupfb",groupfbModel.selfTeam.id);
            return;
         }
         if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
         {
            _defaultContent = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice.gamehall",LanguageMgr.GetTranslation("theseuspvp.doubletitle"),roomInfo.id,roomInfo.playerCount);
            return;
         }
         if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
         {
            _loc3_ = "";
            _loc5_ = 0;
            _loc7_ = 0;
            _loc6_ = new GameHallGameInfo();
            _loc6_.gameId = gameHallModel.gameId;
            _loc6_.difficulty = gameHallModel.difficulty;
            if(_loc6_.templateInfo)
            {
               _loc3_ = _loc6_.templateInfo.GameName;
            }
            if(gameHallModel.gameId == 4)
            {
               _loc3_ = _loc3_ + "-" + _loc6_.eastTemplateInfo.TemplateName;
            }
            if(gameHallModel.selfTeam)
            {
               _loc5_ = int(gameHallModel.selfTeam.teamId);
               _loc7_ = int(gameHallModel.selfTeam.players.length);
            }
            _defaultContent = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice.gamehall",_loc3_,_loc5_,_loc7_);
            return;
         }
         if(isApexInvite)
         {
            if(!ApexManager.instance.model.myTeam)
            {
               return;
            }
            _defaultContent = LanguageMgr.GetTranslation("apex.team.str11",ApexManager.instance.model.myTeam.teamId,ApexManager.instance.model.myTeam.members.length);
            return;
         }
         if(roomInfo.campaignId == 0)
         {
            _loc8_ = LanguageMgr.GetTranslation("chat.view.ChatView.NullMap");
         }
         else
         {
            if(roomInfo.campaignId == 3001)
            {
               _defaultContent = StringHelper.format(LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice.Vechicle",roomInfo.mapName,roomInfo.id));
               return;
            }
            if(inWedding)
            {
               _loc1_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(MarryManager.instance.model.weddingInfo.property9);
               if(_loc1_)
               {
                  _defaultContent = StringHelper.format(LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.WeddingInviteContent",_loc1_.TemplateName));
               }
               return;
            }
            _loc4_ = roomInfo.mapTemplate ? roomInfo.mapTemplate : CampaignManager.instance.mapModel.campaignTemplate;
            if(_loc4_.SonTypes != 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade3");
            }
            else if(_loc4_.DifficultyGrade == 1)
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade1");
            }
            else if(_loc4_.DifficultyGrade == 2)
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade2");
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade4");
            }
            if(_loc2_)
            {
               _loc2_ = LanguageMgr.GetTranslation("public.parentheses1",_loc2_);
            }
            _loc8_ = _loc4_.CampaignName + _loc2_;
         }
         _defaultContent = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteContent",_loc8_,roomInfo.id);
      }
      
      private function get gameHallModel() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      private function get groupfbModel() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
         _cancelBtn.addEventListener("click",__cancelBtnClickHandler);
         _areaSelectedGroup.addEventListener("change",__onSelectedAreaChangeHandler);
         thane.addEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
         _areaSelectedGroup.removeEventListener("change",__onSelectedAreaChangeHandler);
         thane.removeEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
      }
      
      private function __onSelectedAreaChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:* = _areaSelectedGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _selfAreaBtn:
               _inputDarkBg.setFrame(1);
               _inputBg.setFrame(1);
               _vipOpenView.visible = false;
               break;
            case _crossAreaBen:
               _inputDarkBg.setFrame(2);
               _inputBg.setFrame(2);
               _vipOpenView.visible = true;
         }
         updateNotice(contentLength);
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkIsInCrossMutiCampaign())
         {
            return;
         }
         sendQuickInvite();
      }
      
      private function sendQuickInvite() : void
      {
         var _loc1_:String = "";
         if(StringHelper.isNullOrEmpty(StringHelper.trim(_inviteContent.text)))
         {
            _loc1_ = LanguageMgr.GetTranslation("consortiagroupchat.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         _loc1_ = StringHelper.trim(_inviteContent.text);
         thane.inviteContent = _loc1_;
         var _loc3_:String = ChatHelper.parasMsgs(_loc1_);
         var _loc4_:Array = [];
         var _loc2_:Number = 0;
         if(!ChatHelper.checkCanSend(_loc3_,10))
         {
            return;
         }
         _loc4_.push(_loc3_);
         ChatHelper.lastSendTime3 = getTimer();
         SocketSendManager.instance.sendQuickInvite(_loc4_,getSendType());
         dispose();
      }
      
      private function checkIsInCrossMutiCampaign() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:String = "";
         if(getSendType() == 3)
         {
            _loc2_ = int(GoodsManager.instance.getGoodsNumBySonType(280));
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208025);
            if(_loc2_ == 0)
            {
               if(thane.crossBugleFreeCount <= 0)
               {
                  if(_loc1_)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.quickInviteFrame.noGoods",_loc1_.TemplateName);
                  }
                  MessageTipManager.instance().show(_loc3_);
                  return false;
               }
               _quickInviteFlag = true;
               ChatSocketOutManager.sendSmallBugleFreeCount();
               return false;
            }
         }
         else
         {
            _loc2_ = int(GoodsManager.instance.getGoodsNumByTempId(208003));
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208003);
            if(_loc2_ == 0)
            {
               if(thane.smallBugleFreeCount <= 0)
               {
                  if(_loc1_)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.quickInviteFrame.noGoods",_loc1_.TemplateName);
                  }
                  MessageTipManager.instance().show(_loc3_);
                  CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
                  return false;
               }
               _quickInviteFlag = true;
               ChatSocketOutManager.sendSmallBugleFreeCount();
               return false;
            }
         }
         return true;
      }
      
      private function __smallBugleFreeCountHandler(param1:PlayerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         if(!_quickInviteFlag)
         {
            return;
         }
         _quickInviteFlag = false;
         var _loc4_:String = "";
         if(getSendType() == 3)
         {
            _loc3_ = int(GoodsManager.instance.getGoodsNumBySonType(280));
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208025);
            if(_loc3_ == 0)
            {
               if(thane.crossBugleFreeCount <= 0)
               {
                  if(_loc2_)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.quickInviteFrame.noGoods",_loc2_.TemplateName);
                  }
                  MessageTipManager.instance().show(_loc4_);
                  return;
               }
            }
         }
         else
         {
            _loc3_ = int(GoodsManager.instance.getGoodsNumByTempId(208003));
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208003);
            if(_loc3_ == 0)
            {
               if(thane.smallBugleFreeCount <= 0)
               {
                  if(_loc2_)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.quickInviteFrame.noGoods",_loc2_.TemplateName);
                  }
                  MessageTipManager.instance().show(_loc4_);
                  CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
                  return;
               }
            }
         }
         sendQuickInvite();
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208003);
         _loc1_.data(_loc2_);
         _loc1_.show();
      }
      
      private function getSendType() : int
      {
         var _loc1_:int = 0;
         if(inWedding)
         {
            _loc1_ = 1;
         }
         else if(groupfbModel.isCaptain)
         {
            _loc1_ = 2;
         }
         else if(!isInSteel && _areaSelectedGroup.selectIndex == 1 && Boolean(PlayerManager.instance.currentPlayerModel.playerInfo.isOpenCrossMutiCampaign))
         {
            _loc1_ = 3;
         }
         else if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
         {
            _loc1_ = 4;
         }
         else if(isApexInvite)
         {
            _loc1_ = 5;
         }
         return _loc1_;
      }
      
      private function get inWedding() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      private function get isInSteel() : Boolean
      {
         return WorldBossHelper.checkSteel(CampaignManager.instance.mapId);
      }
      
      private function get isApexInvite() : Boolean
      {
         return ApexManager.instance.model.isQuickInvite;
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __inviteContentFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
      }
      
      private function __inviteContentFocusOutHandler(param1:FocusEvent) : void
      {
         IMEManager.disable();
      }
      
      private function __inviteContentInputHandler(param1:Event) : void
      {
         var _loc2_:int = contentLength;
         if(contentLength > 84)
         {
            _inviteContent.text = _tempContent;
         }
         _tempContent = _inviteContent.text;
         updateNotice(_loc2_);
      }
      
      private function updateNotice(param1:int) : void
      {
         var _loc2_:int = int(_areaSelectedGroup.selectIndex);
         _notice.htmlText = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice" + _loc2_,toArialBold(param1 + " / " + 84));
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function get contentLength() : int
      {
         return int(_inviteContent.text.length);
      }
      
      private function transferredApos(param1:String) : String
      {
         return StringHelper.replaceStr(param1,"\'",_apos);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show(param1:int = 0) : void
      {
         _showType = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         setCrossAreaBtnState();
      }
      
      private function setCrossAreaBtnState() : void
      {
         var _loc1_:CampaignTemplate = null;
         var _loc2_:Boolean = false;
         if(roomInfo && roomInfo.campaignId != 0)
         {
            _loc1_ = roomInfo.mapTemplate ? roomInfo.mapTemplate : CampaignManager.instance.mapModel.campaignTemplate;
            if(_loc1_ && playerInfo.isOpenCrossMutiCampaign && !inWedding && !isInSteel && _loc1_.SonTypes == 0)
            {
               _loc2_ = true;
            }
         }
         _crossAreaBen.enable = _loc2_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
         {
            ArmyManager.instance.thane.inviteContent = "";
         }
         ApexManager.instance.model.isQuickInvite = false;
         removeEvents();
         ObjectUtils.disposeObject(_inputDarkBg);
         _inputDarkBg = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inviteTitle);
         _inviteTitle = null;
         ObjectUtils.disposeObject(_inviteContent);
         _inviteContent = null;
         ObjectUtils.disposeObject(_notice);
         _notice = null;
         ObjectUtils.disposeObject(_downBg);
         _downBg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_vipOpenView);
         _vipOpenView = null;
         ObjectUtils.disposeObject(_testField);
         _testField = null;
         ObjectUtils.disposeObject(_crossAreaBen);
         _crossAreaBen = null;
         ObjectUtils.disposeObject(_selfAreaBtn);
         _selfAreaBtn = null;
         ObjectUtils.disposeObject(_backBorder);
         _backBorder = null;
         _filter = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

