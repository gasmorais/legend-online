package theseus.warFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import theseus.war.utils.TheseusWarBitPool;
   import theseus.warFrame.view.WarFrameBag;
   import theseus.warFrame.view.WarframeEnhancementView;
   import theseus.warFrame.view.WarframeTransformationView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.base.TabPageUtil;
   
   public class WarframeEnhancementFrame extends Frame implements IManualSize
   {
      
      private var _tabHbox:HBox;
      
      private var _pagContent:Sprite;
      
      private var _bg:Bitmap;
      
      private var _bk:Scale9CornerImage;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _qhBtn:SelectedIconButton;
      
      private var _gzBtn:SelectedIconButton;
      
      private var _bagII:WarFrameBag;
      
      private var _tabList:Array = [];
      
      private var _splitBtn:TextButton;
      
      public var _allNum:FilterFrameText;
      
      public var _numBack:Bitmap;
      
      public var _mainPriceIcon:ScaleFrameImage;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      public var _tips:FilterFrameText;
      
      public function WarframeEnhancementFrame()
      {
         super();
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         initView();
         initEvent();
         _tabPageUtil.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,536);
      }
      
      private function initView() : void
      {
         TheseusWarBitPool.Ins.init();
         titleText = LanguageMgr.GetTranslation("theseus.warFrame.intensifyTitle");
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.warIntensifyBg");
         _bk = ComponentFactory.Instance.creatComponentByStylename("TheseuswarIntensifyFrame.BagBack");
         _qhBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warFrameTab1Btn");
         _gzBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warFrameTab2Btn");
         _tabHbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warIntensifyFHbox");
         _bagII = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.WarFrameBag");
         _splitBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.splitBtn");
         _splitBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.split");
         _pagContent = new Sprite();
         _tabPageUtil = new TabPageUtil();
         _tips = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.QhNeedMaxTxt");
         addToContent(_bk);
         addToContent(_bg);
         addToContent(_pagContent);
         addToContent(_tabHbox);
         addToContent(_bagII);
         _tabHbox.beginChanges();
         _tabHbox.addChild(_qhBtn);
         _tabHbox.addChild(_gzBtn);
         _tabHbox.commitChanges();
         _tabPageUtil.addItemPage(_qhBtn,creatQhView);
         _tabPageUtil.addItemPage(_gzBtn,createGzView);
         _tabList.push(5);
         _tabList.push(6);
         _allNum = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.allNum");
         _mainPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.mainPriceIcon");
         _numBack = ComponentFactory.Instance.creatBitmap("asset.poseridon.numBack");
         addToContent(_numBack);
         addToContent(_allNum);
         addToContent(_mainPriceIcon);
         _mainPriceIcon.x = 534;
         _mainPriceIcon.y = 19;
         _numBack.y = 9;
         _allNum.y = 13;
         _mainPriceIcon.setFrame(1);
         __updatePoint(null);
         addToContent(_tips);
         _tips.text = LanguageMgr.GetTranslation("theseus.equip.QHtips1");
      }
      
      private function __updatePoint(param1:NotificationEvent = null) : void
      {
         if(_currencyInfo.poseidonCoin)
         {
            _allNum.text = _currencyInfo.poseidonCoin.amount.toString();
         }
      }
      
      private function creatQhView() : WarframeEnhancementView
      {
         var _loc1_:WarframeEnhancementView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warFrame.WarframeEnhancementView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createGzView() : WarframeTransformationView
      {
         var _loc1_:WarframeTransformationView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warFrame.WarframeTransformationView");
         _loc1_.x = 41;
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updatePoint);
         addEventListener("response",__frameResponse);
         _tabPageUtil.addEventListener("change",tabChangeHandler);
         _splitBtn.addEventListener("click",__splitHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updatePoint);
         removeEventListener("response",__frameResponse);
         _tabPageUtil.removeEventListener("change",tabChangeHandler);
         _splitBtn.addEventListener("click",__splitHandler);
      }
      
      private function __splitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         TheseusWarBitPool.Ins.onSplitHandler(this);
      }
      
      private function tabChangeHandler(param1:Event) : void
      {
         if(_bagII)
         {
            _bagII.metrailUpdateView(_tabList[_tabPageUtil.selectIndex]);
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
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_qhBtn);
         _qhBtn = null;
         ObjectUtils.disposeObject(_gzBtn);
         _gzBtn = null;
         ObjectUtils.disposeObject(_tabHbox);
         _tabHbox = null;
         ObjectUtils.disposeObject(_pagContent);
         _pagContent = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_bk);
         _bk = null;
         ObjectUtils.disposeObject(_bagII);
         _bagII = null;
         ObjectUtils.disposeObject(_splitBtn);
         _splitBtn = null;
         DragManager.getInstance().stopDrag();
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.focus = null;
         super.dispose();
         TheseusWarBitPool.Ins.clean();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

