package war2023.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import war2023.ui.SecretwarStartUI;
   import yishi.view.community.TimeDownView;
   
   public class SecretwarStartCDView extends SecretwarStartUI
   {
      
      private var _cd:TimeDownView;
      
      public function SecretwarStartCDView()
      {
         super();
         _cd = ComponentFactory.Instance.creatComponentByStylename("ui.secretwarStartTimeDownCd");
         addChild(_cd);
         initEvent();
         resizeHandler();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      public function timecount(param1:int) : void
      {
         _cd.timeCount = param1;
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
         this.y = (StageReferance.stage.stageHeight - this.height) * 0.5;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cd);
         _cd = null;
         super.dispose();
      }
   }
}

