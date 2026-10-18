package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.treasure.MyTreasureView;
   import consortia.view.myConsortia.treasure.TreasureHelpView;
   import consortia.view.myConsortia.treasure.TreasureListView;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaTreasurePage extends Sprite implements Disposeable
   {
      
      private var _contorller:ConsortiaControler;
      
      private var _data:ConsortiaModel;
      
      private var _bg:Bitmap;
      
      private var _TreasureListBtn:SelectedIconButton;
      
      private var _MyTreasureBtn:SelectedIconButton;
      
      private var _TreasureHelpBtn:SelectedIconButton;
      
      private var _vbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _treasureListView:TreasureListView;
      
      private var _myTreasureView:MyTreasureView;
      
      private var _treasureHelpView:TreasureHelpView;
      
      private var _treasureMyNum:ConsortiaTabItemNumView;
      
      private var _treasureOtherNum:ConsortiaTabItemNumView;
      
      public var defaultViewIndex:int = 0;
      
      public function ConsortiaTreasurePage()
      {
         super();
         TaskTraceTipManager.instance.cleanByType(51);
         ConsortiaManager.instance.loadConfigInfos();
         initView();
         initEvent();
         showDefaultView();
      }
      
      private function initView() : void
      {
         _contorller = FrameControllerManager.instance.consortiaController;
         _data = _contorller.model;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureBg");
         addChild(_bg);
         _TreasureListBtn = ComponentFactory.Instance.creatComponentByStylename("treasure.TreasureListBtn");
         _MyTreasureBtn = ComponentFactory.Instance.creatComponentByStylename("treasure.MyTreasureBtn");
         _TreasureHelpBtn = ComponentFactory.Instance.creatComponentByStylename("treasure.TreasureHelpBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("treasure.BtnVBox");
         _treasureMyNum = new ConsortiaTabItemNumView();
         _treasureOtherNum = new ConsortiaTabItemNumView();
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_TreasureListBtn);
         _btnGroup.addSelectItem(_MyTreasureBtn);
         _btnGroup.addSelectItem(_TreasureHelpBtn);
         _vbox.addChild(_TreasureListBtn);
         _vbox.addChild(_MyTreasureBtn);
         _vbox.addChild(_TreasureHelpBtn);
         addChild(_vbox);
         _treasureMyNum.x = _vbox.x + _MyTreasureBtn.x + _MyTreasureBtn.width - 20;
         _treasureMyNum.y = _vbox.y + _MyTreasureBtn.y;
         _treasureOtherNum.x = _vbox.x + _TreasureHelpBtn.x + _TreasureHelpBtn.width - 20;
         _treasureOtherNum.y = _vbox.y + _TreasureHelpBtn.y;
         addChild(_treasureMyNum);
         addChild(_treasureOtherNum);
         if(ConsortiaManager.instance.model.treasureGroupInfo.helpOpenId > 0)
         {
            if(ConsortiaManager.instance.model.treasureGroupInfo.NoOpen)
            {
               ConsortiaManager.instance.model.treasureGroupInfo.helpOpenId = -1;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasurNoOpen"));
               _btnGroup.selectIndex = 0;
               defaultViewIndex = 0;
               _MyTreasureBtn.enable = false;
               _TreasureHelpBtn.enable = false;
               return;
            }
            _btnGroup.selectIndex = 2;
            defaultViewIndex = 2;
         }
         else
         {
            _btnGroup.selectIndex = 0;
            defaultViewIndex = 0;
         }
         _treasureMyNum.num = _data.treasureMyCount;
         _treasureOtherNum.num = _data.treasureOtherCount;
      }
      
      private function initEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__changeViewHandler);
         }
         if(_data)
         {
            _data.addEventListener("recruitnum_changed",__recruitNumHandler);
         }
      }
      
      private function __recruitNumHandler(param1:ConsortiaEvent) : void
      {
         _treasureMyNum.num = _data.treasureMyCount;
         _treasureOtherNum.num = _data.treasureOtherCount;
      }
      
      public function gotoFrame(param1:int = 2) : void
      {
         if(ConsortiaManager.instance.model.treasureGroupInfo.NoOpen)
         {
            ConsortiaManager.instance.model.treasureGroupInfo.helpOpenId = -1;
            if(param1 != 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasurNoOpen"));
               return;
            }
            _MyTreasureBtn.enable = false;
            _TreasureHelpBtn.enable = false;
            if(_btnGroup.selectIndex == 0)
            {
               return;
            }
         }
         _btnGroup.selectIndex = param1;
         _btnGroup.dispatchEvent(new Event("change"));
      }
      
      public function get treasureHelpView() : TreasureHelpView
      {
         return _treasureHelpView;
      }
      
      private function __changeViewHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_btnGroup)
         {
            _loc2_ = int(_btnGroup.selectIndex);
         }
         defaultViewIndex = _loc2_;
         showDefaultView();
      }
      
      private function showDefaultView() : void
      {
         switch(defaultViewIndex)
         {
            case 0:
               if(_treasureListView == null || Boolean(_treasureListView.isDie))
               {
                  _treasureListView = new TreasureListView();
                  addChild(_treasureListView);
               }
               if(_myTreasureView)
               {
                  _myTreasureView.dispose();
               }
               _myTreasureView = null;
               if(_treasureHelpView)
               {
                  _treasureHelpView.dispose();
               }
               _treasureHelpView = null;
               break;
            case 1:
               if(_myTreasureView == null || Boolean(_myTreasureView.isDie))
               {
                  _myTreasureView = new MyTreasureView();
                  addChild(_myTreasureView);
               }
               if(_treasureListView)
               {
                  _treasureListView.dispose();
               }
               _treasureListView = null;
               if(_treasureHelpView)
               {
                  _treasureHelpView.dispose();
               }
               _treasureHelpView = null;
               break;
            case 2:
               if(_treasureHelpView == null || Boolean(_treasureHelpView.isDie))
               {
                  _treasureHelpView = new TreasureHelpView();
                  addChild(_treasureHelpView);
               }
               if(_treasureListView)
               {
                  _treasureListView.dispose();
               }
               _treasureListView = null;
               if(_myTreasureView)
               {
                  _myTreasureView.dispose();
               }
               _myTreasureView = null;
         }
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeViewHandler);
         }
         if(_data)
         {
            _data.removeEventListener("recruitnum_changed",__recruitNumHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_TreasureListBtn)
         {
            ObjectUtils.disposeObject(_TreasureListBtn);
         }
         _TreasureListBtn = null;
         if(_MyTreasureBtn)
         {
            ObjectUtils.disposeObject(_MyTreasureBtn);
         }
         _MyTreasureBtn = null;
         if(_TreasureHelpBtn)
         {
            ObjectUtils.disposeObject(_TreasureHelpBtn);
         }
         _TreasureHelpBtn = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_treasureListView);
         _treasureListView = null;
         ObjectUtils.disposeObject(_myTreasureView);
         _myTreasureView = null;
         ObjectUtils.disposeObject(_treasureHelpView);
         _treasureHelpView = null;
         ObjectUtils.disposeObject(_treasureMyNum);
         _treasureMyNum = null;
         ObjectUtils.disposeObject(_treasureOtherNum);
         _treasureOtherNum = null;
         _contorller = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

