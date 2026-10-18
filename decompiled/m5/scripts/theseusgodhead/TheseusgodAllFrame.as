package theseusgodhead
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadModel;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import theseusgodhead.view.GodItemSellView;
   import theseusgodhead.view.TheseusGodheadBagView;
   import theseusgodhead.view.TheseusGodheadStarUpView;
   import theseusgodhead.view.TheseusGodheadTaskView;
   import theseusgodhead.view.TheseusGodheadUpgradeView;
   import theseusgodhead.view.TheseusGodheadView;
   import yishi.GlobalConfig;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusgodAllFrame extends Frame
   {
      
      public static const EventGodheadInsPutOut:String = "EventGodheadInsPutOut";
      
      public static const EventGodheadInsPutIn:String = "EventGodheadInsPutIn";
      
      private var _godheadview:TheseusGodheadView;
      
      private var _bagView:TheseusGodheadBagView;
      
      protected var _TheseusGodHeadbg:Bitmap;
      
      private var _dragContainer:Sprite;
      
      private var _pageGroup:SelectedButtonGroup;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _page3:SelectedIconButton;
      
      private var _page4:SelectedIconButton;
      
      private var _page5:SelectedIconButton;
      
      private var _page6:SelectedIconButton;
      
      private var _btnVpLock:IconButton;
      
      private var _lockBtn:TextButton;
      
      private var _setPwdBtn:TextButton;
      
      private var _actionButtonGroup:SelectedButtonGroup;
      
      private var _actionHBox:HBox;
      
      private var _decomposeBtn:TextButton;
      
      private var _rotateBtn:TextButton;
      
      private var _decomposeView:GodItemSellView;
      
      private var _dragBagPos:int = -1;
      
      private var _dragStoneId:int = -1;
      
      private var _selectedPos:int = 0;
      
      private var upgradeView:TheseusGodheadUpgradeView;
      
      private var starUpView:TheseusGodheadStarUpView;
      
      private var taskView:TheseusGodheadTaskView;
      
      public function TheseusgodAllFrame()
      {
         super();
         initView();
         initEvent();
         TheseussoulManager.Instance.requestSlateData();
      }
      
      private function get godheadmodel() : TheseusGodheadModel
      {
         return TheseussoulManager.Instance.modelGodhead;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,600);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("theseusgodhead.txt1");
         _TheseusGodHeadbg = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbg");
         addToContent(_TheseusGodHeadbg);
         _TheseusGodHeadbg.y = 15;
         _godheadview = new TheseusGodheadView();
         _godheadview.y = 15;
         _bagView = new TheseusGodheadBagView();
         _bagView.x = 385;
         _bagView.y = 15;
         _dragContainer = new Sprite();
         _dragContainer.x = 0;
         _dragContainer.y = 0;
         _dragContainer.mouseEnabled = false;
         addToContent(_dragContainer);
         _pageGroup = new SelectedButtonGroup();
         _page1 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page1Button");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page2Button");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page3Button");
         _page4 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page4Button");
         _page5 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page5Button");
         _page6 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page6Button");
         _pageGroup.addSelectItem(_page1);
         _pageGroup.addSelectItem(_page2);
         _pageGroup.addSelectItem(_page3);
         _pageGroup.addSelectItem(_page4);
         _pageGroup.addSelectItem(_page5);
         _pageGroup.addSelectItem(_page6);
         _pageGroup.selectIndex = 0;
         _btnVpLock = ComponentFactory.Instance.creatComponentByStylename("vicepassword.lockbtn");
         _btnVpLock.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.vicepasswordBtnTipData");
         _btnVpLock.enable = thane.grades >= 10;
         _btnVpLock.x = 690;
         _btnVpLock.y = -12;
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.vicePasswordLockBtn");
         _lockBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.lockBtn.text");
         _lockBtn.x = 713;
         _lockBtn.y = -3;
         _setPwdBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.setPwdBtn");
         _setPwdBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         _setPwdBtn.x = 713;
         _setPwdBtn.y = 25;
         showPwdBtnState(false);
         initActionButtons();
         addToContent(_page1);
         addToContent(_page2);
         addToContent(_page3);
         addToContent(_page4);
         addToContent(_page5);
         addToContent(_page6);
         addToContent(_bagView);
         addToContent(_godheadview);
         addToContent(_btnVpLock);
         addToContent(_lockBtn);
         addToContent(_setPwdBtn);
         addToContent(_actionHBox);
         initBagButtons();
      }
      
      private function initBagButtons() : void
      {
         _decomposeBtn = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.decomposeBtn");
         _decomposeBtn.text = LanguageMgr.GetTranslation("theseusgodhead.decompose");
         _decomposeBtn.addEventListener("click",__decomposeBtnClick);
         addToContent(_decomposeBtn);
         _rotateBtn = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.rotateBtn");
         _rotateBtn.text = LanguageMgr.GetTranslation("theseusgodhead.rotate");
         _rotateBtn.addEventListener("click",__rotateBtnClick);
         addToContent(_rotateBtn);
      }
      
      private function __decomposeBtnClick(param1:MouseEvent) : void
      {
         if(!_decomposeView)
         {
            _decomposeView = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.view.GodItemSellView");
            _decomposeView.x = 740;
            _decomposeView.addEventListener("decomposeViewClose",__decomposeViewClose);
         }
         if(_decomposeView.parent)
         {
            _decomposeView.parent.removeChild(_decomposeView);
            _bagView.toggleDecomposeMode();
            _decomposeView.disableEventListeners();
            godheadmodel.isDecomposeVisible = false;
            _decomposeBtn.visible = true;
            _rotateBtn.visible = true;
         }
         else
         {
            addToContent(_decomposeView);
            _bagView.toggleDecomposeMode();
            _decomposeView.enableEventListeners();
            godheadmodel.isDecomposeVisible = true;
            _decomposeBtn.visible = false;
            _rotateBtn.visible = false;
         }
      }
      
      private function __decomposeViewClose(param1:Event) : void
      {
         if(_bagView)
         {
            _bagView.toggleDecomposeMode();
            _bagView.clearSelection();
         }
         _decomposeView = null;
         godheadmodel.isDecomposeVisible = false;
         _decomposeBtn.visible = true;
         _rotateBtn.visible = true;
      }
      
      private function __decomposeItemClick(param1:Event) : void
      {
         var _loc2_:TheseusGodheadBagItem = _bagView.lastClickedItem;
         if(_loc2_ && _loc2_.data)
         {
            _decomposeView.addSlateToDecompose(_loc2_.data);
         }
      }
      
      private function __rotateBtnClick(param1:MouseEvent) : void
      {
         _bagView.toggleRotateMode();
      }
      
      private function __rotateModeChanged(param1:Event) : void
      {
         if(!godheadmodel.isRotateMode)
         {
            _decomposeBtn.visible = true;
            _rotateBtn.visible = true;
         }
      }
      
      private function initActionButtons() : void
      {
         var _loc4_:SelectedTextButton = null;
         var _loc3_:int = 0;
         _actionButtonGroup = new SelectedButtonGroup();
         _actionHBox = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.actionHBox");
         var _loc1_:Array = [LanguageMgr.GetTranslation("theseusgodhead.txt1"),LanguageMgr.GetTranslation("theseusgodhead.txt2"),LanguageMgr.GetTranslation("theseusgodhead.txt3"),LanguageMgr.GetTranslation("theseusgodhead.txt4")];
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _actionHBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.actionButton");
            _loc4_.text = _loc1_[_loc3_];
            _actionHBox.addChild(_loc4_);
            _actionButtonGroup.addSelectItem(_loc4_);
            _loc3_++;
         }
         _actionHBox.commitChanges();
         _actionButtonGroup.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _bagView.addEventListener("change",__bagSelectionChange);
         _bagView.addEventListener("dragStart",__bagItemDragStart,true);
         _bagView.addEventListener("rotateModeChanged",__rotateModeChanged);
         _pageGroup.addEventListener("change",__pageChangeHandler);
         _btnVpLock.addEventListener("click",__vpLockHandler);
         _lockBtn.addEventListener("click",__goodsLockHandler);
         _setPwdBtn.addEventListener("click",__setPwdHandler);
         _actionButtonGroup.addEventListener("change",__actionButtonChange);
         TheseussoulManager.Instance.addEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_bagView)
         {
            _bagView.removeEventListener("change",__bagSelectionChange);
            _bagView.removeEventListener("dragStart",__bagItemDragStart,true);
            _bagView.removeEventListener("rotateModeChanged",__rotateModeChanged);
         }
         if(_pageGroup)
         {
            _pageGroup.removeEventListener("change",__pageChangeHandler);
         }
         if(_btnVpLock)
         {
            _btnVpLock.removeEventListener("click",__vpLockHandler);
         }
         if(_lockBtn)
         {
            _lockBtn.removeEventListener("click",__goodsLockHandler);
         }
         if(_setPwdBtn)
         {
            _setPwdBtn.removeEventListener("click",__setPwdHandler);
         }
         if(_actionButtonGroup)
         {
            _actionButtonGroup.removeEventListener("change",__actionButtonChange);
         }
         if(_decomposeView)
         {
            _decomposeView.removeEventListener("decomposeViewClose",__decomposeViewClose);
         }
         if(_decomposeBtn)
         {
            _decomposeBtn.removeEventListener("click",__decomposeBtnClick);
         }
         if(_rotateBtn)
         {
            _rotateBtn.removeEventListener("click",__rotateBtnClick);
         }
         TheseussoulManager.Instance.removeEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
      }
      
      private function refreshBag() : void
      {
         var _loc1_:Array = godheadmodel.getBagStones();
         _bagView.setGoods(_loc1_);
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _bagView.gotoPage(_pageGroup.selectIndex + 1);
      }
      
      private function __bagSelectionChange(param1:Event) : void
      {
         var _loc2_:TheseusGodheadBagItem = null;
         if(TheseusGodheadBagHelper.instance.isVpLock)
         {
            return;
         }
         if(godheadmodel.isDecomposeVisible)
         {
            _loc2_ = _bagView.lastClickedItem;
            if(_loc2_.data.isLock)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseusgodhead.equipped_none.lock"));
               return;
            }
            if(_loc2_ && _loc2_.data)
            {
               _decomposeView.addSlateToDecompose(_loc2_.data);
            }
            return;
         }
         var _loc3_:TheseusGodheadStoneInfo = _bagView.selectedGoods;
         if(!_loc3_)
         {
            return;
         }
         if(godheadmodel.isMainViewVisible && _selectedPos >= 0)
         {
         }
         if(upgradeView && upgradeView.visible)
         {
            upgradeView.updateUI(_loc3_.stoneId);
            NotificationManager.instance.sendNotification("EventGodheadInsPutIn",_loc3_.stoneId);
         }
         if(starUpView && starUpView.visible)
         {
            NotificationManager.instance.sendNotification("EventGodheadInsPutIn",_loc3_.stoneId);
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
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isDuringResetTime)
         {
            _loc3_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         showPwdBtnState(true);
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
            return;
         }
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         if(GlobalConfig.isConfirmPassword)
         {
            TheseusGodheadBagHelper.instance.vpLockBtnClickHandler(this);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
         }
      }
      
      private function __actionButtonChange(param1:Event) : void
      {
         switch(int(_actionButtonGroup.selectIndex))
         {
            case 0:
               loadTheseusGodheadView();
               break;
            case 1:
               loadTheseusGodheadUpgradeView();
               break;
            case 2:
               loadTheseusGodheadStarUpView();
               break;
            case 3:
               loadTaskView();
         }
         NotificationManager.instance.sendNotification("EventGodheadInsPutOut");
      }
      
      private function loadTheseusGodheadView() : void
      {
         if(_godheadview)
         {
            _godheadview.visible = true;
         }
         godheadmodel.isMainViewVisible = true;
         hideOtherViews();
      }
      
      private function loadTheseusGodheadUpgradeView() : void
      {
         if(starUpView)
         {
            starUpView.visible = false;
         }
         if(_godheadview)
         {
            _godheadview.visible = false;
         }
         if(taskView)
         {
            taskView.visible = false;
         }
         godheadmodel.isMainViewVisible = false;
         _bagView.clearSelection();
         if(!upgradeView)
         {
            upgradeView = new TheseusGodheadUpgradeView();
            addToContent(upgradeView);
            upgradeView.y = 60;
         }
         upgradeView.visible = true;
      }
      
      private function loadTheseusGodheadStarUpView() : void
      {
         if(upgradeView)
         {
            upgradeView.visible = false;
         }
         if(_godheadview)
         {
            _godheadview.visible = false;
         }
         if(taskView)
         {
            taskView.visible = false;
         }
         godheadmodel.isMainViewVisible = false;
         _bagView.clearSelection();
         if(!starUpView)
         {
            starUpView = new TheseusGodheadStarUpView();
            addToContent(starUpView);
         }
         starUpView.y = 30;
         starUpView.visible = true;
      }
      
      private function loadTaskView() : void
      {
         if(upgradeView)
         {
            upgradeView.visible = false;
         }
         if(_godheadview)
         {
            _godheadview.visible = false;
         }
         if(starUpView)
         {
            starUpView.visible = false;
         }
         godheadmodel.isMainViewVisible = false;
         if(!taskView)
         {
            taskView = new TheseusGodheadTaskView();
            taskView.x = -10;
            taskView.y = -15;
            addToContent(taskView);
         }
         taskView.visible = true;
      }
      
      private function hideOtherViews() : void
      {
         if(upgradeView)
         {
            upgradeView.visible = false;
         }
         if(taskView)
         {
            taskView.visible = false;
         }
         if(starUpView)
         {
            starUpView.visible = false;
         }
      }
      
      private function __decomposeHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:GodItemSellView = new GodItemSellView();
         addChild(_loc2_);
      }
      
      private function showPwdBtnState(param1:Boolean) : void
      {
         _lockBtn.visible = _setPwdBtn.visible = param1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function __bagItemDragStart(param1:NotificationEvent) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Object = param1.data as Object;
         var _loc3_:TheseusGodheadStoneInfo = _loc5_ ? _loc5_.stoneInfo as TheseusGodheadStoneInfo : null;
         var _loc2_:Number = _loc5_ ? _loc5_.mouseX as Number : 0;
         var _loc6_:Number = _loc5_ ? _loc5_.mouseY as Number : 0;
         if(_loc3_ && _loc2_ && _loc6_)
         {
            _dragBagPos = _loc5_.bagPos != null ? int(_loc5_.bagPos) : -1;
            _dragStoneId = _loc3_.stoneId;
            _loc4_ = _godheadview.globalToLocal(new Point(_loc2_,_loc6_));
         }
      }
      
      private function sendMoveStoneToServer(param1:int, param2:int) : void
      {
         trace("发{invalid_utf8=233}?{invalid_utf8=129}移动石板到服务{invalid_utf8=231}{invalid_utf8=171}?: 从位{invalid_utf8=231}{invalid_utf8=189}?=" + param1 + ", 到位{invalid_utf8=231}{invalid_utf8=189}?=" + param2);
      }
      
      private function _onSlateUpdate(param1:NotificationEvent = null) : void
      {
         refreshBag();
         if(_godheadview && _godheadview.visible)
         {
            _godheadview.refresh();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rotateBtn);
         _rotateBtn = null;
         ObjectUtils.disposeObject(_pageGroup);
         _pageGroup = null;
         ObjectUtils.disposeObject(_page1);
         _page1 = null;
         ObjectUtils.disposeObject(_page2);
         _page2 = null;
         ObjectUtils.disposeObject(_page3);
         _page3 = null;
         ObjectUtils.disposeObject(_page4);
         _page4 = null;
         ObjectUtils.disposeObject(_page5);
         _page5 = null;
         ObjectUtils.disposeObject(_page6);
         _page6 = null;
         ObjectUtils.disposeObject(_btnVpLock);
         _btnVpLock = null;
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(_setPwdBtn);
         _setPwdBtn = null;
         ObjectUtils.disposeObject(_actionButtonGroup);
         _actionButtonGroup = null;
         ObjectUtils.disposeObject(_actionHBox);
         _actionHBox = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_godheadview);
         _godheadview = null;
         ObjectUtils.disposeObject(_dragContainer);
         _dragContainer = null;
         super.dispose();
      }
   }
}

