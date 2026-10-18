package stage3drender.map
{
   import flash.utils.Dictionary;
   
   public class MapPiecesManager
   {
      
      private static var mInstance:MapPiecesManager = null;
      
      public var currentBlock:Array = [];
      
      public var oldBlock:Array;
      
      public var mBlockTextureCache:Dictionary = new Dictionary();
      
      public function MapPiecesManager()
      {
         super();
      }
      
      public static function get instance() : MapPiecesManager
      {
         if(!mInstance)
         {
            mInstance = new MapPiecesManager();
         }
         return mInstance;
      }
      
      public function excuteLoad(param1:String, param2:Function) : void
      {
      }
   }
}

