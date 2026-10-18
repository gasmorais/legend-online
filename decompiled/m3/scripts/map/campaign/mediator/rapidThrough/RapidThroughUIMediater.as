package map.campaign.mediator.rapidThrough
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.rapidThrough.RapidThroughView;
   import yishi.interfaces.IMediator;
   
   public class RapidThroughUIMediater implements IMediator
   {
      
      private var _view:RapidThroughView;
      
      public function RapidThroughUIMediater()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _view = new RapidThroughView();
         _view.y = 200;
         _view.x = StageReferance.stageWidth - 320;
         addEvent();
         LayerManager.Instance.addToLayer(_view,4);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resize);
      }
      
      protected function resize(param1:Event) : void
      {
         if(!_view)
         {
            return;
         }
         _view.x = StageReferance.stageWidth - 320;
         _view.resize();
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resize);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         removeEvent();
         _view = null;
      }
   }
}

