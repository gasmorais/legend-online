package map.internals.library
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import yishi.manager.PathManager;
   
   public class MapElmsLibrary
   {
      
      private static var _instance:MapElmsLibrary;
      
      private var sourceList:Dictionary = new Dictionary(true);
      
      private var funList:Dictionary = new Dictionary(true);
      
      private var _useDict:Dictionary = new Dictionary(true);
      
      private var _lockCount:int;
      
      public var isLoaderQueue:Boolean = false;
      
      public function MapElmsLibrary()
      {
         super();
      }
      
      public static function get instance() : MapElmsLibrary
      {
         if(!_instance)
         {
            _instance = new MapElmsLibrary();
         }
         return _instance;
      }
      
      public function getElementSource(param1:String, param2:Function) : void
      {
         param1 = ComponentSetting.getMD5FilePathByUrl(PathManager.resourcePath + param1);
         if(sourceList[param1] != null)
         {
            if(param2 != null)
            {
               param2(sourceList[param1]);
            }
            return;
         }
         if(funList[param1] == null)
         {
            funList[param1] = new Vector.<Function>();
         }
         funList[param1].push(param2);
         createLoad(param1);
         param1 = null;
      }
      
      public function getElementByPath(param1:String) : BitmapData
      {
         return sourceList[param1];
      }
      
      public function saveElement(param1:String, param2:BitmapData) : void
      {
         sourceList[param1] = param2;
      }
      
      private function createLoad(param1:String) : void
      {
         LoaderManagerII.instance.load(param1,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Function = null;
         if(sourceList)
         {
            sourceList[param1.url] = param2 && param2.bitmapData ? param2.bitmapData : new BitmapData(1,1,true,0);
            _loc3_ = funList[param1.url];
            if(_loc3_)
            {
               while(_loc3_.length > 0)
               {
                  _loc4_ = _loc3_.pop();
                  if(_loc4_ != null)
                  {
                     _loc4_(sourceList[param1.url]);
                  }
                  _loc4_ = null;
               }
            }
            _loc3_ = null;
            delete funList[param1.url];
         }
      }
      
      public function lock() : void
      {
         _lockCount = _lockCount + 1;
      }
      
      public function unLock() : void
      {
         _lockCount = _lockCount - 1;
         _lockCount < 0 ? (_lockCount = 0) : _lockCount;
         switchSceneBackImp();
      }
      
      private function isLock() : Boolean
      {
         return _lockCount > 0;
      }
      
      public function switchSceneBack(param1:String) : void
      {
         delete _useDict[param1];
         switchSceneBackImp();
      }
      
      private function switchSceneBackImp() : void
      {
         var _loc5_:Function = null;
         var _loc2_:String = null;
         var _loc4_:BitmapData = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadCompleteHandler);
         if(isLock())
         {
            return;
         }
         var _loc3_:Array = [];
         for each(var _loc1_:Vector.<Function> in funList)
         {
            while(_loc1_.length > 0)
            {
               _loc5_ = _loc1_.pop();
               _loc5_ = null;
            }
            _loc1_ = null;
         }
         for(var _loc6_:String in sourceList)
         {
            _loc3_.push(_loc6_);
         }
         while(_loc3_.length > 0)
         {
            _loc2_ = _loc3_.pop();
            _loc4_ = sourceList[_loc2_];
            delete sourceList[_loc2_];
            if(_loc4_)
            {
               _loc4_.dispose();
            }
            _loc4_ = null;
         }
         _loc3_ = null;
      }
   }
}

