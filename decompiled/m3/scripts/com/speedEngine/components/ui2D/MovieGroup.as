package com.speedEngine.components.ui2D
{
   import flash.display.Shape;
   
   public class MovieGroup extends TinyUI
   {
      
      private var _movie:SimpleMovieClip;
      
      private var _hGap:int;
      
      private var _vGap:int;
      
      private var _groupWidth:int;
      
      private var _groupHeight:int;
      
      private var _mask:Shape = new Shape();
      
      public function MovieGroup(param1:SimpleMovieClip = null)
      {
         super();
         movie = param1;
      }
      
      override public function render() : void
      {
         super.render();
         if(_validateDic[STYLE])
         {
            layout();
         }
      }
      
      private function layout() : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:SimpleMovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         if(_groupWidth > 0 && _groupHeight > 0 && _movie)
         {
            _loc8_ = _movie.width;
            _loc3_ = _movie.height;
            _loc2_ = _groupWidth / (_loc8_ + _hGap);
            _loc6_ = _groupHeight / (_loc3_ + _vGap);
            _loc4_ = 0;
            _loc5_ = 0;
            _loc9_ = 0;
            while(_loc9_ < _loc2_)
            {
               _loc4_ = 0;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc1_ = _movie.clone();
                  _loc1_.x = _loc4_;
                  _loc1_.y = _loc5_;
                  addChild(_loc1_);
                  _loc4_ += _loc8_ + _hGap;
                  _loc7_++;
               }
               _loc5_ += _loc3_ + _vGap;
               _loc9_++;
            }
            if(_loc2_ <= 0 || _loc6_ <= 0)
            {
               addChild(_movie);
               _mask.graphics.clear();
               _mask.graphics.beginFill(16711680);
               _mask.graphics.drawRect(0,0,groupWidth,groupHeight);
               _mask.graphics.endFill();
               addChild(_mask);
               _movie.mask = _mask;
            }
         }
         else if(_movie)
         {
            addChild(_movie);
         }
      }
      
      public function get movie() : SimpleMovieClip
      {
         return _movie;
      }
      
      public function set movie(param1:SimpleMovieClip) : void
      {
         _movie = param1;
         _movie.x = _movie.y = 0;
         validate(STYLE);
      }
      
      public function get groupWidth() : int
      {
         return _groupWidth;
      }
      
      public function set groupWidth(param1:int) : void
      {
         _groupWidth = param1;
         validate(STYLE);
      }
      
      public function get groupHeight() : int
      {
         return _groupHeight;
      }
      
      public function set groupHeight(param1:int) : void
      {
         _groupHeight = param1;
         validate(STYLE);
      }
      
      override public function dispose() : void
      {
         if(_movie.parent != this && _movie)
         {
            _movie.dispose();
            _movie = null;
         }
         super.dispose();
      }
   }
}

