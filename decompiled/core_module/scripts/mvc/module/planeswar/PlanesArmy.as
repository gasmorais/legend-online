package mvc.module.planeswar
{
   import flash.geom.Point;
   import mvc.module.armyII.SystemArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesArmy extends SystemArmy
   {
      
      private var _walkPath:Array;
      
      private var _x:int;
      
      private var _y:int;
      
      public var standPoint:Point;
      
      public var walkIndex:int = -1;
      
      public var isMoving:Boolean = false;
      
      public function PlanesArmy()
      {
         super();
         this.baseHero = thane;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(param1:Array) : void
      {
         var _loc2_:Object = null;
         _walkPath = param1;
         walkIndex = 0;
         standPoint = _walkPath[walkIndex + 1];
         if(_walkPath.length > 0 && standPoint)
         {
            _loc2_ = {};
            _loc2_.userId = userId;
            _loc2_.path = _walkPath;
            PlanesWarManager.instance.sendDispatchEvent("PLANES_MOVE_PATH",_loc2_);
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function get x() : int
      {
         return model.planesWarInfo.posX;
      }
      
      public function get y() : int
      {
         return model.planesWarInfo.posY;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

