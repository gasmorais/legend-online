package thessbox.view
{
   import com.pickgliss.ui.LayerManager;
   import flash.events.MouseEvent;
   import thessbox.ui.ThessBoxRightUI;
   import yishi.manager.FrameControllerManager;
   
   public class ThessBoxRightView extends ThessBoxRightUI
   {
      
      public function ThessBoxRightView()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _rightBtn1.addEventListener("click",bagHandler);
         _rightBtn2.addEventListener("click",skDesHandler);
      }
      
      private function removeEvent() : void
      {
         _rightBtn1.removeEventListener("click",bagHandler);
         _rightBtn2.removeEventListener("click",skDesHandler);
      }
      
      private function bagHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxSkillBagFrame");
      }
      
      private function skDesHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxSkillDesFrame");
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

