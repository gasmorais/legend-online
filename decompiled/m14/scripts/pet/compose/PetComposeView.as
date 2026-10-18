package pet.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import managers.PetSocketOut;
   import mvc.controler.PetController;
   import mvc.module.pet.PetData;
   import mvc.module.shop.ShopGoodsInfo;
   import pet.common.PetAvatarView;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PetComposeGoodsTemplete;
   import yishi.datas.templates.PetTemplate;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MaskUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class PetComposeView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _mainPetView:PetComposeHeadView;
      
      private var _composedPreView:PetComposeHeadView;
      
      private var _needMaterialImg:Image;
      
      private var _needGoldImg:Image;
      
      private var _needGoldTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _composeBtn:IconButton;
      
      private var _immediatelyComposeBtn:IconButton;
      
      private var _arrowImg:Image;
      
      private var _pointImg:Bitmap;
      
      public var dragCallBack:Function;
      
      private var _controller:PetController = FrameControllerManager.instance.petController;
      
      private var _dragData:PetData;
      
      private var _bodyContainer:Component;
      
      private var _downPoint:Point = new Point();
      
      private var _composeType:int = -1;
      
      private var payType:int = 2;
      
      private var petId:int = 0;
      
      public var _petComposeMc:MovieClip;
      
      private var _pet1View:PetAvatarView;
      
      private var _pet2View:PetAvatarView;
      
      private var _materialViewList:Array;
      
      private var _data:PetData;
      
      private var _composeTemplate:PetComposeGoodsTemplete;
      
      private var _composedPetData:PetData;
      
      public function PetComposeView(param1:Function)
      {
         dragCallBack = param1;
         super();
         addEvent();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetComposeMaterialView = null;
         _back = ComponentFactory.Instance.creat("asset.pet.ComposeBack");
         _mainPetView = ComponentFactory.Instance.creatCustomObject("PetComposeView.avatarView1");
         _composedPreView = ComponentFactory.Instance.creatCustomObject("PetComposeView.avatarView2");
         _arrowImg = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.arrowImg");
         _needMaterialImg = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.needMaterialImg");
         _needGoldImg = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.needGoldImg");
         _needGoldTxt = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.needGoldTxt");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.hbox");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.VoucherIconAsset");
         _pointImg.x = 72;
         _pointImg.y = 5;
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("PetComposeView.composeBtn");
         _composeBtn.enable = false;
         _immediatelyComposeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.composeView.immediatelyComposeBtn");
         addChild(_back);
         addChild(_mainPetView);
         addChild(_composedPreView);
         addChild(_arrowImg);
         addChild(_needMaterialImg);
         addChild(_needGoldImg);
         addChild(_needGoldTxt);
         addChild(_hbox);
         addChild(_composeBtn);
         addChild(_immediatelyComposeBtn);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new PetComposeMaterialView();
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
         _needGoldTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
      }
      
      private function uint() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_mainPetView);
         _mainPetView = null;
         ObjectUtils.disposeObject(_composedPreView);
         _composedPreView = null;
         ObjectUtils.disposeObject(_needMaterialImg);
         _needMaterialImg = null;
         ObjectUtils.disposeObject(_needGoldImg);
         _needGoldImg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_immediatelyComposeBtn);
         _immediatelyComposeBtn = null;
         ObjectUtils.disposeObject(_arrowImg);
         _arrowImg = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_bodyContainer);
         _bodyContainer = null;
         ObjectUtils.disposeViolentMc(_petComposeMc);
         _petComposeMc = null;
         ObjectUtils.disposeObject(_pet1View);
         _pet1View = null;
         ObjectUtils.disposeObject(_pet2View);
         _pet2View = null;
         _materialViewList = null;
      }
      
      private function addEvent() : void
      {
         _mainPetView.addEventListener("mouseDown",__mouseDownHandler);
         _mainPetView.addEventListener("mouseUp",__removeMainPetHandler);
         _composeBtn.addEventListener("click",__composeBtnClickHandler);
         _immediatelyComposeBtn.addEventListener("click",__immediatelyComposeBtnClickHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mainPetView)
         {
            _mainPetView.removeEventListener("mouseDown",__mouseDownHandler);
            _mainPetView.removeEventListener("mouseUp",__removeMainPetHandler);
            _mainPetView.removeEventListener("mouseMove",__mouseMoveHandler);
         }
         if(_composedPreView)
         {
            _composedPreView.removeEventListener("click",__removePreViewHandler);
         }
         if(_composeBtn)
         {
            _composeBtn.removeEventListener("click",__composeBtnClickHandler);
         }
         if(_immediatelyComposeBtn)
         {
            _immediatelyComposeBtn.removeEventListener("click",__immediatelyComposeBtnClickHandler);
         }
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(_mainPetView.data)
         {
            _downPoint.x = param1.stageX;
            _downPoint.y = param1.stageY;
            _mainPetView.addEventListener("mouseMove",__mouseMoveHandler);
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         if(Point.distance(_loc2_,_downPoint) < 3)
         {
            return;
         }
         _mainPetView.removeEventListener("mouseMove",__mouseMoveHandler);
         _dragData = _mainPetView.data;
         _mainPetView.data = null;
         beginDrag("down");
      }
      
      private function beginDrag(param1:String) : void
      {
         if(!_dragData)
         {
            return;
         }
         var _loc3_:PetAvatarView = new PetAvatarView();
         _loc3_.data = _dragData.template;
         _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":param1
         });
         _loc2_.data = _dragData;
         _loc2_.onDrop = dragBack;
         _loc2_.dropChecks = [PetComposeHeadView,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.dropTarget is PetComposeHeadView)
         {
            _loc2_ = param1.dropTarget as DisplayObject;
         }
         ObjectUtils.disposeAllChildren(param1.dragIcon as Sprite);
         ObjectUtils.disposeObject(param1.dragIcon);
         NotificationManager.instance.sendNotification("END_DRAG",{
            "target":_loc2_,
            "data":_dragData
         });
         _dragData = null;
         _bodyContainer = null;
      }
      
      private function __removeMainPetHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         restoreView();
      }
      
      private function __composeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         if(!_composeTemplate)
         {
            return;
         }
         var _loc3_:PetData = _composedPreView.data;
         if(!_loc3_)
         {
            return;
         }
         if(!_controller)
         {
            return;
         }
         if(!hasEnoughMaterial())
         {
            return;
         }
         var _loc4_:ThaneInfo = ArmyManager.instance.thane;
         var _loc5_:int = int(ResourceManager.instance.gold.count);
         var _loc6_:Boolean = true;
         if(_loc4_.grades < _loc3_.template.NeedGrade)
         {
            _loc6_ = false;
            _loc2_ = LanguageMgr.GetTranslation("petCompose.cannotCompose5",_loc3_.template.NeedGrade,data.template.TemplateName);
         }
         else if(_loc5_ < _composeTemplate.NeedGold)
         {
            _loc6_ = false;
            _loc2_ = LanguageMgr.GetTranslation("public.gold");
         }
         if(!_loc6_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         askComposePet();
      }
      
      private function __immediatelyComposeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         if(!_composeTemplate)
         {
            return;
         }
         var _loc3_:PetData = _composedPreView.data;
         if(!_loc3_)
         {
            return;
         }
         if(!_controller)
         {
            return;
         }
         var _loc4_:ThaneInfo = ArmyManager.instance.thane;
         var _loc5_:int = int(ResourceManager.instance.gold.count);
         var _loc6_:Boolean = true;
         if(_loc4_.grades < _loc3_.template.NeedGrade)
         {
            _loc6_ = false;
            _loc2_ = LanguageMgr.GetTranslation("petCompose.cannotCompose5",_loc3_.template.NeedGrade,data.template.TemplateName);
         }
         else if(_loc5_ < _composeTemplate.NeedGold)
         {
            _loc6_ = false;
            _loc2_ = LanguageMgr.GetTranslation("public.gold");
         }
         if(!_loc6_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!hasEnoughMaterial())
         {
            askImmediatelyComposePet();
         }
         else
         {
            _composeType = 2;
            componentCall(true,true,data);
         }
      }
      
      private function updateToPlayerInfo(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         playerInfo.beginChanges();
         _loc2_ = int(playerInfo.petMonopolyFormationOfArray.indexOf(param1.toString()));
         if(_loc2_ != -1)
         {
            playerInfo.petMonopolyFormationOfArray[_loc2_] = -1;
            _loc3_ = playerInfo.petMonopolyFormationOfArray.join(",");
            playerInfo.petMonopolyFormation = _loc3_;
            MonopolySocketOutManager.sendPetFormation(_loc3_);
         }
         playerInfo.commit();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function hasEnoughMaterial() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:PetComposeMaterialView = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _hbox.numChildren)
         {
            _loc2_ = _hbox.getChildAt(_loc3_) as PetComposeMaterialView;
            _loc4_ = _loc2_.data;
            if(_loc4_ && _loc4_.currentCount < _loc4_.needCount)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function askIsFullInherit() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("petCompose.confirm2",_controller.petCompose100CostPoint);
         SimpleAlertHelper.instance.data = [askIsFullInheritBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true);
      }
      
      private function askIsFullInheritBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(isDie)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         if(data.template.NeedGrade == 2 && !checkNeedAlertPrompt(data))
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("pet.compose.PetComposeView.advComposeViewPropot");
            _composeType = 1;
            SimpleAlertHelper.instance.data = [componentCall,data];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true);
            return;
         }
         if(data)
         {
            _composeType = 1;
            componentCall(true,true,data);
         }
      }
      
      private function componentCall(param1:Boolean, param2:Boolean, param3:PetData = null) : void
      {
         var _loc7_:int = 0;
         var _loc5_:PetComposeMaterialView = null;
         var _loc8_:GoodsInfo = null;
         var _loc4_:ShopGoodsInfo = null;
         if(!param1)
         {
            return;
         }
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _hbox.numChildren)
         {
            _loc5_ = _hbox.getChildAt(_loc7_) as PetComposeMaterialView;
            _loc8_ = _loc5_.data;
            if(_loc8_ && _loc8_.currentCount < _loc8_.needCount)
            {
               _loc4_ = TempleteManager.instance.getShopTempInfoByItemId(_loc8_.templateId);
               _loc6_ += _loc4_.GiftToken * (_loc8_.needCount - _loc8_.currentCount);
            }
            _loc7_++;
         }
         if(_loc6_ > playerInfo.point + playerInfo.giftToken)
         {
            RechargeAlertMannager.show();
            return;
         }
         petId = data.petId;
         _composeBtn.enable = false;
         _immediatelyComposeBtn.enable = true;
         playComposeMovie();
      }
      
      private function checkNeedAlertPrompt(param1:PetData) : Boolean
      {
         if(param1.coeStrength < param1.coeStrengthLimit)
         {
            return false;
         }
         if(param1.coeIntellect < param1.coeIntellectLimit)
         {
            return false;
         }
         if(param1.coeStamina < param1.coeStaminaLimit)
         {
            return false;
         }
         if(param1.coeArmor < param1.coeArmorLimit)
         {
            return false;
         }
         return true;
      }
      
      private function askComposePet() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("petCompose.confirm3");
         SimpleAlertHelper.instance.data = [askComposePetBack,data];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true);
      }
      
      private function askComposePetBack(param1:Boolean, param2:Boolean, param3:PetData) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(isDie)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         if(param3.template.NeedGrade == 2 && !checkNeedAlertPrompt(param3))
         {
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("pet.compose.PetComposeView.advComposeViewPropot");
            _composeType = -1;
            SimpleAlertHelper.instance.data = [componentCall,data];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc4_,_loc5_,true,true);
            return;
         }
         if(param3)
         {
            _composeType = -1;
            componentCall(true,true,param3);
         }
      }
      
      private function askImmediatelyComposePet() : void
      {
         var _loc6_:int = 0;
         var _loc4_:PetComposeMaterialView = null;
         var _loc8_:GoodsInfo = null;
         var _loc3_:ShopGoodsInfo = null;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _hbox.numChildren)
         {
            _loc4_ = _hbox.getChildAt(_loc6_) as PetComposeMaterialView;
            _loc8_ = _loc4_.data;
            if(_loc8_ && _loc8_.currentCount < _loc8_.needCount)
            {
               _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_loc8_.templateId);
               _loc5_ += _loc3_.GiftToken * (_loc8_.needCount - _loc8_.currentCount);
            }
            _loc6_++;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc9_:String = LanguageMgr.GetTranslation("petCompose.confirm4",_loc5_);
         SimpleAlertHelper.instance.data = [askImmediatelyComposePetBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc9_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function askImmediatelyComposePetBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(!param1)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         payType = param2 ? 2 : 1;
         if(data.template.NeedGrade == 2 && !checkNeedAlertPrompt(data))
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("pet.compose.PetComposeView.advComposeViewPropot");
            _composeType = 2;
            SimpleAlertHelper.instance.data = [componentCall,data];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true);
            return;
         }
         if(data)
         {
            _composeType = 2;
            componentCall(true,true,data);
         }
      }
      
      public function playComposeMovie() : void
      {
         var _loc5_:int = 0;
         var _loc2_:PetComposeMaterialView = null;
         var _loc4_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         if(!_mainPetView.data)
         {
            return;
         }
         MaskUtils.instance.maskShow(0);
         KeyBoardRegister.instance.keyEnable = false;
         _petComposeMc = ComponentFactory.Instance.creat("asset.pet.PetComposeMovie");
         _petComposeMc.mouseChildren = false;
         _petComposeMc.x = 228;
         _petComposeMc.y = 186;
         _petComposeMc.gotoAndStop(1);
         var _loc1_:SimpleMovie = new SimpleMovie(_petComposeMc,onMovieEnd,1,1,onMovieEnterFrame);
         _loc1_.mouseChildren = false;
         addChild(_loc1_);
         _pet1View = new PetAvatarView();
         _pet1View.data = _mainPetView.data.template;
         _pet2View = new PetAvatarView();
         _pet2View.data = _composedPreView.data.template;
         _pet1View.y = _pet2View.y = 70;
         _materialViewList = [];
         var _loc3_:int = int(_hbox.numChildren);
         var _loc6_:Array = [{
            "x":-162,
            "y":-24
         },{
            "x":112,
            "y":-24
         },{
            "x":-30,
            "y":-160
         },{
            "x":-30,
            "y":111
         }];
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _hbox.getChildAt(_loc5_) as PetComposeMaterialView;
            if(_loc2_ && _loc2_.data)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("pet.ComposeMaterialCell2");
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc2_.data.templateId;
               _loc4_.data = _loc7_;
               _loc4_.x = _loc6_[_loc5_].x;
               _loc4_.y = _loc6_[_loc5_].y;
               _materialViewList.push(_loc4_);
            }
            _loc5_++;
         }
      }
      
      private function onMovieEnd() : void
      {
         MaskUtils.instance.maskHide();
         KeyBoardRegister.instance.keyEnable = true;
         if(petId != 0)
         {
            updateToPlayerInfo(petId);
            PetSocketOut.composePet(petId,_composeType,payType);
         }
         petId = 0;
         payType = 0;
         _composeType = -1;
         _petComposeMc = null;
         ObjectUtils.disposeObject(_pet1View);
         _pet1View = null;
         ObjectUtils.disposeObject(_pet2View);
         _pet2View = null;
         for each(var _loc1_:Object in _materialViewList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _materialViewList = null;
         if(_composedPreView)
         {
            _composedPreView.addEventListener("click",__removePreViewHandler);
         }
      }
      
      private function __removePreViewHandler(param1:MouseEvent) : void
      {
         _composedPreView.removeEventListener("click",__removePreViewHandler);
         _composedPreView.data = null;
         ShowTipManager.Instance.hideTip(_composedPreView.back);
      }
      
      private function onMovieEnterFrame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_petComposeMc.currentFrame == 13)
         {
            _petComposeMc["body"]["pet1"].addChild(_pet1View);
            _loc1_ = int(_materialViewList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _petComposeMc["body"]["materialview"].addChild(_materialViewList[_loc2_]);
               _loc2_++;
            }
         }
         else if(_petComposeMc.currentFrame == 63)
         {
            _petComposeMc["body"]["pet2"].addChild(_pet2View);
         }
         else if(_petComposeMc.currentFrame == 114)
         {
            _petComposeMc["pet2"].addChild(_pet2View);
            _pet2View.y = 86;
            _pet2View.x = -4;
            restoreView();
         }
         else if(_petComposeMc.currentFrame == 125)
         {
            ObjectUtils.disposeObject(_pet2View);
            _pet2View = null;
            _composedPreView.data = _composedPetData;
            _composedPreView.backTipStyle = "yishi.view.tips.PetCompareTip";
            _composedPreView.petTips = _composedPetData;
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:DisplayObject = param1.data.target;
         var _loc2_:PetData = param1.data.data;
         if(_loc2_ == _dragData)
         {
            if(_loc3_ == _mainPetView)
            {
               _mainPetView.data = _loc2_;
            }
            else
            {
               restoreView();
            }
            return;
         }
         if(_loc3_ != _mainPetView)
         {
            return;
         }
         if(!checkCanComposeAndTip(_loc2_))
         {
            return;
         }
         if(dragCallBack != null)
         {
            dragCallBack(_loc2_);
         }
      }
      
      private function checkCanComposeAndTip(param1:PetData) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         if(!isOpenComposed(param1))
         {
            _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose2");
         }
         if(!param1 || !param1.template)
         {
            _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose");
         }
         else if(param1.template.NeedGrade == 1)
         {
            if(ArmyManager.instance.thane.grades < 50)
            {
               _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose5",50,param1.template.TemplateName);
            }
            if(param1.quality < 4)
            {
               _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose3",param1.template.TemplateName);
            }
         }
         else if(VersionSwitch.SENIOR_PETCOMPOSE && param1.template.NeedGrade == 2)
         {
            if(param1.quality != 5)
            {
               _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose4",param1.template.TemplateName);
            }
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("petCompose.cannotCompose1");
         }
         if(_loc3_)
         {
            _loc2_ = false;
            MessageTipManager.instance().show(_loc3_);
         }
         else
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function isOpenComposed(param1:PetData) : Boolean
      {
         return true;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(!param1)
         {
            return;
         }
         if(!checkCanComposeAndTip(param1))
         {
            if(dragCallBack != null)
            {
               dragCallBack(null);
            }
            return;
         }
         _data = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetComposeMaterialView = null;
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         _composeTemplate = getComposeTemplate(data);
         if(!_composeTemplate)
         {
            return;
         }
         _needGoldTxt.text = _composeTemplate.NeedGold + "";
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = _hbox.getChildAt(_loc2_) as PetComposeMaterialView;
            _loc3_ = _loc2_ + 1;
            if(_composeTemplate.hasOwnProperty("NeedItemTempId" + _loc3_) && _composeTemplate["NeedItemTempId" + _loc3_] > 0)
            {
               _loc1_.visible = true;
               _loc4_ = _loc1_.data;
               if(!_loc4_)
               {
                  _loc4_ = new GoodsInfo();
               }
               _loc4_.templateId = _composeTemplate["NeedItemTempId" + _loc3_];
               _loc4_.needCount = _composeTemplate["NeedItemTempIdCount" + _loc3_];
               _loc4_.currentCount = GoodsManager.instance.getGoodsNumByTempId(_loc4_.templateId);
               _loc1_.data = _loc4_;
            }
            else
            {
               _loc1_.data = null;
               _loc1_.visible = false;
            }
            _loc2_++;
         }
         _composedPetData = getComposedPetData(data,_composeTemplate,true);
         _composedPreView.data = _composedPetData;
         _mainPetView.data = data;
         _composedPreView.backTipStyle = "yishi.view.tips.PetComposeCompareTip";
         _composedPreView.petTips = _mainPetView.petTips = [data,_composedPetData];
         _composeBtn.enable = hasEnoughMaterial();
         _composedPreView.removeEventListener("click",__removePreViewHandler);
      }
      
      private function restoreView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:PetComposeMaterialView = null;
         _composeTemplate = null;
         _needGoldTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
         _composedPreView.data = _mainPetView.data = null;
         _composedPreView.petTips = _mainPetView.petTips = null;
         var _loc2_:int = int(_hbox.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _hbox.getChildAt(_loc3_) as PetComposeMaterialView;
            _loc1_.data = null;
            _loc1_.visible = true;
            _loc3_++;
         }
         _composeBtn.enable = false;
         _data = null;
         if(dragCallBack != null)
         {
            dragCallBack(null);
         }
      }
      
      public function getComposeTemplate(param1:PetData) : PetComposeGoodsTemplete
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:Vector.<PetComposeGoodsTemplete> = _controller.getComposePetTemplateList();
         for each(var _loc3_:PetComposeGoodsTemplete in _loc2_)
         {
            if(_loc3_.Pet1Types == param1.template.PetType && _loc3_.Pet1Grade == param1.template.NeedGrade)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getComposedPetData(param1:PetData, param2:PetComposeGoodsTemplete, param3:Boolean) : PetData
      {
         var _loc4_:PetData = param1.clone();
         var _loc6_:Number = 1;
         var _loc7_:Vector.<PetTemplate> = TempleteManager.instance.petTemplateCate.getPetTemplatesByType(param2.ResultPetTypes);
         var _loc8_:Dictionary = TempleteManager.instance.petTemplateCate.getTemplates();
         for each(var _loc5_:PetTemplate in _loc7_)
         {
            if(_loc5_.NeedGrade == param2.ResultPetGrade && _loc5_.Quality == _loc4_.quality)
            {
               _loc4_.templateId = _loc5_.TemplateId;
               break;
            }
         }
         _loc4_.intellect = _loc4_.intellectBase;
         _loc4_.strength = _loc4_.strengthBase;
         _loc4_.stamina = _loc4_.staminaBase;
         _loc4_.armor = _loc4_.armorBase;
         _loc4_.remainPoint = (_loc4_.grade - 1) * 5;
         _loc4_.fightPower = PetData.calculatefightPower(_loc4_);
         _loc4_.name = _loc4_.template.TemplateName;
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         if(_petComposeMc)
         {
            MaskUtils.instance.maskHide();
            KeyBoardRegister.instance.keyEnable = true;
         }
         if(DragManager.getInstance().isDraging)
         {
            DragManager.getInstance().stopDrag();
         }
         removeEvent();
         uint();
         _dragData = null;
         _composedPetData = null;
         _composeTemplate = null;
         _controller = null;
         super.dispose();
      }
   }
}

