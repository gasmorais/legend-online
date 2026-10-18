package com.pickgliss.loader
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class ResourceDomain
   {
      
      private var _parentDomain:ApplicationDomain;
      
      private var _domainDic:Dictionary;
      
      private var _callBackList:Dictionary;
      
      private var _urlLoaders:Dictionary;
      
      private var _isLoading:Dictionary;
      
      private var _loaderList:Dictionary;
      
      public function ResourceDomain()
      {
         super();
         _parentDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _domainDic = new Dictionary();
         _callBackList = new Dictionary();
         _urlLoaders = new Dictionary();
         _isLoading = new Dictionary();
         _loaderList = new Dictionary();
      }
      
      public function load(param1:String, param2:Boolean = false, param3:Function = null) : void
      {
         if(param1 in _domainDic)
         {
            if(param3 != null)
            {
               param3();
            }
         }
         else if(param1 in _isLoading)
         {
            if(param3 != null)
            {
               addToCallBackList(param1,param3);
            }
         }
         else
         {
            _isLoading[param1] = true;
            if(param3 != null)
            {
               addToCallBackList(param1,param3);
            }
            LoaderManagerII.instance.load(param1,1,7,onResourceLoaded,null,null,param2);
         }
      }
      
      private function onResourceLoaded(param1:com.pickgliss.loader.data.LoaderInfo, param2:ByteArray) : void
      {
         if(!param2)
         {
            delete _isLoading[param1.url];
            backCallUrl(param1.url);
            return;
         }
         var _loc4_:Loader = new Loader();
         _urlLoaders[_loc4_.contentLoaderInfo] = param1.url;
         _loaderList[param1.url] = _loc4_.contentLoaderInfo;
         _loc4_.contentLoaderInfo.addEventListener("complete",onContentLoaded);
         var _loc3_:ApplicationDomain = _parentDomain;
         if(param1.args === true)
         {
            _loc3_ = new ApplicationDomain(_parentDomain);
         }
         _loc4_.loadBytes(param2,new LoaderContext(false,_loc3_));
      }
      
      private function onContentLoaded(param1:Event) : void
      {
         EventDispatcher(param1.currentTarget).removeEventListener("complete",onContentLoaded);
         var _loc2_:String = _urlLoaders[param1.currentTarget];
         _domainDic[_loc2_] = flash.display.LoaderInfo(param1.currentTarget).applicationDomain;
         flash.display.LoaderInfo(param1.currentTarget).loader.unloadAndStop(false);
         delete _isLoading[_loc2_];
         delete _loaderList[_loc2_];
         backCallUrl(_loc2_);
      }
      
      private function backCallUrl(param1:String) : void
      {
         var _loc2_:Array = _callBackList[param1] as Array;
         for each(var _loc3_:Function in _loc2_)
         {
            _loc3_();
         }
         delete _callBackList[param1];
      }
      
      private function addToCallBackList(param1:String, param2:Function) : void
      {
         var _loc3_:Array = _callBackList[param1];
         if(!_loc3_)
         {
            _loc3_ = [];
            _callBackList[param1] = _loc3_;
         }
         if(_loc3_.indexOf(param2) == -1)
         {
            _loc3_.push(param2);
         }
      }
      
      public function removeCallBackFunction(param1:Function) : void
      {
         var _loc3_:int = 0;
         for each(var _loc2_:Array in _callBackList)
         {
            _loc3_ = _loc2_.indexOf(param1);
            if(_loc3_ != -1)
            {
               _loc2_.splice(_loc3_,1);
            }
         }
      }
      
      public function hasDefinition(param1:String, param2:String = "") : Boolean
      {
         var _loc4_:ApplicationDomain = null;
         var _loc3_:* = null;
         if(!param1)
         {
            return false;
         }
         if(param2)
         {
            _loc4_ = _domainDic[param2];
            if(_loc4_ && _loc4_.hasDefinition(param1))
            {
               return true;
            }
         }
         else if(_parentDomain && _parentDomain.hasDefinition(param1))
         {
            return true;
         }
         return false;
      }
      
      public function createInstane(param1:String, param2:String = "") : Object
      {
         var _loc5_:ApplicationDomain = null;
         var _loc3_:Class = null;
         var _loc4_:Object = null;
         if(!param1)
         {
            return null;
         }
         if(param2)
         {
            _loc5_ = _domainDic[param2];
            if(_loc5_ && _loc5_.hasDefinition(param1))
            {
               _loc3_ = _loc5_.getDefinition(param1) as Class;
            }
         }
         else if(_parentDomain.hasDefinition(param1))
         {
            _loc3_ = _parentDomain.getDefinition(param1) as Class;
         }
         if(_loc3_)
         {
            _loc4_ = new _loc3_();
         }
         return _loc4_;
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onResourceLoaded);
         for each(var _loc1_:Object in _loaderList)
         {
            flash.display.LoaderInfo(_loc1_).removeEventListener("complete",onContentLoaded);
            flash.display.LoaderInfo(_loc1_).loader.unloadAndStop(false);
         }
         _parentDomain = null;
         ObjectUtils.clearDictionary(_domainDic);
         _domainDic = null;
         ObjectUtils.clearDictionary(_callBackList);
         _callBackList = null;
         ObjectUtils.clearDictionary(_urlLoaders);
         _urlLoaders = null;
         ObjectUtils.clearDictionary(_isLoading);
         _isLoading = null;
         ObjectUtils.clearDictionary(_loaderList);
         _loaderList = null;
      }
   }
}

