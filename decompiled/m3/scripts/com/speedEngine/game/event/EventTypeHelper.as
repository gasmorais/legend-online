package com.speedEngine.game.event
{
   import com.speedEngine.game.base.basegame_internal;
   
   use namespace basegame_internal;
   
   public class EventTypeHelper
   {
      
      private static var _eventTypes:Object = {};
      
      public function EventTypeHelper()
      {
         super();
         var _loc2_:Array = ["add_to_stage","resize","focusIn","focusOut","click","mouse_down","mouse_move","mouse_out","mouse_over","mouse_up","connect","close","socketData","ioError","securityError","click","contextMenu","doubleClick","middleClick","middleMouseDown","middleMouseUp","mouseDown","mouseMove","mouseOut","mouseOver","mouseUp","mouseWheel","releaseOutside","rightClick","rightMouseDown","rightMouseUp","rollOut","rollOver","keyDown","keyUp"];
         for each(var _loc1_:String in _loc2_)
         {
            basegame_internal::eventTypes[_loc1_] = true;
         }
      }
      
      basegame_internal static function get eventTypes() : Object
      {
         return _eventTypes;
      }
   }
}

