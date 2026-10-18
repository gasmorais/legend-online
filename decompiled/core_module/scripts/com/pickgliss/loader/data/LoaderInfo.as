package com.pickgliss.loader.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.net.URLVariables;
   
   public class LoaderInfo
   {
      
      public static const NULL_STR:String = "";
      
      public static const TRY_LOAD_TIMES:int = 3;
      
      public static const BYTE_LOADER:int = 1;
      
      public static const DISPLAY_LOADER:int = 2;
      
      public static const MODULE_LOADER:int = 3;
      
      public static const DOMAIN_RESOURCE_LOADER:int = 4;
      
      public static const COMPRESS_TEXT_LOADER:int = 5;
      
      public static const UN_COMPRESS_TEXT_LOADER:int = 8;
      
      public static const TEXT_LOADER:int = 7;
      
      private static var index:int = 1;
      
      private var _id:int = 0;
      
      private var _url:String;
      
      public var args:Object;
      
      public var urlArgs:URLVariables;
      
      public var type:int;
      
      public var method:String;
      
      public var urlMd5:String = "";
      
      public var md5:String = "";
      
      public var oneselfSize:Boolean = false;
      
      public var priority:int;
      
      public var callBack:Function;
      
      public var progress:Function;
      
      public var errorFun:Function;
      
      public var canClearWhenSetScene:Boolean;
      
      public var bytesLoaded:Number;
      
      public var bytesTotal:Number;
      
      public var analyzer:DataAnalyzer;
      
      public function LoaderInfo()
      {
         super();
         _id = getId();
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(param1:String) : void
      {
         _url = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function dispose() : void
      {
         _id = getId();
         oneselfSize = false;
         args = null;
         url = null;
         urlMd5 = null;
         md5 = null;
         callBack = null;
         progress = null;
         errorFun = null;
         type = 0;
         priority = 0;
      }
      
      private function getId() : int
      {
         return index++;
      }
   }
}

