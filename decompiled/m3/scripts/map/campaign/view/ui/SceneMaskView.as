package map.campaign.view.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SceneMaskView extends Sprite implements Disposeable
   {
      
      public function SceneMaskView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         __stageResizeHandler(null);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         this.graphics.clear();
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         this.graphics.endFill();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

