package com.pickgliss.loader
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.loader.data.LoaderPriority;
   import com.pickgliss.loaderii.BaseLoaderII;
   import com.pickgliss.loaderii.LoaderEventII;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.StringUtils;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class LoaderManagerII
   {
      
      private static var ROAD7_FLAG:String = "7road";
      
      private static var NULL_STR:String = "";
      
      public static var VER_FLAG:String = "ver";
      
      private static var _instance:LoaderManagerII;
      
      private var oneselfSizeDict:Dictionary;
      
      private var _imdLoader:BaseLoaderII;
      
      private var _loaderQueue:Vector.<BaseLoaderII> = new Vector.<BaseLoaderII>();
      
      private var _imdLoaderList:Array = [];
      
      private var _loaderList:Array = [];
      
      private var _moduleList:Array = [];
      
      private var _loadedInfo:Dictionary = new Dictionary(true);
      
      public var notExist:Dictionary = new Dictionary(true);
      
      public var verFiles:Dictionary = new Dictionary();
      
      private var _baseLoadDic:Dictionary = new Dictionary();
      
      private var _loadDic:Dictionary = new Dictionary();
      
      private var _dic:Dictionary = new Dictionary();
      
      private const _reg:RegExp = /.[maps|titles]$/i;
      
      private var _tempDic:Dictionary = new Dictionary(true);
      
      private var _split:String = ".";
      
      private var _space:String = "_";
      
      public function LoaderManagerII()
      {
         super();
         oneselfSizeDict = new Dictionary();
         oneselfSizeDict[ComponentSetting.TEMPLATE_PATH + "tempinfos.xml"] = true;
         _loaderQueue.push(new BaseLoaderII());
         _loaderQueue.push(new BaseLoaderII());
         _loaderQueue.push(new BaseLoaderII());
         _imdLoader = new BaseLoaderII();
         _imdLoader.addEventListener("complete",__completeHandler);
         _imdLoader.addEventListener("progress",__progressHandler);
         for each(var _loc1_:BaseLoaderII in _loaderQueue)
         {
            _loc1_.addEventListener("complete",__completeHandler);
            _loc1_.addEventListener("progress",__progressHandler);
         }
      }
      
      public static function get instance() : LoaderManagerII
      {
         if(!_instance)
         {
            _instance = new LoaderManagerII();
         }
         return _instance;
      }
      
      public function load(param1:String, param2:int, param3:int, param4:Function, param5:Function = null, param6:Function = null, param7:Object = null, param8:URLVariables = null, param9:String = "GET", param10:Boolean = false, param11:Boolean = true) : void
      {
         if(StringUtils.isEmpty(param1))
         {
            return;
         }
         filterLoaded();
         param1 = param1.toLocaleLowerCase();
         _baseLoadDic[param1] = true;
         if(param10)
         {
            delete _loadedInfo[param1];
         }
         var _loc12_:LoaderInfo = new LoaderInfo();
         _loc12_.url = ComponentSetting.getMD5FilePathByUrl(param1);
         _loc12_.type = param2;
         _loc12_.priority = param3;
         _loc12_.args = param7;
         _loc12_.callBack = param4;
         _loc12_.progress = param5;
         _loc12_.errorFun = param6;
         _loc12_.urlArgs = param8;
         _loc12_.method = param9;
         _loc12_.canClearWhenSetScene = param11;
         if(oneselfSizeDict[_loc12_.url])
         {
            _loc12_.oneselfSize = true;
         }
         if(notExist[param1] || param2 == 3 && _moduleList.indexOf(param1) >= 0 || param2 == 4 && DomainResourceLoad.hasDomainResource(param1))
         {
            _imdLoaderList.unshift(_loc12_);
            baseLoadedComplete(_loc12_,null);
            delete _baseLoadDic[param1];
            return;
         }
         if(_loc12_.urlArgs && _loc12_.urlArgs.hasOwnProperty("rnd"))
         {
            delete _loadedInfo[param1];
         }
         if(!checkLoaded(_loc12_))
         {
            addInfo(_loc12_);
         }
      }
      
      private function filterLoaded() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _loaderList)
         {
            checkLoaded(_loc1_);
         }
         for each(_loc1_ in _imdLoaderList)
         {
            checkLoaded(_loc1_);
         }
      }
      
      private function checkLoaded(param1:LoaderInfo) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:ByteArray = null;
         if(_loadedInfo[param1.url])
         {
            _loc3_ = ComponentSetting.getUrlMd5(param1.url);
            _loc2_ = LoaderSavingManager.loadCachedFile(param1.url,_loc3_);
            if(_loc2_ && _loc2_.length > 0)
            {
               _imdLoaderList.unshift(param1);
               baseLoadedComplete(param1,_loc2_);
               return true;
            }
            delete _loadedInfo[param1.url];
            delete _baseLoadDic[param1.url];
            return false;
         }
         return false;
      }
      
      private function addInfo(param1:LoaderInfo) : void
      {
         if(_loaderList.indexOf(param1) >= 0 || _imdLoaderList.indexOf(param1) >= 0)
         {
            return;
         }
         if(LoaderPriority.isImidiatyLoader(param1))
         {
            _imdLoaderList.unshift(param1);
            _imdLoaderList.sortOn(["priority","id"],[0x10 | 2,0x10 | 2]);
         }
         else
         {
            _loaderList.unshift(param1);
            _loaderList.sortOn(["priority","id"],[0x10 | 2,0x10 | 2]);
         }
         loadNext();
      }
      
      private function loadNext() : void
      {
         var _loc4_:String = null;
         var _loc2_:ByteArray = null;
         var _loc1_:BaseLoaderII = null;
         var _loc3_:LoaderInfo = getLoaderInfo();
         if(!_loc3_)
         {
            return;
         }
         _loc4_ = ComponentSetting.getUrlMd5(_loc3_.url);
         _loc2_ = LoaderSavingManager.loadCachedFile(_loc3_.url,_loc4_);
         if(_loc2_ && _loc2_.length > 0)
         {
            _loadedInfo[_loc3_.url] = true;
            _imdLoaderList.unshift(_loc3_);
            baseLoadedComplete(_loc3_,_loc2_);
            loadNext();
         }
         else
         {
            _loc1_ = getLoader(_loc3_);
            fixUrlVariables(_loc3_);
            _loc1_.info = _loc3_;
            _loc1_.startLoad(_loc3_.urlMd5,_loc3_.urlArgs,true,_loc3_.method);
         }
      }
      
      private function __completeHandler(param1:LoaderEventII) : void
      {
         var _loc4_:String = null;
         if(!param1.info.url)
         {
            return;
         }
         var _loc3_:LoaderInfo = param1.info;
         var _loc2_:ByteArray = param1.data as ByteArray;
         if(!notExist[_loc3_.url])
         {
            if(needCacheFile(_loc3_))
            {
               _loc4_ = ComponentSetting.getUrlMd5(_loc3_.url);
               LoaderSavingManager.cacheFile(_loc3_.url,_loc2_,_loc4_);
            }
            _loadedInfo[_loc3_.url] = true;
         }
         _imdLoaderList.unshift(_loc3_);
         baseLoadedComplete(_loc3_,_loc2_);
         loadNext();
      }
      
      private function needCacheFile(param1:LoaderInfo) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1.type == 7 || param1.type == 5 || param1.type == 8 || param1.url == "code_md5.dat" || param1.url == "res_md5.dat" || param1.url == ComponentSetting.getUIConfigZIPPath())
         {
            _loc2_ = false;
         }
         else if(param1.type == 1 && _reg.test(param1.url))
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function __progressHandler(param1:LoaderEventII) : void
      {
         if(param1.info && param1.info.progress != null)
         {
            param1.info.progress(param1.info);
         }
      }
      
      private function existMonopolizeLoader(param1:LoaderInfo) : Boolean
      {
         if(_imdLoader.isLoading)
         {
            return true;
         }
         for each(var _loc2_:BaseLoaderII in _loaderQueue)
         {
            if(_loc2_.isLoading && LoaderPriority.isMonopolizeLoader(_loc2_.info) && param1.priority < _loc2_.info.priority)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getLoader(param1:LoaderInfo) : BaseLoaderII
      {
         if(existMonopolizeLoader(param1))
         {
            return null;
         }
         if(LoaderPriority.isImidiatyLoader(param1))
         {
            if(_imdLoader.isLoading)
            {
               return null;
            }
            return _imdLoader;
         }
         for each(var _loc2_:BaseLoaderII in _loaderQueue)
         {
            if(!_loc2_.isLoading)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getLoaderInfo() : LoaderInfo
      {
         var _loc2_:LoaderInfo = null;
         var _loc1_:BaseLoaderII = null;
         if(_imdLoaderList.length > 0)
         {
            _loc2_ = _imdLoaderList.shift();
            _loc1_ = getLoader(_loc2_);
            if(!_loc1_)
            {
               _imdLoaderList.unshift(_loc2_);
               return null;
            }
         }
         else if(_loaderList.length > 0)
         {
            _loc2_ = _loaderList.shift();
            _loc1_ = getLoader(_loc2_);
            if(!_loc1_)
            {
               _loaderList.unshift(_loc2_);
               return null;
            }
         }
         return _loc2_;
      }
      
      private function saveTOLoadDic(param1:LoaderInfo) : void
      {
         if(_loadDic[param1.url])
         {
            _loadDic[param1.url].push(param1);
         }
         else
         {
            _loadDic[param1.url] = [];
            _loadDic[param1.url].push(param1);
         }
      }
      
      private function baseLoadedComplete(param1:LoaderInfo, param2:ByteArray) : void
      {
         var _loc4_:LoaderInfo = null;
         var _loc3_:int = 0;
         if(param1.type == 7 || param1.type == 5 || param1.type == 8)
         {
            _loc4_ = _imdLoaderList.shift();
            delete _baseLoadDic[_loc4_.url];
            saveTOLoadDic(_loc4_);
            loadFramBytes(_loc4_,param2);
            return;
         }
         _loc3_ = _imdLoaderList.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _imdLoaderList[_loc3_];
            if(_loc4_.url == param1.url)
            {
               delete _baseLoadDic[_loc4_.url];
               _imdLoaderList.splice(_loc3_,1);
               saveTOLoadDic(_loc4_);
               loadFramBytes(_loc4_,param2);
            }
            _loc3_--;
         }
         _loc3_ = _loaderList.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _loaderList[_loc3_];
            if(_loc4_.url == param1.url)
            {
               delete _baseLoadDic[_loc4_.url];
               saveTOLoadDic(_loc4_);
               _loaderList.splice(_loc3_,1);
               loadFramBytes(_loc4_,param2);
            }
            _loc3_--;
         }
      }
      
      private function removeFromLoadDic(param1:LoaderInfo) : void
      {
         var _loc2_:Array = _loadDic[param1.url] as Array;
         _loc2_.splice(_loc2_.indexOf(param1),1);
         if(_loc2_.length == 0)
         {
            delete _loadDic[param1.url];
         }
      }
      
      private function loadFramBytes(param1:LoaderInfo, param2:ByteArray) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(param2 && param2.length == 0)
         {
            param2 = null;
         }
         if(param1.type == 1 || param1.type == 7)
         {
            completeCall(param1,param2);
            removeFromLoadDic(param1);
         }
         else if(param1.type == 5)
         {
            if(param2 && param2.length > 0)
            {
               try
               {
                  param2.uncompress();
                  param2.position = 0;
                  _loc3_ = param2.readUTFBytes(param2.bytesAvailable);
               }
               catch(e:Error)
               {
               }
            }
            completeCall(param1,_loc3_);
            removeFromLoadDic(param1);
         }
         else if(param1.type == 8)
         {
            if(param2 && param2.length > 0)
            {
               param2.position = 0;
               _loc3_ = param2.readUTFBytes(param2.bytesAvailable);
            }
            completeCall(param1,_loc3_);
            removeFromLoadDic(param1);
         }
         else if(param2 && param2.length > 0)
         {
            _loc4_ = createLoader(param1);
            _loc4_.addEventListener("complete",__loadCompleteHandler);
            param2.position = 0;
            _loc4_.loadFromBytes(param2,param1);
            _tempDic[param1] = param1;
         }
         else
         {
            completeCall(param1,null);
            removeFromLoadDic(param1);
         }
      }
      
      private function __loadCompleteHandler(param1:LoaderEventII) : void
      {
         if(_tempDic[param1.info])
         {
            delete _tempDic[param1.info];
         }
         removeFromLoadDic(param1.info);
         param1.currentTarget.removeEventListener("complete",__loadCompleteHandler);
         param1.currentTarget.dispose();
         completeCall(param1.info,param1.data);
      }
      
      private function createLoader(param1:LoaderInfo) : Object
      {
         switch(param1.type - 2)
         {
            case 0:
               return new DisplayLoader();
            case 1:
               return new ModuleLoader();
            case 2:
               return new DomainResourceLoad();
            default:
               return null;
         }
      }
      
      private function completeCall(param1:LoaderInfo, param2:Object) : void
      {
         if(param1.callBack != null)
         {
            param1.callBack(param1,param2);
         }
         if(param1.type == 3 && _moduleList.indexOf(param1.url) == -1)
         {
            _moduleList.push(param1.url);
         }
         param1.callBack = null;
         param1.args = null;
         param1 = null;
      }
      
      public function getMd5PathByUrl(param1:String) : String
      {
         var _loc2_:String = ComponentSetting.getUrlMd5(param1);
         if(_loc2_ == NULL_STR || _loc2_ == ROAD7_FLAG)
         {
            return param1;
         }
         return groupUrl(param1,_loc2_);
      }
      
      private function groupUrl(param1:String, param2:String) : String
      {
         var _loc4_:int = param1.lastIndexOf(_split);
         var _loc3_:String = param1.substring(0,_loc4_);
         return _loc3_ + _space + param2 + param1.substring(_loc4_);
      }
      
      private function fixUrlVariables(param1:LoaderInfo) : void
      {
         param1.urlMd5 = param1.url;
         var _loc3_:String = ComponentSetting.getUrlMd5(param1.url);
         if(_loc3_ == NULL_STR || _loc3_ == ROAD7_FLAG)
         {
            if(!param1.urlArgs)
            {
               param1.urlArgs = new URLVariables();
               if(param1.type == 7 || param1.type == 5 || param1.type == 8)
               {
                  param1.urlArgs["rnd"] = Math.random();
               }
               return;
            }
            return;
         }
         param1.md5 = _loc3_;
         param1.urlMd5 = groupUrl(param1.url,_loc3_);
         var _loc2_:String = verFiles[_loc3_];
         if(_loc2_ != null && _loc2_ != NULL_STR)
         {
            param1.urlArgs = new URLVariables();
            param1.urlArgs[VER_FLAG] = _loc2_;
         }
      }
      
      public function isLoaded(param1:String) : Boolean
      {
         return _loadedInfo[param1];
      }
      
      public function hasPrority(param1:int) : Boolean
      {
         for each(var _loc2_:LoaderInfo in _loaderList)
         {
            if(_loc2_.priority == param1)
            {
               return true;
            }
         }
         for each(_loc2_ in _imdLoaderList)
         {
            if(_loc2_.priority == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeCanClearList() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:LoaderInfo = null;
         var _loc1_:int = _loaderList.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ >= 0)
         {
            _loc4_ = _loaderList[_loc2_];
            if(LoaderPriority.isCanClearLoader(_loc4_))
            {
               _loc3_ = _loc4_.url;
               _loaderList.splice(_loc2_,1);
               delete _baseLoadDic[_loc4_.url];
               _loc4_.dispose();
            }
            _loc2_--;
         }
         _loc1_ = _imdLoaderList.length - 1;
         _loc2_ = _loc1_;
         while(_loc2_ >= 0)
         {
            _loc4_ = _imdLoaderList[_loc2_];
            if(LoaderPriority.isCanClearLoader(_loc4_))
            {
               _loc3_ = _loc4_.url;
               _imdLoaderList.splice(_loc2_,1);
               delete _baseLoadDic[_loc4_.url];
               _loc4_.dispose();
            }
            _loc2_--;
         }
         clearCurrentLoad(_loc3_);
      }
      
      public function clearLoaderInfoBypriority(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc5_:LoaderInfo = null;
         var _loc2_:int = _loaderList.length - 1;
         _loc3_ = _loc2_;
         while(_loc3_ >= 0)
         {
            _loc5_ = _loaderList[_loc3_];
            if(_loc5_.priority == param1)
            {
               _loc4_ = _loc5_.url;
               _loaderList.splice(_loc3_,1);
               delete _baseLoadDic[_loc5_.url];
               _loc5_.dispose();
            }
            _loc3_--;
         }
         _loc2_ = _imdLoaderList.length - 1;
         _loc3_ = _loc2_;
         while(_loc3_ >= 0)
         {
            _loc5_ = _imdLoaderList[_loc3_];
            if(_loc5_.priority == param1)
            {
               _loc4_ = _loc5_.url;
               _imdLoaderList.splice(_loc3_,1);
               delete _baseLoadDic[_loc5_.url];
               _loc5_.dispose();
            }
            _loc3_--;
         }
         clearCurrentLoad(_loc4_);
      }
      
      public function clearLoaderInfoByCompleteFunction(param1:Function) : void
      {
         var _loc5_:LoaderInfo = null;
         var _loc4_:int = 0;
         for each(_loc5_ in _tempDic)
         {
            if(_loc5_.callBack == param1)
            {
               _loc5_.callBack = null;
               _loc5_.errorFun = null;
            }
         }
         var _loc2_:int = _loaderList.length - 1;
         _loc4_ = _loc2_;
         while(_loc4_ >= 0)
         {
            _loc5_ = _loaderList[_loc4_];
            if(_loc5_.callBack == param1)
            {
               _loaderList.splice(_loc4_,1);
               delete _baseLoadDic[_loc5_.url];
               _loc5_.dispose();
            }
            _loc4_--;
         }
         _loc2_ = _imdLoaderList.length - 1;
         _loc4_ = _loc2_;
         while(_loc4_ >= 0)
         {
            _loc5_ = _imdLoaderList[_loc4_];
            if(_loc5_.callBack == param1)
            {
               _imdLoaderList.splice(_loc4_,1);
               delete _baseLoadDic[_loc5_.url];
               _loc5_.dispose();
            }
            _loc4_--;
         }
         if(_imdLoader.info && _imdLoader.info.callBack == param1)
         {
            _imdLoader.info.callBack = null;
            _imdLoader.info.errorFun = null;
         }
         for each(var _loc3_:BaseLoaderII in _loaderQueue)
         {
            if(_loc3_.info && _loc3_.info.callBack == param1)
            {
               _loc3_.info.callBack = null;
               _loc3_.info.errorFun = null;
            }
         }
      }
      
      private function clearCurrentLoad(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(_imdLoader.info && _imdLoader.info.url == param1)
         {
            _imdLoader.info.callBack = null;
            _imdLoader.info.errorFun = null;
         }
         for each(var _loc2_:BaseLoaderII in _loaderQueue)
         {
            if(_loc2_.info && _loc2_.info.url == param1)
            {
               _loc2_.info.callBack = null;
               _loc2_.info.errorFun = null;
            }
         }
      }
   }
}

