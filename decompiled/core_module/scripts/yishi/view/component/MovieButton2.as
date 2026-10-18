package yishi.view.component
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MovieButton2 extends BaseButton
   {
      
      private var _mc:MovieClip;
      
      public function MovieButton2()
      {
         super();
         addEvent();
         this.buttonMode = true;
      }
      
      public function set movie(param1:String) : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject(param1);
         addChild(_mc);
         _mc.stop();
      }
      
      override protected function addEvent() : void
      {
         addEventListener("mouseDown",__downHandler);
         super.addEvent();
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("mouseDown",__downHandler);
         super.removeEvent();
      }
      
      private function __downHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseUp",__upHandler);
      }
      
      private function __upHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__upHandler);
         _mc.play();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mc);
         _mc = null;
         super.dispose();
      }
   }
}

