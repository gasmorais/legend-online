package battle.animation
{
   import flash.display.DisplayObject;
   
   public interface IAnimation
   {
      
      function get level() : int;
      
      function prepare(param1:ISetAnimation) : void;
      
      function replace(param1:IAnimation) : Boolean;
      
      function cannel() : void;
      
      function update(param1:DisplayObject) : void;
      
      function isFinished() : Boolean;
   }
}

