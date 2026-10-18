package dragonBones.utils
{
   import dragonBones.objects.BoneTransform;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class TransformUtils
   {
      
      private static const DOUBLE_PI:Number = Math.PI * 2;
      
      private static var _helpMatrix:Matrix = new Matrix();
      
      private static var _helpPoint:Point = new Point();
      
      public function TransformUtils()
      {
         super();
      }
      
      public static function transformPointWithParent(param1:BoneTransform, param2:BoneTransform) : void
      {
         nodeToMatrix(param2,_helpMatrix);
         _helpPoint.x = param1.x;
         _helpPoint.y = param1.y;
         _helpMatrix.invert();
         _helpPoint = _helpMatrix.transformPoint(_helpPoint);
         param1.x = _helpPoint.x;
         param1.y = _helpPoint.y;
         param1.skewX -= param2.skewX;
         param1.skewY -= param2.skewY;
      }
      
      public static function nodeToMatrix(param1:BoneTransform, param2:Matrix) : void
      {
         param2.a = param1.scaleX * Math.cos(param1.skewY);
         param2.b = param1.scaleX * Math.sin(param1.skewY);
         param2.c = -param1.scaleY * Math.sin(param1.skewX);
         param2.d = param1.scaleY * Math.cos(param1.skewX);
         param2.tx = param1.x;
         param2.ty = param1.y;
      }
      
      public static function setOffSetColorTransform(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform) : void
      {
         param3.alphaOffset = param2.alphaOffset - param1.alphaOffset;
         param3.redOffset = param2.redOffset - param1.redOffset;
         param3.greenOffset = param2.greenOffset - param1.greenOffset;
         param3.blueOffset = param2.blueOffset - param1.blueOffset;
         param3.alphaMultiplier = param2.alphaMultiplier - param1.alphaMultiplier;
         param3.redMultiplier = param2.redMultiplier - param1.redMultiplier;
         param3.greenMultiplier = param2.greenMultiplier - param1.greenMultiplier;
         param3.blueMultiplier = param2.blueMultiplier - param1.blueMultiplier;
      }
      
      public static function setTweenColorTransform(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform, param4:Number) : void
      {
         param3.alphaOffset = param1.alphaOffset + param4 * param2.alphaOffset;
         param3.redOffset = param1.redOffset + param4 * param2.redOffset;
         param3.greenOffset = param1.greenOffset + param4 * param2.greenOffset;
         param3.blueOffset = param1.blueOffset + param4 * param2.blueOffset;
         param3.alphaMultiplier = param1.alphaMultiplier + param4 * param2.alphaMultiplier;
         param3.redMultiplier = param1.redMultiplier + param4 * param2.redMultiplier;
         param3.greenMultiplier = param1.greenMultiplier + param4 * param2.greenMultiplier;
         param3.blueMultiplier = param1.blueMultiplier + param4 * param2.blueMultiplier;
      }
      
      public static function setOffSetNode(param1:BoneTransform, param2:BoneTransform, param3:BoneTransform, param4:int = 0) : void
      {
         param3.x = param2.x - param1.x;
         param3.y = param2.y - param1.y;
         param3.skewX = param2.skewX - param1.skewX;
         param3.skewY = param2.skewY - param1.skewY;
         param3.scaleX = param2.scaleX - param1.scaleX;
         param3.scaleY = param2.scaleY - param1.scaleY;
         param3.pivotX = param2.pivotX - param1.pivotX;
         param3.pivotY = param2.pivotY - param1.pivotY;
         param3.skewX %= DOUBLE_PI;
         if(param3.skewX > Math.PI)
         {
            param3.skewX -= DOUBLE_PI;
         }
         if(param3.skewX < -Math.PI)
         {
            param3.skewX += DOUBLE_PI;
         }
         param3.skewY %= DOUBLE_PI;
         if(param3.skewY > Math.PI)
         {
            param3.skewY -= DOUBLE_PI;
         }
         if(param3.skewY < -Math.PI)
         {
            param3.skewY += DOUBLE_PI;
         }
         if(param4)
         {
            param3.skewX += param4 * DOUBLE_PI;
            param3.skewY += param4 * DOUBLE_PI;
         }
      }
      
      public static function setTweenNode(param1:BoneTransform, param2:BoneTransform, param3:BoneTransform, param4:Number) : void
      {
         param3.setValues(param1.x + param4 * param2.x,param1.y + param4 * param2.y,param1.skewX + param4 * param2.skewX,param1.skewY + param4 * param2.skewY,param1.scaleX + param4 * param2.scaleX,param1.scaleY + param4 * param2.scaleY,param1.pivotX + param4 * param2.pivotX,param1.pivotY + param4 * param2.pivotY,param3.z);
      }
   }
}

