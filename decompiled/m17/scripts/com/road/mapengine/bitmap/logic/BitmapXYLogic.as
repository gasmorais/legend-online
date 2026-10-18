package com.road.mapengine.bitmap.logic
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.BaseMapScene;
   
   public class BitmapXYLogic extends BitmapXLogic
   {
      
      private var _frameY:int = 0;
      
      private var _mirror:int = 1;
      
      protected var _angle:Number;
      
      public function BitmapXYLogic(param1:BaseMapScene)
      {
         super(param1);
      }
      
      public function get mirror() : int
      {
         return _mirror;
      }
      
      public function set mirror(param1:int) : void
      {
         if(_mirror != param1)
         {
            _mirror = param1;
            x = x;
         }
      }
      
      public function get angle() : Number
      {
         return _angle;
      }
      
      public function set angle(param1:Number) : void
      {
         if(angle == param1)
         {
            return;
         }
         var _loc2_:int = frameY;
         _angle = param1;
         if(param1 >= 260 && param1 < 280)
         {
            frameY = 4;
            mirror = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            frameY = 3;
            mirror = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            frameY = 2;
            mirror = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            frameY = 1;
            mirror = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            frameY = 0;
            mirror = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            frameY = 1;
            mirror = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            frameY = 2;
            mirror = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            frameY = 3;
            mirror = -1;
         }
         play();
      }
      
      public function get frameY() : int
      {
         return _frameY;
      }
      
      public function set frameY(param1:int) : void
      {
         _frameY = param1;
      }
      
      override public function get curResourceType() : int
      {
         return 2;
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
      }
   }
}

