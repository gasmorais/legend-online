package com.speedEngine.res
{
   import com.speedEngine.game.base.basegame_internal;
   import flash.events.Event;
   
   use namespace basegame_internal;
   
   public class LoaderEvent extends Event
   {
      
      public static const PART_COMPLETE:String = "part_complete";
      
      public static const LOADER_COMPLETE:String = "loader_complete";
      
      public static const LOADER_ERROR:String = "loader_error";
      
      public static const LOADER_PROGRESS:String = "loader_progress";
      
      basegame_internal static const LOADERCOMPLETE:String = "loadercomplete";
      
      basegame_internal static const LOADERROR:String = "loaderror";
      
      public var loader:BaseLoader;
      
      public function LoaderEvent(param1:String, param2:BaseLoader = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.loader = param2;
      }
   }
}

