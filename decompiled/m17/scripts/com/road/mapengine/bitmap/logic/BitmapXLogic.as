package com.road.mapengine.bitmap.logic
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.BaseMapScene;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapXLogic extends BitmapSimpleLogic
   {
      
      private var _frameX:int;
      
      private var _isStop:Boolean;
      
      protected var _drawRect:Rectangle;
      
      protected var _destPoint:Point;
      
      public var totalFrameX:int = 6;
      
      public var curTotalFrameX:int = 6;
      
      public function BitmapXLogic(param1:BaseMapScene)
      {
         super(param1);
         stop();
         _drawRect = new Rectangle();
         _destPoint = new Point();
      }
      
      override public function get curResourceType() : int
      {
         return 1;
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
      }
      
      override protected function updateOver() : void
      {
         if(isStop)
         {
            return;
         }
         nextFrameX();
      }
      
      public function get isStop() : Boolean
      {
         return _isStop;
      }
      
      protected function nextFrameX() : void
      {
         frameX = frameX + 1;
         if(frameX >= totalFrameX)
         {
            frameX = 0;
         }
      }
      
      public function get frameX() : int
      {
         return _frameX;
      }
      
      public function set frameX(param1:int) : void
      {
         _frameX = param1;
      }
      
      public function stop() : void
      {
         _isStop = true;
      }
      
      public function play() : void
      {
         _isStop = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

