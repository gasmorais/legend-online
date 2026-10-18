package battle.view.animation
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class AddSpAnimation
   {
      
      private var _container:Sprite;
      
      private var _lines:Vector.<Line>;
      
      private var _startPt:Point;
      
      private var _endPt:Point;
      
      private var _count:int;
      
      private var _balls:Dictionary;
      
      public var arrivedFun:Function;
      
      private var _lineNum:int;
      
      private var _ballAsset:String;
      
      private var _disperseAsset:String;
      
      private var _disperses:Array;
      
      private var _flyTime:Number;
      
      private var _ballNum:int;
      
      public function AddSpAnimation(param1:Sprite, param2:int, param3:String = "asset.battle.AddSpBallMC", param4:String = "asset.battle.AddSpBallMC3", param5:Number = 1.2, param6:int = 3)
      {
         super();
         _container = param1;
         _lineNum = param2;
         _ballAsset = param3;
         _disperseAsset = param4;
         _flyTime = param5;
         _ballNum = param6;
         _lines = new Vector.<Line>();
         _balls = new Dictionary();
      }
      
      public function play(param1:Point, param2:Point) : void
      {
         _startPt = param1;
         _endPt = param2;
         _disperses = [];
         createRandomLines();
         startPlay();
      }
      
      private function createRandomLines() : void
      {
         var _loc3_:Line = null;
         var _loc1_:int = 180;
         var _loc2_:int = 90;
         if(_lineNum == 2)
         {
            _loc1_ = 150;
            _loc2_ = 60;
         }
         var _loc4_:Number = Point.distance(_startPt,_endPt) / 400;
         if(_loc4_ > 1)
         {
            _loc4_ = 1;
         }
         else if(_loc4_ < 0.7)
         {
            _loc4_ = 0.7;
         }
         if(_lineNum > 1)
         {
            _loc3_ = createLine(-_loc1_,_loc2_,_loc4_);
            _loc3_.index = _lines.length + 1;
            _lines.push(_loc3_);
         }
         if(_lineNum != 2)
         {
            _loc3_ = createLine(0,50,_loc4_);
            _loc3_.index = _lines.length + 1;
            _lines.push(_loc3_);
         }
         if(_lineNum > 1)
         {
            _loc3_ = createLine(_loc1_,-_loc2_,_loc4_);
            _loc3_.index = _lines.length + 1;
            _lines.push(_loc3_);
         }
      }
      
      private function createLine(param1:int, param2:int, param3:Number = 1) : Line
      {
         var _loc8_:Number = Math.atan2(_endPt.y - _startPt.y,_endPt.x - _startPt.x);
         var _loc7_:Number = _loc8_ * 180 / 3.141592653589793;
         _loc8_ -= 3.141592653589793 * 0.5;
         var _loc6_:Number = param1 * Math.cos(_loc8_) * param3;
         var _loc4_:Number = (param2 * Math.cos(_loc8_) + param1 * Math.sin(_loc8_)) * param3;
         var _loc5_:Line = new Line();
         _loc5_.pt1 = new Point(_startPt.x + _loc6_,_startPt.y + _loc4_);
         _loc5_.pt2 = new Point(_endPt.x,_endPt.y - 20);
         return _loc5_;
      }
      
      private function startPlay() : void
      {
         _container.addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_count == 0)
         {
            createBalls(true);
            if(_ballNum == 1)
            {
               removeHandler();
            }
         }
         else if(_count == 3)
         {
            createBalls();
            if(_ballNum == 2)
            {
               removeHandler();
            }
         }
         else if(_count == 6)
         {
            createBalls();
            removeHandler();
         }
         _count = _count + 1;
      }
      
      private function removeHandler() : void
      {
         if(_container.hasEventListener("enterFrame"))
         {
            _container.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private function createBalls(param1:Boolean = false) : void
      {
         var _loc2_:Ball = null;
         var _loc3_:* = null;
         for each(var _loc4_:Line in _lines)
         {
            _loc2_ = new Ball(_endPt,_ballAsset);
            _loc2_.x = _startPt.x;
            _loc2_.y = _startPt.y;
            _container.addChild(_loc2_);
            _balls[_loc2_] = _loc2_;
            _loc4_.balls.push(_loc2_);
            _loc2_.line = _loc4_.index;
            if(param1)
            {
               _loc2_.scaleX = _loc2_.scaleY = 0.3;
               TweenMax.to(_loc2_,0.4,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Linear.easeInOut
               });
               _loc2_.needFlag = true;
            }
            else
            {
               _loc2_.scaleX = _loc2_.scaleY = 0.1;
            }
            _loc2_.tween = TweenMax.to(_loc2_,_flyTime,{
               "bezier":[{
                  "x":_loc4_.pt1.x,
                  "y":_loc4_.pt1.y
               },{
                  "x":_loc4_.pt2.x,
                  "y":_loc4_.pt2.y
               },{
                  "x":_endPt.x,
                  "y":_endPt.y
               }],
               "orientToBezier":true,
               "ease":Linear.easeNone,
               "onUpdate":onBallUpdate,
               "onUpdateParams":[_loc2_],
               "delay":Math.abs((_loc4_.index - 2) * 0.05)
            });
            TweenMax.to(_loc2_,0.2,{
               "alpha":0.5,
               "delay":1
            });
         }
      }
      
      private function onBallUpdate(param1:Ball) : void
      {
         if(Math.abs(param1.x - _endPt.x) < 10 && Math.abs(param1.y - _endPt.y) < 10)
         {
            TweenMax.killTweensOf(param1);
            onBallArrived(param1);
            if(param1.needFlag && arrivedFun != null)
            {
               arrivedFun();
               arrivedFun = null;
            }
         }
         var _loc4_:Ball = _lines[param1.line - 1].balls[0];
         if(_loc4_ != param1)
         {
            param1.scaleX = param1.scaleY = _loc4_.scaleX * Math.pow(0.7,_lines[param1.line - 1].balls.indexOf(param1));
         }
         var _loc2_:Number = 2;
         var _loc3_:int = Math.floor(int(param1.tween.currentProgress * 10) / _loc2_);
         if(_loc3_ > param1.process && param1.needFlag)
         {
            param1.process = _loc3_;
            addSmallBall(param1.x,param1.y);
         }
      }
      
      private function addSmallBall(param1:Number, param2:Number) : void
      {
         var posX:Number = param1;
         var posY:Number = param2;
         var removeFun:* = function():void
         {
            var _loc1_:int = 0;
            if(_disperses)
            {
               _loc1_ = _disperses.indexOf(small);
               if(_loc1_ > -1)
               {
                  _disperses.splice(_loc1_,1);
               }
            }
            if(small)
            {
               if(small.parent)
               {
                  small.parent.removeChild(small);
               }
               small.dispose();
               small = null;
            }
         };
         var temMC:MovieClip = ComponentFactory.Instance.creat(_disperseAsset);
         var small:SimpleBitmapMovieClip = new SimpleBitmapMovieClip(temMC,_disperseAsset,true,false);
         small.addFrameScript(small.totalFrames,removeFun);
         small.mouseEnabled = false;
         small.mouseChildren = false;
         small.blendMode = "add";
         small.x = posX;
         small.y = posY;
         _container.addChild(small);
         _disperses.push(small);
      }
      
      private function onBallArrived(param1:Ball) : void
      {
         var ball:Ball = param1;
         var shakeEnd:* = function():void
         {
            if(_container && _container.contains(ball))
            {
               _container.removeChild(ball);
            }
            ball.dispose();
            delete _balls[ball];
         };
         ball.shake(shakeEnd);
      }
      
      public function dispose() : void
      {
         removeHandler();
         for each(var _loc1_:Ball in _balls)
         {
            if(_loc1_.parent)
            {
               _container.removeChild(_loc1_);
            }
            _loc1_.dispose();
            delete _balls[_loc1_];
         }
         for each(var _loc2_:Sprite in _disperses)
         {
            if(_loc2_ && _loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
               if(_loc2_ is SimpleBitmapMovieClip)
               {
                  SimpleBitmapMovieClip(_loc2_).dispose();
               }
            }
         }
         _balls = null;
         _disperses = null;
      }
   }
}

