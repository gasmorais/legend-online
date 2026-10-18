package fashion
{
   import avatar.view.ShowAvatar;
   import cell.view.fashionbag.FashionBag;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.FashionManager;
   import managers.ShopManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.utils.ThaneEquipShowHelper;
   
   public class FashionStoreFrame extends Frame implements IManualSize
   {
      
      private var _composeBtn:SelectedButton;
      
      private var _switchBtn:SelectedButton;
      
      private var _refreshBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _back:Scale9CornerImage;
      
      private var _heroBack:ScaleFrameImage;
      
      private var _rightBack:MutipleImage;
      
      private var _bagBack:MovieClip;
      
      private var _hGapLine:Bitmap;
      
      private var _vGapLine:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _powerNumTxt:FilterFrameText;
      
      private var _figure:ShowAvatar;
      
      private var _mask:Shape;
      
      private var _composeView:FashionComposeView;
      
      private var _switchView:FashionSwitchView;
      
      private var _refreshView:FashionRefreshView;
      
      private var _switchTip:TextButton;
      
      private var _switchTip2:TextButton;
      
      private var _fashionBag:FashionBag;
      
      private var _showThane:ThaneInfo;
      
      private var _buyFashionBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _powerTxt2:FilterFrameText;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _propertyTxt1:FilterFrameText;
      
      private var _propertyTopsTxt:FilterFrameText;
      
      private var _propertyShowImg:Image;
      
      private var _propertyShowTxt:FilterFrameText;
      
      private var _changeShowBtn:TextButton;
      
      private var _curretnStatus:Boolean;
      
      private var _changeBg:Image;
      
      public function FashionStoreFrame()
      {
         super();
         model.scene = "FASHION_STORE_SCENE";
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,660,600);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function initView() : void
      {
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.composeBtn");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.switchBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.refreshBtn");
         _back = ComponentFactory.Instance.creatComponentByStylename("fashionstore.Frame.back");
         _heroBack = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.heroBack");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.rightBack");
         _bagBack = ComponentFactory.Instance.creat("asset.fashion.bagBack");
         _hGapLine = ComponentFactory.Instance.creatBitmap("asset.playerinfo.hGapLine");
         _vGapLine = ComponentFactory.Instance.creatBitmap("asset.fashion.vGapLine");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.levelText");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.nameText");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.powerText");
         _powerNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.powerNumText");
         _switchTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitcTip");
         _changeShowBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.changeShowBtn");
         _powerTxt2 = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.powerTxt2");
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.propertyTxt");
         _changeBg = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.changeBg");
         _switchTip2 = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitcTip2");
         _powerTxt2.visible = false;
         _propertyTxt.visible = false;
         _propertyTxt1 = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.propertyRefreshTxt");
         _propertyTxt1.visible = false;
         _propertyTopsTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.propertyTipsTxt");
         _propertyTopsTxt.visible = false;
         _propertyTopsTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips24");
         _buyFashionBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.buyBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.helpBtn");
         _propertyShowImg = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.propertyShowImg");
         _propertyShowTxt = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.propertyShowTxt");
         _helpBtn.tipData = LanguageMgr.GetTranslation("fashion.FashionStoreFrame.helpBtn.tipData");
         _helpBtn.tipGapH = 10;
         _helpBtn.tipDirctions = "1,0,2";
         _helpBtn.x = 564;
         _helpBtn.y = -31;
         _figure = new ShowAvatar(true);
         _figure.x = 0;
         _figure.y = 145;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _switchTip.mouseEnabled = false;
         _switchTip.x = 295;
         _switchTip.y = 0;
         _switchTip2.mouseEnabled = false;
         _mask = new Shape();
         addToContent(_back);
         addToContent(_heroBack);
         addToContent(_rightBack);
         addToContent(_vGapLine);
         addToContent(_mask);
         addToContent(_figure);
         _figure.mask = _mask;
         addToContent(_composeBtn);
         addToContent(_switchBtn);
         addToContent(_refreshBtn);
         addToContent(_switchTip);
         if(VersionSwitch.DRAGONIC_FASHION)
         {
            addToContent(_changeBg);
            addToContent(_changeShowBtn);
            addToContent(_switchTip2);
         }
         addToContent(_levelTxt);
         addToContent(_nameTxt);
         addToContent(_powerTxt);
         addToContent(_powerTxt2);
         addToContent(_propertyTxt);
         addToContent(_propertyTxt1);
         addToContent(_propertyTopsTxt);
         addToContent(_powerNumTxt);
         addToContent(_buyFashionBtn);
         addToContent(_propertyShowImg);
         addToContent(_propertyShowTxt);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_composeBtn);
         _btnGroup.addSelectItem(_switchBtn);
         _btnGroup.addSelectItem(_refreshBtn);
         __heroInfoChangeHandler(null);
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_heroBack.width - 5,_heroBack.height);
         _mask.graphics.endFill();
         _mask.x = _heroBack.x;
         _mask.y = _heroBack.y;
         _fashionBag = new FashionBag(2,7);
         addToContent(_fashionBag);
         _fashionBag.x = 276;
         _fashionBag.y = 370;
         setSwitchTipText();
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc2_:Dictionary = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc7_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc1_:GoodsInfo = null;
         var _loc8_:GoodsInfo = null;
         if(playerInfo.vocationGrades > 0)
         {
            _heroBack.setFrame(thane.templateInfo.Job + 3);
         }
         else
         {
            _heroBack.setFrame(thane.templateInfo.Job);
         }
         _showThane = new ThaneInfo();
         _showThane.templateId = thane.templateId;
         if(model.lookDragonTalkerFashion)
         {
            _loc2_ = ArmyManager.instance.dragonFashionList;
            _loc5_ = _loc2_[8];
            _loc3_ = _loc2_[9];
            _loc7_ = _loc2_[10];
            _loc4_ = _loc2_[11];
            _showThane.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
            _showThane.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
            _showThane.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
            _showThane.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         else
         {
            _loc2_ = ArmyManager.instance.fashionList;
            _loc5_ = _loc2_[8];
            _loc3_ = _loc2_[9];
            _loc7_ = _loc2_[10];
            _loc4_ = _loc2_[11];
            _loc6_ = int(ArmyManager.instance.thane.id);
            _loc1_ = GoodsManager.instance.getItemByPOB(0,_loc6_,4);
            _loc8_ = GoodsManager.instance.getItemByPOB(2,_loc6_,4);
            if(_loc8_)
            {
               _showThane.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
            }
            if(_loc1_)
            {
               _showThane.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc1_);
            }
            _showThane.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
            _showThane.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
            _showThane.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
            _showThane.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         _figure.data = _showThane;
      }
      
      public function show(param1:int, param2:Boolean) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("fashionStoreFrame.title");
         model.lookDragonTalkerFashion = param2;
         _btnGroup.selectIndex = param1;
      }
      
      private function __heroInfoChangeHandler(param1:PlayerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(thane.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _loc3_ = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _loc3_ = thane.nickName;
         }
         _loc2_ = thane.consortiaName ? " < " + thane.consortiaName + " >" : "";
         _levelTxt.text = LanguageMgr.GetTranslation("public.level2",thane.grades);
         _nameTxt.text = _loc3_ + _loc2_;
         _powerTxt.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap");
         _powerNumTxt.text = playerInfo.fightingCapacity.toString();
         _powerTxt2.htmlText = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap") + StringHelper.format("<font face=\'Arial\'>{0}</font>",playerInfo.fightingCapacity);
         _refreshBtn.enable = ArmyManager.instance.fashionInfoMsg.grades > 0;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         thane.addEventListener("THANE_INFO_UPDATE",__heroInfoChangeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__heroInfoChangeHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__changeHandler);
         }
         _buyFashionBtn.addEventListener("click",__gotoShopFrame);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__openHelpFrame);
         }
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         NotificationManager.instance.addEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         if(_changeShowBtn)
         {
            _changeShowBtn.addEventListener("click",__changeShowBtnHandler);
         }
      }
      
      private function setSwitchTipText() : void
      {
         if(model.lookDragonTalkerFashion)
         {
            if(model.newFashionDragonTalkerCount > 0)
            {
               _switchTip.text = model.newFashionDragonTalkerCount + "";
               _switchTip.visible = true;
            }
            else
            {
               _switchTip.visible = false;
            }
            if(model.newFashionCount > 0 && _btnGroup.selectIndex == 1)
            {
               _switchTip2.text = model.newFashionCount + "";
               _switchTip2.visible = true;
            }
            else
            {
               _switchTip2.visible = false;
            }
         }
         else
         {
            if(model.newFashionCount > 0)
            {
               _switchTip.text = model.newFashionCount + "";
               _switchTip.visible = true;
            }
            else
            {
               _switchTip.visible = false;
            }
            if(model.newFashionDragonTalkerCount > 0 && _btnGroup.selectIndex == 1)
            {
               _switchTip2.text = model.newFashionDragonTalkerCount + "";
               _switchTip2.visible = true;
            }
            else
            {
               _switchTip2.visible = false;
            }
         }
      }
      
      private function __receivedBookHandler(param1:FashionEvent) : void
      {
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         setSwitchTipText();
         if(_propertyTxt)
         {
            _loc2_ = FashionManager.instance.fashionModel.getIdentityedProperties();
            _loc5_ = FashionManager.instance.fashionModel.getAllSwitchAdd();
            _loc3_ = LanguageMgr.GetTranslation("fashion.tip.total2");
            _loc6_ = int(_loc5_.length);
            _loc7_ = "";
            _loc4_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc4_ = Math.floor(_loc5_[_loc8_] / 100 * _loc2_[_loc8_]);
               _loc7_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _loc3_ += "\n" + LanguageMgr.GetTranslation("fashion.tip.total0" + (_loc8_ + 1),_loc2_[_loc8_],_loc7_);
               _loc8_ += 1;
            }
            _propertyShowImg.tipData = _loc3_;
         }
      }
      
      private function __clickCell(param1:Array, param2:Array) : void
      {
         _propertyShowImg.tipData = getRefreshAttri(param1,param2);
      }
      
      private function getRefreshAttri(param1:Array, param2:Array) : String
      {
         var _loc8_:int = 0;
         var _loc3_:String = LanguageMgr.GetTranslation("fashion.tip.totalRefresh01");
         var _loc4_:Array = FashionManager.instance.fashionModel.getIdentityedAttriteds();
         var _loc5_:int = int(_loc4_.length);
         var _loc7_:String = "";
         var _loc6_:String = "";
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc7_ = LanguageMgr.GetTranslation("fashion.refreshView.tips22",param1[_loc8_]);
            _loc6_ = LanguageMgr.GetTranslation("fashion.refreshView.tips10",param2[_loc8_]);
            if(param2[_loc8_] == "")
            {
               _loc6_ = "";
            }
            _loc3_ += "\n" + LanguageMgr.GetTranslation("fashion.tip.totalRefresh02",_loc4_[_loc8_],_loc7_,_loc6_);
            _loc8_ += 1;
         }
         return _loc3_;
      }
      
      private function __onComposeCallback(param1:FashionEvent) : void
      {
         if(!param1.data)
         {
            return;
         }
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         switch(int(_loc2_.templateInfo.SonType) - 109)
         {
            case 0:
               _showThane.wingAvata = _loc2_.templateInfo.Avata;
               break;
            case 1:
               _showThane.hairFashionAvata = _loc2_.templateInfo.Avata;
               break;
            case 2:
               _showThane.armsFashionAvata = _loc2_.templateInfo.Avata;
               break;
            case 3:
               _showThane.bodyFashionAvata = _loc2_.templateInfo.Avata;
         }
         _figure.data = _showThane;
      }
      
      private function __changeHandler(param1:Event) : void
      {
         model.moveGoodsBack();
         model.to_pos = 0;
         refreshHeroFigure();
         _powerTxt.visible = false;
         _nameTxt.visible = false;
         _powerTxt2.visible = false;
         _propertyTxt.visible = false;
         _powerNumTxt.visible = false;
         _levelTxt.visible = false;
         _propertyTxt1.visible = false;
         _propertyTopsTxt.visible = false;
         closeOtherView();
         _propertyShowImg.visible = true;
         _propertyShowTxt.visible = true;
         if(_btnGroup.selectIndex == 0)
         {
            showComposeView();
            if(_rightBack)
            {
               _rightBack.visible = true;
            }
            if(_fashionBag)
            {
               _fashionBag.visible = true;
            }
            if(_hGapLine)
            {
               _hGapLine.visible = true;
            }
            if(_bagBack)
            {
               _bagBack.visible = true;
            }
            model.selectedPanel = "FASHION_COMPOSE_PANEL";
            _levelTxt.visible = true;
            _powerTxt.visible = true;
            _powerNumTxt.visible = true;
            _nameTxt.visible = true;
            _propertyShowImg.visible = false;
            _propertyShowTxt.visible = false;
         }
         else if(_btnGroup.selectIndex == 1)
         {
            showSwitchView();
            if(_rightBack)
            {
               _rightBack.visible = false;
            }
            if(_fashionBag)
            {
               _fashionBag.visible = false;
            }
            if(_hGapLine)
            {
               _hGapLine.visible = false;
            }
            if(_bagBack)
            {
               _bagBack.visible = false;
            }
            model.selectedPanel = "FASHION_SWITCH_PANEL";
            _propertyShowImg.y = _propertyShowTxt.y = 70;
            _propertyShowTxt.text = LanguageMgr.GetTranslation("fashion.FashionStoreFrame.showSwitchView.text");
            _powerTxt2.visible = true;
            _propertyTxt.visible = true;
         }
         else if(_btnGroup.selectIndex == 2)
         {
            showRefreshView();
            if(_rightBack)
            {
               _rightBack.visible = false;
            }
            if(_fashionBag)
            {
               _fashionBag.visible = false;
            }
            if(_hGapLine)
            {
               _hGapLine.visible = false;
            }
            if(_bagBack)
            {
               _bagBack.visible = false;
            }
            model.selectedPanel = "FASHION_REFRESH_PANEL";
            _propertyShowImg.y = _propertyShowTxt.y = 90;
            _propertyShowTxt.text = LanguageMgr.GetTranslation("fashion.FashionStoreFrame.showRefreshView.text");
            _levelTxt.visible = true;
            _powerTxt.visible = true;
            _powerNumTxt.visible = true;
            _nameTxt.visible = true;
            _propertyTxt1.visible = true;
            _propertyTopsTxt.visible = true;
         }
         if(!dragonTalkerModel.isOpen)
         {
            _changeShowBtn.text = LanguageMgr.GetTranslation("fashion.changeBtn.text2");
            _changeShowBtn.enable = false;
            _changeBg.tipData = LanguageMgr.GetTranslation("fashion.changeBtn.text3");
         }
         else
         {
            _changeShowBtn.text = model.lookDragonTalkerFashion ? LanguageMgr.GetTranslation("fashion.changeBtn.text1") : LanguageMgr.GetTranslation("fashion.changeBtn.text2");
            _changeShowBtn.enable = true;
         }
         setSwitchTipText();
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function showComposeView() : void
      {
         if(!_composeView)
         {
            _composeView = new FashionComposeView();
            _composeView.x = 315;
            _composeView.y = 52;
            addToContent(_composeView);
            _composeView.addEventListener("COMPOSE_SUCCEED",__onComposeCallback);
         }
      }
      
      private function showSwitchView() : void
      {
         if(!_switchView)
         {
            _switchView = new FashionSwitchView();
            _switchView.x = 277;
            _switchView.y = 51;
            addToContent(_switchView);
            _switchView.addEventListener("FASHION_BOOK_WEAR",__wearHandler);
         }
      }
      
      private function showRefreshView() : void
      {
         if(!_refreshView)
         {
            _refreshView = new FashionRefreshView(__clickCell);
            _refreshView.x = 265;
            _refreshView.y = 40;
            addToContent(_refreshView);
         }
      }
      
      private function closeOtherView() : void
      {
         if(_composeView)
         {
            _composeView.removeEventListener("COMPOSE_SUCCEED",__onComposeCallback);
         }
         if(_switchView)
         {
            _switchView.removeEventListener("FASHION_BOOK_WEAR",__wearHandler);
         }
         ObjectUtils.disposeObject(_composeView);
         _composeView = null;
         ObjectUtils.disposeObject(_switchView);
         _switchView = null;
         ObjectUtils.disposeObject(_refreshView);
         _refreshView = null;
      }
      
      private function __wearHandler(param1:FashionEvent) : void
      {
         param1.stopPropagation();
         if(!param1.data)
         {
            return;
         }
         var _loc2_:GoodsTemplateInfo = param1.data.data as GoodsTemplateInfo;
         switch(int(_loc2_.SonType) - 109)
         {
            case 0:
               _showThane.wingAvata = _loc2_.Avata;
               break;
            case 1:
               _showThane.hairFashionAvata = _loc2_.Avata;
               break;
            case 2:
               _showThane.armsFashionAvata = _loc2_.Avata;
               break;
            case 3:
               _showThane.bodyFashionAvata = _loc2_.Avata;
         }
         _figure.data = _showThane;
      }
      
      private function __fashionMsgHandler(param1:NotificationEvent = null) : void
      {
         _refreshBtn.enable = ArmyManager.instance.fashionInfoMsg.grades > 0;
         refreshHeroFigure();
      }
      
      private function __changeShowBtnHandler(param1:MouseEvent) : void
      {
         model.lookDragonTalkerFashion = !model.lookDragonTalkerFashion;
         __heroInfoChangeHandler(null);
         __changeHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         thane.removeEventListener("THANE_INFO_UPDATE",__heroInfoChangeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__heroInfoChangeHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(_composeView)
         {
            _composeView.removeEventListener("COMPOSE_SUCCEED",__onComposeCallback);
         }
         if(_switchView)
         {
            _switchView.removeEventListener("FASHION_BOOK_WEAR",__wearHandler);
         }
         _buyFashionBtn.removeEventListener("click",__gotoShopFrame);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpFrame);
         }
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         NotificationManager.instance.removeEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         if(_changeShowBtn)
         {
            _changeShowBtn.removeEventListener("click",__changeShowBtnHandler);
         }
      }
      
      private function __gotoShopFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ShopManager.Instance.shopFrameDefaultPanel = "fashion";
         var _loc2_:String = _btnGroup.selectIndex == 0 ? "0" : "1";
         FrameControllerManager.instance.shopController.setPreFrame("fashion",_loc2_);
         FrameControllerManager.instance.openControllerByInfo("shop");
         this.dispose();
      }
      
      private function __openHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_btnGroup.selectIndex == 0)
         {
            FrameControllerManager.instance.fashionCodeController.openHelpFrame("fashionComposeView.helpFrame");
         }
         else if(VersionSwitch.FASHION_APPRAISAL)
         {
            FrameControllerManager.instance.fashionCodeController.openHelpFrame("fashionSwitchView.helpFrame2");
         }
         else
         {
            FrameControllerManager.instance.fashionCodeController.openHelpFrame("fashionSwitchView.helpFrame");
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
         model.lookDragonTalkerFashion = false;
         model.moveGoodsBack();
         removeEvent();
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_heroBack);
         _heroBack = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeViolentMc(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_hGapLine);
         _hGapLine = null;
         ObjectUtils.disposeObject(_vGapLine);
         _vGapLine = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_powerTxt);
         _powerTxt = null;
         ObjectUtils.disposeObject(_powerNumTxt);
         _powerNumTxt = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_composeView);
         _composeView = null;
         ObjectUtils.disposeObject(_switchView);
         _switchView = null;
         ObjectUtils.disposeObject(_refreshView);
         _refreshView = null;
         ObjectUtils.disposeObject(_fashionBag);
         _fashionBag = null;
         ObjectUtils.disposeObject(_showThane);
         _showThane = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_buyFashionBtn);
         _buyFashionBtn = null;
         ObjectUtils.disposeObject(_switchTip);
         _switchTip = null;
         ObjectUtils.disposeObject(_switchTip2);
         _switchTip2 = null;
         ObjectUtils.disposeObject(_propertyTxt1);
         _propertyTxt1 = null;
         ObjectUtils.disposeObject(_propertyTopsTxt);
         _propertyTopsTxt = null;
         ObjectUtils.disposeObject(_propertyShowImg);
         _propertyShowImg = null;
         ObjectUtils.disposeObject(_propertyShowTxt);
         _propertyShowTxt = null;
         ObjectUtils.disposeObject(_changeShowBtn);
         _changeShowBtn = null;
         ObjectUtils.disposeObject(_changeBg);
         _changeBg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         model.selectedPanel = "FASHION_PANEL";
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

