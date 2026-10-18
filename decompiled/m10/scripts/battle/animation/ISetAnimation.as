package battle.animation
{
   import flash.display.DisplayObject;
   
   public interface ISetAnimation
   {
      
      function addAnimation(param1:IAnimation) : void;
      
      function getAnimateTarget() : DisplayObject;
      
      function update() : void;
   }
}

