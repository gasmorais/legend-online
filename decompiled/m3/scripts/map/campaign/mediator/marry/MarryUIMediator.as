package map.campaign.mediator.marry
{
   import chat.datas.ChatData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.marriage.MarriageProMsg;
   import dialog.data.DialogMessageInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import managers.MarryManager;
   import managers.MountsManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.layer.NpcLayer;
   import map.campaign.view.physics.CampaignNpcPhysics;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.CampaignNode;
   import map.space.SpaceManager;
   import marry.view.MarryFlowerView;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryRoomInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryUIMediator implements IMediator
   {
      
      private var _hideBtn:BaseButton;
      
      private var _roomSetBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _guideBtn:TextButton;
      
      private var _selfArmy:CampaignArmy;
      
      private var _btnDic:Dictionary;
      
      private var _itemDic:Dictionary;
      
      private var _uiSprite:Sprite;
      
      private var _npcLayer:NpcLayer;
      
      private var _flowerView:MarryFlowerView;
      
      private var _leftBack:Bitmap;
      
      private var _leftTxt:GradientText;
      
      private var _timer:Timer;
      
      private var _lastTime:int;
      
      private var _clickIndexList:Array;
      
      private var model:CampaignMapModel;
      
      public function MarryUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         model = CampaignManager.instance.mapModel;
         initView();
         (param1 as Sprite).addChild(_uiSprite);
         initEvent();
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         unInit();
      }
      
      private function initView() : void
      {
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("marry.wedding.hideBtn");
         _roomSetBtn = ComponentFactory.Instance.creatComponentByStylename("marry.wedding.roomSetBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("marry.wedding.inviteBtn");
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("marry.wedding.leftTxt");
         _leftBack = ComponentFactory.Instance.creatBitmap("asset.wedding.leftTimeBack");
         _guideBtn = ComponentFactory.Instance.creatComponentByStylename("marry.wedding.guideBtn");
         _npcLayer = CampaignManager.instance.mapView.npcLayer;
         _uiSprite = new Sprite();
         _clickIndexList = [];
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         _hideBtn.tipData = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.hideBtn.Tips");
         LayerManager.Instance.addToLayer(_hideBtn,4,false);
         LayerManager.Instance.addToLayer(_roomSetBtn,4,false);
         LayerManager.Instance.addToLayer(_inviteBtn,4,false);
         LayerManager.Instance.addToLayer(_leftBack,4,false);
         LayerManager.Instance.addToLayer(_leftTxt,4,false);
         LayerManager.Instance.addToLayer(_guideBtn,4,false);
         _lastTime = 7200;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mar_time");
         if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
         {
            _lastTime = int(_loc1_.ConfigValue) * 60;
         }
         _timer = new Timer(1000);
         _timer.start();
         addAllBtn();
         setGuideState();
         __resizeHandler(null);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         if(_hideBtn)
         {
            _hideBtn.addEventListener("click",__hideBtnHandler);
         }
         if(_roomSetBtn)
         {
            _roomSetBtn.addEventListener("click",__roomSetHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.addEventListener("click",__inviteBtnHandler);
         }
         if(_guideBtn)
         {
            _guideBtn.addEventListener("click",__guideBtnHandler);
         }
         NotificationManager.instance.addEventListener("NPC_LOAD_COMPLETE",layout);
         MsgMan.addObserver("MarryEventType.WEDDING_OATH",this,__oathHandler);
         MsgMan.addObserver("MarryEventType.WEDDING_STATE",this,__stateHandler);
         MsgMan.addObserver("MarryEventType.WEDDING_AUTOMOVE",this,__autoMoveHandler);
         if(_timer)
         {
            _timer.addEventListener("timer",__timerHandler);
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__hideBtnHandler);
         }
         if(_roomSetBtn)
         {
            _roomSetBtn.removeEventListener("click",__roomSetHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteBtnHandler);
         }
         if(_guideBtn)
         {
            _guideBtn.removeEventListener("click",__guideBtnHandler);
         }
         NotificationManager.instance.removeEventListener("NPC_LOAD_COMPLETE",layout);
         MsgMan.removeObserver("MarryEventType.WEDDING_OATH",this,__oathHandler);
         MsgMan.removeObserver("MarryEventType.WEDDING_STATE",this,__stateHandler);
         MsgMan.removeObserver("MarryEventType.WEDDING_AUTOMOVE",this,__autoMoveHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
      
      private function unInit() : void
      {
         for(var _loc1_:String in marryModel.guestDic)
         {
            delete marryModel.guestDic[_loc1_];
         }
         if(_hideBtn)
         {
            _hideBtn.dispose();
         }
         _hideBtn = null;
         if(_roomSetBtn)
         {
            _roomSetBtn.dispose();
         }
         _roomSetBtn = null;
         if(_inviteBtn)
         {
            _inviteBtn.dispose();
         }
         _inviteBtn = null;
         if(_guideBtn)
         {
            _guideBtn.dispose();
         }
         _guideBtn = null;
         if(_leftTxt)
         {
            _leftTxt.dispose();
         }
         _leftTxt = null;
         ObjectUtils.disposeObject(_leftBack);
         _leftBack = null;
         if(_flowerView)
         {
            _flowerView.dispose();
         }
         _flowerView = null;
         clearAllBtn();
         _uiSprite = null;
         _npcLayer = null;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(roomInfo == null)
         {
            return;
         }
         var _loc3_:Number = _lastTime + DateFormatter.parse(roomInfo.property4,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         var _loc2_:Number = _loc3_ - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc2_ <= 0)
         {
            _leftTxt.text = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.leftTxt01");
            return;
         }
         if(_loc2_ >= 60)
         {
            _leftTxt.text = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.leftTxt02",int(_loc2_ / 60),LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min"));
         }
         else
         {
            _leftTxt.text = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.leftTxt02",_loc2_,LanguageMgr.GetTranslation("public.time.second"));
         }
      }
      
      private function __autoMoveHandler(param1:String, param2:Object) : void
      {
         var _loc6_:MarryQualityData = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(_guideBtn)
         {
            _guideBtn.visible = false;
         }
         if(marryModel.isWeddingMaster && !MarryManager.instance.model.lockScreen)
         {
            MarryManager.instance.model.lockScreen = true;
            MountsManager.instance.mountOperateSend(3,0,0,0,0);
            _loc6_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(marryModel.roomInfo.property2);
            if(_loc6_)
            {
               _loc3_ = ["SlotId","ClothId","WingId","HatId"];
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  if(_loc6_[_loc3_[_loc4_]] && _loc6_[_loc3_[_loc4_]] > 0)
                  {
                     _loc5_ = int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_[_loc3_[_loc4_]]).TemplateId);
                     FashionManager.instance.saveBook(_loc5_);
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function __oathHandler(param1:String, param2:Object) : void
      {
         var _loc8_:DialogMessageInfo = null;
         var _loc3_:String = null;
         var _loc6_:RegExp = null;
         var _loc7_:ChatData = null;
         var _loc4_:CampaignArmy = null;
         var _loc5_:CampaignNode = null;
         var _loc9_:MarriageProMsg = param2 as MarriageProMsg;
         SoundManager.instance.playMusic("wedding");
         if(_guideBtn)
         {
            _guideBtn.visible = false;
         }
         if(_loc9_)
         {
            _loc8_ = new DialogMessageInfo();
            if(_loc9_.property2 == playerInfo.userId)
            {
               _loc8_.direction = 1;
            }
            else if(_loc9_.property2 == marryModel.selfMarryInfo.userId)
            {
               _loc8_.direction = 1;
            }
            else
            {
               _loc8_.direction = 0;
            }
            _loc8_.txt = _loc9_.property4;
            _loc8_.roleId = _loc9_.property3;
            _loc8_.roleName = _loc9_.property5;
            _loc3_ = _loc9_.property4;
            _loc6_ = />/g;
            _loc3_ = _loc3_.replace(_loc6_,"");
            _loc6_ = /</g;
            _loc3_ = _loc3_.replace(_loc6_,"");
            if(marryModel.isWeddingMaster)
            {
               CheckUIModuleUtil.instance.tryCall("wedding",showWeddingFlowerCall,[_loc8_]);
            }
            else
            {
               _loc7_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc7_.uid = _loc9_.property2;
               _loc7_.msg = _loc3_;
               _loc7_.commit();
               if(_loc9_.property2 == marryModel.weddingInfo.userIdA || _loc9_.property2 == marryModel.weddingInfo.userIdB)
               {
                  _loc4_ = mapModel.getUserArmyByUserId(_loc9_.property2);
                  if(_loc4_)
                  {
                     _loc4_.chatData = _loc7_;
                  }
               }
               else
               {
                  _loc5_ = mapModel.getMapNodesById(_loc9_.property2);
                  if(_loc5_)
                  {
                     _loc5_.chatData = _loc7_;
                  }
               }
            }
            _loc7_ = ObjectPool.getObject(ChatData) as ChatData;
            if(_loc7_)
            {
               _loc7_.channel = 8;
               _loc7_.msg = _loc8_.roleName + ":" + _loc3_;
               _loc7_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc7_);
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function showWeddingFlowerCall(param1:Array) : void
      {
         var _loc2_:DialogMessageInfo = param1[0];
         if(_flowerView == null)
         {
            _flowerView = new MarryFlowerView();
            _flowerView.show();
         }
         _flowerView.setRoles(_loc2_.roleId);
         _flowerView.showMessage(_loc2_);
      }
      
      private function __hideBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SharedManager.instance.hideOthers = !SharedManager.instance.hideOthers;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UP_DATA_SHOW_PLAYER_VIEW",SharedManager.instance.hideOthers));
         if(SharedManager.instance.hideOthers)
         {
            _hideBtn.backStyle = "wedding.hideBtn.back02";
            _hideBtn.tipData = "";
         }
         else
         {
            _hideBtn.backStyle = "wedding.hideBtn.back01";
            _hideBtn.tipData = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.hideBtn.Tips");
         }
      }
      
      private function __roomSetHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(marryModel.isWeddingMaster)
         {
            MarryManager.instance.creatWeddingRoomSetFrame();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.notMaster"));
         }
      }
      
      private function __inviteBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(marryModel.isWeddingMaster)
         {
            MarryManager.instance.creatWeddingInvateFrame();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.notMaster"));
         }
      }
      
      private function __guideBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc9_:NpcAvatarView = null;
         var _loc5_:CampaignNode = null;
         var _loc2_:int = 0;
         var _loc6_:BaseArmy = null;
         SoundManager.instance.play("022");
         if(_guideBtn)
         {
            _guideBtn.visible = false;
         }
         var _loc3_:int = guideState;
         _clickIndexList.push(_loc3_);
         var _loc7_:int = 0;
         switch(_loc3_)
         {
            case 0:
               break;
            case 1:
               _loc7_ = 3;
               break;
            case 2:
               _loc7_ = 8;
               break;
            case 3:
               _loc7_ = 8;
               break;
            case 4:
               _loc4_ = 21;
               break;
            case 5:
               _loc7_ = 8;
         }
         if(_loc7_ == 3 || _loc7_ == 8)
         {
            for each(var _loc8_:NpcAvatarView in _npcLayer.avatarList)
            {
               _loc5_ = _loc8_.nodeInfo as CampaignNode;
               if(_loc5_.param1 == _loc7_)
               {
                  _loc9_ = _loc8_;
                  break;
               }
            }
            if(_loc9_)
            {
               if(CampaignManager.instance.controller)
               {
                  CampaignManager.instance.controller.moveArmyByPos(_loc9_.nodeInfo.posX * 20,_loc9_.nodeInfo.posY * 20,false,true);
               }
            }
         }
         if(_loc4_ > 0)
         {
            SpaceManager.instance.serchId = _loc4_;
            _loc2_ = 0;
            _loc6_ = ArmyManager.instance.army;
            if(_loc6_)
            {
               _loc2_ = int(_loc6_.id);
            }
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(_loc2_);
         }
      }
      
      private function __stateHandler(param1:String, param2:Object) : void
      {
         addAllBtn();
         setGuideState();
      }
      
      private function setGuideState() : void
      {
         if(_guideBtn == null)
         {
            return;
         }
         var _loc1_:int = guideState;
         if(_clickIndexList.indexOf(_loc1_) >= 0)
         {
            return;
         }
         _guideBtn.visible = true;
         switch(_loc1_)
         {
            case 0:
               _guideBtn.visible = false;
               break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               _guideBtn.backStyle = "asset.wedding.guideBtnBack0" + _loc1_;
               if(_loc1_ == 4)
               {
                  _guideBtn.backgoundInnerRectString = "85,22,21,23";
               }
               else
               {
                  _guideBtn.backgoundInnerRectString = "85,22,18,23";
               }
               _guideBtn.text = LanguageMgr.GetTranslation("map.campaign.mediator.marry.MarryUIMediator.guideBtn.text0" + _loc1_);
         }
      }
      
      private function get guideState() : int
      {
         var _loc1_:int = 0;
         if(marryModel.isWeddingMaster && marryModel.selfMarryInfo.speTemplateId != 0)
         {
            _loc1_ = 1;
         }
         else if(marryModel.canAddCake)
         {
            _loc1_ = 2;
         }
         else if(marryModel.canAddBubbly)
         {
            _loc1_ = 3;
         }
         else if(marryModel.canRideCar)
         {
            _loc1_ = 4;
         }
         else if(marryModel.canHandGift)
         {
            _loc1_ = 5;
         }
         else
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function layout(param1:NotificationEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(!_btnDic[_loc2_])
         {
            return;
         }
         var _loc3_:DisplayObject = _btnDic[_loc2_] as DisplayObject;
         _loc3_.y = _loc2_.y - _loc3_.height - 135;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            CampaignManager.instance.mapModel.selectNode = _loc3_.nodeInfo as CampaignNode;
            _loc3_.attackFun();
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            CampaignManager.instance.mapModel.selectNode = _loc2_.info as CampaignNode;
            _loc2_.mouseClickHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            _loc3_.mouseMoveHandler(param1);
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            _loc2_.mouseMoveHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            _loc3_.mouseOutHandler(param1);
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            _loc2_.mouseOutHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_hideBtn)
         {
            _hideBtn.x = (StageReferance.stageWidth - _roomSetBtn.width >> 0) - 5;
         }
         if(_hideBtn)
         {
            _hideBtn.y = 10;
         }
         if(_roomSetBtn)
         {
            _roomSetBtn.x = (StageReferance.stageWidth - _roomSetBtn.width >> 0) - 5;
         }
         if(_roomSetBtn)
         {
            _roomSetBtn.y = 57;
         }
         if(_inviteBtn)
         {
            _inviteBtn.x = (StageReferance.stageWidth - _roomSetBtn.width >> 0) - 5;
         }
         if(_inviteBtn)
         {
            _inviteBtn.y = 104;
         }
         if(_leftBack)
         {
            _leftBack.x = (StageReferance.stageWidth - _roomSetBtn.width) / 2;
         }
         if(_leftBack)
         {
            _leftBack.y = 0;
         }
         if(_leftTxt)
         {
            _leftTxt.x = (StageReferance.stageWidth - _roomSetBtn.width) / 2 + 23;
         }
         if(_leftTxt)
         {
            _leftTxt.y = 3;
         }
         if(_guideBtn)
         {
            _guideBtn.x = (StageReferance.stageWidth - _guideBtn.width) / 2;
         }
         if(_guideBtn)
         {
            _guideBtn.y = StageReferance.stageHeight - 150;
         }
      }
      
      private function getBackStyle() : String
      {
         var _loc1_:String = "";
         if(marryModel.canAddCake)
         {
            _loc1_ = "asset.map.marryNpcBtnAsset8_1";
         }
         else if(marryModel.canAddBubbly)
         {
            _loc1_ = "asset.map.marryNpcBtnAsset8_2";
         }
         else if(marryModel.canFetchFlower)
         {
            _loc1_ = "asset.map.marryNpcBtnAsset8_3";
         }
         else if(marryModel.canBuyFirework)
         {
            _loc1_ = "asset.map.marryNpcBtnAsset8_4";
         }
         return _loc1_;
      }
      
      private function addAllBtn() : void
      {
         var _loc2_:CampaignNode = null;
         var _loc3_:SimpleBitmapButton = null;
         if(_btnDic == null)
         {
            _btnDic = new Dictionary(true);
         }
         if(_itemDic == null)
         {
            _itemDic = new Dictionary(true);
         }
         for each(var _loc1_:NpcAvatarView in _npcLayer.avatarList)
         {
            _loc2_ = _loc1_.nodeInfo as CampaignNode;
            if(_loc2_.info.types == 61)
            {
               _loc3_ = _btnDic[_loc1_];
               if(_loc2_.param1 == 3)
               {
                  if(!_loc3_)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.marry.NPCBtn" + _loc2_.param1);
                     _loc3_.addEventListener("click",__onClickHandler);
                     _loc3_.addEventListener("mouseOver",__onOverHandler);
                     _loc3_.addEventListener("mouseOut",__onOutHandler);
                     _btnDic[_loc1_] = _loc3_;
                  }
                  _itemDic[_loc3_] = _loc1_;
                  if(!_loc3_.parent)
                  {
                     _loc3_.x = _loc1_.x - _loc3_.width / 2 - 3;
                     _loc3_.y = _loc1_.y - _loc3_.height - 135;
                     _uiSprite.addChild(_loc3_);
                  }
               }
               else if(_loc2_.param1 == 8 && marryModel.weddingInfo.property2 == 3)
               {
                  if(marryModel.canBuyFirework && !marryModel.canAddCake && !marryModel.canAddBubbly && !marryModel.canFetchFlower)
                  {
                     return;
                  }
                  if(!_loc3_)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.marry.NPCBtn" + _loc2_.param1);
                     _loc3_.addEventListener("click",__onClickHandler);
                     _loc3_.addEventListener("mouseOver",__onOverHandler);
                     _loc3_.addEventListener("mouseOut",__onOutHandler);
                     _btnDic[_loc1_] = _loc3_;
                  }
                  _itemDic[_loc3_] = _loc1_;
                  _loc3_.backStyle = getBackStyle();
                  if(!_loc3_.parent)
                  {
                     _loc3_.x = _loc1_.x - _loc3_.width / 2 - 5;
                     _loc3_.y = _loc1_.y - _loc3_.height - 135;
                     _uiSprite.addChild(_loc3_);
                  }
               }
            }
         }
      }
      
      private function clearAllBtn() : void
      {
         for(var _loc1_:String in _btnDic)
         {
            if(_btnDic[_loc1_] is MovieButton)
            {
               _btnDic[_loc1_].removeEventListener("click",__onClickHandler);
               _btnDic[_loc1_].removeEventListener("mouseOver",__onOverHandler);
               _btnDic[_loc1_].removeEventListener("mouseOut",__onOutHandler);
               _btnDic[_loc1_].dispose();
            }
            _btnDic[_loc1_] = null;
            delete _btnDic[_loc1_];
         }
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_] = null;
            delete _itemDic[_loc2_];
         }
         _itemDic = null;
         _btnDic = null;
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get roomInfo() : MarryRoomInfo
      {
         for each(var _loc1_:MarryRoomInfo in marryModel.roomDic)
         {
            if(_loc1_.userIdA == marryModel.weddingInfo.userIdA || _loc1_.userIdA == marryModel.weddingInfo.userIdB)
            {
               return _loc1_;
            }
         }
         return null;
      }
   }
}

