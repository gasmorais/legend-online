package com.speedEngine.game.manager
{
   import com.greensock.TweenLite;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.tween.Tween;
   import flash.utils.Dictionary;
   
   use namespace basegame_internal;
   
   public class TweenManager extends BaseManager
   {
      
      private static var _instance:TweenManager;
      
      private var _tweens:Dictionary;
      
      public function TweenManager(param1:SingleHelper)
      {
         super();
      }
      
      public static function get instance() : TweenManager
      {
         if(_instance == null)
         {
            _instance = new TweenManager(new SingleHelper());
         }
         return _instance;
      }
      
      override public function init() : void
      {
         super.init();
         _tweens = new Dictionary(true);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      basegame_internal function createTween(param1:Class, param2:Object, param3:Number, param4:Object, param5:Boolean = true) : Tween
      {
         var _loc6_:Tween = null;
         try
         {
            _loc6_ = new param1(param2,param3,param4,param5);
         }
         catch(e:Error)
         {
            _loc6_ = null;
            throw new Error("Class必须为game.tween.Tween及其子类");
         }
         return _loc6_;
      }
      
      basegame_internal function to(param1:Tween) : void
      {
         if(param1.tweenLite == null)
         {
            addTween(param1);
         }
         param1.tweenLite = TweenLite.to(param1.target,param1.duration,param1.args);
      }
      
      basegame_internal function from(param1:Tween) : void
      {
         if(param1.tweenLite == null)
         {
            addTween(param1);
         }
         param1.tweenLite = TweenLite.from(param1.target,param1.duration,param1.args);
      }
      
      private function addTween(param1:Tween) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Vector.<Tween> = _tweens[param1.target];
         if(_loc3_ != null)
         {
            if(_loc3_.indexOf(param1) != -1)
            {
               _loc3_.push(param1);
            }
         }
         else
         {
            _loc2_ = new Vector.<Tween>();
            _loc2_.push(param1);
            _tweens[param1.target] = _loc2_;
            trace("asd");
         }
      }
      
      basegame_internal function kill(param1:Tween) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Tween> = _tweens[param1.target];
         if(_loc3_)
         {
            _loc2_ = _loc3_.indexOf(param1);
            if(_loc2_ == -1)
            {
               return;
            }
            if(param1.tweenLite != null)
            {
               param1.tweenLite.kill();
            }
            param1.dispose();
            _loc3_.splice(_loc2_,1);
            if(_loc3_.length == 0)
            {
               _tweens[param1.target] = null;
            }
         }
      }
      
      basegame_internal function killAll(param1:Object) : void
      {
         var _loc3_:Vector.<Tween> = _tweens[param1];
         if(_loc3_ != null)
         {
            for each(var _loc2_:Tween in _loc3_)
            {
               if(_loc2_.tweenLite != null)
               {
                  _loc2_.tweenLite.kill();
                  _loc2_.tweenLite = null;
               }
            }
            _tweens[param1] = null;
         }
      }
      
      public function startBefore() : void
      {
      }
      
      public function startAfter() : void
      {
      }
      
      public function updateBefore() : void
      {
      }
      
      public function updateAfter() : void
      {
      }
      
      public function completeBefore() : void
      {
      }
      
      public function completeAfter(param1:Tween) : void
      {
         if(param1.isKill)
         {
            kill(param1);
         }
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}
