package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.core.*;
   
   public class TweenPlugin
   {
      
      public static const VERSION:Number = 1.32;
      
      public static const API:Number = 1;
      
      public var propName:String;
      
      public var overwriteProps:Array;
      
      public var round:Boolean;
      
      public var priority:int = 0;
      
      public var activeDisable:Boolean;
      
      public var onComplete:Function;
      
      public var onEnable:Function;
      
      public var onDisable:Function;
      
      protected var _tweens:Array = [];
      
      protected var _changeFactor:Number = 0;
      
      public function TweenPlugin()
      {
         super();
      }
      
      private static function onTweenEvent(param1:String, param2:TweenLite) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:PropTween = param2.cachedPT1;
         if(param1 == "onInit")
         {
            _loc4_ = [];
            while(_loc3_)
            {
               _loc4_[_loc4_.length] = _loc3_;
               _loc3_ = _loc3_.nextNode;
            }
            _loc4_.sortOn("priority",0x10 | 2);
            _loc5_ = int(_loc4_.length);
            while(_loc5_--)
            {
               PropTween(_loc4_[_loc5_]).nextNode = _loc4_[_loc5_ + 1];
               PropTween(_loc4_[_loc5_]).prevNode = _loc4_[_loc5_ - 1];
            }
            param2.cachedPT1 = _loc4_[0];
         }
         else
         {
            while(_loc3_)
            {
               if(_loc3_.isPlugin && _loc3_.target[param1])
               {
                  if(_loc3_.target.activeDisable)
                  {
                     _loc6_ = true;
                  }
                  _loc3_.target[param1]();
               }
               _loc3_ = _loc3_.nextNode;
            }
         }
         return _loc6_;
      }
      
      public static function activate(param1:Array) : Boolean
      {
         var _loc2_:Object = null;
         TweenLite.onPluginEvent = TweenPlugin.onTweenEvent;
         var _loc3_:int = int(param1.length);
         while(_loc3_--)
         {
            if(param1[_loc3_].hasOwnProperty("API"))
            {
               _loc2_ = new (param1[_loc3_] as Class)();
               TweenLite.plugins[_loc2_.propName] = param1[_loc3_];
            }
         }
         return true;
      }
      
      public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         addTween(param1,this.propName,param1[this.propName],param2,this.propName);
         return true;
      }
      
      protected function addTween(param1:Object, param2:String, param3:Number, param4:*, param5:String = null) : void
      {
         var _loc6_:Number = NaN;
         if(param4 != null)
         {
            _loc6_ = typeof param4 == "number" ? Number(param4) - param3 : Number(param4);
            if(_loc6_ != 0)
            {
               _tweens[_tweens.length] = new PropTween(param1,param2,param3,_loc6_,param5 || param2,false);
            }
         }
      }
      
      protected function updateTweens(param1:Number) : void
      {
         var _loc3_:PropTween = null;
         var _loc2_:Number = NaN;
         var _loc4_:int = int(_tweens.length);
         if(this.round)
         {
            while(--_loc4_ > -1)
            {
               _loc3_ = _tweens[_loc4_];
               _loc2_ = _loc3_.start + _loc3_.change * param1;
               if(_loc2_ > 0)
               {
                  _loc3_.target[_loc3_.property] = _loc2_ + 0.5 >> 0;
               }
               else
               {
                  _loc3_.target[_loc3_.property] = _loc2_ - 0.5 >> 0;
               }
            }
         }
         else
         {
            while(--_loc4_ > -1)
            {
               _loc3_ = _tweens[_loc4_];
               _loc3_.target[_loc3_.property] = _loc3_.start + _loc3_.change * param1;
            }
         }
      }
      
      public function set changeFactor(param1:Number) : void
      {
         updateTweens(param1);
         _changeFactor = param1;
      }
      
      public function get changeFactor() : Number
      {
         return _changeFactor;
      }
      
      public function killProps(param1:Object) : void
      {
         var _loc2_:int = int(this.overwriteProps.length);
         while(--_loc2_ > -1)
         {
            if(this.overwriteProps[_loc2_] in param1)
            {
               this.overwriteProps.splice(_loc2_,1);
            }
         }
         _loc2_ = int(_tweens.length);
         while(--_loc2_ > -1)
         {
            if(PropTween(_tweens[_loc2_]).name in param1)
            {
               _tweens.splice(_loc2_,1);
            }
         }
      }
   }
}

