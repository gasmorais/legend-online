package avatar.data
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class SimpleAvatarInfo
   {
      
      private var _key:String;
      
      private var _rectData:Vector.<Rectangle>;
      
      private var _tileData:Vector.<BitmapData>;
      
      public function SimpleAvatarInfo(param1:uint)
      {
         super();
         _rectData = new Vector.<Rectangle>(param1);
         _tileData = new Vector.<BitmapData>(param1);
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(param1:String) : void
      {
         _key = param1;
      }
      
      public function get rectData() : Vector.<Rectangle>
      {
         return _rectData;
      }
      
      public function set rectData(param1:Vector.<Rectangle>) : void
      {
         _rectData = param1;
      }
      
      public function get tileData() : Vector.<BitmapData>
      {
         return _tileData;
      }
      
      public function set tileData(param1:Vector.<BitmapData>) : void
      {
         _tileData = param1;
      }
      
      public function dispose() : void
      {
         if(_rectData)
         {
            for each(var _loc1_:Rectangle in _rectData)
            {
               _loc1_ = null;
            }
         }
         _rectData = null;
         if(_tileData)
         {
            for each(var _loc2_:BitmapData in _tileData)
            {
               _loc2_.dispose();
            }
         }
         _tileData = null;
      }
   }
}

