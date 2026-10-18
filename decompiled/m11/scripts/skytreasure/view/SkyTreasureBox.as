package skytreasure.view
{
   import com.greensock.TweenMax;
   import com.greensock.core.TweenCore;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class SkyTreasureBox extends Sprite implements Disposeable
   {
      
      private static const CHANNEPATTERN:int = 3;
      
      private static const INIT_X:int = 550;
      
      private static const INIT_Y:int = 0;
      
      private static const DURATION:int = 5;
      
      public static const STATE_STOP:String = "STATE_STOP";
      
      public static const STATE_MOVE_OUT_DISPLAY_VIEW:String = "STATE_MOVE_OUT_DISPLAY_VIEW";
      
      public static const STATE_MOVEING:String = "STATE_MOVEING";
      
      public static const STATE_HITING:String = "STATE_HITING";
      
      private static const CHANNE:Array = [[10,90],[110,200],[220,300]];
      
      private var _serial:int;
      
      private var _boxMc:MovieClip;
      
      private var _hitEffect:MovieClip;
      
      private var _state:String;
      
      private var _tweenMax:TweenMax;
      
      private var _speedFlag:Boolean;
      
      public function SkyTreasureBox(param1:int)
      {
         super();
         clean();
         createBox(param1);
      }
      
      public function set state(param1:String) : void
      {
         _state = param1;
      }
      
      public function get serial() : int
      {
         return _serial;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      private function resetXY() : void
      {
         var _loc3_:int = _serial % 3;
         var _loc2_:Array = CHANNE[_loc3_];
         var _loc4_:int = int(_loc2_[0]);
         var _loc1_:int = int(_loc2_[1]);
         this.x = 550;
         this.y = _loc4_ + (_loc1_ - _loc4_) * Math.random();
      }
      
      protected function clean() : void
      {
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
      }
      
      private function createBox(param1:int) : void
      {
         _serial = param1;
         state = "STATE_MOVEING";
         var _loc2_:int = Math.random() * 3;
         _loc2_ += 1;
         _boxMc = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureCenterViewBox0" + _loc2_);
         _hitEffect = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureCenterViewBoxHit");
         _hitEffect.stop();
         addChild(_boxMc);
         resetXY();
      }
      
      public function get boxMc() : MovieClip
      {
         return _boxMc;
      }
      
      public function initTweenMax() : void
      {
         _tweenMax = TweenMax.to(this,5,{
            "x":-100,
            "onComplete":tweenComplete,
            "onCompleteParams":[this],
            "ease":Linear.easeNone
         });
      }
      
      private function tweenComplete(param1:SkyTreasureBox) : void
      {
         param1.moveOutDisplayView();
         this.visible = false;
      }
      
      public function isMoveing() : Boolean
      {
         if(state == "STATE_MOVEING")
         {
            return true;
         }
         return false;
      }
      
      public function isMoveOutDisplayView() : Boolean
      {
         if(_state == "STATE_MOVE_OUT_DISPLAY_VIEW")
         {
            return true;
         }
         return false;
      }
      
      public function hitDispose() : void
      {
         state = "STATE_HITING";
         _tweenMax.pause();
         TweenMax.to(this,0.5,{
            "alpha":0,
            "onComplete":hitDisposeComplete
         });
         var _loc1_:Rectangle = this.getRect(this.parent);
         _hitEffect.x = _loc1_.x;
         _hitEffect.y = _loc1_.y;
         _hitEffect.visible = true;
         _hitEffect.play();
         if(!_hitEffect.parent)
         {
            parent.addChild(_hitEffect);
         }
      }
      
      private function hitDisposeComplete() : void
      {
         if(_hitEffect)
         {
            _hitEffect.x = 550;
            _hitEffect.y = 0;
            _hitEffect.visible = false;
            _hitEffect.stop();
         }
         this.visible = false;
         this.moveOutDisplayView();
      }
      
      private function moveOutDisplayView() : void
      {
         state = "STATE_MOVE_OUT_DISPLAY_VIEW";
         this.x = 550;
         this.y = 0;
         this.alpha = 1;
      }
      
      public function speed() : void
      {
         var _loc1_:Number = this.x / 50 / 15;
         _tweenMax.kill();
         _tweenMax = TweenMax.to(this,_loc1_,{
            "x":-100,
            "onComplete":tweenComplete,
            "onCompleteParams":[this],
            "ease":Linear.easeNone
         });
         _speedFlag = true;
      }
      
      public function pause() : void
      {
         if(state == "STATE_MOVEING")
         {
            state = "STATE_STOP";
         }
         pauseAllTweenMax();
      }
      
      private function pauseAllTweenMax() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Array = TweenMax.getAllTweens();
         var _loc3_:int = int(_loc1_.length);
         while(--_loc3_ > -1)
         {
            if(_loc1_[_loc3_] is TweenMax)
            {
               _loc2_ = TweenMax(_loc1_[_loc3_]).target == TweenMax(_loc1_[_loc3_]).vars.onComplete;
               if(_loc2_ == true || _loc2_ != true && _loc1_[_loc3_] is TweenMax)
               {
                  TweenCore(_loc1_[_loc3_]).paused = true;
               }
            }
         }
      }
      
      public function resume() : void
      {
         if(state == "STATE_STOP")
         {
            state = "STATE_MOVEING";
         }
         _tweenMax.resume();
      }
      
      public function restart() : void
      {
         this.resetXY();
         state = "STATE_MOVEING";
         this.visible = true;
         if(_speedFlag)
         {
            _tweenMax.kill();
            _tweenMax = TweenMax.to(this,5,{
               "x":-100,
               "onComplete":tweenComplete,
               "onCompleteParams":[this],
               "ease":Linear.easeNone
            });
            _speedFlag = false;
         }
         else
         {
            _tweenMax.restart();
         }
      }
      
      public function dispose() : void
      {
         if(_hitEffect)
         {
            _hitEffect.stop();
         }
         if(_boxMc)
         {
            _boxMc.stop();
         }
         ObjectUtils.disposeViolentMc(_hitEffect);
         _hitEffect = null;
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
         if(_tweenMax)
         {
            _tweenMax.kill();
         }
      }
   }
}

