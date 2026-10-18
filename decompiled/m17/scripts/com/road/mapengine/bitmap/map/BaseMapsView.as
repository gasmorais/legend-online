package com.road.mapengine.bitmap.map
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BaseMapsView extends Bitmap implements Disposeable
   {
      
      private var _data:BaseMapsData;
      
      public function BaseMapsView(param1:String = "auto", param2:Boolean = false)
      {
         super(new BitmapData(1,1),param1,param2);
      }
      
      public function set data(param1:BaseMapsData) : void
      {
         _data = param1;
         var _loc2_:BitmapData = new BitmapData(_data.mapWidth,_data.mapHeight);
         bitmapData = _loc2_;
         render();
      }
      
      private function render() : void
      {
         var _loc2_:* = null;
         var _loc5_:BitmapData = null;
         var _loc1_:Rectangle = new Rectangle();
         var _loc4_:Point = new Point();
         var _loc3_:Array = _data.indexArray;
         bitmapData.lock();
         drawBack();
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_["baseNum"] <= 101)
            {
               throw new Error(_loc2_.baseNum);
            }
            _loc5_ = _data.getBitmapDataById(_loc2_.url);
            if(_loc5_)
            {
               _loc4_.x = _loc2_.x;
               _loc4_.y = _loc2_.y;
               _loc1_.width = _loc5_.width;
               _loc1_.height = _loc5_.height;
               bitmapData.copyPixels(_loc5_,_loc1_,_loc4_,null,null,true);
            }
         }
         bitmapData.unlock();
         cacheAsBitmap = false;
      }
      
      private function drawBack() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:BitmapData = _data.getBitmapDataById(_data.backUrl);
         var _loc3_:int = _loc1_.width;
         var _loc9_:int = _loc1_.height;
         var _loc8_:int = Math.ceil(this.width / _loc3_);
         var _loc2_:int = Math.ceil(this.height / _loc9_);
         var _loc4_:Rectangle = new Rectangle(0,0,_loc3_,_loc9_);
         var _loc7_:Point = new Point();
         if(_loc1_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc7_.x = _loc5_ * _loc3_;
                  _loc7_.y = _loc6_ * _loc9_;
                  bitmapData.copyPixels(_loc1_,_loc4_,_loc7_);
                  _loc6_++;
               }
               _loc5_++;
            }
         }
      }
      
      public function dispose() : void
      {
         _data = null;
         this.bitmapData.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

