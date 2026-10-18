package auction.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   
   public class AuctionAlert
   {
      
      public function AuctionAlert()
      {
         super();
      }
      
      public static function alert(param1:String, param2:String, param3:Function = null) : void
      {
         var title:String = param1;
         var msg:String = param2;
         var closeFun:Function = param3;
         var response:* = function(param1:FrameEvent):void
         {
            if(closeFun != null)
            {
               if(closeFun.length > 0)
               {
                  closeFun(param1);
               }
               else
               {
                  closeFun();
               }
            }
            alert.removeEventListener("response",response);
            alert.dispose();
         };
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(title,msg);
         alert.addEventListener("response",response);
      }
   }
}

