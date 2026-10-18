package yishi.debug
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class Fps extends Sprite
   {
      
      private static var _instance:Fps;
      
      private static const tfDelayMax:int = 10;
      
      private static const maxMemory:uint = 200000000;
      
      private static const diagramHeight:uint = 40;
      
      private static const diagramWidth:uint = 60;
      
      private var currentY:int;
      
      private var fps:TextField;
      
      private var tfDelay:int = 0;
      
      private var diagramTimer:int;
      
      private var tfTimer:int;
      
      private var mem:TextField;
      
      private var skins:int = -1;
      
      private var diagram:BitmapData;
      
      private var skinsChanged:int = 0;
      
      public function Fps()
      {
         super();
      }
      
      public static function get instance() : Fps
      {
         if(!_instance)
         {
            _instance = new Fps();
         }
         return _instance;
      }
      
      public function setup(param1:Stage) : void
      {
         param1.addChild(this);
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:Bitmap = null;
         fps = new TextField();
         mem = new TextField();
         mouseEnabled = false;
         mouseChildren = false;
         fps.defaultTextFormat = new TextFormat("Tahoma",10,16711680);
         fps.autoSize = "left";
         fps.text = "FPS: " + stage.frameRate.toFixed(2);
         fps.selectable = false;
         fps.x = -62;
         addChild(fps);
         mem.defaultTextFormat = new TextFormat("Tahoma",10,65280);
         mem.autoSize = "left";
         mem.text = "MEM: " + bytesToString(System.totalMemory);
         mem.selectable = false;
         mem.x = -62;
         mem.y = 10;
         addChild(mem);
         currentY = 20;
         diagram = new BitmapData(60,40,true,255);
         _loc1_ = new Bitmap(diagram);
         _loc1_.y = currentY + 4;
         _loc1_.x = -60;
         addChildAt(_loc1_,0);
         addEventListener("enterFrame",__enterFrame);
         this.stage.addEventListener("resize",__onResize);
         __onResize();
         diagramTimer = getTimer();
         tfTimer = getTimer();
      }
      
      private function __onResize(param1:Event = null) : void
      {
         x = this.width;
         y = stage.stageHeight - 270;
      }
      
      public function __enterFrame(param1:Event) : void
      {
         tfDelay = tfDelay + 1;
         if(tfDelay >= 10)
         {
            tfDelay = 0;
            fps.text = "FPS: " + (1000 * 10 / (getTimer() - tfTimer)).toFixed(2);
            tfTimer = getTimer();
         }
         var _loc4_:Number = 1000 / (getTimer() - diagramTimer);
         var _loc5_:Number = _loc4_ > stage.frameRate ? 1 : _loc4_ / stage.frameRate;
         diagramTimer = getTimer();
         diagram.scroll(1,0);
         diagram.fillRect(new Rectangle(0,0,1,diagram.height),2852126720);
         diagram.setPixel32(0,40 * (1 - _loc5_),4294901760);
         mem.text = "MEM: " + bytesToString(System.totalMemory);
         var _loc2_:Number = skins == 0 ? 0 : skinsChanged / skins;
         diagram.setPixel32(0,40 * (1 - _loc2_),4294967295);
         var _loc3_:Number = System.totalMemory / 200000000;
         diagram.setPixel32(0,40 * (1 - _loc3_),4278255360);
      }
      
      private function bytesToString(param1:uint) : String
      {
         var _loc2_:String = null;
         if(param1 < 1024)
         {
            _loc2_ = String(param1) + "b";
         }
         else if(param1 < 10240)
         {
            _loc2_ = (param1 / 1024).toFixed(2) + "kb";
         }
         else if(param1 < 102400)
         {
            _loc2_ = (param1 / 1024).toFixed(1) + "kb";
         }
         else if(param1 < 1048576)
         {
            _loc2_ = Math.round(param1 / 1024) + "kb";
         }
         else if(param1 < 10485760)
         {
            _loc2_ = (param1 / 1048576).toFixed(2) + "mb";
         }
         else if(param1 < 104857600)
         {
            _loc2_ = (param1 / 1048576).toFixed(1) + "mb";
         }
         else
         {
            _loc2_ = Math.round(param1 / 1048576) + "mb";
         }
         return _loc2_;
      }
   }
}

