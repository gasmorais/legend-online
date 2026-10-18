package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Program3D;
   import starling.textures.Texture;
   import starling.utils.Color;
   
   public class BlurFilter extends FragmentFilter
   {
      
      private const MAX_SIGMA:Number = 2;
      
      private var mNormalProgram:Program3D;
      
      private var mTintedProgram:Program3D;
      
      private var mOffsets:Vector.<Number> = new <Number>[0,0,0,0];
      
      private var mWeights:Vector.<Number> = new <Number>[0,0,0,0];
      
      private var mColor:Vector.<Number> = new <Number>[1,1,1,1];
      
      private var mBlurX:Number;
      
      private var mBlurY:Number;
      
      private var mUniformColor:Boolean;
      
      private var sTmpWeights:Vector.<Number> = new Vector.<Number>(5,true);
      
      public function BlurFilter(param1:Number = 1, param2:Number = 1, param3:Number = 1)
      {
         super(1,param3);
         this.mBlurX = param1;
         this.mBlurY = param2;
         this.updateMarginsAndPasses();
      }
      
      public static function createDropShadow(param1:Number = 4, param2:Number = 0.785, param3:uint = 0, param4:Number = 0.5, param5:Number = 1, param6:Number = 0.5) : BlurFilter
      {
         var _loc7_:BlurFilter = new BlurFilter(param5,param5,param6);
         _loc7_.offsetX = Math.cos(param2) * param1;
         _loc7_.offsetY = Math.sin(param2) * param1;
         _loc7_.mode = FragmentFilterMode.BELOW;
         _loc7_.setUniformColor(true,param3,param4);
         return _loc7_;
      }
      
      public static function createGlow(param1:uint = 16776960, param2:Number = 1, param3:Number = 1, param4:Number = 0.5) : BlurFilter
      {
         var _loc5_:BlurFilter = new BlurFilter(param3,param3,param4);
         _loc5_.mode = FragmentFilterMode.BELOW;
         _loc5_.setUniformColor(true,param1,param2);
         return _loc5_;
      }
      
      override public function dispose() : void
      {
         if(this.mNormalProgram)
         {
            this.mNormalProgram.dispose();
         }
         if(this.mTintedProgram)
         {
            this.mTintedProgram.dispose();
         }
         super.dispose();
      }
      
      override protected function createPrograms() : void
      {
         this.mNormalProgram = this.createProgram(false);
         this.mTintedProgram = this.createProgram(true);
      }
      
      private function createProgram(param1:Boolean) : Program3D
      {
         var _loc2_:String = "m44 op, va0, vc0       \n" + "mov v0, va1            \n" + "sub v1, va1, vc4.zwxx  \n" + "sub v2, va1, vc4.xyxx  \n" + "add v3, va1, vc4.xyxx  \n" + "add v4, va1, vc4.zwxx  \n";
         var _loc3_:String = "tex ft0,  v0, fs0 <2d, clamp, linear, mipnone> \n" + "mul ft5, ft0, fc0.xxxx                         \n" + "tex ft1,  v1, fs0 <2d, clamp, linear, mipnone> \n" + "mul ft1, ft1, fc0.zzzz                         \n" + "add ft5, ft5, ft1                              \n" + "tex ft2,  v2, fs0 <2d, clamp, linear, mipnone> \n" + "mul ft2, ft2, fc0.yyyy                         \n" + "add ft5, ft5, ft2                              \n" + "tex ft3,  v3, fs0 <2d, clamp, linear, mipnone> \n" + "mul ft3, ft3, fc0.yyyy                         \n" + "add ft5, ft5, ft3                              \n" + "tex ft4,  v4, fs0 <2d, clamp, linear, mipnone> \n" + "mul ft4, ft4, fc0.zzzz                         \n";
         if(param1)
         {
            _loc3_ += "add ft5, ft5, ft4                              \n" + "mul ft5.xyz, fc1.xyz, ft5.www                  \n" + "mul oc, ft5, fc1.wwww                          \n";
         }
         else
         {
            _loc3_ += "add  oc, ft5, ft4                              \n";
         }
         return assembleAgal(_loc3_,_loc2_);
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         this.updateParameters(param1,param3.nativeWidth,param3.nativeHeight);
         param2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,this.mOffsets);
         param2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this.mWeights);
         if(this.mUniformColor && param1 == numPasses - 1)
         {
            param2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,1,this.mColor);
            param2.setProgram(this.mTintedProgram);
         }
         else
         {
            param2.setProgram(this.mNormalProgram);
         }
      }
      
      private function updateParameters(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Boolean = param1 < this.mBlurX;
         if(_loc5_)
         {
            _loc4_ = Math.min(1,this.mBlurX - param1) * this.MAX_SIGMA;
            _loc6_ = 1 / param2;
         }
         else
         {
            _loc4_ = Math.min(1,this.mBlurY - (param1 - Math.ceil(this.mBlurX))) * this.MAX_SIGMA;
            _loc6_ = 1 / param3;
         }
         _loc7_ = 2 * _loc4_ * _loc4_;
         var _loc8_:Number = 1 / Math.sqrt(_loc7_ * Math.PI);
         var _loc9_:* = 0;
         while(_loc9_ < 5)
         {
            this.sTmpWeights[_loc9_] = _loc8_ * Math.exp(-_loc9_ * _loc9_ / _loc7_);
            _loc9_++;
         }
         this.mWeights[0] = this.sTmpWeights[0];
         this.mWeights[1] = this.sTmpWeights[1] + this.sTmpWeights[2];
         this.mWeights[2] = this.sTmpWeights[3] + this.sTmpWeights[4];
         var _loc10_:Number = this.mWeights[0] + 2 * this.mWeights[1] + 2 * this.mWeights[2];
         var _loc11_:Number = 1 / _loc10_;
         this.mWeights[0] *= _loc11_;
         this.mWeights[1] *= _loc11_;
         this.mWeights[2] *= _loc11_;
         var _loc12_:Number = (_loc6_ * this.sTmpWeights[1] + 2 * _loc6_ * this.sTmpWeights[2]) / this.mWeights[1];
         var _loc13_:Number = (3 * _loc6_ * this.sTmpWeights[3] + 4 * _loc6_ * this.sTmpWeights[4]) / this.mWeights[2];
         if(_loc5_)
         {
            this.mOffsets[0] = _loc12_;
            this.mOffsets[1] = 0;
            this.mOffsets[2] = _loc13_;
            this.mOffsets[3] = 0;
         }
         else
         {
            this.mOffsets[0] = 0;
            this.mOffsets[1] = _loc12_;
            this.mOffsets[2] = 0;
            this.mOffsets[3] = _loc13_;
         }
      }
      
      private function updateMarginsAndPasses() : void
      {
         if(this.mBlurX == 0 && this.mBlurY == 0)
         {
            this.mBlurX = 0.001;
         }
         numPasses = Math.ceil(this.mBlurX) + Math.ceil(this.mBlurY);
         marginX = 4 + Math.ceil(this.mBlurX);
         marginY = 4 + Math.ceil(this.mBlurY);
      }
      
      public function setUniformColor(param1:Boolean, param2:uint = 0, param3:Number = 1) : void
      {
         this.mColor[0] = Color.getRed(param2) / 255;
         this.mColor[1] = Color.getGreen(param2) / 255;
         this.mColor[2] = Color.getBlue(param2) / 255;
         this.mColor[3] = param3;
         this.mUniformColor = param1;
      }
      
      public function get blurX() : Number
      {
         return this.mBlurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         this.mBlurX = param1;
         this.updateMarginsAndPasses();
      }
      
      public function get blurY() : Number
      {
         return this.mBlurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         this.mBlurY = param1;
         this.updateMarginsAndPasses();
      }
   }
}

