package dragonBones.display
{
   import dragonBones.objects.BoneTransform;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import starling.display.Quad;
   import starling.filters.ColorMatrixFilter;
   
   public class StarlingDisplayBridge implements IDisplayBridge
   {
      
      protected var _display:Object;
      
      public function StarlingDisplayBridge()
      {
         super();
      }
      
      public function get display() : Object
      {
         return this._display;
      }
      
      public function set display(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         if(this._display == param1)
         {
            return;
         }
         if(this._display)
         {
            _loc2_ = this._display.parent;
            if(_loc2_)
            {
               _loc3_ = int(this._display.parent.getChildIndex(this._display));
            }
            this.removeDisplay();
         }
         this._display = param1;
         this.addDisplay(_loc2_,_loc3_);
      }
      
      public function update(param1:Matrix, param2:BoneTransform, param3:ColorTransform, param4:Boolean) : void
      {
         var _loc5_:Number = param2.pivotX + this._display.pivotX;
         var _loc6_:Number = param2.pivotY + this._display.pivotY;
         param1.tx -= param1.a * _loc5_ + param1.c * _loc6_;
         param1.ty -= param1.b * _loc5_ + param1.d * _loc6_;
         this._display.transformationMatrix.copyFrom(param1);
         if(Boolean(param3) && this._display is Quad)
         {
            this.useColorTransform(param3);
         }
         this._display.visible = param4;
      }
      
      private function useColorTransform(param1:ColorTransform) : void
      {
         var _loc3_:ColorMatrixFilter = null;
         var _loc2_:Quad = this._display as Quad;
         if(param1.alphaOffset == 0 && param1.redOffset == 0 && param1.greenOffset == 0 && param1.blueOffset == 0 && param1.alphaMultiplier == 1 && param1.redMultiplier == 1 && param1.greenMultiplier == 1 && param1.blueMultiplier == 1)
         {
            _loc2_.filter = null;
            return;
         }
         if(param1.alphaOffset <= 5 && param1.redOffset <= 5 && param1.greenOffset <= 5 && param1.blueOffset <= 5)
         {
            _loc2_.alpha = param1.alphaMultiplier;
            _loc2_.color = (uint(param1.redMultiplier * 255) << 16) + (uint(param1.greenMultiplier * 255) << 8) + uint(param1.blueMultiplier * 255);
         }
         else
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustRGBA(param1);
            _loc2_.filter = _loc3_;
         }
      }
      
      public function addDisplay(param1:Object, param2:int = -1) : void
      {
         if(Boolean(param1) && Boolean(this._display))
         {
            if(param2 < 0)
            {
               param1.addChild(this._display);
            }
            else
            {
               param1.addChildAt(this._display,Math.min(param2,param1.numChildren));
            }
         }
      }
      
      public function removeDisplay() : void
      {
         if(Boolean(this._display) && Boolean(this._display.parent))
         {
            this._display.parent.removeChild(this._display);
         }
      }
   }
}

