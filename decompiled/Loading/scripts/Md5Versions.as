package
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.vo.FileVo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Md5Versions
   {
      
      private var _md5Complete:Function;
      
      private var _codeComplete:Function;
      
      private var _resComplete:Function;
      
      private var _md5Progress:Function;
      
      private var _codeProgress:Function;
      
      private var _resProgress:Function;
      
      private var _versionXml:XMLList;
      
      private var _checkXml:XMLList;
      
      private var _versionLen:int;
      
      private var _checkLen:int;
      
      private var _enterFrame:int = 0;
      
      private var _count:int = 100;
      
      private var _currCount:int = 0;
      
      private var _maxTime:int = 40;
      
      private var _sprite:Sprite;
      
      public function Md5Versions(param1:Function, param2:Function = null)
      {
         super();
         _md5Complete = param1;
         _md5Progress = param2;
         loadCode(md5CodeComplete,_md5Progress);
      }
      
      private function md5CodeComplete() : void
      {
         loadRes(_md5Complete,_md5Progress);
      }
      
      private function enterFrame(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc5_:int = getTimer();
         var _loc6_:RegExp = /[\\]/g;
         _loc4_ = 0;
         while(_loc4_ < 100)
         {
            if(_currCount > _versionLen)
            {
               break;
            }
            _loc2_ = checkVersion(_loc5_,_currCount,_currCount + _count);
            _currCount += _count;
            if(_loc2_)
            {
               return;
            }
            _loc4_++;
         }
         if(_currCount < _versionLen)
         {
            return;
         }
         if(_sprite)
         {
            _sprite.removeEventListener("enterFrame",enterFrame);
         }
         if(_resComplete != null)
         {
            _resComplete();
         }
      }
      
      private function checkVersion(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:XML = null;
         var _loc6_:String = null;
         var _loc9_:FileVo = null;
         var _loc7_:int = 0;
         var _loc5_:int = getTimer();
         var _loc8_:RegExp = /[\\]/g;
         if(param3 > _versionLen)
         {
            param3 = _versionLen;
         }
         _loc7_ = param2;
         while(_loc7_ < param3)
         {
            _loc4_ = _versionXml[_loc7_];
            _loc6_ = ComponentSetting.RESOURCE_PATH + String(_loc4_.@name);
            _loc6_ = _loc6_.replace(_loc8_,"/");
            _loc9_ = new FileVo();
            _loc9_.md5 = _loc4_.@md5;
            _loc9_.size = _loc4_.@size;
            ComponentSetting.md5Dic[_loc6_] = _loc9_;
            _loc7_++;
         }
         return getTimer() - param1 >= _maxTime;
      }
      
      private function loadCode(param1:Function, param2:Function = null) : void
      {
         _codeComplete = param1;
         _codeProgress = param2;
         var _loc5_:String = new Date().time.toString();
         var _loc3_:String = "code_md5.dat";
         if(DisplayLoader.isDebug)
         {
            _loc3_ = "md5.zip";
         }
         var _loc4_:URLVariables = new URLVariables();
         _loc4_["rnd"] = _loc5_;
         LoaderManagerII.instance.load(_loc3_,1,8,__codemd5XmlLoadComplete,__codemd5XmlLoadProgressHandler,null,null,_loc4_);
      }
      
      private function loadRes(param1:Function, param2:Function = null) : void
      {
         _resComplete = param1;
         _resProgress = param2;
         var _loc3_:String = new Date().time.toString();
         var _loc4_:String = "res_md5.dat";
         if(DisplayLoader.isOldres)
         {
            _loc4_ = "md5.zip";
         }
         var _loc5_:URLVariables = new URLVariables();
         _loc5_["rnd"] = _loc3_;
         LoaderManagerII.instance.load(_loc4_,1,8,__md5XmlLoadComplete,__md5XmlLoadProgressHandler,null,null,_loc5_);
      }
      
      private function __codemd5XmlLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc7_:String = null;
         var _loc9_:FileVo = null;
         var _loc3_:ByteArray = param2 as ByteArray;
         if(_loc3_)
         {
            _loc3_.uncompress();
            _loc3_.uncompress();
            _loc3_.position = 0;
         }
         var _loc8_:RegExp = /[\\]/g;
         var _loc4_:XML = new XML(_loc3_);
         var _loc6_:XMLList = _loc4_..version..Item;
         for each(var _loc5_:XML in _loc6_)
         {
            _loc7_ = DisplayLoader.isDebug ? String(_loc5_.@name) : ComponentSetting.RESOURCE_PATH + String(_loc5_.@name);
            _loc7_ = _loc7_.replace(_loc8_,"/");
            _loc9_ = new FileVo();
            _loc9_.md5 = _loc5_.@md5;
            _loc9_.size = _loc5_.@size;
            ComponentSetting.md5Dic[_loc7_] = _loc9_;
         }
         if(_codeComplete != null)
         {
            _codeComplete();
         }
      }
      
      private function __md5XmlLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ByteArray = param2 as ByteArray;
         if(_loc3_)
         {
            _loc3_.uncompress();
            _loc3_.uncompress();
            _loc3_.position = 0;
         }
         var _loc4_:XML = new XML(_loc3_);
         _versionXml = _loc4_..version..Item;
         _checkXml = _loc4_..check..Item;
         _versionLen = _versionXml.length();
         _checkLen = _checkXml.length();
         _sprite = new Sprite();
         _sprite.addEventListener("enterFrame",enterFrame);
      }
      
      private function __codemd5XmlLoadProgressHandler(param1:LoaderInfo) : void
      {
         if(_codeProgress != null)
         {
            _codeProgress(param1);
         }
         if(_md5Progress != null)
         {
            _md5Progress(param1);
         }
      }
      
      private function __md5XmlLoadProgressHandler(param1:LoaderInfo) : void
      {
         if(_resProgress != null)
         {
            _resProgress(param1);
         }
         if(_md5Progress != null)
         {
            _md5Progress(param1);
         }
      }
   }
}

