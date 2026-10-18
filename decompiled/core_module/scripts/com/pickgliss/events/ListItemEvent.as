package com.pickgliss.events
{
   import com.pickgliss.ui.controls.cell.IListCell;
   import flash.events.Event;
   
   public class ListItemEvent extends Event
   {
      
      public static const LIST_ITEM_CLICK:String = "listItemClick";
      
      public static const LIST_ITEM_DOUBLE_CLICK:String = "listItemDoubleclick";
      
      public static const LIST_ITEM_MOUSE_DOWN:String = "listItemMouseDown";
      
      public static const LIST_ITEM_MOUSE_UP:String = "listItemMouseUp";
      
      public static const LIST_ITEM_ROLL_OVER:String = "listItemRollOver";
      
      public static const LIST_ITEM_ROLL_OUT:String = "listItemRollOut";
      
      public var cell:IListCell;
      
      public var cellValue:*;
      
      public var index:int;
      
      public var sourceEvent:Object;
      
      public function ListItemEvent(param1:IListCell, param2:*, param3:String, param4:int, param5:Object = null)
      {
         cell = param1;
         cellValue = param2;
         index = param4;
         sourceEvent = param5;
         super(param3);
      }
      
      override public function clone() : Event
      {
         return new ListItemEvent(cell,cellValue,type,index,sourceEvent);
      }
   }
}

