package com.yy.game
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class GameMsgCollector
   {
      
      private static const SWF_LIB_URL:String = "http://client.garbage.game.yy.com/GameMsgCollectorLib.swf";
      
      private static const CONFIG_URL:String = "http://client.garbage.game.yy.com/v.xml";
      
      private static var _instance:GameMsgCollector;
      
      public static const VERSION:String = "3.0";
      
      private var libInstance:Object = null;
      
      private var toCallParamsMap:Object = {};
      
      private var isIniting:Boolean = false;
      
      public function GameMsgCollector(param1:PrivateClass)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("本类是单例实现，请通过instance静态getter获取实例！");
         }
      }
      
      public static function get instance() : GameMsgCollector
      {
         if(_instance == null)
         {
            _instance = new GameMsgCollector(new PrivateClass());
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         _instance = null;
      }
      
      public function collectMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Function = null) : void
      {
         var paramsList:Array;
         var content:String = param1;
         var toUserRoleName:String = param2;
         var fromUserRoleName:String = param3;
         var msgType:String = param4;
         var gameSceneId:String = param5;
         var serverId:String = param6;
         var gameId:String = param7;
         var onSend:Function = param8;
         if(libInstance)
         {
            libInstance["collectMessage"].apply(libInstance,arguments);
            return;
         }
         paramsList = toCallParamsMap["collectMessage"] || [];
         toCallParamsMap["collectMessage"] = paramsList;
         paramsList.push(arguments);
         initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["collectMessage"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      public function getReportable(param1:String, param2:String, param3:String, param4:String) : void
      {
         var paramsList:Array;
         var toUserRoleName:String = param1;
         var gameSceneId:String = param2;
         var serverId:String = param3;
         var gameId:String = param4;
         if(libInstance)
         {
            libInstance["getReportable"].apply(libInstance,arguments);
            return;
         }
         paramsList = toCallParamsMap["getReportable"] || [];
         toCallParamsMap["getReportable"] = paramsList;
         paramsList.push(arguments);
         initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["getReportable"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      public function reportGameProfile(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:String, param8:GameProfileParams = null) : void
      {
         var paramsList:Array;
         var passport:String = param1;
         var udbid:int = param2;
         var game:String = param3;
         var gameServer:String = param4;
         var roleName:String = param5;
         var roleLevel:int = param6;
         var gameEvent:String = param7;
         var otherParams:GameProfileParams = param8;
         if(libInstance)
         {
            libInstance["reportGameProfile"].apply(libInstance,arguments);
            return;
         }
         paramsList = toCallParamsMap["reportGameProfile"] || [];
         toCallParamsMap["reportGameProfile"] = paramsList;
         paramsList.push(arguments);
         initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["reportGameProfile"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      private function initLib(param1:Function) : void
      {
         var onInited:Function = param1;
         if(isIniting)
         {
            return;
         }
         isIniting = true;
         loadConfig(function(param1:String):void
         {
            var version:String = param1;
            if(version == null)
            {
               isIniting = false;
               return;
            }
            loadLibSwf(version,function(param1:Object):void
            {
               libInstance = param1;
               if(libInstance)
               {
                  onInited();
               }
               isIniting = false;
            });
         });
      }
      
      private function loadLibSwf(param1:String, param2:Function) : void
      {
         var variables:URLVariables;
         var context:LoaderContext;
         var version:String = param1;
         var onLoaded:Function = param2;
         var onComplete:* = function(param1:Event):void
         {
            removeAllEvents();
            onLoaded(Object(loader.content)["instance"]);
         };
         var onIOError:* = function(param1:IOErrorEvent):void
         {
            removeAllEvents();
            onLoaded(null);
         };
         var onSecurityError:* = function(param1:SecurityErrorEvent):void
         {
            removeAllEvents();
            onLoaded(null);
         };
         var removeAllEvents:* = function():void
         {
            loader.contentLoaderInfo.removeEventListener("complete",onComplete);
            loader.contentLoaderInfo.removeEventListener("ioError",onIOError);
            loader.contentLoaderInfo.removeEventListener("securityError",onSecurityError);
         };
         var loader:Loader = new Loader();
         var request:URLRequest = new URLRequest();
         request.url = "http://client.garbage.game.yy.com/GameMsgCollectorLib.swf";
         variables = new URLVariables();
         variables.v = version;
         request.data = variables;
         request.method = "GET";
         context = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         loader.contentLoaderInfo.addEventListener("complete",onComplete);
         loader.contentLoaderInfo.addEventListener("ioError",onIOError);
         loader.contentLoaderInfo.addEventListener("securityError",onSecurityError);
         loader.load(request,context);
      }
      
      private function loadConfig(param1:Function) : void
      {
         var variables:URLVariables;
         var onLoaded:Function = param1;
         var onComplete:* = function(param1:Event):void
         {
            removeAllEvents();
            var _loc2_:XML = new XML(loader.data);
            onLoaded(_loc2_.v);
         };
         var onIOError:* = function(param1:IOErrorEvent):void
         {
            removeAllEvents();
            onLoaded(null);
         };
         var removeAllEvents:* = function():void
         {
            loader.removeEventListener("complete",onComplete);
            loader.removeEventListener("ioError",onIOError);
         };
         var loader:URLLoader = new URLLoader();
         var request:URLRequest = new URLRequest();
         request.url = "http://client.garbage.game.yy.com/v.xml";
         variables = new URLVariables();
         variables.v = new Date().getTime().toString();
         request.data = variables;
         request.method = "GET";
         loader.dataFormat = "text";
         loader.addEventListener("complete",onComplete);
         loader.addEventListener("ioError",onIOError);
         loader.load(request);
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
