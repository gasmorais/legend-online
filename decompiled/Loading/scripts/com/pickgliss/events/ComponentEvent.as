package com.pickgliss.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ComponentEvent extends Event
   {
      
      public static const PROPERTIES_CHANGED:String = "propertiesChanged";
      
      public static const GROUP_CONFLICT:String = "GROUP_CONFLICT";
      
      public static const FRAME_MOVE_COMPLETE:String = "FRAME_MOVE_COMPLETE";
      
      private var _changedProperties:Dictionary;
      
      public function ComponentEvent(param1:String, param2:Dictionary = null)
      {
         _changedProperties = param2;
         super(param1);
      }
      
      public function get changedProperties() : Dictionary
      {
         return _changedProperties;
      }
   }
}

