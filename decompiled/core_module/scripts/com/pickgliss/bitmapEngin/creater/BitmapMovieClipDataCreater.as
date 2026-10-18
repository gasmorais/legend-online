package com.pickgliss.bitmapEngin.creater
{
   import com.pickgliss.bitmapEngin.cache.CacheFrame;
   import com.pickgliss.bitmapEngin.mode.BitmapMovieClipData;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BitmapMovieClipDataCreater
   {
      
      private static const STEP_COUNT:int = 8;
      
      private var _mc:MovieClip;
      
      private var _id:String;
      
      private var _async:Boolean;
      
      private var _data:BitmapMovieClipData;
      
      private var _currentFrame:int;
      
      private var _timeId:int;
      
      public function BitmapMovieClipDataCreater(param1:MovieClip, param2:String, param3:Boolean)
      {
         super();
         _mc = param1;
         _id = param2;
         _async = param3;
         _currentFrame = 1;
      }
      
      public static function create(param1:MovieClip, param2:String, param3:Boolean) : BitmapMovieClipData
      {
         var _loc4_:BitmapMovieClipDataCreater = new BitmapMovieClipDataCreater(param1,param2,param3);
         return _loc4_.create();
      }
      
      private function create() : BitmapMovieClipData
      {
         _data = new BitmapMovieClipData();
         _data.id = _id;
         _data.frames = new Vector.<CacheFrame>();
         _data.labels = _mc.currentLabels;
         if(!_async)
         {
            createFrames(_mc.totalFrames);
            _data.inited = true;
            _mc = null;
         }
         else
         {
            startCreateByAsync();
         }
         return _data;
      }
      
      private function startCreateByAsync() : void
      {
         createStep();
      }
      
      private function createStep() : void
      {
         var _loc1_:int = _mc.totalFrames - _currentFrame + 1;
         if(_loc1_ > 8)
         {
            _loc1_ = 8;
         }
         createFrames(_loc1_);
         _currentFrame += _loc1_;
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         if(_currentFrame < _mc.totalFrames)
         {
            _timeId = setTimeout(createStep,10);
         }
         else
         {
            _data.inited = true;
            _mc = null;
         }
      }
      
      private function createFrames(param1:int) : void
      {
         var _loc8_:Rectangle = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:BitmapData = null;
         if(_mc == null || _data == null)
         {
            return;
         }
         var _loc7_:Matrix = new Matrix();
         var _loc4_:int = _currentFrame + param1;
         _loc3_ = _currentFrame;
         while(_loc3_ < _loc4_)
         {
            _mc.gotoAndStop(_loc3_);
            _loc8_ = _mc.getBounds(_mc);
            _loc7_.identity();
            _loc11_ = -_loc8_.x;
            _loc12_ = -_loc8_.y;
            _loc6_ = _mc.numChildren;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc13_ = _mc.getChildAt(_loc5_) as MovieClip;
               if(_loc13_)
               {
                  if(_loc13_.currentFrame != _loc13_.totalFrames)
                  {
                     _loc13_.gotoAndStop(_loc13_.currentFrame + 1);
                  }
                  else
                  {
                     _loc13_.gotoAndStop(1);
                  }
               }
               _loc5_++;
            }
            _loc7_.translate(_loc11_,_loc12_);
            _loc10_ = _mc.width;
            _loc2_ = _mc.height;
            _loc10_ = int(_loc10_ > 0 ? _loc10_ : 1);
            _loc2_ = int(_loc2_ > 0 ? _loc2_ : 1);
            _loc9_ = new BitmapData(_loc10_,_loc2_,true,0);
            _loc9_.draw(_mc,_loc7_);
            _data.frames.push(new CacheFrame(_loc9_,_loc11_,_loc12_));
            _loc9_ = null;
            _loc3_++;
         }
      }
   }
}

