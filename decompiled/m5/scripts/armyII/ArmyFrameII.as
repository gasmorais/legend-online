package armyII
{
   import armyII.viewII.battleGuard.BattleGuardBagView;
   import armyII.viewII.battleGuard.BattleGuardView;
   import armyII.viewII.dragonsoul.DragonSoulBagView;
   import armyII.viewII.dragonsoul.DragonSoulView;
   import armyII.viewII.equip.EquipView;
   import armyII.viewII.holydragonsoul.HolyDragonSoulView;
   import armyII.viewII.information.InformationView;
   import armyII.viewII.tattoo.TattooBagView;
   import armyII.viewII.tattoo.TattooView;
   import bag.BaseBagListManager;
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import bag.view.EquipBagII;
   import bag.view.EquipBagSortList;
   import bag.view.ItemSellView;
   import bag.view.StoreBag;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dialog.utils.NewbieManager;
   import events.FashionEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.fashion.FashionModel;
   import playerinfo.view.ThaneAttributeFrame;
   import yishi.GlobalConfig;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyFrameII extends Frame implements IManualSize
   {
      
      private var _bagBack:Scale9CornerImage;
      
      private var _equipButton:SelectedIconButton;
      
      private var _guardButton:SelectedIconButton;
      
      private var _informationButton:SelectedIconButton;
      
      private var _dragonSoulButton:SelectedIconButton;
      
      private var _holyDragonSoulButton:SelectedIconButton;
      
      private var _tattooButton:SelectedIconButton;
      
      private var _equipView:EquipView;
      
      private var _guardView:BattleGuardView;
      
      private var _informationView:InformationView;
      
      private var _dragonSoulView:DragonSoulView;
      
      private var _holyDragonSoulView:HolyDragonSoulView;
      
      private var _pageGroup:SelectedButtonGroup;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _page3:SelectedIconButton;
      
      private var _page4:SelectedIconButton;
      
      private var _page5:SelectedIconButton;
      
      private var _page6:SelectedIconButton;
      
      private var _tidyButton:TextButton;
      
      private var _splitButton:TextButton;
      
      private var _sellButton:TextButton;
      
      private var _sellView:ItemSellView;
      
      private var _equipBag:EquipBagII;
      
      private var _tattooView:TattooView;
      
      private var _storeBag:StoreBag;
      
      private var _guardBag:BattleGuardBagView;
      
      private var _tattooBag:TattooBagView;
      
      private var _dragonSoulBag:DragonSoulBagView;
      
      private var _sortBtn:TextButton;
      
      private var _storeBagBagBtn:SelectedIconButton;
      
      private var _storeBagStoreBtn:SelectedIconButton;
      
      private var _rightBtnGroup:SelectedButtonGroup;
      
      private var _sortList:EquipBagSortList;
      
      private var _attributeView:ThaneAttributeFrame;
      
      private var _rect:Rectangle = new Rectangle(0,0,212,520);
      
      private var _btnHBox:HBox;
      
      private var _guardButtonMc:MovieClip;
      
      private var _dragonSoulButtonMc:MovieClip;
      
      private var _stopDragonShineTimerId:uint;
      
      private var _btnVpLock:IconButton;
      
      private var _dragonSoulBtnInfoTipsView:MovieClip;
      
      private var _isHand:Boolean = true;
      
      private var _informationStrip:StripView;
      
      private var _sellStrip:StripView;
      
      private var _dragonSoulStrip:StripView;
      
      private var _vicePasswordStrip:StripView;
      
      private var _lockBtn:TextButton;
      
      private var _setPwdBtn:TextButton;
      
      private var filterFlag:Boolean = false;
      
      private var _curSelectedItem:ISelectable;
      
      public function ArmyFrameII()
      {
         super();
         initView();
         initEvent();
         control.setOldData();
         initData();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,585,510);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:Boolean = false;
         _btnHBox = ComponentFactory.Instance.creatComponentByStylename("ArmyFrameII.BtnHBox");
         _equipButton = ComponentFactory.Instance.creatComponentByStylename("army.HeroEquipButton");
         _guardButton = ComponentFactory.Instance.creatComponentByStylename("army.BattleGuardButton");
         _informationButton = ComponentFactory.Instance.creatComponentByStylename("army.InformationButton");
         _dragonSoulButton = ComponentFactory.Instance.creatComponentByStylename("army.DragonSoulButton");
         _holyDragonSoulButton = ComponentFactory.Instance.creatComponentByStylename("army.HolyDragonSoulButton");
         _tattooButton = ComponentFactory.Instance.creatComponentByStylename("army.TattooButton");
         _guardButtonMc = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _dragonSoulButtonMc = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _storeBagBagBtn = ComponentFactory.Instance.creatComponentByStylename("army.BagStroeBagBtn");
         _storeBagStoreBtn = ComponentFactory.Instance.creatComponentByStylename("army.BagStroeStroeBtn");
         _equipButton.autoSelect = false;
         _guardButton.autoSelect = false;
         _informationButton.autoSelect = false;
         _dragonSoulButton.autoSelect = false;
         _tattooButton.autoSelect = false;
         _holyDragonSoulButton.autoSelect = false;
         _guardButtonMc.mouseEnabled = false;
         _guardButtonMc["pos"].addChild(_guardButton);
         _dragonSoulButtonMc.mouseEnabled = false;
         _dragonSoulButtonMc["pos"].addChild(_dragonSoulButton);
         _dragonSoulButton.enable = thane.grades >= 40;
         _loc2_ = Boolean(PlayerManager.instance.currentPlayerModel.showBattleGuardBtnShine);
         if(_loc2_)
         {
            _guardButtonMc.play();
         }
         else
         {
            _guardButtonMc.gotoAndStop(1);
         }
         _loc2_ = Boolean(PlayerManager.instance.currentPlayerModel.showDragonSoulBtnShine);
         if(_loc2_)
         {
            model.currentOpenPanel == ArmyPanelEnum.DRAGON_SOUL_PANEL ? (_stopDragonShineTimerId = setTimeout(stopDragonSoulBtnShine,5000)) : _dragonSoulButtonMc.play();
         }
         else
         {
            _dragonSoulButtonMc.gotoAndStop(1);
         }
         _btnHBox.addChild(_equipButton);
         if(thane.grades >= 50)
         {
            _btnHBox.addChild(_guardButtonMc);
         }
         if(playerInfo.dragonSoulType == 153)
         {
            _btnHBox.addChild(_holyDragonSoulButton);
         }
         else
         {
            _btnHBox.addChild(_dragonSoulButtonMc);
         }
         _dragonSoulBtnInfoTipsView = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _dragonSoulButtonMc.addChild(_dragonSoulBtnInfoTipsView);
         _dragonSoulBtnInfoTipsView.x = 55;
         _dragonSoulBtnInfoTipsView.y = 10;
         _dragonSoulBtnInfoTipsView.mouseChildren = _dragonSoulBtnInfoTipsView.mouseEnabled = false;
         updateTipsView();
         if(thane.vocationGrades > 0)
         {
            _btnHBox.addChild(_tattooButton);
         }
         _btnHBox.addChild(_informationButton);
         addToContent(_btnHBox);
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("army.BagBack");
         _pageGroup = new SelectedButtonGroup();
         _tidyButton = ComponentFactory.Instance.creatComponentByStylename("army.TidyButton");
         _tidyButton.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.tidy");
         _splitButton = ComponentFactory.Instance.creatComponentByStylename("army.SplitButton");
         _splitButton.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.split");
         _sellButton = ComponentFactory.Instance.creatComponentByStylename("army.SellButton");
         _sellButton.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.sell");
         _page1 = ComponentFactory.Instance.creatComponentByStylename("army.Page1Button");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("army.Page2Button");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("army.Page3Button");
         _page6 = ComponentFactory.Instance.creatComponentByStylename("army.Page4Button");
         _page4 = ComponentFactory.Instance.creatComponentByStylename("army.Page5Button");
         _page5 = ComponentFactory.Instance.creatComponentByStylename("army.Page6Button");
         _vicePasswordStrip = ComponentFactory.Instance.creatCustomObject("ArmyFrameII.vicePasswordStrip");
         _pageGroup.addSelectItem(_page1);
         _pageGroup.addSelectItem(_page2);
         _pageGroup.addSelectItem(_page3);
         _pageGroup.addSelectItem(_page6);
         _pageGroup.addSelectItem(_page4);
         _pageGroup.addSelectItem(_page5);
         addToContent(_bagBack);
         addToContent(_tidyButton);
         addToContent(_splitButton);
         addToContent(_sellButton);
         addToContent(_page1);
         addToContent(_page2);
         addToContent(_page3);
         addToContent(_page6);
         addToContent(_page4);
         addToContent(_page5);
         _rightBtnGroup = new SelectedButtonGroup();
         _rightBtnGroup.addSelectItem(_storeBagBagBtn);
         _rightBtnGroup.addSelectItem(_storeBagStoreBtn);
         _rightBtnGroup.selectIndex = 0;
         _guardBag = new BattleGuardBagView(7,8);
         _guardBag.x = 393;
         _guardBag.y = 26;
         addToContent(_guardBag);
         _tattooBag = new TattooBagView(7,8);
         _tattooBag.x = 393;
         _tattooBag.y = 26;
         addToContent(_tattooBag);
         _dragonSoulBag = new DragonSoulBagView(7,8);
         _dragonSoulBag.x = 393;
         _dragonSoulBag.y = 26;
         addToContent(_dragonSoulBag);
         _equipBag = new EquipBagII(7,8,6);
         _equipBag.x = 393;
         _equipBag.y = 26;
         _equipBag.reFreshAll();
         addToContent(_equipBag);
         _storeBag = new StoreBag(7,8,6);
         _storeBag.x = 393;
         _storeBag.y = 26;
         _storeBag.reFreshAll();
         _sellButton.enable = thane.grades >= 10;
         _informationButton.enable = thane.grades >= 10;
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("army.BagSortBtn");
         addToContent(_sortBtn);
         var _loc1_:int = int(BaseBagListManager.instance.model.lastBagSortType);
         _sortBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder" + _loc1_);
         FrameControllerManager.instance.fashionCodeController.model.selectedPanel = "";
         _btnVpLock = ComponentFactory.Instance.creatComponentByStylename("vicepassword.lockbtn");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.vicePasswordLockBtn");
         _setPwdBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.setPwdBtn");
         this.addToContent(_btnVpLock);
         addToContent(_lockBtn);
         addToContent(_setPwdBtn);
         addToContent(_vicePasswordStrip);
         _vicePasswordStrip.setTarget(_btnVpLock);
         _btnVpLock.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.vicepasswordBtnTipData");
         _vicePasswordStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
         _vicePasswordStrip.visible = thane.grades < 10;
         _btnVpLock.enable = thane.grades >= 10;
         _lockBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.lockBtn.text");
         _setPwdBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         showPwdBtnState(false);
         _informationStrip = ComponentFactory.Instance.creatCustomObject("army.attribute.informationStrip");
         _sellStrip = ComponentFactory.Instance.creatCustomObject("army.attribute.sellStrip");
         _dragonSoulStrip = ComponentFactory.Instance.creatCustomObject("army.attribute.dragonSoulStrip");
         addToContent(_informationStrip);
         addToContent(_sellStrip);
         addToContent(_dragonSoulStrip);
         _informationStrip.setTarget(_informationButton);
         _informationStrip.x = _informationButton.x + 5;
         _sellStrip.setTarget(_sellButton);
         _dragonSoulStrip.setTarget(_dragonSoulButton);
         _dragonSoulStrip.x = _dragonSoulButtonMc.x + 5;
         _dragonSoulStrip.visible = thane.grades < 40;
         _informationStrip.visible = thane.grades < 10;
         _sellStrip.visible = thane.grades < 10;
         _informationStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
         _sellStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
         _dragonSoulStrip.tipData = LanguageMgr.GetTranslation("HigherGradeOpenTipView.openGrade",40);
      }
      
      public function updateTipsView(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         if(_dragonSoulBtnInfoTipsView)
         {
            _loc2_ = int(InfoTipsManager.instance.getValueByKey(11));
            if(_loc2_ > 0)
            {
               _dragonSoulBtnInfoTipsView.visible = true;
               _dragonSoulBtnInfoTipsView.txt.text = _loc2_ > 99 ? "99+" : _loc2_.toString();
            }
            else
            {
               _dragonSoulBtnInfoTipsView.visible = false;
            }
         }
      }
      
      private function initData() : void
      {
         model.currentPage = model.currentPage > 6 ? 6 : int(model.currentPage);
         _pageGroup.selectIndex = model.currentPage - 1;
         _equipBag.gotoPage(model.currentPage);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _equipButton.addEventListener("click",__panelChangeHandler);
         _guardButton.addEventListener("click",__panelChangeHandler);
         _informationButton.addEventListener("click",__panelChangeHandler);
         _tattooButton.addEventListener("click",__panelChangeHandler);
         _pageGroup.addEventListener("change",__pageChangeHandler);
         _dragonSoulButton.addEventListener("click",__panelChangeHandler);
         _holyDragonSoulButton.addEventListener("click",__panelChangeHandler);
         _tidyButton.addEventListener("click",__tidyHandler);
         _splitButton.addEventListener("click",__splitHandler);
         _sellButton.addEventListener("click",__sellHandler);
         playerInfo.addEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         playerInfo.addEventListener("DRAGON_SOUL_TYPE",__dragonSoulUpdateHandler);
         GoodsManager.instance.addEventListener("BAG_FULL",__bagIsFullHandler);
         NotificationManager.instance.addEventListener("ITEM_DOUBLE_CLICK",__bagItemDoubleClick);
         _sortBtn.addEventListener("mouseDown",__sortBtnDownHandler);
         _sortBtn.addEventListener("click",__sortBtnClickHandler);
         NotificationManager.instance.addEventListener("BAG_SORT_SELECT",__bagSortSelectHandler);
         NotificationManager.instance.addEventListener("BAG_SORT_CHANGE",__bagSortChangeHandler);
         BagHelper.instance.addEventListener("SELL_GOODS",__openSellViewHandler);
         if(thane.grades < 55)
         {
            thane.addEventListener("THANE_LEVEL_UPDATE",__upgradesHandler);
         }
         _btnVpLock.addEventListener("click",__vpLockHandler);
         _lockBtn.addEventListener("click",__goodsLockHandler);
         _setPwdBtn.addEventListener("click",__setPwdHandler);
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",updateTipsView);
         _rightBtnGroup.addEventListener("change",onRightBtnChange);
         NotificationManager.instance.addEventListener("STORE_BAG_COUNT_CHANGE",onStoreCountChange);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 276,onOpenStoreBag);
         StageReferance.stage.addEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _equipButton.removeEventListener("click",__panelChangeHandler);
         _guardButton.removeEventListener("click",__panelChangeHandler);
         _informationButton.removeEventListener("click",__panelChangeHandler);
         _tattooButton.removeEventListener("click",__panelChangeHandler);
         _pageGroup.removeEventListener("change",__pageChangeHandler);
         _dragonSoulButton.removeEventListener("click",__panelChangeHandler);
         _holyDragonSoulButton.removeEventListener("click",__panelChangeHandler);
         _tidyButton.removeEventListener("click",__tidyHandler);
         _splitButton.removeEventListener("click",__splitHandler);
         _sellButton.removeEventListener("click",__sellHandler);
         playerInfo.removeEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         playerInfo.removeEventListener("DRAGON_SOUL_TYPE",__dragonSoulUpdateHandler);
         GoodsManager.instance.removeEventListener("BAG_FULL",__bagIsFullHandler);
         NotificationManager.instance.removeEventListener("ITEM_DOUBLE_CLICK",__bagItemDoubleClick);
         _sortBtn.removeEventListener("mouseDown",__sortBtnDownHandler);
         _sortBtn.removeEventListener("click",__sortBtnClickHandler);
         NotificationManager.instance.removeEventListener("BAG_SORT_SELECT",__bagSortSelectHandler);
         NotificationManager.instance.removeEventListener("BAG_SORT_CHANGE",__bagSortChangeHandler);
         BagHelper.instance.removeEventListener("SELL_GOODS",__openSellViewHandler);
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
         if(_attributeView)
         {
            _attributeView.removeEventListener("response",__hideHandler);
         }
         if(_equipView)
         {
            _equipView.removeEventListener("ATTRIBUTE_CLICK",__showAttributeHandler);
         }
         thane.removeEventListener("THANE_LEVEL_UPDATE",__upgradesHandler);
         _btnVpLock.removeEventListener("click",__vpLockHandler);
         _lockBtn.removeEventListener("click",__goodsLockHandler);
         _setPwdBtn.removeEventListener("click",__setPwdHandler);
         NotificationManager.instance.removeEventListener("INFO_TIPS_DATA_UPDATE",updateTipsView);
         _rightBtnGroup.removeEventListener("change",onRightBtnChange);
         NotificationManager.instance.removeEventListener("STORE_BAG_COUNT_CHANGE",onStoreCountChange);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 276,onOpenStoreBag);
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function onOpenStoreBag(param1:SLGSocketEvent) : void
      {
         _page1.enable = true;
         _page2.enable = true;
         _page3.enable = true;
         _page6.enable = true;
         _page4.enable = true;
         _page5.enable = true;
      }
      
      private function showPwdBtnState(param1:Boolean) : void
      {
         _lockBtn.visible = _setPwdBtn.visible = param1;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ && _loc2_.hasOwnProperty("stylename") && (_loc2_["stylename"] == "army.ArmyFrameII.vicePasswordLockBtn" || _loc2_["stylename"] == "army.ArmyFrameII.setPwdBtn"))
         {
            return;
         }
         if(_lockBtn.visible && Boolean(_setPwdBtn.visible))
         {
            showPwdBtnState(false);
         }
      }
      
      private function onRightBtnChange(param1:Event) : void
      {
         if(equipBag == null)
         {
            return;
         }
         _page5.visible = true;
         _pageGroup.selectIndex = 0;
         if(_rightBtnGroup.selectIndex == 0)
         {
            addToContent(equipBag);
            equipBag.showStoreBagStateView(false);
            if(_storeBag != null && _storeBag.parent != null)
            {
               _storeBag.parent.removeChild(_storeBag);
            }
            _page1.enable = true;
            _page2.enable = true;
            _page3.enable = true;
            _page6.enable = true;
            _page4.enable = true;
            _page5.enable = true;
            model.selectedStroeBag = false;
            _sortBtn.enable = true;
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _page5.visible = false;
            if(playerInfo.stoneBagCount == 0)
            {
               equipBag.showStoreBagStateView(true);
               _page1.enable = false;
               _page2.enable = false;
               _page3.enable = false;
               _page6.enable = false;
               _page4.enable = false;
            }
            else
            {
               if(equipBag != null && equipBag.parent != null)
               {
                  equipBag.parent.removeChild(equipBag);
               }
               addToContent(_storeBag);
            }
            model.selectedStroeBag = true;
            _sortBtn.enable = false;
         }
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
      }
      
      private function onStoreCountChange(param1:Event) : void
      {
         var _loc2_:int = int(playerInfo.stoneBagCount);
         if(_loc2_ > 0)
         {
            equipBag.showStoreBagStateView(false);
            if(equipBag != null && equipBag.parent != null)
            {
               equipBag.parent.removeChild(equipBag);
            }
            addToContent(_storeBag);
            _storeBag.reFreshAll();
         }
      }
      
      private function __vpLockHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         NewbieManager.instance.closePlayLockWeek();
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isDuringResetTime)
         {
            _loc3_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         showPwdBtnState(true);
      }
      
      private function __goodsLockHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         showPwdBtnState(false);
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isDuringResetTime)
         {
            _loc3_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.hasVicePassword == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",1);
         }
         else
         {
            SoundManager.instance.play("022");
            param1.stopPropagation();
            param1.stopImmediatePropagation();
            if(GlobalConfig.isConfirmPassword)
            {
               BagHelper.instance.vpLockBtnClickHandler(this);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
            }
         }
      }
      
      private function __setPwdHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         showPwdBtnState(false);
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isDuringResetTime)
         {
            _loc3_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.hasVicePassword == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",2);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",1);
         }
      }
      
      private function __upgradesHandler(param1:PlayerEvent) : void
      {
         if(thane.grades >= 55)
         {
            _btnHBox.removeAllChild();
            _btnHBox.addChild(_equipButton);
            _btnHBox.addChild(_guardButtonMc);
            _btnHBox.addChild(_dragonSoulButtonMc);
            _btnHBox.addChild(_informationButton);
            _guardButtonMc.gotoAndPlay(1);
         }
         _vicePasswordStrip.visible = thane.grades < 10;
         _btnVpLock.enable = thane.grades >= 10;
         _dragonSoulStrip.x = _dragonSoulButtonMc.x + 5;
         _informationStrip.x = _informationButton.x + 5;
      }
      
      public function get currentIsBattleGuardPanel() : Boolean
      {
         return _curSelectedItem == _guardButton;
      }
      
      private function __showAttributeHandler(param1:BagEvent) : void
      {
         TweenLite.killTweensOf(_rect);
         if(!_attributeView)
         {
            showAttributeView();
         }
         else if(attributeViewIsTweening())
         {
            _attributeView.dispose();
            _attributeView = null;
         }
         else
         {
            _rect.x = -20;
            TweenLite.to(_rect,0.7,{
               "x":-232,
               "onUpdate":updateRec,
               "onComplete":completeTween
            });
         }
      }
      
      private function showAttributeView() : void
      {
         if(!_attributeView)
         {
            _attributeView = ComponentFactory.Instance.creatComponentByStylename("army.ThaneAttribute");
            _attributeView.addEventListener("response",__hideHandler);
            addChild(_attributeView);
            _attributeView.thane = thane;
            _attributeView.refresh();
            _rect.x = -232;
            TweenLite.to(_rect,0.7,{
               "x":-20,
               "onUpdate":updateRec
            });
         }
      }
      
      private function attributeViewIsTweening() : Boolean
      {
         return _rect.x < -20 || _attributeView.x != -193 || _attributeView.y != 41;
      }
      
      private function updateRec() : void
      {
         if(_attributeView)
         {
            _attributeView.scrollRect = _rect;
         }
      }
      
      private function completeTween() : void
      {
         TweenLite.killTweensOf(_rect);
         if(_attributeView)
         {
            _attributeView.dispose();
            _attributeView = null;
         }
      }
      
      private function __hideHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            param1.currentTarget.removeEventListener("response",__hideHandler);
            __showAttributeHandler(null);
         }
      }
      
      private function __openSellViewHandler(param1:BagEvent) : void
      {
         if(!_sellView)
         {
            _sellView = ComponentFactory.Instance.creatComponentByStylename("army.ItemSellView");
            _sellView.addEventListener("dispose",__disposeHandler1);
            addChild(_sellView);
         }
         if(_splitButton)
         {
            _splitButton.enable = false;
         }
         if(_tidyButton)
         {
            _tidyButton.enable = false;
         }
         if(_sortBtn)
         {
            _sortBtn.enable = false;
         }
         _sellView.addSellGoods(param1.info);
      }
      
      private function __disposeHandler1(param1:Event) : void
      {
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
         if(_splitButton)
         {
            _splitButton.enable = true;
         }
         if(_tidyButton)
         {
            _tidyButton.enable = true;
         }
         if(_sortBtn)
         {
            _sortBtn.enable = true;
            if(currentIndex == 1)
            {
               _sortBtn.enable = false;
            }
         }
         _sellView = null;
      }
      
      private function __bagSortSelectHandler(param1:NotificationEvent) : void
      {
         BagHelper.instance.onTidyHandler(_equipBag,param1.data);
      }
      
      private function __bagSortChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.data)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder0");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder1");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder2");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder3");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder4");
         }
         _sortBtn.text = _loc2_;
         BaseBagListManager.instance.model.lastBagSortType = param1.data;
         filterFlag = true;
         GoodsManager.instance.filterFlag = filterFlag;
      }
      
      private function __sortBtnDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __sortBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_sortList)
         {
            _sortList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_sortList)
         {
            _sortList = new EquipBagSortList();
         }
         _sortList.addEventListener("dispose",__onSortListDispose);
         var _loc2_:Point = new Point(_sortBtn.x,_sortBtn.y);
         _sortList.x = localToGlobal(_loc2_).x + 20;
         _sortList.y = localToGlobal(_loc2_).y - _sortBtn.height + 5;
         LayerManager.Instance.addToLayer(_sortList,7);
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _sortList.removeEventListener("dispose",__onSortListDispose);
         _sortList = null;
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_isHand)
         {
            ArmyManager.instance.openCurrPage = 1;
         }
         _isHand = true;
         var _loc3_:SelectedIconButton = param1.currentTarget as SelectedIconButton;
         if(_curSelectedItem == _loc3_)
         {
            return;
         }
         if(_loc3_ == _guardButton)
         {
            if(!PlayerManager.instance.currentPlayerModel.petSystemIsOpened)
            {
               _loc2_ = LanguageMgr.GetTranslation("ArmyFrameII.needOpenPetSystem");
            }
            if(_loc2_)
            {
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         _curSelectedItem = _loc3_;
         if(_informationView)
         {
            _informationView.visible = false;
         }
         if(_dragonSoulView)
         {
            _dragonSoulView.visible = false;
         }
         if(_holyDragonSoulView)
         {
            _holyDragonSoulView.visible = false;
         }
         if(_equipView)
         {
            _equipView.visible = false;
         }
         if(_guardView)
         {
            _guardView.visible = false;
         }
         if(_equipBag)
         {
            _equipBag.visible = false;
         }
         if(_guardBag)
         {
            _guardBag.visible = false;
         }
         if(_tattooBag)
         {
            _tattooBag.visible = false;
         }
         if(_dragonSoulBag)
         {
            _dragonSoulBag.visible = false;
         }
         if(_tattooView)
         {
            _tattooView.visible = false;
         }
         _equipButton.selected = false;
         _informationButton.selected = false;
         _tattooButton.selected = false;
         _dragonSoulButton.selected = false;
         _holyDragonSoulButton.selected = false;
         _guardButton.selected = false;
         _loc3_.selected = true;
         _dragonSoulButton.enable = thane.grades >= 40;
         _holyDragonSoulButton.enable = true;
         _page2.enable = true;
         _page3.enable = true;
         _page6.enable = true;
         _page4.enable = true;
         _page5.enable = true;
         _sellButton.enable = thane.grades >= 10;
         _splitButton.enable = true;
         _tidyButton.enable = true;
         _sortBtn.enable = true;
         GoodsManager.instance.filterFlag = this.filterFlag;
         _rightBtnGroup.selectIndex = 0;
         switch(_loc3_)
         {
            case _equipButton:
               model.currentOpenPanel = ArmyPanelEnum.EQUIP_PANEL;
               showEquip();
               if(fashionModel.selectedPanel == "EQUIP_PANEL" || fashionModel.selectedPanel == "FASHION_PANEL")
               {
                  fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
               }
               switchRightViewVisible(true);
               _equipBag.visible = true;
               _pageGroup.selectIndex = _equipBag.curPage - 1;
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = true;
               break;
            case _informationButton:
               model.currentOpenPanel = ArmyPanelEnum.INFORMATION_PANEL;
               showInformation();
               switchRightViewVisible(true);
               _equipBag.visible = true;
               _pageGroup.selectIndex = _equipBag.curPage - 1;
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = false;
               break;
            case _guardButton:
               PlayerManager.instance.currentPlayerModel.showBattleGuardBtnShine = false;
               _guardButtonMc.gotoAndStop(1);
               showBattleGuardView();
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = false;
               break;
            case _dragonSoulButton:
               if(_stopDragonShineTimerId <= 0)
               {
                  stopDragonSoulBtnShine();
               }
               model.currentOpenPanel = ArmyPanelEnum.DRAGON_SOUL_PANEL;
               showDragonSoul();
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = false;
               break;
            case _tattooButton:
               model.currentOpenPanel = ArmyPanelEnum.TATTOO_PANEL;
               showTattoo();
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = false;
               break;
            case _holyDragonSoulButton:
               model.currentOpenPanel = ArmyPanelEnum.HOLY_DRAGON_SOUL_PANEL;
               showHolyDragonSoul();
               _storeBagBagBtn.enable = _storeBagStoreBtn.enable = false;
         }
      }
      
      private function stopDragonSoulBtnShine() : void
      {
         clearTimeout(_stopDragonShineTimerId);
         _stopDragonShineTimerId = 0;
         PlayerManager.instance.currentPlayerModel.showDragonSoulBtnShine = false;
         if(_dragonSoulButtonMc)
         {
            _dragonSoulButtonMc.gotoAndStop(1);
         }
      }
      
      private function showEquip() : void
      {
         model.curBagType = 4;
         model.curAcceptBagType = 1;
         titleText = LanguageMgr.GetTranslation("armyII.ArmyFrameII.title01");
         showAttributeView();
         if(!_equipView)
         {
            _equipView = ComponentFactory.Instance.creatCustomObject("army.EquipPanel");
            addToContentAt(_equipView,0);
            _equipView.addEventListener("ATTRIBUTE_CLICK",__showAttributeHandler);
         }
         _equipView.visible = true;
         _equipView.synHideFashion();
         if(_informationView)
         {
            _informationView.visible = false;
         }
         if(_dragonSoulView)
         {
            _dragonSoulView.dispose();
            _dragonSoulView = null;
         }
         if(_holyDragonSoulView)
         {
            _holyDragonSoulView.dispose();
            _holyDragonSoulView = null;
         }
         if(_guardView)
         {
            _guardView.dispose();
            _guardView = null;
         }
         if(_attributeView)
         {
            _attributeView.switchPanel(1);
         }
      }
      
      private function showBattleGuardView() : void
      {
         if(!_guardView)
         {
            _guardView = new BattleGuardView(false,thane);
            _guardView.y = 18;
         }
         if(_dragonSoulView)
         {
            _dragonSoulView.dispose();
            _dragonSoulView = null;
         }
         if(_holyDragonSoulView)
         {
            _holyDragonSoulView.dispose();
            _holyDragonSoulView = null;
         }
         if(_sellView)
         {
            _sellView.dispose();
         }
         GoodsManager.instance.filterFlag = false;
         _guardView.data = playerInfo.battleGuardInfo;
         addToContentAt(_guardView,0);
         _guardBag.defaultView();
         _guardView.visible = true;
         model.currentOpenPanel = ArmyPanelEnum.BATTLEGUARD_PANEL;
         showAttributeView();
         if(_attributeView)
         {
            _attributeView.switchPanel(2);
         }
         _guardBag.visible = true;
         _pageGroup.selectIndex = 0;
         _page2.enable = false;
         _page3.enable = false;
         _page6.enable = false;
         _page4.enable = false;
         _page5.enable = false;
         _sellButton.enable = false;
         _splitButton.enable = false;
         _tidyButton.enable = false;
         _sortBtn.enable = false;
      }
      
      private function showInformation() : void
      {
         model.curBagType = -1;
         model.curAcceptBagType = -1;
         titleText = LanguageMgr.GetTranslation("armyII.ArmyFrameII.title04");
         if(!_informationView)
         {
            _informationView = ComponentFactory.Instance.creatCustomObject("army.InformationPanel");
            addToContentAt(_informationView,0);
         }
         _informationView.visible = true;
         _informationView._goodsExchangeView.refresh();
         if(_dragonSoulView)
         {
            _dragonSoulView.dispose();
            _dragonSoulView = null;
         }
         if(_holyDragonSoulView)
         {
            _holyDragonSoulView.dispose();
            _holyDragonSoulView = null;
         }
         if(_equipView)
         {
            _equipView.visible = false;
         }
         if(_attributeView)
         {
            _attributeView.switchPanel(1);
            _attributeView.dispose();
         }
         _attributeView = null;
         if(_guardView)
         {
            _guardView.dispose();
            _guardView = null;
         }
      }
      
      private function showDragonSoul() : void
      {
         if(!_dragonSoulView)
         {
            _dragonSoulView = new DragonSoulView();
            _dragonSoulView.y = 17;
            addToContentAt(_dragonSoulView,0);
         }
         _dragonSoulBag.defaultView();
         _dragonSoulView.visible = true;
         showAttributeView();
         if(_attributeView)
         {
            _attributeView.switchPanel(1);
         }
         if(_holyDragonSoulView)
         {
            _holyDragonSoulView.dispose();
            _holyDragonSoulView = null;
         }
         if(_informationView)
         {
            _informationView.visible = false;
         }
         if(_equipView)
         {
            _equipView.visible = false;
         }
         if(_guardView)
         {
            _guardView.dispose();
            _guardView = null;
         }
         if(_sellView)
         {
            _sellView.dispose();
         }
         _dragonSoulBag.visible = true;
         _pageGroup.selectIndex = 0;
         _page2.enable = false;
         _page3.enable = false;
         _page6.enable = false;
         _page4.enable = false;
         _page5.enable = false;
         _sellButton.enable = false;
         _splitButton.enable = false;
         _tidyButton.enable = false;
         _sortBtn.enable = false;
      }
      
      private function showHolyDragonSoul() : void
      {
         if(!_holyDragonSoulView)
         {
            _holyDragonSoulView = new HolyDragonSoulView();
            _holyDragonSoulView.y = 17;
            addToContentAt(_holyDragonSoulView,0);
         }
         _dragonSoulBag.holyDefaultView();
         _holyDragonSoulView.visible = true;
         showAttributeView();
         if(_attributeView)
         {
            _attributeView.switchPanel(1);
         }
         if(_dragonSoulView)
         {
            _dragonSoulView.dispose();
            _dragonSoulView = null;
         }
         if(_informationView)
         {
            _informationView.visible = false;
         }
         if(_equipView)
         {
            _equipView.visible = false;
         }
         if(_guardView)
         {
            _guardView.dispose();
            _guardView = null;
         }
         if(_sellView)
         {
            _sellView.dispose();
         }
         _dragonSoulBag.visible = true;
         _pageGroup.selectIndex = 0;
         _page2.enable = false;
         _page3.enable = false;
         _page6.enable = false;
         _page4.enable = false;
         _page5.enable = false;
         _sellButton.enable = false;
         _splitButton.enable = false;
         _tidyButton.enable = false;
         _sortBtn.enable = false;
      }
      
      private function showTattoo() : void
      {
         if(!_tattooView)
         {
            _tattooView = new TattooView();
            _tattooView.y = 17;
            addToContentAt(_tattooView,0);
         }
         _tattooView.visible = true;
         showAttributeView();
         FrameControllerManager.instance.tattooController.sendReqTattooInfo();
         if(_attributeView)
         {
            _attributeView.switchPanel(1);
         }
         if(_informationView)
         {
            _informationView.visible = false;
         }
         if(_equipView)
         {
            _equipView.visible = false;
         }
         if(_guardView)
         {
            _guardView.dispose();
            _guardView = null;
         }
         if(_sellView)
         {
            _sellView.dispose();
         }
         _tattooBag.defaultView();
         _tattooBag.visible = true;
         _pageGroup.selectIndex = 0;
         _page2.enable = false;
         _page3.enable = false;
         _page6.enable = false;
         _page4.enable = false;
         _page5.enable = false;
         _sellButton.enable = false;
         _splitButton.enable = false;
         _tidyButton.enable = false;
         _sortBtn.enable = false;
      }
      
      private function switchRightViewVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(!_bagBack.parent)
            {
               addToContent(_bagBack);
            }
            if(!_page1.parent)
            {
               addToContent(_page1);
            }
            if(!_page2.parent)
            {
               addToContent(_page2);
            }
            if(!_page3.parent)
            {
               addToContent(_page3);
            }
            if(!_page6.parent)
            {
               addToContent(_page6);
            }
            if(!_page4.parent)
            {
               addToContent(_page4);
            }
            if(!_page5.parent)
            {
               addToContent(_page5);
            }
            if(!_storeBagBagBtn.parent)
            {
               addToContent(_storeBagBagBtn);
            }
            if(!_storeBagStoreBtn.parent)
            {
               addToContent(_storeBagStoreBtn);
            }
            if(!_equipBag.parent)
            {
               addToContent(_equipBag);
            }
            if(!_guardBag.parent)
            {
               addToContent(_guardBag);
            }
            if(!_tattooBag.parent)
            {
               addToContent(_tattooBag);
            }
            if(!_dragonSoulBag.parent)
            {
               addToContent(_dragonSoulBag);
            }
            if(!_sellButton.parent)
            {
               addToContent(_sellButton);
            }
            if(!_splitButton.parent)
            {
               addToContent(_splitButton);
            }
            if(!_tidyButton.parent)
            {
               addToContent(_tidyButton);
            }
            if(!_sortBtn.parent)
            {
               addToContent(_sortBtn);
            }
         }
         else
         {
            _equipBag.parent.removeChild(_equipBag);
            _bagBack.parent.removeChild(_bagBack);
            _storeBagBagBtn.parent.removeChild(_storeBagBagBtn);
            _storeBagStoreBtn.parent.removeChild(_storeBagStoreBtn);
            _page1.parent.removeChild(_page1);
            _page2.parent.removeChild(_page2);
            _page3.parent.removeChild(_page3);
            _page6.parent.removeChild(_page6);
            _page4.parent.removeChild(_page4);
            _page5.parent.removeChild(_page5);
            _sellButton.parent.removeChild(_sellButton);
            _splitButton.parent.removeChild(_splitButton);
            _tidyButton.parent.removeChild(_tidyButton);
            _sortBtn.parent.removeChild(_sortBtn);
            if(_guardBag.parent)
            {
               _guardBag.parent.removeChild(_guardBag);
            }
            if(_tattooBag.parent)
            {
               _tattooBag.parent.removeChild(_tattooBag);
            }
            if(_dragonSoulBag.parent)
            {
               _dragonSoulBag.parent.removeChild(_dragonSoulBag);
            }
         }
      }
      
      public function set defaultContent(param1:String) : void
      {
         _isHand = false;
         switch(param1)
         {
            case ArmyPanelEnum.EQUIP_PANEL:
            case ArmyPanelEnum.ATTRIBUTE_PANEL:
               _equipButton.dispatchEvent(new MouseEvent("click"));
               break;
            case ArmyPanelEnum.INFORMATION_PANEL:
               _informationButton.dispatchEvent(new MouseEvent("click"));
               break;
            case ArmyPanelEnum.BATTLEGUARD_PANEL:
               _guardButton.dispatchEvent(new MouseEvent("click"));
               break;
            case ArmyPanelEnum.DRAGON_SOUL_PANEL:
               _dragonSoulButton.dispatchEvent(new MouseEvent("click"));
               break;
            case ArmyPanelEnum.TATTOO_PANEL:
               _tattooButton.dispatchEvent(new MouseEvent("click"));
               break;
            case ArmyPanelEnum.HOLY_DRAGON_SOUL_PANEL:
               _holyDragonSoulButton.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function __tidyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_rightBtnGroup.selectIndex == 0)
         {
            BagHelper.instance.onTidyHandler(_equipBag);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            BagHelper.instance.onTidyHandler(_storeBag);
         }
      }
      
      private function __sellHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         BagHelper.instance.onSellButtonClickHandler(this);
      }
      
      private function __splitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BagHelper.instance.onSplitHandler(this);
      }
      
      private function __infoChange(param1:PlayerEvent) : void
      {
      }
      
      private function __dragonSoulUpdateHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.dragonSoulType == 153)
         {
            _btnHBox.removeAllChild();
            _btnHBox.addChild(_equipButton);
            _btnHBox.addChild(_guardButtonMc);
            _btnHBox.addChild(_holyDragonSoulButton);
            _btnHBox.addChild(_tattooButton);
            _btnHBox.addChild(_informationButton);
            _guardButtonMc.gotoAndStop(1);
            _vicePasswordStrip.visible = thane.grades < 10;
            _btnVpLock.enable = thane.grades >= 10;
            _informationStrip.x = _informationButton.x + 5;
            _holyDragonSoulButton.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function __bagIsFullHandler(param1:BagEvent) : void
      {
         GoodsManager.instance.filterGoodsInGeneralAndConsortiaBag();
      }
      
      private function __bagItemDoubleClick(param1:NotificationEvent) : void
      {
         defaultContent = ArmyPanelEnum.EQUIP_PANEL;
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_pageGroup.getSelectedItem())
         {
            case _page1:
               model.currentPage = 1;
               break;
            case _page2:
               model.currentPage = 2;
               break;
            case _page3:
               model.currentPage = 3;
               break;
            case _page6:
               model.currentPage = 4;
               break;
            case _page4:
               model.currentPage = 5;
               break;
            case _page5:
               model.currentPage = 6;
         }
         if(_equipBag.visible)
         {
            _equipBag.gotoPage(model.currentPage);
         }
         if(_storeBag.visible)
         {
            _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show(param1:Object = null) : void
      {
         if(!stage)
         {
            LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
            NewbieManager.instance.playLockWeekGuild();
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
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         NewbieManager.instance.closePlayLockWeek();
         if(isAddToPool)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            _loc1_ = StageReferance.stage.focus as DisplayObject;
            if(_loc1_ && contains(_loc1_))
            {
               StageReferance.stage.focus = null;
            }
            ComponentFactory.Instance.preStylename = "";
            return;
         }
         clearTimeout(_stopDragonShineTimerId);
         _stopDragonShineTimerId = 0;
         removeEvent();
         BagHelper.instance.stopSelling();
         DragManager.getInstance().stopDrag();
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.focus = null;
         fashionModel.selectedPanel = "";
         ObjectUtils.disposeObject(_dragonSoulBtnInfoTipsView);
         _dragonSoulBtnInfoTipsView = null;
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         ObjectUtils.disposeObject(_informationView);
         _informationView = null;
         ObjectUtils.disposeObject(_dragonSoulView);
         _dragonSoulView = null;
         ObjectUtils.disposeObject(_pageGroup);
         _pageGroup = null;
         ObjectUtils.disposeObject(_equipButton);
         _equipButton = null;
         ObjectUtils.disposeObject(_informationButton);
         _informationButton = null;
         ObjectUtils.disposeObject(_tattooButton);
         _tattooButton = null;
         ObjectUtils.disposeObject(_dragonSoulButton);
         _dragonSoulButton = null;
         ObjectUtils.disposeObject(_guardButton);
         _guardButton = null;
         ObjectUtils.disposeObject(_page1);
         _page1 = null;
         ObjectUtils.disposeObject(_page2);
         _page2 = null;
         ObjectUtils.disposeObject(_page3);
         _page3 = null;
         ObjectUtils.disposeObject(_page6);
         _page6 = null;
         ObjectUtils.disposeObject(_page4);
         _page4 = null;
         ObjectUtils.disposeObject(_page5);
         _page5 = null;
         ObjectUtils.disposeObject(_tidyButton);
         _tidyButton = null;
         ObjectUtils.disposeObject(_splitButton);
         _splitButton = null;
         ObjectUtils.disposeObject(_sellButton);
         _sellButton = null;
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_sellView);
         _sellView = null;
         ObjectUtils.disposeObject(_guardBag);
         _guardBag = null;
         ObjectUtils.disposeObject(_tattooBag);
         _tattooBag = null;
         ObjectUtils.disposeObject(_dragonSoulBag);
         _dragonSoulBag = null;
         ObjectUtils.disposeObject(_btnHBox);
         _btnHBox = null;
         ObjectUtils.disposeObject(_guardButtonMc);
         _guardButtonMc = null;
         ObjectUtils.disposeObject(_dragonSoulButtonMc);
         _dragonSoulButtonMc = null;
         ObjectUtils.disposeObject(_guardView);
         _guardView = null;
         ObjectUtils.disposeObject(_storeBagBagBtn);
         _storeBagBagBtn = null;
         ObjectUtils.disposeObject(_storeBagStoreBtn);
         _storeBagStoreBtn = null;
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeObject(_informationStrip);
         _informationStrip = null;
         ObjectUtils.disposeObject(_sellStrip);
         _sellStrip = null;
         ObjectUtils.disposeObject(_dragonSoulStrip);
         _dragonSoulStrip = null;
         ObjectUtils.disposeObject(_vicePasswordStrip);
         _vicePasswordStrip = null;
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(_setPwdBtn);
         _setPwdBtn = null;
         ObjectUtils.disposeObject(_holyDragonSoulView);
         _holyDragonSoulView = null;
         ObjectUtils.disposeObject(_holyDragonSoulButton);
         _holyDragonSoulButton = null;
         TweenLite.killTweensOf(_rect);
         _rect = null;
         if(BagHelper.instance.isSelling)
         {
            BagHelper.instance.onSellButtonClickHandler(this);
         }
         if(BagHelper.instance.isVpLock)
         {
            BagHelper.instance.vpLockBtnClickHandler(this);
         }
         super.dispose();
         GoodsManager.instance.filterFlag = false;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
      
      public function get equipView() : EquipView
      {
         return _equipView;
      }
      
      public function get equipBag() : EquipBagII
      {
         return _equipBag;
      }
      
      public function get heroEquip() : EquipView
      {
         return _equipView;
      }
      
      public function get page1() : SelectedIconButton
      {
         return _page1;
      }
      
      public function get page2() : SelectedIconButton
      {
         return _page2;
      }
      
      public function get page3() : SelectedIconButton
      {
         return _page3;
      }
      
      public function get page6() : SelectedIconButton
      {
         return _page6;
      }
      
      public function get page4() : SelectedIconButton
      {
         return _page4;
      }
      
      public function get page5() : SelectedIconButton
      {
         return _page5;
      }
      
      public function get vpLockBtn() : IconButton
      {
         return _btnVpLock;
      }
      
      public function get currentPage() : int
      {
         return model != null ? model.currentPage : -1;
      }
      
      public function playFirstOpen() : void
      {
         _equipView.playFirstOpen();
      }
      
      public function get currentIndex() : int
      {
         if(_rightBtnGroup)
         {
            return _rightBtnGroup.selectIndex;
         }
         return 0;
      }
   }
}

