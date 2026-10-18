package com.pickgliss.toplevel
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public final class StageReferance
   {
      
      private static var _stageHeight:int;
      
      private static var _stageWidth:int;
      
      private static var _stage:Stage;
      
      private static const widthChange:String = "widthChange";
      
      private static const heightChange:String = "heightChange";
      
      public static var keyBoardEnable:Boolean = true;
      
      public static var isDebug:Boolean = false;
      
      private static var _stageMouseChildren:Boolean;
      
      private static const eventDispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _dict:Object = {};
      
      public function StageReferance()
      {
         super();
      }
      
      public static function get stageWidth() : int
      {
         return _stageWidth;
      }
      
      public static function set stageWidth(param1:int) : void
      {
         if(_stageWidth == param1)
         {
            return;
         }
         _stageWidth = param1;
         _dict["widthChange"] = true;
      }
      
      public static function get stageHeight() : int
      {
         return _stageHeight;
      }
      
      public static function set stageHeight(param1:int) : void
      {
         if(_stageHeight == param1)
         {
            return;
         }
         _stageHeight = param1;
         _dict["heightChange"] = true;
      }
      
      public static function commit() : void
      {
         if(_dict["widthChange"] || _dict["heightChange"])
         {
            eventDispatcher.dispatchEvent(new Event("resize"));
            _dict["widthChange"] = false;
            _dict["heightChange"] = false;
         }
      }
      
      public static function setup(param1:Stage, param2:Boolean = false) : void
      {
         if(_stage != null)
         {
            return;
         }
         isDebug = param2;
         _stage = param1;
         _stage.addEventListener("exitFrame",__onNextFrame);
         _stage.addEventListener("resize",__onResize,false,100);
         _stage.stageFocusRect = false;
         __onResize(null);
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      private static function __onNextFrame(param1:Event) : void
      {
         if(_stage.stageWidth > 0)
         {
            _stage.removeEventListener("exitFrame",__onNextFrame);
            stageWidth = _stage.stageWidth;
            stageHeight = _stage.stageHeight;
            commit();
            eventDispatcher.dispatchEvent(new Event("resize"));
         }
      }
      
      private static function __onResize(param1:Event) : void
      {
         stageWidth = _stage.stageWidth;
         stageHeight = _stage.stageHeight;
         commit();
         _stage.addEventListener("exitFrame",__onNextFrame);
      }
      
      public static function get gameStageWidth() : int
      {
         return int(stageWidth < 800 ? 800 : stageWidth);
      }
      
      public static function get gameStageHeight() : int
      {
         return int(stageHeight < 480 ? 480 : stageHeight);
      }
      
      public static function get gameScaleX() : Number
      {
         if(gameStageWidth < 1000)
         {
            return gameStageWidth / 1000;
         }
         return 1;
      }
      
      public static function get gameScaleY() : Number
      {
         if(gameStageHeight < 600)
         {
            return gameStageHeight / 600;
         }
         return 1;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
      
      public static function get stageMouseChildren() : Boolean
      {
         return _stageMouseChildren;
      }
      
      public static function set stageMouseChildren(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         StageReferance._stageMouseChildren = param1;
         StageReferance.stage.mouseChildren = param1;
         if(ClassUtils.uiSourceDomain.hasDefinition("com.speedEngine.game.Director"))
         {
            _loc2_ = ClassUtils.getDefinition("com.speedEngine.game.Director");
            if(_loc2_.instance.stage3d)
            {
               _loc2_.instance.stage3d.touchableChildren = param1;
            }
         }
      }
   }
}

