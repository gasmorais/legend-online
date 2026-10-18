package map.space
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BgTileInfo
   {
      
      private var _tx:int;
      
      private var _ty:int;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _key:String;
      
      private var _isLoaded:Boolean;
      
      private var _size:Number;
      
      private var _tileView:Bitmap;
      
      public var mapTemplate:int;
      
      private var _parent:Sprite;
      
      public function BgTileInfo(param1:int, param2:int, param3:Number, param4:int, param5:Sprite, param6:Boolean = false)
      {
         super();
         _tx = param1;
         _ty = param2;
         _parent = param5;
         _size = param3;
         if(param6)
         {
            _key = _ty + "_" + _tx;
         }
         else
         {
            _key = _tx + "_" + _ty;
         }
         _x = param1 * param3;
         _y = param2 * param3;
         mapTemplate = param4;
      }
      
      public function get tileView() : Bitmap
      {
         return _tileView;
      }
      
      public function set tileView(param1:Bitmap) : void
      {
         _tileView = param1;
         if(_tileView)
         {
            _isLoaded = true;
            _tileView.x = _x;
            _tileView.y = _y;
            _parent.addChild(param1);
         }
      }
      
      public function get size() : Number
      {
         return _size;
      }
      
      public function get isLoaded() : Boolean
      {
         return _isLoaded;
      }
      
      public function set isLoaded(param1:Boolean) : void
      {
         _isLoaded = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get ty() : int
      {
         return _ty;
      }
      
      public function get tx() : int
      {
         return _tx;
      }
   }
}

