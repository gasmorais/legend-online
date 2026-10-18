package com.speedEngine.game.base
{
   import com.speedEngine.speedBones.display.Stage;
   import com.speedEngine.speedBones.events.Event;
   import flash.display.Stage;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   use namespace basegame_internal;
   
   public class AppStage
   {
      
      private static var _stage2d:flash.display.Stage;
      
      private static var _stage3d:com.speedEngine.speedBones.display.Stage;
      
      private static var _context3D:Context3D;
      
      private static var _stage3D:Stage3D;
      
      private static var _complete:Function;
      
      private static var _firstRequestContext3D:Boolean = true;
      
      public function AppStage()
      {
         super();
      }
      
      basegame_internal static function init(param1:flash.display.Stage, param2:Function, param3:Boolean = true) : void
      {
         _stage2d = param1;
         _complete = param2;
         param1.scaleMode = "noScale";
         param1.align = "TL";
         com.speedEngine.speedBones.display.Stage.step(_stage2d);
         _stage3d = com.speedEngine.speedBones.display.Stage.current;
         if(!param3)
         {
            if(_complete != null)
            {
               _complete();
            }
            return;
         }
         if(_stage2d.stage3Ds.length > 0)
         {
            _stage3D = _stage2d.stage3Ds[0];
            _stage3D.addEventListener("context3DCreate",onContextCreated,false,10,true);
            _stage3D.addEventListener("error",onStage3DError,false,10,true);
            requestContext3D();
         }
         else
         {
            showFatalError("your computer GPU not work");
         }
      }
      
      protected static function onStage3DError(param1:ErrorEvent) : void
      {
         if(param1.errorID == 3702)
         {
            showFatalError("This application is not correctly embedded (wrong wmode value)");
         }
         else
         {
            showFatalError("Stage3D error: " + param1.text);
         }
      }
      
      private static function onContextCreated(param1:flash.events.Event) : void
      {
         var _loc2_:com.speedEngine.speedBones.events.Event = null;
         _context3D = _stage3D.context3D;
         com.speedEngine.speedBones.display.Stage.stepContext(_context3D);
         trace("[SpeedEngine] Initialization complete.");
         trace("[SpeedEngine] Display Driver:",_context3D.driverInfo);
         if(_firstRequestContext3D)
         {
            _firstRequestContext3D = false;
            if(_complete != null)
            {
               _complete.call(null);
            }
         }
         else
         {
            _loc2_ = com.speedEngine.speedBones.events.Event.getEvent(com.speedEngine.speedBones.events.Event,"context3DCreate");
            _stage3d.dispathEventWidth(_loc2_);
         }
      }
      
      private static function requestContext3D() : void
      {
         var _loc1_:Function = null;
         try
         {
            _loc1_ = _stage3D.requestContext3D;
            if(_loc1_.length == 1)
            {
               _loc1_("auto");
            }
            else
            {
               _loc1_("auto","baselineConstrained");
            }
         }
         catch(e:Error)
         {
            showFatalError("Context3D error: " + e.message);
         }
      }
      
      private static function showFatalError(param1:String) : void
      {
         var _loc3_:TextField = new TextField();
         var _loc2_:TextFormat = new TextFormat("Verdana",12,16777215);
         _loc2_.align = "center";
         _loc3_.defaultTextFormat = _loc2_;
         _loc3_.wordWrap = true;
         _loc3_.width = _stage2d.stageWidth * 0.75;
         _loc3_.autoSize = "center";
         _loc3_.text = param1;
         _loc3_.x = (_stage2d.stageWidth - _loc3_.width) / 2;
         _loc3_.y = (_stage2d.stageHeight - _loc3_.height) / 2;
         _loc3_.background = true;
         _loc3_.backgroundColor = 4456448;
         _stage2d.addChild(_loc3_);
      }
      
      basegame_internal static function get stage2d() : flash.display.Stage
      {
         return _stage2d;
      }
      
      basegame_internal static function get stage3d() : com.speedEngine.speedBones.display.Stage
      {
         return _stage3d;
      }
      
      public static function get context3D() : Context3D
      {
         return _context3D;
      }
   }
}

