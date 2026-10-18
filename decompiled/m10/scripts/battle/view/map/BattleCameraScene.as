package battle.view.map
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.view.component.DelayRendSprite;
   
   public class BattleCameraScene extends DelayRendSprite implements Disposeable
   {
      
      protected var _cameraX:int = 500;
      
      protected var _cameraY:int = 300;
      
      protected var _preCameraX:int = 0;
      
      protected var _zoom:Number = 1;
      
      protected var childLayerSettingMap:Dictionary;
      
      protected var _cameraScaleCenterPoint:Point = new Point(500,600);
      
      protected var _sceneWidth:int = 1000;
      
      protected var _sceneHeight:int = 600;
      
      public function BattleCameraScene()
      {
         super();
         childLayerSettingMap = new Dictionary();
      }
      
      public function addLayerAt(param1:DisplayObject, param2:int, param3:Number = 1) : void
      {
         addChildAt(param1,param2);
         childLayerSettingMap[param1] = {"moveCoefficient":param3};
      }
      
      public function addLayer(param1:DisplayObject, param2:Number = 0) : void
      {
         addLayerAt(param1,numChildren,param2);
      }
      
      public function removeLayer(param1:DisplayObject) : void
      {
         removeChild(param1);
         delete childLayerSettingMap[param1];
      }
      
      public function get cameraY() : int
      {
         return _cameraY;
      }
      
      public function set cameraY(param1:int) : void
      {
         if(_cameraY == param1)
         {
            return;
         }
         _cameraY = param1;
         upDateNextRend();
      }
      
      public function get cameraX() : int
      {
         return _cameraX;
      }
      
      public function set cameraX(param1:int) : void
      {
         if(_cameraX == param1)
         {
            return;
         }
         _cameraX = param1;
         upDateNextRend();
      }
      
      public function get zoom() : Number
      {
         return _zoom;
      }
      
      public function set zoom(param1:Number) : void
      {
         if(_zoom == param1)
         {
            return;
         }
         _zoom = param1;
         upDateNextRend();
      }
      
      public function get cameraScaleCenterPoint() : Point
      {
         return _cameraScaleCenterPoint;
      }
      
      public function set cameraScaleCenterPoint(param1:Point) : void
      {
         _cameraScaleCenterPoint = param1;
         upDateNextRend();
      }
      
      override protected function onDraw() : void
      {
         var _loc2_:Number = NaN;
         updateCenterPoint();
         _preCameraX = cameraX;
         for(var _loc3_:Object in childLayerSettingMap)
         {
            _loc2_ = Number(childLayerSettingMap[_loc3_].moveCoefficient);
            _loc3_.x = -(_cameraX - _cameraScaleCenterPoint.x) * _loc2_;
         }
         var _loc1_:int = (StageReferance.stageWidth - width) / 2 >> 0;
         scaleX = _zoom;
         scaleY = _zoom;
         y = -(_cameraY * _zoom - _cameraScaleCenterPoint.y * 0.5);
         x = -(750 - _cameraScaleCenterPoint.x);
      }
      
      protected function stopMovingAllMembers() : void
      {
         for(var _loc1_:Object in childLayerSettingMap)
         {
            childLayerSettingMap[_loc1_].moveCoefficient = 0;
            if(_loc1_ is RepeatBackGroundLayer)
            {
               RepeatBackGroundLayer(_loc1_).moveSpeed = 0;
            }
         }
      }
      
      protected function playMovingAllMembers() : void
      {
         for(var _loc1_:Object in childLayerSettingMap)
         {
            if(_loc1_ is RepeatBackGroundLayer)
            {
               childLayerSettingMap[_loc1_].moveCoefficient = RepeatBackGroundLayer(_loc1_).getParaData().moveCoefficient;
               if(_loc1_ is RepeatBackGroundLayer)
               {
                  RepeatBackGroundLayer(_loc1_).moveSpeed = RepeatBackGroundLayer(_loc1_).getParaData().moveSpeed;
               }
            }
         }
      }
      
      public function get preCameraX() : int
      {
         return _preCameraX;
      }
      
      public function get sceneWidth() : int
      {
         return _sceneWidth;
      }
      
      public function set sceneWidth(param1:int) : void
      {
         if(_sceneWidth == param1)
         {
            return;
         }
         _sceneWidth = param1;
         upDateNextRend();
      }
      
      public function get sceneHeight() : int
      {
         return _sceneHeight;
      }
      
      public function set sceneHeight(param1:int) : void
      {
         if(_sceneHeight == param1)
         {
            return;
         }
         _sceneHeight = param1;
         upDateNextRend();
      }
      
      private function updateCenterPoint() : void
      {
         _cameraScaleCenterPoint.x = _sceneWidth / 2;
         _cameraScaleCenterPoint.y = _sceneHeight;
      }
      
      public function dispose() : void
      {
         childLayerSettingMap = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
   }
}

