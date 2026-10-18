package map.internals3D.mapbackground
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import map.internals3D.mapbackground.model.MapBackgroundBaseModel3D;
   import map.internals3D.mapbackground.model.MapBackgroundCellInfo3D;
   import map.internals3D.mapbackground.view.MapBackgroundCellView3D;
   import yishi.manager.NotificationManager;
   
   public class MapBackgroundView3D
   {
      
      public static var RENDER_MODE_3D:Boolean = true;
      
      private var _model:MapBackgroundBaseModel3D;
      
      private var _allCells:Dictionary;
      
      private var _parent:Object;
      
      private var _x:Number = -9999999;
      
      private var _y:Number = -9999999;
      
      public function MapBackgroundView3D(param1:Object, param2:Boolean)
      {
         super();
         _parent = param1;
         RENDER_MODE_3D = param2;
         _allCells = new Dictionary(true);
      }
      
      public function set model(param1:MapBackgroundBaseModel3D) : void
      {
         _model = param1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("updateScreenBackground",__updateScreenBackgroundHandler);
         StageReferance.stage.addEventListener("resize",__updateScreenBackgroundHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("updateScreenBackground",__updateScreenBackgroundHandler);
         StageReferance.stage.removeEventListener("resize",__updateScreenBackgroundHandler);
      }
      
      private function __updateScreenBackgroundHandler(param1:Event) : void
      {
         var _loc6_:MapBackgroundCellInfo3D = null;
         var _loc5_:MapBackgroundCellView3D = null;
         var _loc7_:int = 0;
         var _loc3_:Array = _model.newBackroundCellList;
         _loc3_ = _loc3_.sortOn("offset",2 | 0x10);
         _loc3_ = _loc3_.reverse();
         var _loc4_:Array = _model.deleteBackroundCellList;
         var _loc2_:int = int(_loc4_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc6_ = _loc4_[_loc7_] as MapBackgroundCellInfo3D;
            _loc5_ = _allCells[_loc6_.tileName] as MapBackgroundCellView3D;
            if(_loc5_)
            {
               _loc5_.setParent(null);
            }
            _loc7_++;
         }
         _loc2_ = int(_loc3_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc6_ = _loc3_[_loc7_] as MapBackgroundCellInfo3D;
            _loc5_ = _allCells[_loc6_.tileName] as MapBackgroundCellView3D;
            if(!_loc5_)
            {
               _loc5_ = new MapBackgroundCellView3D();
               _loc5_.cellInfo = _loc6_;
               _allCells[_loc6_.tileName] = _loc5_;
            }
            _loc5_.setParent(_parent,_loc7_);
            _loc7_++;
         }
      }
      
      public function move(param1:int, param2:int) : void
      {
         param1 += StageReferance.stageWidth / 2;
         param2 += StageReferance.stageHeight / 2;
         _model.updateScreenCenterPoint(param1,param2);
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
         if(_parent && RENDER_MODE_3D)
         {
            _parent.x = param1;
         }
         if(_y != -9999999)
         {
            move(_x,_y);
         }
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         if(_parent && RENDER_MODE_3D)
         {
            _parent.y = param1;
         }
         if(_x != -9999999)
         {
            move(_x,_y);
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         _parent = null;
         removeEvent();
         for each(_loc1_ in _allCells)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _model.dispose();
         _model = null;
      }
   }
}

