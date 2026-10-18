package com.pickgliss.loaderii
{
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.events.Event;
   
   public class LoaderEventII extends Event
   {
      
      public static const COMPLETE:String = "complete";
      
      public static const LOAD_ERROR:String = "loadError";
      
      public static const PROGRESS:String = "progress";
      
      private var _info:LoaderInfo;
      
      private var _data:Object;
      
      public function LoaderEventII(param1:String, param2:LoaderInfo, param3:Object)
      {
         super(param1,bubbles,cancelable);
         _info = param2;
         _data = param3;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get info() : LoaderInfo
      {
         return _info;
      }
   }
}

