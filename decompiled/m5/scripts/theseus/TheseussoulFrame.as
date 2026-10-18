package theseus
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dialog.utils.NewbieManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import playerinfo.view.ThaneAttributeFrame;
   import theseus.view.TheseusEquipPageView;
   import theseus.view.TheseusWarPageView;
   import theseus.view.TheseussoulyiPageView;
   import theseus.view.TreasurePageView;
   import theseus.war.utils.TheseusWarBitPool;
   import yishi.GlobalConfig;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.view.base.TabPageUtil;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseussoulFrame extends Frame implements IManualSize
   {
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _yiBtn:SelectedIconButton;
      
      private var _attributeView:ThaneAttributeFrame;
      
      private var _rect:Rectangle;
      
      private var _pagContent:Sprite;
      
      private var _treasureBtn:SelectedIconButton;
      
      private var _warBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _helpBtn:BaseButton;
      
      private var _btnVpLock:IconButton;
      
      private var _lockBtn:TextButton;
      
      private var _setPwdBtn:TextButton;
      
      public function TheseussoulFrame()
      {
         super();
         initView();
         initEvent();
         TheseussoulManager.Instance.doSomething(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,772,540);
      }
      
      private function initView() : void
      {
         TheseusWarBitPool.Ins.init();
         _rect = new Rectangle(0,0,212,520);
         _tabPageUtil = new TabPageUtil();
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.selectBtnHbox");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.equipSbtn");
         _yiBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.yiSbtn");
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.treasureBtn");
         _warBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("theseuswar.zhangyi.helpBtn");
         _pagContent = new Sprite();
         addToContent(_pagContent);
         addToContent(_btnHbox);
         addToContent(_helpBtn);
         _btnHbox.beginChanges();
         _btnHbox.addChild(_equipBtn);
         _btnHbox.addChild(_yiBtn);
         _btnHbox.addChild(_treasureBtn);
         if(TaskManage.instance.IsTaskFinish(TaskManage.WARSOUL) && Boolean(VersionSwitch.WARSOUL))
         {
            _btnHbox.addChild(_warBtn);
         }
         _btnHbox.commitChanges();
         _helpBtn.visible = false;
         showAttributeView();
         _tabPageUtil.addItemPage(_equipBtn,createEquipView);
         _tabPageUtil.addItemPage(_yiBtn,createYiView);
         _tabPageUtil.addItemPage(_treasureBtn,createTreasureView);
         if(TaskManage.instance.IsTaskFinish(TaskManage.WARSOUL) && Boolean(VersionSwitch.WARSOUL))
         {
            _tabPageUtil.addItemPage(_warBtn,creatWarsoulView);
         }
         _tabPageUtil.selectIndex = 0;
         _btnVpLock = ComponentFactory.Instance.creatComponentByStylename("vicepassword.lockbtn");
         this.addToContent(_btnVpLock);
         _btnVpLock.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.vicepasswordBtnTipData");
         _btnVpLock.enable = thane.grades >= 10;
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.vicePasswordLockBtn");
         _btnVpLock.x = 689;
         _btnVpLock.y = -8;
         addToContent(_lockBtn);
         _lockBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.lockBtn.text");
         _setPwdBtn = ComponentFactory.Instance.creatComponentByStylename("army.ArmyFrameII.setPwdBtn");
         addToContent(_setPwdBtn);
         _setPwdBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         showPwdBtnState(false);
         _lockBtn.x = 713;
         _setPwdBtn.x = 713;
         _lockBtn.y = -3;
         _setPwdBtn.y = 25;
      }
      
      private function creatWarsoulView() : TheseusWarPageView
      {
         var _loc1_:TheseusWarPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseusWarPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createEquipView() : TheseusEquipPageView
      {
         var _loc1_:TheseusEquipPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseusEquipPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createYiView() : TheseussoulyiPageView
      {
         var _loc1_:TheseussoulyiPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseussoulyiPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createTreasureView() : TreasurePageView
      {
         var _loc1_:TreasurePageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TreasurePageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         _tabPageUtil.addEventListener("change",tabPageChange);
         TheseussoulManager.Instance.addEventListener("EVENT_PROPERTY_UPDATE",propertyHandler);
         _btnVpLock.addEventListener("click",__vpLockHandler);
         _lockBtn.addEventListener("click",__goodsLockHandler);
         _setPwdBtn.addEventListener("click",__setPwdHandler);
         StageReferance.stage.addEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function removeEvent() : void
      {
         _btnVpLock.removeEventListener("click",__vpLockHandler);
         _lockBtn.removeEventListener("click",__goodsLockHandler);
         _setPwdBtn.removeEventListener("click",__setPwdHandler);
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
         _tabPageUtil.removeEventListener("change",tabPageChange);
         TheseussoulManager.Instance.removeEventListener("EVENT_PROPERTY_UPDATE",propertyHandler);
         if(_attributeView)
         {
            _attributeView.removeEventListener("response",__hideHandler);
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
               TheseusBagHelper.instance.vpLockBtnClickHandler(this);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
            }
         }
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
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("theseuswar.zhangyi.helpFrame");
         _loc2_.show();
      }
      
      private function tabPageChange(param1:Event) : void
      {
         if(_tabPageUtil.selectIndex != 1)
         {
            _btnVpLock.visible = true;
         }
         else
         {
            _btnVpLock.visible = false;
         }
         if(_tabPageUtil.selectIndex == 3)
         {
            _helpBtn.visible = true;
         }
         else
         {
            _helpBtn.visible = false;
            _rect.x = -20;
         }
      }
      
      private function propertyHandler(param1:Event = null) : void
      {
         if(_attributeView)
         {
            _attributeView.thane = TheseussoulManager.Instance.model.propertys.thane;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
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
      
      private function __showAttributeHandler(param1:Event) : void
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
            _attributeView.isHideAppell = true;
            propertyHandler();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(_setPwdBtn);
         _setPwdBtn = null;
         ObjectUtils.disposeObject(_btnVpLock);
         _btnVpLock = null;
         ObjectUtils.disposeObject(_attributeView);
         _attributeView = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_yiBtn);
         _yiBtn = null;
         ObjectUtils.disposeObject(_treasureBtn);
         _treasureBtn = null;
         ObjectUtils.disposeObject(_pagContent);
         _pagContent = null;
         DragManager.getInstance().stopDrag();
         ObjectUtils.disposeObject(_warBtn);
         _warBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         StageReferance.stage.focus = null;
         super.dispose();
         TheseusWarBitPool.Ins.clean();
      }
      
      public function get vpLockBtn() : IconButton
      {
         return _btnVpLock;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.equip.mainFrame");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

