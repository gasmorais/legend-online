package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.core.*;
   import flash.display.*;
   import flash.filters.*;
   
   public class FilterPlugin extends TweenPlugin
   {
      
      public static const VERSION:Number = 2.03;
      
      public static const API:Number = 1;
      
      protected var _target:Object;
      
      protected var _type:Class;
      
      protected var _filter:BitmapFilter;
      
      protected var _index:int;
      
      protected var _remove:Boolean;
      
      public function FilterPlugin()
      {
         super();
      }
      
      protected function initFilter(param1:Object, param2:BitmapFilter, param3:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc8_:HexColorsPlugin = null;
         var _loc7_:Array = _target.filters;
         var _loc6_:Object = param1 is BitmapFilter ? {} : param1;
         _index = -1;
         if(_loc6_.index != null)
         {
            _index = _loc6_.index;
         }
         else
         {
            _loc5_ = int(_loc7_.length);
            while(_loc5_--)
            {
               if(_loc7_[_loc5_] is _type)
               {
                  _index = _loc5_;
                  break;
               }
            }
         }
         if(_index == -1 || _loc7_[_index] == null || _loc6_.addFilter == true)
         {
            _index = _loc6_.index != null ? _loc6_.index : _loc7_.length;
            _loc7_[_index] = param2;
            _target.filters = _loc7_;
         }
         _filter = _loc7_[_index];
         if(_loc6_.remove == true)
         {
            _remove = true;
            this.onComplete = onCompleteTween;
         }
         _loc5_ = int(param3.length);
         while(_loc5_--)
         {
            _loc4_ = param3[_loc5_];
            if(_loc4_ in param1 && _filter[_loc4_] != param1[_loc4_])
            {
               if(_loc4_ == "color" || _loc4_ == "highlightColor" || _loc4_ == "shadowColor")
               {
                  _loc8_ = new HexColorsPlugin();
                  _loc8_.initColor(_filter,_loc4_,_filter[_loc4_],param1[_loc4_]);
                  _tweens[_tweens.length] = new PropTween(_loc8_,"changeFactor",0,1,_loc4_,false);
               }
               else if(_loc4_ == "quality" || _loc4_ == "inner" || _loc4_ == "knockout" || _loc4_ == "hideObject")
               {
                  _filter[_loc4_] = param1[_loc4_];
               }
               else
               {
                  addTween(_filter,_loc4_,_filter[_loc4_],param1[_loc4_],_loc4_);
               }
            }
         }
      }
      
      public function onCompleteTween() : void
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         if(_remove)
         {
            _loc2_ = _target.filters;
            if(!(_loc2_[_index] is _type))
            {
               _loc1_ = int(_loc2_.length);
               while(_loc1_--)
               {
                  if(_loc2_[_loc1_] is _type)
                  {
                     _loc2_.splice(_loc1_,1);
                     break;
                  }
               }
            }
            else
            {
               _loc2_.splice(_index,1);
            }
            _target.filters = _loc2_;
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:PropTween = null;
         var _loc3_:int = int(_tweens.length);
         var _loc4_:Array = _target.filters;
         while(_loc3_--)
         {
            _loc2_ = _tweens[_loc3_];
            _loc2_.target[_loc2_.property] = _loc2_.start + _loc2_.change * param1;
         }
         if(!(_loc4_[_index] is _type))
         {
            _loc3_ = _index = _loc4_.length;
            while(_loc3_--)
            {
               if(_loc4_[_loc3_] is _type)
               {
                  _index = _loc3_;
                  break;
               }
            }
         }
         _loc4_[_index] = _filter;
         _target.filters = _loc4_;
      }
   }
}

