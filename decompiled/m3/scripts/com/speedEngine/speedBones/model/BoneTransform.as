package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.BaseClass;
   
   public class BoneTransform extends BaseClass
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
         setValues();
      }
      
      public function get rotation() : Number
      {
         return skewX;
      }
      
      public function set rotation(param1:Number) : void
      {
         skewX = skewY = param1;
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
      
      public function copy(param1:Object) : void
      {
         x = param1.x;
         y = param1.y;
         scaleX = param1.scaleX;
         scaleY = param1.scaleY;
         skewX = param1.skewX;
         skewY = param1.skewY;
         pivotX = param1.pivotX;
         pivotY = param1.pivotY;
         z = param1.z;
      }
      
      public function toString() : String
      {
         return "x:" + x + " y:" + y + " skewX:" + skewX + " skewY:" + skewY + " scaleX:" + scaleX + " scaleY:" + scaleY;
      }
      
      public function clone() : BoneTransform
      {
         var _loc1_:BoneTransform = new BoneTransform();
         _loc1_.copy(this);
         return _loc1_;
      }
   }
}

