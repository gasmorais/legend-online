package com.pickgliss.ui.controls.container
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class HBox extends BoxContainer
   {
      
      public var autoCenter:Boolean = false;
      
      public function HBox()
      {
         super();
      }
      
      override protected function arrange() : void
      {
         var _loc3_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc6_:int = 0;
         _width = 0;
         _height = 0;
         var _loc1_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < _childrenList.length)
         {
            _loc7_ = _childrenList[_loc3_];
            _loc4_ = getItemWidth(_loc7_);
            _loc2_ = getItemHeight(_loc7_);
            _loc7_.x = _loc1_;
            _loc1_ += _loc4_;
            _loc1_ += _spacing;
            _width += _loc4_;
            _height = Math.max(_height,_loc2_);
            _loc3_++;
         }
         _width += _spacing * (numChildren - 1);
         _width = Math.max(0,_width);
         if(autoCenter)
         {
            _loc6_ = 0.5 * _width;
            for each(var _loc5_:DisplayObject in _childrenList)
            {
               _loc5_.x -= _loc6_;
            }
         }
         dispatchEvent(new Event("resize"));
      }
      
      private function getItemHeight(param1:DisplayObject) : Number
      {
         if(param1 is IManualSize)
         {
            return (param1 as IManualSize).viewRectangle.height;
         }
         if(param1 is IManualTipTargetSize)
         {
            return (param1 as IManualTipTargetSize).manualHeight;
         }
         if(param1 is Component)
         {
            return (param1 as Component).displayHeight;
         }
         return param1.height;
      }
      
      private function getItemWidth(param1:DisplayObject) : Number
      {
         if(isStrictWidth)
         {
            return _strictWidth;
         }
         if(param1 is IManualSize)
         {
            return (param1 as IManualSize).viewRectangle.width;
         }
         if(param1 is IManualTipTargetSize)
         {
            return (param1 as IManualTipTargetSize).manualWidth;
         }
         if(param1 is Component)
         {
            return (param1 as Component).displayWidth;
         }
         return param1.width;
      }
   }
}

