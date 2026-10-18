package com.road.mapengine.bitmap.load
{
   import com.pickgliss.ui.core.Disposeable;
   
   public class ResourceLoaderInfo implements Disposeable
   {
      
      public var loaderType:int;
      
      public var content:Object;
      
      private var _url:String;
      
      public var stand:Array;
      
      public var walk:Array;
      
      public var position:String;
      
      public var positionAddSign:String = "";
      
      public var packageName:String;
      
      public var call:Function;
      
      public var resourceType:int;
      
      public var queueLoader:Boolean;
      
      public function ResourceLoaderInfo()
      {
         super();
      }
      
      public function get url() : String
      {
         return _url.toLowerCase();
      }
      
      public function set url(param1:String) : void
      {
         _url = param1;
      }
      
      public function dispose() : void
      {
         url = null;
         stand = null;
         walk = null;
         position = null;
         call = null;
      }
   }
}

