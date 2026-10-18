package svs.view.warteam
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.SvsModel;
   import map.campaign.event.SvsEvent;
   import mvc.controler.SvsController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SvsEnterWarAddFrame extends Frame implements IManualSize
   {
      
      private var _left:SvsEnterWarLeftView;
      
      private var _arrow:Bitmap;
      
      private var _right:SvsEnterWarRightView;
      
      private var _helpBtn:BaseButton;
      
      private var _searchBack:ScaleBitmapImage;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchTip:FilterFrameText;
      
      private var _searchBtn:SimpleBitmapButton;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      public function SvsEnterWarAddFrame()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
         _controller.sendSvsUserOnlineReq();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _left = ComponentFactory.Instance.creatCustomObject("svs.SvsEnterWarLeftView");
         _arrow = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _right = ComponentFactory.Instance.creatCustomObject("svs.SvsEnterWarRightView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.HelpBtn");
         _searchBack = ComponentFactory.Instance.creatComponentByStylename("gvg.WarmanSearchBack");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.WarmanSearchTxt");
         _searchTip = ComponentFactory.Instance.creatComponentByStylename("gvg.WarmanSearchTxt");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("gvg.WarmanSearchBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("svs.view.warteam.SvsEnterWarAddFrame.helpBtn");
         _helpBtn.x = 825;
         _arrow.x = 335;
         _arrow.y = 125;
         this.titleText = LanguageMgr.GetTranslation("gvg.view.ready.EnterWarFrame.title");
         _searchTip.text = LanguageMgr.GetTranslation("gvg.WarmanTip");
         _searchTip.mouseEnabled = false;
         addToContent(_left);
         addToContent(_right);
         addToContent(_arrow);
         addToContent(_helpBtn);
         addToContent(_searchBack);
         addToContent(_searchTip);
         addToContent(_searchTxt);
         addToContent(_searchBtn);
         _searchTip.setFrame(1);
         _searchTxt.setFrame(2);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
         _searchTxt.addEventListener("change",__searchChangeHandler);
         _searchTxt.addEventListener("focusIn",__focusInHandler);
         _searchTxt.addEventListener("focusOut",__focusOutHandler);
         _model.addEventListener("SVS_USER_LIST_CHANGE",__userListChangeHandler);
         _model.addEventListener("SVS_USER_ONLINE_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
         _searchTxt.removeEventListener("change",__searchChangeHandler);
         _searchTxt.removeEventListener("focusIn",__focusInHandler);
         _searchTxt.removeEventListener("focusOut",__focusOutHandler);
         _model.removeEventListener("SVS_USER_LIST_CHANGE",__userListChangeHandler);
         _model.removeEventListener("SVS_USER_ONLINE_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      protected function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("svs.HelperFrame");
         _loc2_.show();
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         _searchTip.visible = false;
      }
      
      private function __focusOutHandler(param1:FocusEvent) : void
      {
         if(_searchTxt.text == "")
         {
            _searchTip.visible = true;
         }
      }
      
      private function __searchChangeHandler(param1:Event) : void
      {
         _left.filterName = _searchTxt.text;
         _left.setListView();
      }
      
      private function __userListChangeHandler(param1:SvsEvent) : void
      {
         if(_right)
         {
            _right.setListView();
         }
         if(_left)
         {
            _left.setListView();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

