package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.ui.ChesspvpResultUI;
   import flash.events.MouseEvent;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   
   public class ChessPvpResultFrame extends Frame
   {
      
      private var _view:ChesspvpResultUI;
      
      public function ChessPvpResultFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new ChesspvpResultUI();
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view.btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view.btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         dispose();
         NotificationManager.instance.sendNotification("chesspvp.gameover");
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
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         _closeButton.visible = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

