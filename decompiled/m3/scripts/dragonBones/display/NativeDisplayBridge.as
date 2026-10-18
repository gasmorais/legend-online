package dragonBones.display
{
   import dragonBones.objects.BoneTransform;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class NativeDisplayBridge implements IDisplayBridge
   {
      
      protected var _display:DisplayObject;
      
      public function NativeDisplayBridge()
      {
         super();
      }
      
      public function get display() : Object
      {
         return this._display;
      }
      
      public function set display(param1:Object) : void
      {
         var _loc2_:DisplayObjectContainer = null;
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
               _loc3_ = this._display.parent.getChildIndex(this._display);
            }
            this.removeDisplay();
         }
         this._display = param1 as DisplayObject;
         this.addDisplay(_loc2_,_loc3_);
      }
      
      public function update(param1:Matrix, param2:BoneTransform, param3:ColorTransform, param4:Boolean) : void
      {
         var _loc5_:Number = param2.pivotX;
         var _loc6_:Number = param2.pivotY;
         param1.tx -= param1.a * _loc5_ + param1.c * _loc6_;
         param1.ty -= param1.b * _loc5_ + param1.d * _loc6_;
         this._display.transform.matrix = param1;
         if(param3)
         {
            this._display.transform.colorTransform = param3;
         }
         this._display.visible = param4;
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

