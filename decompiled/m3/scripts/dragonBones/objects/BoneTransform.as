package dragonBones.objects
{
   public class BoneTransform
   {
      
      public var x:Number;
      
      public var y:Number;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      public var skewX:Number;
      
      public var skewY:Number;
      
      public var pivotX:Number;
      
      public var pivotY:Number;
      
      public var z:Number;
      
      public function BoneTransform()
      {
         super();
         this.setValues();
      }
      
      public function get rotation() : Number
      {
         return this.skewX;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.skewX = this.skewY = param1;
      }
      
      public function setValues(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:int = 0) : void
      {
         this.x = param1 || 0;
         this.y = param2 || 0;
         this.skewX = param3 || 0;
         this.skewY = param4 || 0;
         this.scaleX = param5 || 0;
         this.scaleY = param6 || 0;
         this.pivotX = param7 || 0;
         this.pivotY = param8 || 0;
         this.z = param9;
      }
      
      public function copy(param1:BoneTransform) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.scaleX = param1.scaleX;
         this.scaleY = param1.scaleY;
         this.skewX = param1.skewX;
         this.skewY = param1.skewY;
         this.pivotX = param1.pivotX;
         this.pivotY = param1.pivotY;
         this.z = param1.z;
      }
      
      public function toString() : String
      {
         return "x:" + this.x + " y:" + this.y + " skewX:" + this.skewX + " skewY:" + this.skewY + " scaleX:" + this.scaleX + " scaleY:" + this.scaleY;
      }
   }
}

