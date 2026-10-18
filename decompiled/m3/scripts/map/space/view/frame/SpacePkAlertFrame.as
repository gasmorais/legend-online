package map.space.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import map.space.mediator.mapview.SpacePKMediator;
   
   public class SpacePkAlertFrame extends SimpleAlert
   {
      
      public var msg:HangupAttackMsg;
      
      public var mediator:SpacePKMediator;
      
      public function SpacePkAlertFrame()
      {
         super();
         this.addEventListener("response",__onResponseHandler);
      }
      
      private function __onResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               mediator.refuseThisRequest(msg);
               dispose();
               break;
            case 2:
            case 3:
               mediator.receiveThisRequest(msg);
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         this.removeEventListener("response",__onResponseHandler);
         msg = null;
         mediator = null;
         super.dispose();
      }
   }
}

