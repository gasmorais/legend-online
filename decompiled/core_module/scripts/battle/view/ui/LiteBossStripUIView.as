package battle.view.ui
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class LiteBossStripUIView extends Sprite implements IHpStrip
   {
      
      private var _tween:Boolean;
      
      private var _maskRect:Rectangle;
      
      private var _viewWidth:uint;
      
      private var _currentValue:Number;
      
      private var _maxValue:Number;
      
      private var _resource:DisplayObject;
      
      public function LiteBossStripUIView(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Boolean = true)
      {
         super();
         _tween = param4;
         _resource = param1;
         _viewWidth = param1.width;
         _maskRect = new Rectangle(0,0,param1.width,param1.height);
         param1.scrollRect = _maskRect;
         addChild(param1);
         this.maxValue = param3;
         this.currentValue = currentValue;
      }
      
      public function set currentValue(param1:Number) : void
      {
         var value:Number = param1;
         _currentValue = value;
         var targetViewWidth:uint = _currentValue / _maxValue * _viewWidth;
         if(_tween)
         {
            TweenLite.killTweensOf(_maskRect);
            TweenLite.to(_maskRect,0.3,{
               "width":targetViewWidth,
               "onUpdate":function():void
               {
                  _resource.scrollRect = _maskRect;
               },
               "onComplete":function():void
               {
                  _maskRect.width = targetViewWidth;
                  _resource.scrollRect = _maskRect;
               }
            });
         }
         else
         {
            _maskRect.width = targetViewWidth;
            _resource.scrollRect = _maskRect;
         }
      }
      
      public function get currentValue() : Number
      {
         return _currentValue;
      }
      
      public function get maxValue() : Number
      {
         return _maxValue;
      }
      
      public function set maxValue(param1:Number) : void
      {
         _maxValue = param1;
      }
      
      public function initCurrentValue(param1:Number) : void
      {
      }
      
      public function getView() : DisplayObject
      {
         return _resource;
      }
      
      public function dispose() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

