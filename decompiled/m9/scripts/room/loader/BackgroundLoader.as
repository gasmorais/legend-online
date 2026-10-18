package room.loader
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import yishi.manager.PathManager;
   
   public class BackgroundLoader
   {
      
      private var _load:Loader;
      
      private var _callBack:Function;
      
      public function BackgroundLoader()
      {
         super();
         _load = new Loader();
         _load.contentLoaderInfo.addEventListener("complete",__loadCompleteHandler);
         _load.contentLoaderInfo.addEventListener("ioError",__ioErrorHandler);
      }
      
      private function __loadCompleteHandler(param1:Event) : void
      {
         if(_callBack != null)
         {
            _callBack((_load.content as Bitmap).bitmapData.clone());
         }
         dispose();
      }
      
      private function __ioErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private function dispose() : void
      {
         var _loc1_:Bitmap = null;
         if(_load.content)
         {
            _loc1_ = _load.content as Bitmap;
            _loc1_.bitmapData.dispose();
            _loc1_ = null;
         }
         _load.contentLoaderInfo.removeEventListener("complete",__loadCompleteHandler);
         _load.contentLoaderInfo.removeEventListener("ioError",__ioErrorHandler);
         _callBack = null;
         _load = null;
      }
      
      public function loadSyc(param1:String, param2:Function) : void
      {
         _callBack = param2;
         param1 = PathManager.resourcePath + param1;
         _load.load(new URLRequest(param1));
      }
      
      public function loadByUrl(param1:String, param2:Function) : void
      {
         _callBack = param2;
         _load.load(new URLRequest(param1));
      }
   }
}

