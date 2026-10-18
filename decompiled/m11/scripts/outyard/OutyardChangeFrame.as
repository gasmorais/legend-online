package outyard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   
   public class OutyardChangeFrame extends Frame implements IManualSize
   {
      
      private var _listView:OutyardChangeView;
      
      public function OutyardChangeFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      private function initView() : void
      {
         _listView = ComponentFactory.Instance.creatCustomObject("outyard.OutyardChangeView");
         _listView.x = 0;
         _listView.y = 0;
         this.titleText = LanguageMgr.GetTranslation("gvg.view.ready.EnterWarFrame.title");
         addToContent(_listView);
      }
      
      protected function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("OUTYARD_CHANGE_SENIOR",__finishHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("OUTYARD_CHANGE_SENIOR",__finishHandler);
      }
      
      private function __finishHandler(param1:NotificationEvent) : void
      {
         dispose();
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
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_listView)
         {
            _listView.dispose();
         }
         _listView = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         initView();
         addEvent();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function hide() : void
      {
      }
   }
}

