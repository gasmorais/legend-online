package yishi.view.component
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DelayRendSprite extends Sprite
   {
      
      protected static var invalidates:Array = [];
      
      private var _isCaneled:Boolean = false;
      
      public function DelayRendSprite()
      {
         super();
         addEventListener("addedToStage",__addToStage);
      }
      
      protected function upDateNextRend() : void
      {
         _isCaneled = false;
         if(stage)
         {
            stage.invalidate();
            addEventListener("render",__onScreenRend);
         }
      }
      
      protected function cancelUpDataNextRend() : void
      {
         removeEventListener("render",__onScreenRend);
      }
      
      protected function cancelCurrentRend() : void
      {
         _isCaneled = true;
      }
      
      protected function beforDraw() : void
      {
      }
      
      protected function onDraw() : void
      {
      }
      
      protected function afterDraw() : void
      {
      }
      
      private function __addToStage(param1:Event) : void
      {
         upDateNextRend();
      }
      
      final public function draw() : void
      {
         beforDraw();
         onDraw();
         afterDraw();
         _isCaneled = false;
         removeEventListener("render",__onScreenRend);
      }
      
      private function __onScreenRend(param1:Event) : void
      {
         beforDraw();
         if(_isCaneled == false)
         {
            onDraw();
            afterDraw();
         }
         _isCaneled = false;
         removeEventListener("render",__onScreenRend);
      }
   }
}

