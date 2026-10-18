package com.pickgliss.ui.controls.tree
{
   import flash.events.Event;
   
   public class TreeDataEvent extends Event
   {
      
      public static const ITEM_CLICK:String = "TreeDataEvent.ITEM_CLICK";
      
      public static const ITEM_OPEN:String = "TreeDataEvent.ITEM_OPEN";
      
      public static const ITEM_SELECT:String = "TreeDataEvent.ITEM_SELECT";
      
      public var params:Object;
      
      public function TreeDataEvent(param1:String, param2:Object)
      {
         this.params = param2;
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new TreeDataEvent(type,params);
      }
   }
}

