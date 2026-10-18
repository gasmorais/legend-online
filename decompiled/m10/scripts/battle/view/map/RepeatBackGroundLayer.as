package battle.view.map
{
   import battle.data.BattleBackGroundData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class RepeatBackGroundLayer extends Sprite implements IEnterFrame
   {
      
      private var _bitmapdata:BitmapData;
      
      private var _x:Number = 0;
      
      private var _xOffset:Number = 0;
      
      private var _moveSpeed:Number = 0;
      
      private var _shape:Shape;
      
      private var _matrix:Matrix;
      
      private var _bitmap:Bitmap;
      
      protected var _asset:DisplayObject;
      
      private var _inited:Boolean;
      
      private var _transparent:Boolean;
      
      private var timeOutId:int;
      
      private var _groundData:BattleBackGroundData;
      
      public function RepeatBackGroundLayer(param1:DisplayObject, param2:BitmapData = null, param3:Boolean = true)
      {
         super();
         _asset = param1;
         _transparent = param3;
         addChild(_asset);
      }
      
      private function init() : void
      {
         _bitmapdata = drawBitmap();
         _shape = new Shape();
         _shape.y = _asset.y;
         addChild(_shape);
         _matrix = new Matrix();
         refreshView();
      }
      
      private function getBitmap() : Bitmap
      {
         return new Bitmap(_bitmapdata,"auto",false);
      }
      
      private function drawBitmap() : BitmapData
      {
         if(!_bitmapdata)
         {
            _bitmapdata = new BitmapData(1500,_asset.height,_transparent,0);
            _bitmapdata.draw(_asset,new Matrix(1,0,0,1,_asset.x));
         }
         return _bitmapdata;
      }
      
      override public function set x(param1:Number) : void
      {
         if(_x == param1)
         {
            return;
         }
         _x = param1;
         refreshView();
      }
      
      override public function get x() : Number
      {
         return _x;
      }
      
      private function refreshView() : void
      {
         if(!_bitmapdata)
         {
            return;
         }
         var _loc1_:Number = (x + _xOffset) % 1500;
         _matrix.tx = _loc1_;
         _shape.graphics.clear();
         _shape.graphics.beginBitmapFill(_bitmapdata,_matrix);
         _shape.graphics.drawRect(0,0,_bitmapdata.width,_bitmapdata.height);
         _shape.graphics.endFill();
      }
      
      public function get moveSpeed() : Number
      {
         return _moveSpeed;
      }
      
      public function set moveSpeed(param1:Number) : void
      {
         _moveSpeed = param1;
         if(param1 != 0)
         {
            EnterFrameManager.instance.registeEnterFrame(this);
            if(!_inited)
            {
               timeOutId = setTimeout(delayInitBmd,1750);
               _inited = true;
            }
         }
         else
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      private function delayInitBmd() : void
      {
         clearTimeout(timeOutId);
         timeOutId = 0;
         if(_asset)
         {
            init();
            removeChild(_asset);
            _asset = null;
         }
      }
      
      public function setParaData(param1:BattleBackGroundData) : void
      {
         _groundData = param1;
      }
      
      public function getParaData() : BattleBackGroundData
      {
         return _groundData;
      }
      
      public function enterFrame() : void
      {
         if(!_bitmapdata)
         {
            return;
         }
         _xOffset += moveSpeed;
         refreshView();
      }
      
      private function __enterFrame(param1:Event) : void
      {
         _xOffset += moveSpeed;
         refreshView();
      }
      
      public function dispose() : void
      {
         moveSpeed = 0;
         if(_bitmapdata)
         {
            _bitmapdata.dispose();
            _bitmapdata = null;
         }
         if(_bitmap)
         {
            if(_bitmap.parent)
            {
               removeChild(_bitmap);
            }
            _bitmap.bitmapData.dispose();
            _bitmap = null;
         }
         if(_shape)
         {
            if(_shape.parent)
            {
               _shape.parent.removeChild(_shape);
            }
            _shape.graphics.clear();
            _shape = null;
         }
         if(_asset)
         {
            if(_asset.parent)
            {
               _asset.parent.removeChild(_asset);
            }
         }
         _asset = null;
      }
   }
}

