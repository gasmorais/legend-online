package org.events
{
   import flash.events.Event;
   
   public class DictionaryEvent extends Event
   {
      
      public static const PREADD:String = "preaddDictionary";
      
      public static const PREUPDATE:String = "preupdateDictionary";
      
      public static const PREDELETE:String = "predeleteDictionary";
      
      public static const PRECLEAR:String = "preclearDictionary";
      
      public static const ADD:String = "addDictionary";
      
      public static const UPDATE:String = "updateDictionary";
      
      public static const DELETE:String = "deleteDictionary";
      
      public static const CLEAR:String = "clearDictionary";
      
      private var _oldData:*;
      
      private var _newData:*;
      
      private var _key:String;
      
      public function DictionaryEvent(param1:String, param2:* = null, param3:* = null, param4:String = "")
      {
         _newData = param2;
         _oldData = param3;
         _key = param4;
         super(param1);
      }
      
      public function get oldData() : *
      {
         return _oldData;
      }
      
      public function get newData() : *
      {
         return _newData;
      }
      
      public function get key() : String
      {
         return _key;
      }
   }
}

