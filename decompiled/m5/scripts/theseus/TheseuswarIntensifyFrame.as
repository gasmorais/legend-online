package theseus
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
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import theseus.war.TheseusWarInSBag;
   import theseus.war.utils.TheseusWarBitPool;
   import theseus.war.view.TheseusWarFenJiePageView;
   import theseus.war.view.TheseusWarGZpageView;
   import theseus.war.view.TheseusWarIntenPageView;
   import theseus.war.view.TheseusWarRefPageView;
   import theseus.war.view.TheseusWarSKPageView;
   import theseus.war.view.TheseusWarStarPageView;
   import yishi.datas.VersionSwitch;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.view.base.TabPageUtil;
   
   public class TheseuswarIntensifyFrame extends Frame implements IManualSize
   {
      
      private var _tabHbox:HBox;
      
      private var _pagContent:Sprite;
      
      private var _bg:Bitmap;
      
      private var _bk:Scale9CornerImage;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _qhBtn:SelectedIconButton;
      
      private var _gzBtn:SelectedIconButton;
      
      private var _xlBtn:SelectedIconButton;
      
      private var _jnBtn:SelectedIconButton;
      
      private var _sxBtn:SelectedIconButton;
      
      private var _fjBtn:SelectedIconButton;
      
      private var _bagII:TheseusWarInSBag;
      
      private var _tabList:Array = [];
      
      private var _splitBtn:TextButton;
      
      public function TheseuswarIntensifyFrame()
      {
         super();
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
         titleText = LanguageMgr.GetTranslation("theseus.war.intensifyTitle");
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.warIntensifyBg");
         _bk = ComponentFactory.Instance.creatComponentByStylename("TheseuswarIntensifyFrame.BagBack");
         _qhBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab1Btn");
         _gzBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab2Btn");
         _xlBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab3Btn");
         _jnBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab4Btn");
         _sxBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab5Btn");
         _fjBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsoulTab6Btn");
         _tabHbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warIntensifyFHbox");
         _bagII = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarInSBag");
         _splitBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.splitBtn");
         _splitBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.split");
         _pagContent = new Sprite();
         _tabPageUtil = new TabPageUtil();
         addToContent(_bk);
         addToContent(_bg);
         addToContent(_pagContent);
         addToContent(_tabHbox);
         addToContent(_bagII);
         _tabHbox.beginChanges();
         _tabHbox.addChild(_qhBtn);
         _tabHbox.addChild(_sxBtn);
         _tabHbox.addChild(_gzBtn);
         if(VersionSwitch.WARSOUL_XL)
         {
            _tabHbox.addChild(_xlBtn);
         }
         if(VersionSwitch.WARSOUL_JN)
         {
            _tabHbox.addChild(_jnBtn);
         }
         _tabHbox.addChild(_fjBtn);
         _tabHbox.commitChanges();
         _tabPageUtil.addItemPage(_qhBtn,creatQhView);
         _tabPageUtil.addItemPage(_sxBtn,creatSxView);
         _tabPageUtil.addItemPage(_gzBtn,createGzView);
         if(VersionSwitch.WARSOUL_XL)
         {
            _tabPageUtil.addItemPage(_xlBtn,createXlView);
         }
         if(VersionSwitch.WARSOUL_JN)
         {
            _tabPageUtil.addItemPage(_jnBtn,creatJnView);
         }
         _tabPageUtil.addItemPage(_fjBtn,creatfjView);
         _tabList.push("qh");
         _tabList.push("sx");
         _tabList.push("gz");
         if(VersionSwitch.WARSOUL_XL)
         {
            _tabList.push("xl");
         }
         if(VersionSwitch.WARSOUL_JN)
         {
            _tabList.push("jn");
         }
         _tabList.push("fj");
      }
      
      private function creatQhView() : TheseusWarIntenPageView
      {
         var _loc1_:TheseusWarIntenPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarIntenPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createGzView() : TheseusWarGZpageView
      {
         var _loc1_:TheseusWarGZpageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarGZpageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createXlView() : TheseusWarRefPageView
      {
         var _loc1_:TheseusWarRefPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarRefPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatJnView() : TheseusWarSKPageView
      {
         var _loc1_:TheseusWarSKPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarSKPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatSxView() : TheseusWarStarPageView
      {
         var _loc1_:TheseusWarStarPageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarStarPageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatfjView() : TheseusWarFenJiePageView
      {
         var _loc1_:TheseusWarFenJiePageView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarFenJiePageView");
         _pagContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabPageUtil.addEventListener("change",tabChangeHandler);
         _splitBtn.addEventListener("click",__splitHandler);
      }
      
      private function removeEvent() : void
      {
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
         ObjectUtils.disposeObject(_xlBtn);
         _xlBtn = null;
         ObjectUtils.disposeObject(_jnBtn);
         _jnBtn = null;
         ObjectUtils.disposeObject(_sxBtn);
         _sxBtn = null;
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

