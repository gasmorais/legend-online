package dragonBones.textures
{
   import flash.geom.Rectangle;
   
   public class SubTextureData extends Rectangle
   {
      
      public var pivotX:Number;
      
      public var pivotY:Number;
      
      public function SubTextureData(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         this.pivotX = 0;
         this.pivotY = 0;
      }
   }
}

