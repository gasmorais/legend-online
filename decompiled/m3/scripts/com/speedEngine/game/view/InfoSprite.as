package com.speedEngine.game.view
{
   import com.speedEngine.game.Director;
   import com.speedEngine.speedBones.manager.RenderManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class InfoSprite extends Sprite
   {
      
      public static var fps:int;
      
      private static const SCREEN_RES_X:Number = Capabilities.screenResolutionX;
      
      private static const SCREEN_RES_Y:Number = Capabilities.screenResolutionY;
      
      private static const FLASH_PLAYER_VERSION:String = Capabilities.version;
      
      private var _bg:Sprite = new Sprite();
      
      private var _txtBox:TextField = new TextField();
      
      private var _color:int = 0;
      
      private var _monitor:Boolean = false;
      
      private var _time:Number = 0;
      
      private var _frameTime:Number = 0;
      
      private var _frames:Number = 0;
      
      private var _secondTime:Number = 0;
      
      private var _prevSecondTime:Number = getTimer();
      
      private var _prevFrameTime:Number = getTimer();
      
      private var workTime:uint = 10;
      
      private var _dynamicSprite:Sprite = new Sprite();
      
      private var _staticSprite:Sprite = new Sprite();
      
      public function InfoSprite()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.mouseChildren = false;
         _bg.graphics.beginFill(0,0.8);
         _bg.graphics.drawRect(0,0,200,20);
         _bg.graphics.endFill();
         _bg.cacheAsBitmap = true;
         _txtBox.x = 0;
         _txtBox.y = 0;
         _txtBox.width = 250;
         _txtBox.autoSize = "left";
         _txtBox.defaultTextFormat = new TextFormat("_sans",12,16777215);
         _txtBox.selectable = false;
         _txtBox.mouseEnabled = false;
         _dynamicSprite.addChild(_txtBox);
         var _loc2_:String = "SpeedEngine Version: " + Director.instance.speedEngineVersion + "\n" + "DriverInfo: " + Director.instance.driverInfo + "\n" + "FlashPlayer Version: " + FLASH_PLAYER_VERSION + "\n";
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "left";
         _loc1_.defaultTextFormat = new TextFormat("_sans",12,16777215);
         _loc1_.width = 300;
         _loc1_.wordWrap = true;
         _loc1_.htmlText = _loc2_;
         _staticSprite.addChild(_loc1_);
         _staticSprite.y = 25;
         _staticSprite.visible = false;
         addChild(_bg);
         addChild(_dynamicSprite);
         addChild(_staticSprite);
         _time = getTimer();
         this.addEventListener("enterFrame",update);
         this.addEventListener("click",onClickHandler);
      }
      
      protected function onClickHandler(param1:MouseEvent) : void
      {
         _staticSprite.visible = !_staticSprite.visible;
      }
      
      public function update(param1:Event) : void
      {
         var _loc2_:uint = uint(System.totalMemory >> 20);
         _time = Math.max(getTimer(),_time + workTime);
         _secondTime = _time - _prevSecondTime;
         if(_secondTime >= 1000)
         {
            fps = _frames + 1;
            _frames = 0;
            _prevSecondTime = _time;
         }
         else
         {
            _frames = _frames + 1;
         }
         _prevFrameTime = _time;
         _txtBox.text = "Mem: " + _loc2_ + " MB  |  FPS: " + fps + " | DW: " + RenderManager.drawTriangleNums;
      }
      
      public function dispose() : void
      {
         this.removeEventListener("click",onClickHandler);
         this.removeEventListener("enterFrame",update);
         this.removeChildren();
      }
   }
}

