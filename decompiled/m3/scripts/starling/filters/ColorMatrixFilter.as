package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Program3D;
   import flash.geom.ColorTransform;
   import starling.textures.Texture;
   
   public class ColorMatrixFilter extends FragmentFilter
   {
      
      private static const MIN_COLOR:Vector.<Number> = new <Number>[0,0,0,0.0001];
      
      private static const IDENTITY:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      private static const LUMA_R:Number = 0.299;
      
      private static const LUMA_G:Number = 0.587;
      
      private static const LUMA_B:Number = 0.114;
      
      private static var sTmpMatrix1:Vector.<Number> = new Vector.<Number>(20,true);
      
      private static var sTmpMatrix2:Vector.<Number> = new Vector.<Number>(0);
      
      private var mShaderProgram:Program3D;
      
      private var mUserMatrix:Vector.<Number>;
      
      private var mShaderMatrix:Vector.<Number>;
      
      public function ColorMatrixFilter(param1:Vector.<Number> = null)
      {
         super();
         this.mUserMatrix = new Vector.<Number>(0);
         this.mShaderMatrix = new Vector.<Number>(0);
         this.matrix = param1;
      }
      
      override public function dispose() : void
      {
         if(this.mShaderProgram)
         {
            this.mShaderProgram.dispose();
         }
         super.dispose();
      }
      
      override protected function createPrograms() : void
      {
         var _loc1_:String = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone>  \n" + "max ft0, ft0, fc5              \n" + "div ft0.xyz, ft0.xyz, ft0.www  \n" + "m44 ft0, ft0, fc0              \n" + "add ft0, ft0, fc4              \n" + "mul ft0.xyz, ft0.xyz, ft0.www  \n" + "mov oc, ft0                    \n";
         this.mShaderProgram = assembleAgal(_loc1_);
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         param2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.mShaderMatrix);
         param2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,5,MIN_COLOR);
         param2.setProgram(this.mShaderProgram);
      }
      
      public function invert() : void
      {
         this.concatValues(-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0);
      }
      
      public function adjustSaturation(param1:Number) : void
      {
         param1 += 1;
         var _loc2_:Number = 1 - param1;
         var _loc3_:Number = _loc2_ * LUMA_R;
         var _loc4_:Number = _loc2_ * LUMA_G;
         var _loc5_:Number = _loc2_ * LUMA_B;
         this.concatValues(_loc3_ + param1,_loc4_,_loc5_,0,0,_loc3_,_loc4_ + param1,_loc5_,0,0,_loc3_,_loc4_,_loc5_ + param1,0,0,0,0,0,1,0);
      }
      
      public function adjustContrast(param1:Number) : void
      {
         var _loc2_:Number = param1 + 1;
         var _loc3_:Number = 128 * (1 - _loc2_);
         this.concatValues(_loc2_,0,0,0,_loc3_,0,_loc2_,0,0,_loc3_,0,0,_loc2_,0,_loc3_,0,0,0,1,0);
      }
      
      public function adjustBrightness(param1:Number) : void
      {
         param1 *= 255;
         this.concatValues(1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0);
      }
      
      public function adjustRGBA(param1:ColorTransform) : void
      {
         this.concatValues(param1.redMultiplier,0,0,0,param1.redOffset,0,param1.greenMultiplier,0,0,param1.greenOffset,0,0,param1.blueMultiplier,0,param1.blueOffset,0,0,0,param1.alphaMultiplier,param1.alphaOffset);
      }
      
      public function adjustHue(param1:Number) : void
      {
         param1 *= Math.PI;
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         this.concatValues(LUMA_R + _loc2_ * (1 - LUMA_R) + _loc3_ * -LUMA_R,LUMA_G + _loc2_ * -LUMA_G + _loc3_ * -LUMA_G,LUMA_B + _loc2_ * -LUMA_B + _loc3_ * (1 - LUMA_B),0,0,LUMA_R + _loc2_ * -LUMA_R + _loc3_ * 0.143,LUMA_G + _loc2_ * (1 - LUMA_G) + _loc3_ * 0.14,LUMA_B + _loc2_ * -LUMA_B + _loc3_ * -0.283,0,0,LUMA_R + _loc2_ * -LUMA_R + _loc3_ * -(1 - LUMA_R),LUMA_G + _loc2_ * -LUMA_G + _loc3_ * LUMA_G,LUMA_B + _loc2_ * (1 - LUMA_B) + _loc3_ * LUMA_B,0,0,0,0,0,1,0);
      }
      
      public function reset() : void
      {
         this.matrix = null;
      }
      
      public function concat(param1:Vector.<Number>) : void
      {
         var _loc4_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               sTmpMatrix1[int(_loc2_ + _loc4_)] = param1[_loc2_] * this.mUserMatrix[_loc4_] + param1[int(_loc2_ + 1)] * this.mUserMatrix[int(_loc4_ + 5)] + param1[int(_loc2_ + 2)] * this.mUserMatrix[int(_loc4_ + 10)] + param1[int(_loc2_ + 3)] * this.mUserMatrix[int(_loc4_ + 15)] + (_loc4_ == 4 ? param1[int(_loc2_ + 4)] : 0);
               _loc4_++;
            }
            _loc2_ += 5;
            _loc3_++;
         }
         this.copyMatrix(sTmpMatrix1,this.mUserMatrix);
         this.updateShaderMatrix();
      }
      
      private function concatValues(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Number, param17:Number, param18:Number, param19:Number, param20:Number) : void
      {
         sTmpMatrix2.length = 0;
         sTmpMatrix2.push(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17,param18,param19,param20);
         this.concat(sTmpMatrix2);
      }
      
      private function copyMatrix(param1:Vector.<Number>, param2:Vector.<Number>) : void
      {
         var _loc3_:* = 0;
         while(_loc3_ < 20)
         {
            param2[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function updateShaderMatrix() : void
      {
         this.mShaderMatrix.length = 0;
         this.mShaderMatrix.push(this.mUserMatrix[0],this.mUserMatrix[1],this.mUserMatrix[2],this.mUserMatrix[3],this.mUserMatrix[5],this.mUserMatrix[6],this.mUserMatrix[7],this.mUserMatrix[8],this.mUserMatrix[10],this.mUserMatrix[11],this.mUserMatrix[12],this.mUserMatrix[13],this.mUserMatrix[15],this.mUserMatrix[16],this.mUserMatrix[17],this.mUserMatrix[18],this.mUserMatrix[4] / 255,this.mUserMatrix[9] / 255,this.mUserMatrix[14] / 255,this.mUserMatrix[19] / 255);
      }
      
      public function get matrix() : Vector.<Number>
      {
         return this.mUserMatrix;
      }
      
      public function set matrix(param1:Vector.<Number>) : void
      {
         if(Boolean(param1) && param1.length != 20)
         {
            throw new ArgumentError("Invalid matrix length: must be 20");
         }
         if(param1 == null)
         {
            this.mUserMatrix.length = 0;
            this.mUserMatrix.push.apply(this.mUserMatrix,IDENTITY);
         }
         else
         {
            this.copyMatrix(param1,this.mUserMatrix);
         }
         this.updateShaderMatrix();
      }
   }
}

