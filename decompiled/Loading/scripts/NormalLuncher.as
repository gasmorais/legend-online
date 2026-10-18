package
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import manager.ExternalInterfaceManager;
   
   public class NormalLuncher
   {
      
      public static const UIMODULE_NAME:String = "mainloading";
      
      public static const CORE_CODE:String = "2.png";
      
      public static const YISHI_CLASS_PATH:String = "yishi.lunch.Yishi";
      
      public static const CONFIG_PARSER_CLASS:String = "yishi.lunch.ConfigParaser";
      
      public static const STARTUP_LOADER_CLASS:String = "yishi.lunch.StartupResourcesLoader";
      
      public static const UIMODULE_TYPES_CLASS:String = "yishi.datas.UIModuleTypes";
      
      private var _stage:Stage;
      
      private var _maxLoading:Sprite;
      
      private var _moduleLoad:URLLoader;
      
      private var _config:XML;
      
      private var _userInfo:Object;
      
      private var _callback:Function;
      
      private var _timeId:int;
      
      private var _stepCount:int = 16;
      
      private var _count:int = 0;
      
      private var _count2:int = 0;
      
      private var _loaderSavingCloseList:Array = [21];
      
      private var _startupLoader:*;
      
      private var _proObj:Object;
      
      private var _preTotalPro:Number;
      
      private var _preSubPro:Number;
      
      private var _preSubProName:String;
      
      private var _preStep:int;
      
      private var _prePro:int;
      
      private var _preTime:int;
      
      private var _isOpenWeb:Boolean;
      
      public function NormalLuncher()
      {
         super();
      }
      
      public function lunch(param1:XML, param2:Object, param3:Stage, param4:Sprite, param5:Function = null) : void
      {
         _config = param1;
         _userInfo = param2;
         _callback = param5;
         _stage = param3;
         _maxLoading = param4;
         checkLoaderSaving();
         start();
      }
      
      private function checkLoaderSaving() : void
      {
         var _loc2_:String = Capabilities.version.split(" ")[1];
         var _loc3_:Array = _loc2_.split(",");
         var _loc1_:int = int(_loc3_[0]);
         if(_loaderSavingCloseList.indexOf(_loc1_) == -1)
         {
            LoaderSavingManager.OPEN_SHARED = true;
         }
         else
         {
            LoaderSavingManager.OPEN_SHARED = false;
         }
      }
      
      private function start() : void
      {
         var _loc1_:String = ComponentSetting.getProjectSourcePath("2.png");
         LoaderManagerII.instance.load(_loc1_,3,8,__loadeCompleteHandler,__moduleProgressHandler);
      }
      
      private function __moduleProgressHandler(param1:LoaderInfo) : void
      {
         var _loc3_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc2_:String = "Carregando    " + ComponentSetting.getMD5FileNameByFilePath(param1.url);
         updateProgress(_loc3_ * 6 / 16 * 100);
         _maxLoading["setItemLoaderInfo"](_loc3_,_loc2_);
      }
      
      private function updateProgress(param1:Number) : void
      {
         timeRefresh(param1);
         _maxLoading["setProgress"](checkNumber(param1));
      }
      
      private function __loadeCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:String = ComponentSetting.getUIConfigZIPPath();
         LoaderManagerII.instance.load(_loc3_,1,8,onLoadZipComplete,onLoadZipProgress);
      }
      
      private function onLoadZipProgress(param1:LoaderInfo) : void
      {
         var _loc3_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc2_:String = "Carregando    " + ComponentSetting.getMD5FileNameByFilePath(param1.url);
         updateProgress(37.5 + 0.0625 * _loc3_ * 100);
         _maxLoading["setItemLoaderInfo"](_loc3_,_loc2_);
      }
      
      private function onLoadZipComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:String = ComponentSetting.getUrlMd5(param1.url);
         if(ComponentSetting.checkNeedAnalyzeMd5(_loc4_))
         {
            if(ComponentSetting.compareMD5(param2 as ByteArray,_loc4_))
            {
               _loc3_ = new ByteArray();
               param2.position = 37;
               param2.readBytes(_loc3_);
               unzipFile(_loc3_ as ByteArray);
            }
         }
         else
         {
            unzipFile(param2 as ByteArray);
         }
      }
      
      private function unzipFile(param1:ByteArray) : void
      {
         var _loc8_:String = null;
         var _loc4_:* = 0;
         var _loc5_:XML = null;
         var _loc10_:ByteArray = null;
         var _loc7_:* = undefined;
         var _loc11_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         param1.uncompress();
         _loc10_ = param1;
         _loc10_.position = 0;
         var _loc9_:ByteArray = new ByteArray();
         var _loc6_:Object = {};
         while(_loc10_.position != _loc10_.length)
         {
            _loc3_ = _loc10_.readByte();
            _loc8_ = _loc10_.readMultiByte(_loc3_,"utf-8");
            _loc4_ = _loc10_.readUnsignedInt();
            _loc9_.writeBytes(_loc10_,_loc10_.position,_loc4_);
            _loc10_.position += _loc4_;
            _loc9_.position = 0;
            _loc5_ = new XML(_loc9_);
            ComponentFactory.Instance.setup(_loc5_);
            _loc9_.length = 0;
         }
         try
         {
            _loc7_ = DisplayLoader.Context.applicationDomain.getDefinition("yishi.lunch.Yishi") as Class;
            _startupLoader = DisplayLoader.Context.applicationDomain.getDefinition("yishi.lunch.StartupResourcesLoader");
            _startupLoader.instance.addEventListener("coreSetupLoadComplete",__startupCompleteHandler);
            _stage.addEventListener("enterFrame",__enterFrameHandler);
            _loc11_ = new _loc7_();
            _loc11_.lunch(_config,_userInfo);
         }
         catch(e:Error)
         {
            ErrorLog.sendLog(_userInfo.userId,"解析核心库异常，重新请求2.png",_config);
            LoaderSavingManager.clearFiles(ComponentSetting.getProjectSourcePath("2.png"));
            _loc2_ = ComponentSetting.getProjectSourcePath("2.png");
            LoaderManagerII.instance.load(_loc2_,3,8,__loadeCompleteHandler,__moduleProgressHandler);
         }
         _loc9_.clear();
         _loc9_ = null;
      }
      
      private function __startupCompleteHandler(param1:Event) : void
      {
         _stage.removeEventListener("enterFrame",__enterFrameHandler);
         _maxLoading["hide"]();
         _proObj = null;
         _stage = null;
         _maxLoading = null;
         _moduleLoad = null;
         _config = null;
         _userInfo = null;
         if(_callback != null)
         {
            _callback();
            _callback = null;
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         _proObj = _startupLoader.instance.proObj;
         var _loc3_:Number = Number(_startupLoader.instance.templateProgress());
         var _loc2_:int = int(_startupLoader.instance.step);
         if(_loc3_ > 0)
         {
            _maxLoading["setProgress"](75 + _loc3_);
         }
         else if(_loc2_ == 5)
         {
            _maxLoading["setProgress"](99);
         }
         else if(_loc2_ < 5)
         {
            timeRefresh(_proObj["totalPro"]);
            if(_proObj["totalPro"] != _preTotalPro)
            {
               _preTotalPro = _proObj["totalPro"];
               _maxLoading["setProgress"](43.75 + checkNumber(_preTotalPro));
            }
         }
         if(_proObj["subPro"] != _preSubPro || _proObj["subProName"] != _preSubProName)
         {
            _preSubPro = _proObj["subPro"];
            _preSubProName = _proObj["subProName"];
            _maxLoading["setItemLoaderInfo"](_preSubPro,_preSubProName);
         }
      }
      
      public function checkNumber(param1:int) : int
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         return int(param1 >= 100 ? 99 : param1);
      }
      
      public function timeRefresh(param1:int) : void
      {
         var _loc2_:int = 0;
         if(_isOpenWeb)
         {
            return;
         }
         if(param1 == _prePro)
         {
            _loc2_ = getTimer();
            if(_loc2_ - _preTime > 30000)
            {
               _isOpenWeb = true;
               ExternalInterfaceManager.instance.refreshWebSite();
            }
         }
         else
         {
            _preTime = getTimer();
         }
         _prePro = param1;
      }
   }
}

