package avatar.view
{
   import avatar.data.SimpleAvatarInfo;
   import avatar.utils.SimpleAvatarPool;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SimpleAvatarView extends Bitmap implements Disposeable
   {
      
      private var _url:String;
      
      private var _frameX:int;
      
      private var _frameY:int;
      
      private var _curFrameX:int;
      
      private var _curFrameY:int;
      
      private var _unitWidth:int;
      
      private var _unitHeight:int;
      
      private var _drawFrame:int = 3;
      
      private var _curDrawFrame:int;
      
      private var _simpleAvatarInfo:SimpleAvatarInfo;
      
      private var _viewX:Number;
      
      private var _viewY:Number;
      
      private var _curFrameIndex:int;
      
      private var _clearRect:Rectangle;
      
      private var _drawRect:Rectangle;
      
      public function SimpleAvatarView(param1:Number, param2:Number, param3:String, param4:int = 12, param5:int = 1, param6:String = "auto", param7:Boolean = false)
      {
         _frameX = param4;
         _frameY = param5;
         _url = param3;
         _clearRect = new Rectangle(0,0,param1,param2);
         _drawRect = new Rectangle(0,0,param1,param2);
         _unitWidth = param1;
         _unitHeight = param2;
         super(null,param6,param7);
         init();
         this.scrollRect = null;
      }
      
      public function set drawFrame(param1:int) : void
      {
         _drawFrame = param1;
      }
      
      private function init() : void
      {
         var _loc1_:int = 5;
         if(LoaderManagerII.instance.isLoaded(_url))
         {
            _loc1_ = 0;
         }
         LoaderManagerII.instance.load(_url,2,_loc1_,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is Bitmap)
         {
            initSimpleAvatarInfo((param2 as Bitmap).bitmapData);
         }
         ObjectUtils.disposeObject(param2);
      }
      
      public function initSimpleAvatarInfo(param1:BitmapData) : void
      {
         var _loc4_:BitmapData = null;
         var _loc7_:Rectangle = null;
         var _loc6_:Rectangle = null;
         var _loc3_:BitmapData = null;
         var _loc5_:int = 0;
         if(!_drawRect)
         {
            return;
         }
         if(SimpleAvatarPool.instance.hasSimpleAvatar(_url))
         {
            _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_url);
            return;
         }
         if(SimpleAvatarPool.instance.existSimpleAvatarLoader(_url))
         {
            return;
         }
         SimpleAvatarPool.instance.registerSimpleAvatarLoader(_url);
         var _loc2_:int = _frameX * _frameY;
         _simpleAvatarInfo = new SimpleAvatarInfo(_loc2_);
         _loc3_ = new BitmapData(_unitWidth,_unitHeight,true,0);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _curFrameX = _curFrameX + 1;
            if(_curFrameX >= _frameX)
            {
               _curFrameX = 0;
               _curFrameY = _curFrameY + 1;
            }
            if(_curFrameY >= _frameY)
            {
               _curFrameY = 0;
            }
            _drawRect.x = _curFrameX * _unitWidth;
            _drawRect.y = _curFrameY * _unitHeight;
            _loc3_.lock();
            _loc3_.fillRect(_clearRect,0);
            _loc3_.copyPixels(param1,_drawRect,new Point(0,0),null,null,true);
            _loc3_.unlock();
            _loc7_ = _loc3_.getColorBoundsRect(4278190080,0,false);
            _loc6_ = new Rectangle(0,0,_loc7_.width,_loc7_.height);
            _loc4_ = new BitmapData(_loc7_.width,_loc7_.height,true,0);
            _loc4_.lock();
            _loc4_.fillRect(_loc6_,0);
            _loc4_.copyPixels(_loc3_,_loc7_,new Point(0,0),null,null,true);
            _loc4_.unlock();
            _simpleAvatarInfo.rectData[_loc5_] = _loc7_;
            _simpleAvatarInfo.tileData[_loc5_] = _loc4_;
            _loc5_++;
         }
         SimpleAvatarPool.instance.addSimpleAvatar(_url,_simpleAvatarInfo);
         SimpleAvatarPool.instance.unregisterSimpleAvatarLoader(_url);
      }
      
      public function draw() : void
      {
         _curDrawFrame = _curDrawFrame + 1;
         if(_curDrawFrame < _drawFrame)
         {
            return;
         }
         _curDrawFrame = 0;
         if(_simpleAvatarInfo)
         {
            _curFrameX = _curFrameX + 1;
            if(_curFrameX >= _frameX)
            {
               _curFrameX = 0;
               _curFrameY = _curFrameY + 1;
            }
            if(_curFrameY >= _frameY)
            {
               _curFrameY = 0;
            }
            _curFrameIndex = _curFrameX + _curFrameY * _frameX;
            if(_simpleAvatarInfo.tileData[_curFrameIndex])
            {
               super.x = _viewX + _simpleAvatarInfo.rectData[_curFrameIndex].x;
               super.y = _viewY + _simpleAvatarInfo.rectData[_curFrameIndex].y;
               this.bitmapData = _simpleAvatarInfo.tileData[_curFrameIndex];
            }
         }
         else
         {
            _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_url);
         }
      }
      
      override public function set x(param1:Number) : void
      {
         if(_viewX == param1)
         {
            return;
         }
         _viewX = param1;
         super.x = _viewX;
      }
      
      override public function set y(param1:Number) : void
      {
         if(_viewY == param1)
         {
            return;
         }
         _viewY = param1;
         super.y = _viewY;
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadCompleteHandler);
         bitmapData = null;
         _clearRect = null;
         _drawRect = null;
         if(_simpleAvatarInfo)
         {
            SimpleAvatarPool.instance.releaseSimpleAvatar(_simpleAvatarInfo.key);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get unitWidth() : int
      {
         return _unitWidth;
      }
      
      public function get unitHeight() : int
      {
         return _unitHeight;
      }
      
      override public function get height() : Number
      {
         return _unitHeight;
      }
      
      override public function get width() : Number
      {
         return _unitWidth;
      }
   }
}

