package com.pickgliss.loader
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class LoaderSavingManager extends EventDispatcher
   {
      
      public static const SO_OPEN:String = "SharedObject.Flush.Open";
      
      public static const SO_FAILED:String = "SharedObject.Flush.Failed";
      
      public static const SO_SUCCESS:String = "SharedObject.Flush.Success";
      
      public static var OPEN_SHARED:Boolean = true;
      
      private static var _eventDispatcher:LoaderSavingManager;
      
      private static const LOCAL_FILE:String = "7road/files";
      
      private static var _cacheFile:Boolean = false;
      
      private static var _saveTimer:Timer;
      
      private static var _so:SharedObject;
      
      private static var _changed:Boolean;
      
      private static var _save:Array;
      
      private static var _reg:RegExp;
      
      private static var _version:int;
      
      private static var isSetup:Boolean;
      
      private static var _isSaving:Boolean = false;
      
      private static var count:int;
      
      private static var _retryCount:int = 0;
      
      private static var _files:Object = {};
      
      private static const _reg1:RegExp = /http:\/\/[\w|.|:]+\//i;
      
      private static const _reg2:RegExp = /[:|.|\/]/g;
      
      private static var _shape:Shape = new Shape();
      
      public function LoaderSavingManager()
      {
         super();
      }
      
      public static function get eventDispatcher() : LoaderSavingManager
      {
         if(!_eventDispatcher)
         {
            _eventDispatcher = new LoaderSavingManager();
         }
         return _eventDispatcher;
      }
      
      public static function set cacheAble(param1:Boolean) : void
      {
         _cacheFile = param1;
         if(!param1 && _save)
         {
            while(_save.length > 1)
            {
               _save.pop();
            }
            _changed = false;
         }
      }
      
      public static function get cacheAble() : Boolean
      {
         return _cacheFile;
      }
      
      public static function setup() : void
      {
         if(isSetup)
         {
            return;
         }
         _reg = new RegExp(ComponentSetting.RESOURCE_PATH);
         isSetup = true;
         cacheAble = false;
         _save = [];
         loadFilesInLocal(false);
      }
      
      public static function parseUpdate(param1:XML) : Boolean
      {
         var _loc6_:XMLList = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:XMLList = null;
         var _loc2_:Array = null;
         try
         {
            _loc6_ = param1..version;
            for each(var _loc3_:XML in _loc6_)
            {
               _loc8_ = int(_loc3_.@from);
               _loc5_ = int(_loc3_.@to);
               _loc7_ = _loc3_..file;
               _loc2_ = [];
               for each(var _loc4_:XML in _loc7_)
               {
                  _loc2_.push(String(_loc4_.@value));
               }
               applyUpdate(_loc8_,_loc5_,_loc2_);
            }
         }
         catch(e:Error)
         {
            _version = -1;
            if(_so)
            {
               _so.data["data"] = _files = {};
            }
            _changed = true;
         }
         saveFilesToLocal();
         return _changed;
      }
      
      public static function applyUpdate(param1:int, param2:int, param3:Array) : void
      {
         var _loc8_:Array = null;
         var _loc6_:String = null;
         var _loc4_:Array = null;
         if(param2 <= param1)
         {
            return;
         }
         if(_version < param2)
         {
            if(_version < param1)
            {
               _so.data["data"] = _files = {};
            }
            else
            {
               _loc8_ = [];
               for each(var _loc5_:String in param3)
               {
                  _loc6_ = getPath(_loc5_);
                  _loc6_ = _loc6_.replace("*","\\w*");
                  _loc8_.push(new RegExp("^" + _loc6_));
                  _loc8_.push(new RegExp(_loc6_));
               }
               _loc4_ = [];
               for(var _loc7_:String in _files)
               {
                  if(hasUpdate(_loc7_,_loc8_))
                  {
                     _loc4_.push(_loc7_);
                  }
               }
               for each(var _loc9_:String in _loc4_)
               {
                  delete _files[_loc9_];
               }
            }
            _version = param2;
            _files["version"] = param2;
            _changed = true;
         }
      }
      
      private static function hasUpdate(param1:String, param2:Array) : Boolean
      {
         for each(var _loc3_:RegExp in param2)
         {
            if(param1.match(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function updateVersionToMD5(param1:Dictionary) : void
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc6_:Array = [];
         for(var _loc5_:String in param1)
         {
            _loc3_ = getPath(_loc5_);
            _loc2_ = _files[_loc3_] == param1[_loc5_];
            _loc4_ = _files[_loc3_] == true || _files[_loc3_] == "7road";
            if(_loc3_ && !_loc2_ && _loc4_)
            {
               _changed = true;
               _files[_loc3_] = param1[_loc5_];
            }
         }
      }
      
      public static function clearFiles(param1:String) : void
      {
         var _loc2_:String = null;
         if(_files)
         {
            _loc2_ = getPath(param1);
            delete _files[_loc2_];
         }
      }
      
      public static function loadFilesInLocal(param1:Boolean = false) : void
      {
         try
         {
            if(!_so)
            {
               _so = SharedObject.getLocal("7road/files","/");
            }
            _so.addEventListener("netStatus",__netStatus);
            _files = _so.data["data"];
            if(_files == null)
            {
               _files = {};
               _so.data["data"] = _files;
               cacheAble = false;
               if(param1)
               {
                  openSO();
               }
            }
            else
            {
               _version = _files["version"];
               cacheAble = true;
               if(param1)
               {
                  openSO();
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function checkCloseShardObject() : int
      {
         var _loc1_:String = null;
         try
         {
            if(!_so)
            {
               _so = SharedObject.getLocal("7road/files","/");
            }
            _loc1_ = _so.flush(20971520);
            if(_loc1_ == "pending")
            {
               eventDispatcher.dispatchEvent(new Event("SharedObject.Flush.Open"));
               return 1;
            }
            cacheAble = true;
            return 2;
         }
         catch(e:Error)
         {
            eventDispatcher.dispatchEvent(new Event("SharedObject.Flush.Failed"));
            var _loc5_:int = 0;
         }
         return _loc5_;
      }
      
      private static function openSO() : void
      {
         if(!OPEN_SHARED)
         {
            return;
         }
         var _loc1_:String = _so.flush(20971520);
         if(_loc1_ == "pending")
         {
            eventDispatcher.dispatchEvent(new Event("SharedObject.Flush.Open"));
         }
         else
         {
            cacheAble = true;
         }
      }
      
      private static function getPath(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("?");
         if(_loc2_ != -1)
         {
            param1 = param1.substring(0,_loc2_);
         }
         param1 = param1.replace(_reg1,"");
         return param1.replace(_reg2,"-");
      }
      
      public static function cleanTempSaveFile() : void
      {
         if(_so == null)
         {
            return;
         }
         _so.data["data"] = _files = {};
         try
         {
            _so.flush();
         }
         catch(error:Error)
         {
         }
         _changed = true;
      }
      
      public static function saveFilesToLocal() : void
      {
         if(!OPEN_SHARED)
         {
            return;
         }
         try
         {
            if(_files && _changed && cacheAble && !_isSaving)
            {
               _isSaving = true;
               _shape.addEventListener("enterFrame",save);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private static function save(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Object = null;
         var _loc5_:SharedObject = null;
         try
         {
            _loc3_ = _so.flush(20971520);
            if(_loc3_ != "pending")
            {
               _loc4_ = getTimer();
               if(_save.length > 0)
               {
                  _loc2_ = _save.shift();
                  if(!_loc2_ || _loc2_.d == null)
                  {
                     return;
                  }
                  _loc5_ = SharedObject.getLocal(_loc2_.p,"/");
                  _loc5_.data["data"] = _loc2_.d;
                  _loc5_.flush();
                  _loc5_ = null;
                  _files[_loc2_.p] = _loc2_.md5;
                  _so.flush();
                  _loc2_.d.clear();
                  _loc2_.d = null;
               }
               if(_save.length == 0)
               {
                  _shape.removeEventListener("enterFrame",save);
                  _changed = false;
                  _isSaving = false;
               }
            }
         }
         catch(e:Error)
         {
            _shape.removeEventListener("enterFrame",save);
            _isSaving = false;
         }
      }
      
      public static function loadCachedFile(param1:String, param2:String = "") : ByteArray
      {
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc6_:SharedObject = null;
         if(!OPEN_SHARED)
         {
            return null;
         }
         if(_files)
         {
            _loc3_ = getPath(param1);
            _loc5_ = getTimer();
            _loc4_ = findInSave(_loc3_);
            if(_loc4_ == null && _files[_loc3_])
            {
               if(_files[_loc3_] == param2)
               {
                  _loc6_ = SharedObject.getLocal(_loc3_,"/");
                  _loc4_ = ByteArray(_loc6_.data["data"]);
               }
               else
               {
                  delete _files[_loc3_];
               }
            }
            if(_loc4_)
            {
               return _loc4_;
            }
            delete _files[_loc3_];
         }
         return null;
      }
      
      private static function findInSave(param1:String) : ByteArray
      {
         for each(var _loc2_:Object in _save)
         {
            if(_loc2_.p == param1)
            {
               return ByteArray(_loc2_.d);
            }
         }
         return null;
      }
      
      public static function cacheFile(param1:String, param2:ByteArray, param3:String = "") : void
      {
         if(!OPEN_SHARED)
         {
            return;
         }
         if(!cacheAble || param2 == null || param2.length == 0)
         {
            return;
         }
         var _loc4_:String = getPath(param1);
         if(_files[_loc4_])
         {
            return;
         }
         if(_files)
         {
            _save.push({
               "p":_loc4_,
               "md5":param3,
               "d":param2
            });
            _changed = true;
            if(_save.length > 200)
            {
               saveFilesToLocal();
            }
         }
      }
      
      private static function __netStatus(param1:NetStatusEvent) : void
      {
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Failed":
               if(_retryCount < 1)
               {
                  try
                  {
                     _so.flush(20971520);
                  }
                  catch(e:Error)
                  {
                  }
                  _retryCount = _retryCount + 1;
               }
               else
               {
                  cacheAble = false;
                  eventDispatcher.dispatchEvent(new Event("SharedObject.Flush.Failed"));
               }
               break;
            case "SharedObject.Flush.Success":
               cacheAble = true;
               eventDispatcher.dispatchEvent(new Event("SharedObject.Flush.Success"));
            default:
               _retryCount = 0;
         }
      }
      
      public static function get hasFileToSave() : Boolean
      {
         return cacheAble && _changed;
      }
      
      public static function checkIsCached(param1:String) : Boolean
      {
         if(_files && _files[getPath(param1)])
         {
            return _files[getPath(param1)];
         }
         for each(var _loc2_:Object in _save)
         {
            if(_loc2_["p"] == getPath(param1))
            {
               return _loc2_["p"];
            }
         }
         return false;
      }
   }
}

