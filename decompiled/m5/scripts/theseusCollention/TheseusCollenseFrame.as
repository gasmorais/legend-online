package theseusCollention
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollenTionModel;
   import yishi.datas.ComponentGroupType;
   import yishi.service.managers.SocketManager;
   
   public class TheseusCollenseFrame extends Frame implements IManualSize
   {
      
      public var _collentionBtn:SelectedIconButton;
      
      public var _suitBtn:SelectedIconButton;
      
      public var _chipBtn:SelectedIconButton;
      
      public var _box:SelectedIconButton;
      
      public var _box1:SelectedIconButton;
      
      public var _box2:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _currentView:Sprite;
      
      protected var _redcollention:Bitmap;
      
      protected var _redbox:Bitmap;
      
      protected var _redboxcoll:Bitmap;
      
      public function TheseusCollenseFrame()
      {
         super();
         initView();
         addEvent();
         initInfo();
         TheseussoulManager.Instance.doCollectionthing(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,600);
      }
      
      private function initView() : void
      {
         _collentionBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_CollectedBtn");
         _suitBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_suitBtn");
         _chipBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_chipBtn");
         _box = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_boxBtn");
         _box1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_boxBtn1");
         _box2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_boxBtn2");
         _redcollention = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         _redbox = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         _redboxcoll = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         _redboxcoll.x = _redcollention.x = _redbox.x = 80;
         _redboxcoll.y = _redcollention.y = _redbox.y = 0;
         _collentionBtn.addChild(_redcollention);
         _box.addChild(_redbox);
         _box2.addChild(_redboxcoll);
         addToContent(_collentionBtn);
         addToContent(_suitBtn);
         addToContent(_chipBtn);
         addToContent(_box);
         addToContent(_box1);
         addToContent(_box2);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_collentionBtn);
         _group.addSelectItem(_suitBtn);
         _group.addSelectItem(_chipBtn);
         _group.addSelectItem(_box);
         _group.addSelectItem(_box1);
         _group.addSelectItem(_box2);
         _group.selectIndex = 0;
         updateRed();
      }
      
      private function initInfo() : void
      {
         _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.view.TheseusCollentionedView");
         _currentView.x = 0;
         _currentView.y = -15;
         addToContent(_currentView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__groupChangeHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",updateRed1);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,updateRed);
         TheseussoulManager.Instance.addEventListener("OP_COLLECTION_UPGRADETASK",updateRed1);
      }
      
      private function updateRed1(param1:Event) : void
      {
         var e:Event = param1;
         setTimeout(function():void
         {
            updateRed();
         },2000);
      }
      
      private function updateRed(param1:Object = null) : void
      {
         if(_redcollention)
         {
            _redcollention.visible = model.checkAllcollectionRed();
         }
         if(_redbox)
         {
            _redbox.visible = model.checkAllboxRed();
         }
         if(_redboxcoll)
         {
            _redboxcoll.visible = model.allred;
         }
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__groupChangeHandler);
         removeEventListener("response",__frameResponse);
         TheseussoulManager.Instance.removeEventListener("EVENT_COLLECTION_UPDATE",updateRed1);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 212,updateRed);
         TheseussoulManager.Instance.removeEventListener("OP_COLLECTION_UPGRADETASK",updateRed1);
      }
      
      private function refreshView() : void
      {
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         if(_group.selectIndex == 0)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.view.TheseusCollentionedView");
            _currentView.x = 0;
            _currentView.y = -15;
         }
         else if(_group.selectIndex == 1)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.view.TheseusCollentionSuitView");
            _currentView.x = 0;
            _currentView.y = 30;
         }
         else if(_group.selectIndex == 2)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.view.TheseusCollentionChipView");
            _currentView.x = 0;
            _currentView.y = 30;
         }
         else if(_group.selectIndex == 3)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.view.TheseusBoxView");
            _currentView.x = 0;
            _currentView.y = 30;
         }
         else if(_group.selectIndex == 4)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.shop.TheseusCollentionShopView");
            _currentView.x = 0;
            _currentView.y = 30;
         }
         else if(_group.selectIndex == 5)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("theseusCollention.pro.TheseusCollProView");
            _currentView.x = 220;
            _currentView.y = 30;
         }
         addToContent(_currentView);
      }
      
      private function get index() : int
      {
         return _group.selectIndex + 1;
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
         this.titleText = LanguageMgr.GetTranslation("TheseusCollentionFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_collentionBtn);
         _collentionBtn = null;
         ObjectUtils.disposeObject(_suitBtn);
         _suitBtn = null;
         ObjectUtils.disposeObject(_chipBtn);
         _chipBtn = null;
         ObjectUtils.disposeObject(_redbox);
         _redbox = null;
         ObjectUtils.disposeObject(_redcollention);
         _redcollention = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         super.dispose();
      }
   }
}

