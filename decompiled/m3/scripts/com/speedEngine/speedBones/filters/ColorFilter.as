package com.speedEngine.speedBones.filters
{
   import flash.geom.ColorTransform;
   
   public class ColorFilter extends Filter
   {
      
      public static const BYTE_LENGTH:uint = 80;
      
      private static const LUMA_R:Number = 0.299;
      
      private static const LUMA_G:Number = 0.587;
      
      private static const LUMA_B:Number = 0.114;
      
      private var _colorFilterMatrix:Vector.<Number>;
      
      public function ColorFilter()
      {
         super();
         _colorFilterMatrix = new Vector.<Number>();
         _colorFilterMatrix.push(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0);
      }
      
      public function clear() : void
      {
         _colorFilterMatrix.length = 0;
         _colorFilterMatrix.push(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0);
         _filterBytes.length = 0;
      }
      
      public function invert() : void
      {
         _colorFilterMatrix[0] = -1;
         _colorFilterMatrix[1] = 0;
         _colorFilterMatrix[2] = 0;
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = 0;
         _colorFilterMatrix[5] = -1;
         _colorFilterMatrix[6] = 0;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = 0;
         _colorFilterMatrix[9] = 0;
         _colorFilterMatrix[10] = -1;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = 1;
         _colorFilterMatrix[16] = 0;
         _colorFilterMatrix[17] = 0;
         _colorFilterMatrix[18] = 0;
         _colorFilterMatrix[19] = 0;
         genarateFilterBytes();
      }
      
      public function adjustSaturation(param1:Number) : void
      {
         param1 += 1;
         var _loc3_:Number = 1 - param1;
         var _loc4_:Number = _loc3_ * 0.299;
         var _loc2_:Number = _loc3_ * 0.587;
         var _loc5_:Number = _loc3_ * 0.114;
         _colorFilterMatrix[0] = _loc4_ + param1;
         _colorFilterMatrix[1] = _loc2_;
         _colorFilterMatrix[2] = _loc5_;
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = _loc4_;
         _colorFilterMatrix[5] = _loc2_ + param1;
         _colorFilterMatrix[6] = _loc5_;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = _loc4_;
         _colorFilterMatrix[9] = _loc2_;
         _colorFilterMatrix[10] = _loc5_ + param1;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = 1;
         _colorFilterMatrix[16] = 0;
         _colorFilterMatrix[17] = 0;
         _colorFilterMatrix[18] = 0;
         _colorFilterMatrix[19] = 0;
         genarateFilterBytes();
      }
      
      public function adjustContrast(param1:Number) : void
      {
         var _loc2_:Number = param1 + 1;
         var _loc3_:Number = 128 * (1 - _loc2_) / 256;
         _colorFilterMatrix[0] = _loc2_;
         _colorFilterMatrix[1] = 0;
         _colorFilterMatrix[2] = 0;
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = 0;
         _colorFilterMatrix[5] = _loc2_;
         _colorFilterMatrix[6] = 0;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = 0;
         _colorFilterMatrix[9] = 0;
         _colorFilterMatrix[10] = _loc2_;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = 1;
         _colorFilterMatrix[16] = _loc3_;
         _colorFilterMatrix[17] = _loc3_;
         _colorFilterMatrix[18] = _loc3_;
         _colorFilterMatrix[19] = 0;
         genarateFilterBytes();
      }
      
      public function adjustBrightness(param1:Number) : void
      {
         _colorFilterMatrix[0] = 1;
         _colorFilterMatrix[1] = 0;
         _colorFilterMatrix[2] = 0;
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = 0;
         _colorFilterMatrix[5] = 1;
         _colorFilterMatrix[6] = 0;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = 0;
         _colorFilterMatrix[9] = 0;
         _colorFilterMatrix[10] = 1;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = 1;
         _colorFilterMatrix[16] = param1;
         _colorFilterMatrix[17] = param1;
         _colorFilterMatrix[18] = param1;
         _colorFilterMatrix[19] = 0;
         genarateFilterBytes();
      }
      
      public function adjustRGBA(param1:ColorTransform) : void
      {
         _colorFilterMatrix[0] = param1.redMultiplier;
         _colorFilterMatrix[1] = 0;
         _colorFilterMatrix[2] = 0;
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = 0;
         _colorFilterMatrix[5] = param1.greenMultiplier;
         _colorFilterMatrix[6] = 0;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = 0;
         _colorFilterMatrix[9] = 0;
         _colorFilterMatrix[10] = param1.blueMultiplier;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = param1.alphaMultiplier;
         _colorFilterMatrix[16] = param1.redOffset;
         _colorFilterMatrix[17] = param1.greenOffset;
         _colorFilterMatrix[18] = param1.blueOffset;
         _colorFilterMatrix[19] = param1.alphaOffset;
         genarateFilterBytes();
      }
      
      public function adjustHue(param1:Number) : void
      {
         param1 *= 3.141592653589793;
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         _colorFilterMatrix[0] = 0.299 + _loc2_ * (1 - 0.299) + _loc3_ * -0.299;
         _colorFilterMatrix[1] = 0.587 + _loc2_ * -0.587 + _loc3_ * -0.587;
         _colorFilterMatrix[2] = 0.114 + _loc2_ * -0.114 + _loc3_ * (1 - 0.114);
         _colorFilterMatrix[3] = 0;
         _colorFilterMatrix[4] = 0.299 + _loc2_ * -0.299 + _loc3_ * 0.143;
         _colorFilterMatrix[5] = 0.587 + _loc2_ * (1 - 0.587) + _loc3_ * 0.14;
         _colorFilterMatrix[6] = 0.114 + _loc2_ * -0.114 + _loc3_ * -0.283;
         _colorFilterMatrix[7] = 0;
         _colorFilterMatrix[8] = 0.299 + _loc2_ * -0.299 + _loc3_ * -0.7010000000000001;
         _colorFilterMatrix[9] = 0.587 + _loc2_ * -0.587 + _loc3_ * 0.587;
         _colorFilterMatrix[10] = 0.114 + _loc2_ * (1 - 0.114) + _loc3_ * 0.114;
         _colorFilterMatrix[11] = 0;
         _colorFilterMatrix[12] = 0;
         _colorFilterMatrix[13] = 0;
         _colorFilterMatrix[14] = 0;
         _colorFilterMatrix[15] = 1;
         _colorFilterMatrix[16] = 0;
         _colorFilterMatrix[17] = 0;
         _colorFilterMatrix[18] = 0;
         _colorFilterMatrix[19] = 0;
         genarateFilterBytes();
      }
      
      private function genarateFilterBytes() : void
      {
         _filterBytes.length = 0;
         _filterBytes.writeFloat(_colorFilterMatrix[0]);
         _filterBytes.writeFloat(_colorFilterMatrix[1]);
         _filterBytes.writeFloat(_colorFilterMatrix[2]);
         _filterBytes.writeFloat(_colorFilterMatrix[3]);
         _filterBytes.writeFloat(_colorFilterMatrix[4]);
         _filterBytes.writeFloat(_colorFilterMatrix[5]);
         _filterBytes.writeFloat(_colorFilterMatrix[6]);
         _filterBytes.writeFloat(_colorFilterMatrix[7]);
         _filterBytes.writeFloat(_colorFilterMatrix[8]);
         _filterBytes.writeFloat(_colorFilterMatrix[9]);
         _filterBytes.writeFloat(_colorFilterMatrix[10]);
         _filterBytes.writeFloat(_colorFilterMatrix[11]);
         _filterBytes.writeFloat(_colorFilterMatrix[12]);
         _filterBytes.writeFloat(_colorFilterMatrix[13]);
         _filterBytes.writeFloat(_colorFilterMatrix[14]);
         _filterBytes.writeFloat(_colorFilterMatrix[15]);
         _filterBytes.writeFloat(_colorFilterMatrix[16]);
         _filterBytes.writeFloat(_colorFilterMatrix[17]);
         _filterBytes.writeFloat(_colorFilterMatrix[18]);
         _filterBytes.writeFloat(_colorFilterMatrix[19]);
      }
      
      override public function dispose() : void
      {
         _colorFilterMatrix.length = 0;
         super.dispose();
      }
   }
}

