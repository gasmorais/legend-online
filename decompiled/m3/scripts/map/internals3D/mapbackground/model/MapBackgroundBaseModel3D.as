package map.internals3D.mapbackground.model
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import flash.geom.Point;
   import map.internals.data.template.MapTemplate;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class MapBackgroundBaseModel3D
   {
      
      public static const CELL_UNIT_WIDTH:int = 512;
      
      public static const CELL_UNIT_HEIGHT:int = 512;
      
      protected var _screenCenterCellPos:Point;
      
      protected var _mapBackgroundWidth:int;
      
      protected var _mapBackgroundHeight:int;
      
      protected var _nextBackroundCellList:Array;
      
      protected var _currBackroundCellList:Array;
      
      protected var _deleteBackroundCellList:Array;
      
      protected var _newBackroundCellList:Array;
      
      private var _mapId:int;
      
      public function MapBackgroundBaseModel3D()
      {
         super();
         _screenCenterCellPos = new Point(-10,-10);
         _nextBackroundCellList = [];
         _currBackroundCellList = [];
         _deleteBackroundCellList = [];
         _newBackroundCellList = [];
         StageReferance.addEventListener("resize",__onResize);
      }
      
      private function __onResize(param1:Event) : void
      {
         _screenCenterCellPos.x = -10;
         _screenCenterCellPos.y = -10;
      }
      
      public function get mapTempInfo() : MapTemplate
      {
         return TempleteManager.instance.mapTemplateCate.getTemplateByID(_mapId);
      }
      
      public function get deleteBackroundCellList() : Array
      {
         return _deleteBackroundCellList;
      }
      
      public function get currBackroundCellList() : Array
      {
         return _currBackroundCellList;
      }
      
      public function get newBackroundCellList() : Array
      {
         return _newBackroundCellList;
      }
      
      public function updateScreenCenterPoint(param1:int, param2:int) : void
      {
         var _loc3_:int = Math.floor(param1 / 512);
         var _loc4_:int = Math.floor(param2 / 512);
         if(_loc3_ != _screenCenterCellPos.x || _loc4_ != _screenCenterCellPos.y)
         {
            updateScreenBackground(param1,param2);
            _screenCenterCellPos.x = _loc3_;
            _screenCenterCellPos.y = _loc4_;
            NotificationManager.instance.dispatchEvent(new Event("updateScreenBackground"));
         }
      }
      
      protected function updateScreenBackground(param1:int, param2:int) : void
      {
         throw new Error("子类请实现updateScreenBackground()逻辑");
      }
      
      public function get mapBackgroundHeight() : int
      {
         return _mapBackgroundHeight;
      }
      
      public function get mapBackgroundWidth() : int
      {
         return _mapBackgroundWidth;
      }
      
      public function set mapBackgroundHeight(param1:int) : void
      {
         _mapBackgroundHeight = param1;
      }
      
      public function set mapBackgroundWidth(param1:int) : void
      {
         _mapBackgroundWidth = param1;
      }
      
      public function dispose() : void
      {
         _deleteBackroundCellList.length = 0;
         _deleteBackroundCellList = null;
         _currBackroundCellList.length = 0;
         _currBackroundCellList = null;
         _newBackroundCellList.length = 0;
         _newBackroundCellList = null;
         _nextBackroundCellList.length = 0;
         _nextBackroundCellList = null;
         _screenCenterCellPos = null;
         StageReferance.removeEventListener("resize",__onResize);
      }
   }
}