import com.greensock.TweenMax;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.utils.ObjectUtils;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

class Line
{
   
   public var pt1:Point;
   
   public var pt2:Point;
   
   public var index:int;
   
   public var balls:Vector.<Ball> = new Vector.<Ball>();
   
   public function Line()
   {
      super();
   }
}

class Ball extends Sprite
{
   
   private var mc:MovieClip;
   
   private var _shakeEndFun:Function;
   
   private var _count:int;
   
   private var _destX:Number;
   
   private var _destY:Number;
   
   private var _maxCount:int;
   
   private var _shakeInterval:int = 10;
   
   private var _shakeTimeId:uint;
   
   public var line:int;
   
   public var tween:TweenMax;
   
   public var process:int;
   
   public var needFlag:Boolean;
   
   public function Ball(param1:Point, param2:String)
   {
      super();
      _destX = param1.x;
      _destY = param1.y;
      _maxCount = int(Math.random() * 2) + 1;
      mc = ComponentFactory.Instance.creat(param2) as MovieClip;
      mc.mouseChildren = mc.mouseEnabled = false;
      addChild(mc);
   }
   
   public function shake(param1:Function) : void
   {
      _shakeEndFun = param1;
      _shakeTimeId = setTimeout(shakeOne,_shakeInterval);
   }
   
   private function shakeOne() : void
   {
      x = _destX + Math.random() * 24 - 12;
      if(_count < _maxCount - 1)
      {
         clearTimeout(_shakeTimeId);
         _shakeTimeId = setTimeout(shakeOne,_shakeInterval);
      }
      else
      {
         _shakeEndFun();
      }
      _count = Number(_count) + 1;
   }
   
   public function dispose() : void
   {
      TweenMax.killTweensOf(this);
      clearTimeout(_shakeTimeId);
      ObjectUtils.disposeViolentMc(mc);
      mc = null;
      _shakeEndFun = null;
      tween = null;
   }
}
