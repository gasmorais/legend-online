package mainBar
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class StripView extends TransformableComponent
   {
      
      public function StripView()
      {
         super();
      }
      
      public function setHitArea(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(16777215,0);
         _loc5_.graphics.drawRect(param1,param2,param3,param4);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         this.hitArea = _loc5_;
      }
      
      public function setCircleArea(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.beginFill(16777215,0);
         _loc4_.graphics.drawCircle(param1,param2,param3);
         _loc4_.graphics.endFill();
         addChild(_loc4_);
         this.hitArea = _loc4_;
      }
      
      public function setTarget(param1:DisplayObject, param2:int = 0, param3:int = 0) : void
      {
         ObjectUtils.disposeAllChildren(this);
         var _loc5_:Sprite = new Sprite();
         var _loc4_:Object = getTargetObjSize(param1);
         if(param2 > 0 && param3 > 0)
         {
            _loc4_.w = param2;
            _loc4_.h = param3;
         }
         _loc5_.graphics.beginFill(0,0);
         _loc5_.graphics.drawRect(0,0,_loc4_.w,_loc4_.h);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         if(this.parent == param1.parent)
         {
            this.x = param1.x;
            this.y = param1.y;
         }
         this.hitArea = _loc5_;
      }
      
      private function getTargetObjSize(param1:DisplayObject) : Object
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(param1 is Component)
         {
            _loc3_ = Number(param1["displayWidth"]);
            _loc2_ = Number(param1["displayHeight"]);
         }
         else
         {
            _loc3_ = param1.width;
            _loc2_ = param1.height;
         }
         return {
            "w":_loc3_,
            "h":_loc2_
         };
      }
      
      public function set opaqueBG(param1:Boolean) : void
      {
         if(param1)
         {
            graphics.beginFill(16711680,0);
            graphics.drawRect(0,0,width,height);
            graphics.endFill();
         }
      }
      
      override public function get width() : Number
      {
         return displayWidth;
      }
      
      override public function get height() : Number
      {
         return displayHeight;
      }
   }
}

