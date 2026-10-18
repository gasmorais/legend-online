package stelesys
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import stelesys.view.SteleIntensifyView;
   import stelesys.view.SteleSysAdvanceView;
   import stelesys.view.SteleSysRecycleView;
   import stelesys.view.SteleSysRefineView;
   import stelesys.view.SteleSysmainView;
   import stelesys.view.StelesysboxTip;
   import yishi.view.base.TabPageUtil;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SteleSysFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _btnBox:HBox;
      
      private var _mainBtn:SelectedIconButton;
      
      private var _intensifyBtn:SelectedIconButton;
      
      private var _advanceBtn:SelectedIconButton;
      
      private var _refineBtn:SelectedIconButton;
      
      private var _recycleBtn:SelectedIconButton;
      
      private var _tipView:StelesysboxTip;
      
      private var _helpBtn:BaseButton;
      
      private var _pageContent:Sprite;
      
      public function SteleSysFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,985,675);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("stela.mainFrame.title");
         _border = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.border");
         _btnBox = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.btnBox");
         _mainBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.mainBtn");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifyBtn");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceBtn");
         _refineBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineBtn");
         _recycleBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.recycleBtn");
         _tipView = ComponentFactory.Instance.creatCustomObject("ui.stelesys.main.tipView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("stela.helpBtn");
         _pageContent = new Sprite();
         addToContent(_border);
         addToContent(_helpBtn);
         addToContent(_pageContent);
         _btnBox.beginChanges();
         _btnBox.addChild(_mainBtn);
         _btnBox.addChild(_intensifyBtn);
         _btnBox.addChild(_advanceBtn);
         _btnBox.addChild(_refineBtn);
         _btnBox.addChild(_recycleBtn);
         _btnBox.commitChanges();
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_mainBtn,creatMainPage);
         _tabPageUtil.addItemPage(_intensifyBtn,creatIntensifyPage);
         _tabPageUtil.addItemPage(_advanceBtn,creatAdvancePage);
         _tabPageUtil.addItemPage(_refineBtn,creatRefinePage);
         _tabPageUtil.addItemPage(_recycleBtn,creatRecyclePage);
         _tabPageUtil.selectIndex = 0;
         addToContent(_btnBox);
         addToContent(_tipView);
         _tipView.visible = false;
      }
      
      private function creatMainPage() : SteleSysmainView
      {
         var _loc1_:SteleSysmainView = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.MainPage");
         _pageContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatIntensifyPage() : SteleIntensifyView
      {
         var _loc1_:SteleIntensifyView = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.IntensifyPage");
         _pageContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatAdvancePage() : SteleSysAdvanceView
      {
         var _loc1_:SteleSysAdvanceView = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.AdvancePage");
         _pageContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatRefinePage() : SteleSysRefineView
      {
         var _loc1_:SteleSysRefineView = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.RefinePage");
         _pageContent.addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatRecyclePage() : SteleSysRecycleView
      {
         var _loc1_:SteleSysRecycleView = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.RecyclePage");
         _pageContent.addChild(_loc1_);
         return _loc1_;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            _tabPageUtil.selectIndex = int(param1.frameData);
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("stela.helpFrame");
         _loc2_.show();
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
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_mainBtn);
         _mainBtn = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_refineBtn);
         _refineBtn = null;
         ObjectUtils.disposeObject(_recycleBtn);
         _recycleBtn = null;
         ObjectUtils.disposeObject(_btnBox);
         _btnBox = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(_pageContent);
         _pageContent = null;
         super.dispose();
      }
   }
}

