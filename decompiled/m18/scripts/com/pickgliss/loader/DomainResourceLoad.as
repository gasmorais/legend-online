package com.pickgliss.loader
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.loaderii.LoaderEventII;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class DomainResourceLoad extends EventDispatcher
   {
      
      public static const B_SWF:String = ".bswf";
      
      private static var _loaderContext:LoaderContext;
      
      private static var loaderList:Dictionary = new Dictionary();
      
      private var _tempLoad:Loader;
      
      public var info:com.pickgliss.loader.data.LoaderInfo;
      
      private var swfBytes:ByteArray;
      
      private var _data:ByteArray;
      
      public function DomainResourceLoad()
      {
         super();
      }
      
      public static function hasDomainResource(param1:String) : Boolean
      {
         var _loc2_:String = getPackageName(param1) + "S_0_0";
         var _loc3_:Boolean = false;
         if(DomainResourceLoad.loaderContext)
         {
            _loc3_ = Boolean(DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc2_));
         }
         return _loc3_;
      }
      
      public static function getPackageName(param1:String) : String
      {
         param1 = param1.toLowerCase();
         var _loc3_:String = StringUtils.substrLastFolder(param1);
         var _loc2_:String = StringUtils.substrBswfName(param1);
         return "asset." + _loc3_ + "_" + _loc2_ + ".";
      }
      
      public static function clearDomainResource() : void
      {
         var _loc1_:Loader = null;
         for(var _loc2_:String in loaderList)
         {
            _loc1_ = loaderList[_loc2_] as Loader;
            _loc1_.unloadAndStop(false);
            delete loaderList[_loc2_];
         }
         loaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
      }
      
      public static function get loaderContext() : LoaderContext
      {
         if(!_loaderContext)
         {
            _loaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
         }
         return _loaderContext;
      }
      
      public static function set loaderContext(param1:LoaderContext) : void
      {
         _loaderContext = param1;
      }
      
      public function loadFromBytes(param1:ByteArray, param2:com.pickgliss.loader.data.LoaderInfo) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _data = param1;
         info = param2;
         if(info.url in loaderList)
         {
            _tempLoad = loaderList[info.url] as Loader;
            _tempLoad.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
            _tempLoad.contentLoaderInfo.addEventListener("ioError",__ioErrorHandler);
            return;
         }
         param1.position = 0;
         var _loc3_:int = int(param1.bytesAvailable);
         swfBytes = new ByteArray();
         var _loc6_:Object = {};
         try
         {
            while(param1.position < _loc3_)
            {
               switch((_loc5_ = param1.readByte()) - 1)
               {
                  case 0:
                     _loc6_["sizeType"] = param1.readByte();
                     break;
                  case 1:
                     _loc6_["standsPara"] = param1.readUTF();
                     break;
                  case 2:
                     _loc6_["walksPara"] = param1.readUTF();
                     break;
                  case 3:
                     _loc6_["noShadow"] = param1.readBoolean();
                     break;
                  case 4:
                     _loc6_["showNamePosY"] = param1.readInt();
                     break;
                  case 5:
                     _loc6_["curTotalFrameX"] = param1.readByte();
                     break;
                  case 6:
                     _loc6_["offsetY"] = param1.readInt();
                     break;
                  case 7:
                     _loc6_["attackPara"] = param1.readUTF();
                     break;
                  case 8:
                     _loc6_["flight"] = param1.readInt();
                     break;
                  case 15:
                     _loc4_ = param1.readInt();
                     param1.readBytes(swfBytes,0,_loc4_);
                     swfBytes.position = 0;
                     param1.position = _loc3_;
               }
            }
         }
         catch(e:Error)
         {
            onLoadError();
            return;
         }
         LoaderHeaderList.avatarShowNamePos[info.url] = _loc6_;
         _loc6_ = null;
         if(swfBytes.length > 0)
         {
            loadFromBytesImp(swfBytes);
         }
         else
         {
            onLoadError();
         }
      }
      
      private function loadFromBytesImp(param1:ByteArray) : void
      {
         if(!_loaderContext)
         {
            loaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
         }
         if(DisplayLoader.isDebug)
         {
            loaderContext.allowCodeImport = true;
         }
         _tempLoad = createLoader();
         _tempLoad.loadBytes(param1,_loaderContext);
      }
      
      private function createLoader() : Loader
      {
         _tempLoad = new Loader();
         _tempLoad.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
         _tempLoad.contentLoaderInfo.addEventListener("ioError",__ioErrorHandler);
         loaderList[info.url] = _tempLoad;
         return _tempLoad;
      }
      
      protected function __onContentLoadComplete(param1:Event) : void
      {
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__onContentLoadComplete);
         _loc2_.removeEventListener("ioError",__ioErrorHandler);
         _loc2_.loader.unloadAndStop(false);
         if(info && info.url in loaderList)
         {
            delete loaderList[info.url];
         }
         _tempLoad = null;
         dispatchEvent(new LoaderEventII("complete",info,null));
      }
      
      private function __ioErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc3_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc3_.removeEventListener("complete",__onContentLoadComplete);
         _loc3_.removeEventListener("ioError",__ioErrorHandler);
         _loc3_.loader.unloadAndStop(false);
         if(info && info.url in loaderList)
         {
            delete loaderList[info.url];
         }
         _tempLoad = null;
         var _loc2_:String = ComponentSetting.getMD5FilePathByUrl(info.url);
         LoaderManagerII.instance.notExist[_loc2_] = true;
      }
      
      private function onLoadError() : void
      {
      }
      
      public function dispose() : void
      {
         if(swfBytes)
         {
            swfBytes.clear();
            swfBytes = null;
         }
         if(_tempLoad && _tempLoad.contentLoaderInfo)
         {
            _tempLoad.contentLoaderInfo.removeEventListener("complete",__onContentLoadComplete);
            _tempLoad.contentLoaderInfo.removeEventListener("ioError",__ioErrorHandler);
            _tempLoad.unloadAndStop(false);
         }
         _tempLoad = null;
         info = null;
      }
   }
}

