package outyard.scene
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import mvc.module.outyard.LandPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class LandNodeView extends Component
   {
      
      private var _landNode:ScaleFrameImage;
      
      private var _info:LandPoint;
      
      public function LandNodeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _landNode = ComponentFactory.Instance.creatComponentByStylename("outyard.landNodeImage");
         addChild(_landNode);
         this.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         _landNode.addEventListener("click",__clickHandler);
         this.addEventListener("rollOver",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
         NotificationManager.instance.addEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
      }
      
      private function removeEvent() : void
      {
         _landNode.removeEventListener("click",__clickHandler);
         this.removeEventListener("rollOver",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
         NotificationManager.instance.removeEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_LAND_NODE",_info));
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OVER_LAND_NODE",_info));
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OVER_LAND_NODE",null));
      }
      
      private function __updateNodeHandler(param1:NotificationEvent) : void
      {
         info = _info;
      }
      
      public function set info(param1:LandPoint) : void
      {
         var _loc2_:int = 0;
         _info = param1;
         if(param1.nodeType == 1)
         {
            _loc2_ = int(param1.forceIndex);
         }
         else if(param1.nodeType == 2)
         {
            _loc2_ = param1.forceIndex + 4;
            if(_info.nodeState != 0)
            {
               if(_info.nodeState != 2)
               {
                  if(_info.nodeState == 3)
                  {
                  }
               }
            }
         }
         else if(param1.nodeType == 4)
         {
            _loc2_ = 9;
         }
         else if(param1.nodeType == 3)
         {
            _loc2_ = 10;
         }
         else if(param1.nodeType == 5)
         {
            _loc2_ = 11;
         }
         else if(param1.nodeType == 6)
         {
            _loc2_ = 12;
         }
         else if(param1.nodeType == 7)
         {
            _loc2_ = 13;
         }
         else if(param1.nodeType == 8)
         {
            _loc2_ = 14;
         }
         _landNode.setFrame(_loc2_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_landNode);
         _landNode = null;
         _info = null;
         super.dispose();
      }
   }
}

