package dragonBones.animation
{
   public interface IAnimatable
   {
      
      function advanceTime(param1:Number, param2:String = "", param3:int = 0) : void;
      
      function isUpdateFrame(param1:Number) : Number;
   }
}

