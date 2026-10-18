package org.bytearray.display
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ScaleBitmap extends Bitmap implements Disposeable
   {
      
      protected var _originalBitmap:BitmapData;
      
      protected var _scale9Grid:Rectangle = null;
      
      public function ScaleBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         super(param1,param2,param3);
         _originalBitmap = param1.clone();
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         if(_originalBitmap)
         {
            _originalBitmap.dispose();
         }
         _originalBitmap = null;
         _originalBitmap = param1.clone();
         if(_scale9Grid != null)
         {
            if(!validGrid(_scale9Grid))
            {
               _scale9Grid = null;
            }
            setSize(param1.width,param1.height);
         }
         else
         {
            assignBitmapData(_originalBitmap.clone());
         }
         param1.dispose();
         param1 = null;
      }
      
      public function dispose() : void
      {
         if(_originalBitmap)
         {
            _originalBitmap.dispose();
         }
         _originalBitmap = null;
         if(_scale9Grid)
         {
            _scale9Grid = null;
         }
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         super.bitmapData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function getOriginalBitmapData() : BitmapData
      {
         return _originalBitmap;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 != height)
         {
            setSize(width,param1);
         }
      }
      
      override public function get scale9Grid() : Rectangle
      {
         return _scale9Grid;
      }
      
      override public function set scale9Grid(param1:Rectangle) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(_scale9Grid == null && param1 != null || _scale9Grid != null && !_scale9Grid.equals(param1))
         {
            if(param1 == null)
            {
               _loc2_ = width;
               _loc3_ = height;
               _scale9Grid = null;
               assignBitmapData(_originalBitmap.clone());
               setSize(_loc2_,_loc3_);
            }
            else
            {
               if(!validGrid(param1))
               {
                  throw new Error("#001 - The _scale9Grid does not match the original BitmapData");
               }
               _scale9Grid = param1.clone();
               resizeBitmap(width,height);
               scaleX = 1;
               scaleY = 1;
            }
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(_scale9Grid == null)
         {
            super.width = param1;
            super.height = param2;
         }
         else
         {
            param1 = Math.max(param1,_originalBitmap.width - _scale9Grid.width);
            param2 = Math.max(param2,_originalBitmap.height - _scale9Grid.height);
            resizeBitmap(param1,param2);
         }
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 != width)
         {
            setSize(param1,height);
         }
      }
      
      protected function resizeBitmap(param1:Number, param2:Number) : void
      {
         var _loc9_:Rectangle = null;
         var _loc10_:Rectangle = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:BitmapData = new BitmapData(param1,param2,true,0);
         var _loc11_:Array = [0,_scale9Grid.top,_scale9Grid.bottom,_originalBitmap.height];
         var _loc12_:Array = [0,_scale9Grid.left,_scale9Grid.right,_originalBitmap.width];
         var _loc5_:Array = [0,_scale9Grid.top,param2 - (_originalBitmap.height - _scale9Grid.bottom),param2];
         var _loc7_:Array = [0,_scale9Grid.left,param1 - (_originalBitmap.width - _scale9Grid.right),param1];
         var _loc3_:Matrix = new Matrix();
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               _loc9_ = new Rectangle(_loc12_[_loc6_],_loc11_[_loc8_],_loc12_[_loc6_ + 1] - _loc12_[_loc6_],_loc11_[_loc8_ + 1] - _loc11_[_loc8_]);
               _loc10_ = new Rectangle(_loc7_[_loc6_],_loc5_[_loc8_],_loc7_[_loc6_ + 1] - _loc7_[_loc6_],_loc5_[_loc8_ + 1] - _loc5_[_loc8_]);
               _loc3_.identity();
               _loc3_.a = _loc10_.width / _loc9_.width;
               _loc3_.d = _loc10_.height / _loc9_.height;
               _loc3_.tx = _loc10_.x - _loc9_.x * _loc3_.a;
               _loc3_.ty = _loc10_.y - _loc9_.y * _loc3_.d;
               _loc4_.draw(_originalBitmap,_loc3_,null,null,_loc10_,smoothing);
               _loc8_++;
            }
            _loc6_++;
         }
         assignBitmapData(_loc4_);
         _loc4_ = null;
      }
      
      private function assignBitmapData(param1:BitmapData) : void
      {
         super.bitmapData.dispose();
         super.bitmapData = param1;
      }
      
      private function validGrid(param1:Rectangle) : Boolean
      {
         return param1.right <= _originalBitmap.width && param1.bottom <= _originalBitmap.height;
      }
   }
}

