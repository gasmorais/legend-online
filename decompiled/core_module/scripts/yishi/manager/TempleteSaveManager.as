package yishi.manager
{
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class TempleteSaveManager
   {
      
      public static const SWITCH:Boolean = false;
      
      private static const LOCAL_FILE:String = "7road/templetes";
      
      private static var _instance:TempleteSaveManager;
      
      private static var _single:Boolean = true;
      
      private var _preSaveList:Array = [];
      
      private var _preSaveData:ByteArray;
      
      private var _preSaveName:String = null;
      
      private var _preSaveVersions:uint = 0;
      
      private var _isMate:Boolean = true;
      
      private var _timer:uint;
      
      public function TempleteSaveManager()
      {
         super();
         if(_single)
         {
            throw new Error("please use instance...");
         }
      }
      
      public static function get instance() : TempleteSaveManager
      {
         if(_instance == null)
         {
            _single = false;
            _instance = new TempleteSaveManager();
            _single = true;
         }
         return _instance;
      }
      
      public function save(param1:*, param2:String) : void
      {
         return;
         _preSaveList[_preSaveList.length] = {
            "n":param2,
            "d":param1
         };
      }
      
      public function load(param1:String) : *
      {
         var _loc5_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc2_:Object = null;
         return null;
         if(!_isMate)
         {
            return null;
         }
         var _loc6_:SharedObject = SharedObject.getLocal("7road/templetes","/");
         if(_loc6_.data["data"] == null)
         {
            return null;
         }
         var _loc3_:ByteArray = ByteArray(_loc6_.data["data"][param1]);
         if(_loc3_ != null)
         {
            _loc5_ = new ByteArray();
            _loc3_.readBytes(_loc5_);
            _loc3_.position = 0;
            _loc5_.uncompress();
            _loc5_.position = _loc5_.bytesAvailable - 4;
            _loc4_ = _loc5_.readInt();
            if(_loc5_.length - 4 != _loc4_)
            {
               return null;
            }
            _loc5_.position = 0;
            _loc2_ = _loc5_.readObject();
            _loc5_.clear();
            _loc5_ = null;
            return _loc2_;
         }
         return null;
      }
      
      public function startSave() : void
      {
         stopSave();
         if(_preSaveList.length == 0 && _preSaveData == null)
         {
            return;
         }
         _timer = setInterval(__timerCall,10000);
      }
      
      private function __timerCall() : void
      {
         var _loc1_:Object = null;
         if(_preSaveVersions != 0)
         {
            saveVersions();
         }
         else if(_preSaveData)
         {
            saveData();
         }
         else
         {
            if(_preSaveList.length == 0)
            {
               stopSave();
               return;
            }
            _loc1_ = _preSaveList.shift();
            shiftData(_loc1_);
         }
      }
      
      private function shiftData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.n;
         var _loc3_:Object = param1.d;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeObject(_loc3_);
         var _loc4_:int = int(_loc5_.length);
         _loc5_.writeInt(_loc4_);
         _loc5_.position = 0;
         _loc5_.compress();
         if(_preSaveData)
         {
            _preSaveData.clear();
            _preSaveData = null;
         }
         _preSaveData = _loc5_;
         _preSaveName = _loc2_;
         param1.d = null;
         param1.n = null;
      }
      
      private function saveData() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal("7road/templetes","/");
         if(_loc1_.data["data"] == null)
         {
            _loc1_.data["data"] = {};
         }
         _loc1_.data["data"][_preSaveName] = _preSaveData;
         try
         {
            _loc1_.flush();
            _loc1_ = null;
         }
         catch(error:Error)
         {
            trace(error.message);
         }
         _preSaveData = null;
         _preSaveName = null;
         if(_preSaveList.length == 0)
         {
            stopSave();
         }
      }
      
      private function saveVersions() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal("7road/templetes","/");
         _loc1_.data["Versions"] = _preSaveVersions;
         try
         {
            _loc1_.flush();
         }
         catch(error:Error)
         {
            trace(error.message);
         }
         _preSaveVersions = 0;
      }
      
      public function stopSave() : void
      {
         if(_timer != 0)
         {
            clearInterval(_timer);
            _timer = 0;
         }
      }
      
      public function checkVersions(param1:uint) : void
      {
         return;
         var _loc3_:SharedObject = SharedObject.getLocal("7road/templetes","/");
         var _loc2_:uint = uint(_loc3_.data["Versions"]);
         if(_loc2_ == param1)
         {
            return;
         }
         if(_preSaveVersions == 0)
         {
            _isMate = false;
         }
         _preSaveVersions = param1;
      }
      
      public function clean() : void
      {
         _preSaveList = [];
         _preSaveData = null;
         stopSave();
         var _loc2_:SharedObject = SharedObject.getLocal("7road/templetes","/");
         var _loc1_:Object = _loc2_.data;
         if(_loc1_["Versions"] != null)
         {
            _loc1_["Versions"] = null;
            delete _loc1_["Versions"];
         }
         if(_loc1_["data"] != null)
         {
            _loc1_["data"] = null;
            delete _loc1_["data"];
         }
         try
         {
            _loc2_.flush();
         }
         catch(error:Error)
         {
            trace(error.message);
         }
      }
   }
}

