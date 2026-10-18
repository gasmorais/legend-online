package stage3drender
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.textures.Texture;
   
   public class SimpleAtfLoader extends EventDispatcher
   {
      
      public static var isLoaded:Dictionary = new Dictionary();
      
      private var loaderPriority:int;
      
      protected var _path:String;
      
      public var atfData:Texture;
      
      public var atlData:Object;
      
      private var _isDispose:Boolean = false;
      
      public function SimpleAtfLoader(param1:int)
      {
         super();
         loaderPriority = param1;
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function load(param1:String) : void
      {
         _path = param1.toLowerCase();
         loadAtf(_path + ".a");
      }
      
      protected function loadAtf(param1:String) : void
      {
         LoaderManagerII.instance.load(param1,1,loaderPriority,__atfDataComplete,null,__atfDataErrorComplete);
      }
      
      private function __atfDataComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:ByteArray = null;
         var _loc4_:String = null;
         var _loc3_:ByteArray = null;
         if(_isDispose || !Starling.current)
         {
            return;
         }
         if(param2 && !isLoaded[_path])
         {
            _loc5_ = param2 as ByteArray;
            _loc5_.uncompress();
            _loc4_ = _loc5_.readUTF();
            atlData = JSON.parse(_loc4_);
            _loc3_ = new ByteArray();
            _loc3_.writeBytes(_loc5_,_loc5_.position,_loc5_.bytesAvailable);
            atfData = Texture.fromAtfData(_loc3_);
            Global.avatarAltarTexture[_path] = atfData;
            _loc3_.clear();
            _loc5_.clear();
            isLoaded[_path] = true;
         }
         tryComplete();
      }
      
      private function __atfDataErrorComplete(param1:LoaderInfo, param2:Object) : void
      {
         tryComplete();
      }
      
      private function tryComplete() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         _isDispose = true;
         atlData = null;
         atfData = null;
      }
   }
}

