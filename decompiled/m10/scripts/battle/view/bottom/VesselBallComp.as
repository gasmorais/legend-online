package battle.view.bottom
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class VesselBallComp
   {
      
      public static const BALL_WIDTH:Number = 93;
      
      private var _max:int;
      
      private var _curr:int;
      
      private var _view:Sprite;
      
      private var _container:Sprite;
      
      private var _ball:DisplayObject;
      
      private var _ballMask:Shape;
      
      private var _line:DisplayObject;
      
      private var _mask:Shape;
      
      private var _tweener:TweenLite;
      
      private var _rotationFlag:Boolean;
      
      public function VesselBallComp(param1:int, param2:int, param3:DisplayObject)
      {
         super();
         _max = param1;
         _curr = param2;
         _line = param3;
         init();
      }
      
      private function init() : void
      {
         _view = new Sprite();
         _container = new Sprite();
         _view.addChild(_container);
         _mask = createMask();
         _view.addChild(_mask);
         _container.mask = _mask;
         _container.addChild(_line);
         initLinePos();
      }
      
      private function initLinePos() : void
      {
         _line.y = calculateY();
         if(_curr == 0)
         {
            _line.visible = false;
         }
      }
      
      private function createMask() : Shape
      {
         var _loc1_:Number = 46.5;
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      public function update(param1:int) : void
      {
         if(_curr == param1)
         {
            return;
         }
         _curr = param1;
         if(_curr > 0)
         {
            _line.visible = true;
         }
         _tweener = TweenLite.to(_line,0.5,{
            "y":calculateY(),
            "onUpdate":updateBallMask,
            "onComplete":onChangeComplete
         });
      }
      
      private function onChangeComplete() : void
      {
         if(_curr == 0)
         {
            _line.visible = false;
         }
         if(_line)
         {
            TweenLite.killTweensOf(_line);
         }
      }
      
      private function calculateY() : Number
      {
         var _loc2_:Number = (_max - _curr) / _max;
         var _loc1_:Number = 93 * _loc2_;
         if(_loc1_ <= 0)
         {
            _loc1_ = -10;
         }
         if(_loc1_ > 93)
         {
            _loc1_ = 93;
         }
         return _loc1_;
      }
      
      public function showBall(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(_ball)
         {
            _ball.removeEventListener("enterFrame",onEnterFrame);
         }
         ObjectUtils.disposeObject(_ball);
         _ball = null;
         _ball = param1;
         _ball.x = 93 * 0.5;
         _ball.y = 93 * 0.5;
         _container.addChildAt(_ball,0);
         _ballMask = new Shape();
         _ballMask.graphics.beginFill(0);
         _ballMask.graphics.drawRect(0,-93,93,93);
         _ballMask.graphics.endFill();
         _ballMask.y = 93;
         _container.addChild(_ballMask);
         _ball.mask = _ballMask;
         if(param2)
         {
            _ball.addEventListener("enterFrame",onEnterFrame);
         }
         updateBallMask();
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(_ball)
         {
            if(param1)
            {
               _ball.addEventListener("enterFrame",onEnterFrame);
            }
            else
            {
               _ball.removeEventListener("enterFrame",onEnterFrame);
            }
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         _ball.rotation += 1;
      }
      
      private function updateBallMask() : void
      {
         if(_ballMask)
         {
            _ballMask.height = 93 - _line.y;
         }
      }
      
      public function getView() : Sprite
      {
         return _view;
      }
      
      public function set max(param1:int) : void
      {
         _max = param1;
      }
      
      public function dispose() : void
      {
         if(_line)
         {
            TweenLite.killTweensOf(_line);
         }
         if(_ball)
         {
            if(_ball is SimpleBitmapMovieClip)
            {
               SimpleBitmapMovieClip(_ball).dispose();
            }
            _ball.removeEventListener("enterFrame",onEnterFrame);
            _ball = null;
         }
         ObjectUtils.disposeObject(_ballMask);
         _ballMask = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeViolentMc(_container);
         _container = null;
         ObjectUtils.disposeViolentMc(_view);
         _view = null;
         if(_tweener)
         {
            _tweener.kill();
         }
         _tweener = null;
      }
   }
}

