package cultureactive
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
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   
   public class CultureActiveFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _personBtn:SelectedIconButton;
      
      private var _consortiaBtn:SelectedIconButton;
      
      private var _serverBtn:SelectedIconButton;
      
      private var _cultureView:CultureActiveView;
      
      public function CultureActiveFrame()
      {
         super();
         initView();
         addEvent();
         _tabGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,913,708);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("cultureactive.CultureActiveFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.cultureactive.Bg");
         _tabGroup = new SelectedButtonGroup();
         _personBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.PersonBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.ConsortiaBtn");
         _serverBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.ServerBtn");
         _cultureView = ComponentFactory.Instance.creatCustomObject("cultureactive.CultureActiveView");
         _tabGroup.addSelectItem(_personBtn);
         _tabGroup.addSelectItem(_consortiaBtn);
         _tabGroup.addSelectItem(_serverBtn);
         addToContent(_personBtn);
         addToContent(_consortiaBtn);
         addToContent(_serverBtn);
         addToContent(_bg);
         addToContent(_cultureView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabGroup.addEventListener("change",__panelChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__panelChangeHandler);
         }
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _cultureView.index = _tabGroup.selectIndex + 1;
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
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_personBtn);
         _personBtn = null;
         ObjectUtils.disposeObject(_consortiaBtn);
         _consortiaBtn = null;
         ObjectUtils.disposeObject(_serverBtn);
         _serverBtn = null;
         ObjectUtils.disposeObject(_cultureView);
         _cultureView = null;
         super.dispose();
      }
   }
}

