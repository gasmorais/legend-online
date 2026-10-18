package dragonBones.display
{
   import dragonBones.objects.BoneTransform;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public interface IDisplayBridge
   {
      
      function get display() : Object;
      
      function set display(param1:Object) : void;
      
      function update(param1:Matrix, param2:BoneTransform, param3:ColorTransform, param4:Boolean) : void;
      
      function addDisplay(param1:Object, param2:int = -1) : void;
      
      function removeDisplay() : void;
   }
}

