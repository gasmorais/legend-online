package com.speedEngine.game.tween
{
   import avmplus.getQualifiedClassName;
   import com.greensock.TweenLite;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.manager.TweenManager;
   
   public class Tween
   {
      
      private const CLASS_NAME:String = "game.tween::Tween";
      
      private var _operate:Object;
      
      private var _target:Object;
      
      private var _duration:Number;
      
      private var _args:Object;
      
      private var _onCompleteFun:Function = null;
      
      private var _onUpdateFun:Function = null;
      
      private var _onStartFun:Function = null;
      
      private var _tweenLite:TweenLite;
      
      private var _isKill:Boolean;
      
      public function Tween(param1:Object, param2:Number, param3:Object, param4:Boolean = true, param5:Object = null)
      {
         super();
         _operate = param5;
         _target = param1;
         _duration = param2;
         _args = param3;
         _tweenLite = null;
         _isKill = param4;
         if(param3.hasOwnProperty("onComplete"))
         {
            _onCompleteFun = param3.onComplete;
         }
         if(param3.hasOwnProperty("onStart"))
         {
            _onStartFun = param3.onStart;
         }
         if(param3.hasOwnProperty("onUpdate"))
         {
            _onUpdateFun = param3.onUpdate;
         }
         _args.onComplete = this.onUseComplete;
         if("game.tween::Tween" != getQualifiedClassName(this))
         {
            if(this.hasOwnProperty("onUpdate"))
            {
               Director.instance.trace(4,"已重写onUpdate。{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}??");
               _args.onUpdata = this.onUseUpdate;
            }
            if(this.hasOwnProperty("onStart"))
            {
               Director.instance.trace(4,"已重写onStart。{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}?{invalid_utf8=130}{invalid_utf8=227}??");
               _args.onStart = this.onUseStart;
            }
         }
      }
      
      private function onUseStart() : void
      {
         TweenManager.instance.startBefore();
         this["onStart"]();
         if(_onStartFun != null)
         {
            _onStartFun.apply(null);
         }
         TweenManager.instance.startAfter();
      }
      
      private function onUseUpdate() : void
      {
         TweenManager.instance.updateBefore();
         this["onUpdate"]();
         if(_onUpdateFun != null)
         {
            _onUpdateFun.apply(null);
         }
         TweenManager.instance.updateAfter();
      }
      
      private function onUseComplete() : void
      {
         TweenManager.instance.completeBefore();
         this["onComplete"]();
         if(_onCompleteFun != null)
         {
            _onCompleteFun.apply(null);
         }
         TweenManager.instance.completeAfter(this);
      }
      
      protected function onComplete() : void
      {
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function get args() : Object
      {
         return _args;
      }
      
      public function get operate() : Object
      {
         return _operate;
      }
      
      public function get tweenLite() : TweenLite
      {
         return _tweenLite;
      }
      
      public function set tweenLite(param1:TweenLite) : void
      {
         _tweenLite = param1;
      }
      
      public function dispose() : void
      {
         _tweenLite = null;
         _operate = null;
         _args = null;
         _target = null;
         _onCompleteFun = null;
         _onStartFun = null;
         _onUpdateFun = null;
      }
      
      public function get isKill() : Boolean
      {
         return _isKill;
      }
   }
}

