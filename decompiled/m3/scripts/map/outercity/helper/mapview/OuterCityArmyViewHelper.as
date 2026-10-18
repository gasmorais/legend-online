package map.outercity.helper.mapview
{
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import map.internals.constant.PosType;
   import map.internals.data.MapPhysics;
   import map.internals.data.OuterCityNode;
   import map.internals.data.PhysicInfo;
   import map.outercity.OuterCityModel;
   import map.outercity.manager.OuterCityManager;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class OuterCityArmyViewHelper
   {
      
      private static var _preTime:int;
      
      private static var timeId:int = 0;
      
      public function OuterCityArmyViewHelper()
      {
         super();
      }
      
      public static function checkArmyEventNode(param1:int, param2:AIBaseInfo, param3:Object, param4:Point, param5:Boolean = false, param6:int = 0) : Boolean
      {
         return launchFight(param2,param3,param4,param6);
      }
      
      private static function launchFight(param1:AIBaseInfo, param2:Object, param3:Point, param4:int = 0) : Boolean
      {
         return false;
      }
      
      public static function sendMessage(param1:Point, param2:MapPhysics) : Boolean
      {
         return true;
      }
      
      private static function delayCall(param1:PhysicInfo) : void
      {
         if(timeId > 0)
         {
            clearTimeout(timeId);
         }
         timeId = 0;
      }
      
      public static function getResetPoint(param1:OuterCityNode, param2:Object, param3:Point) : Point
      {
         var _loc4_:Point = null;
         if(param1.resetPosX > 0 && param1.resetPosY > 0)
         {
            _loc4_ = new Point(param1.resetPosX,param1.resetPosY);
         }
         else if(PosType.checkSendType(param1.info.types))
         {
            _loc4_ = new Point(param3.x,param3.y);
         }
         else
         {
            _loc4_ = new Point(int(param2.x / 20),int(param2.y / 20));
         }
         return _loc4_;
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private static function get outerCityModel() : OuterCityModel
      {
         return OuterCityManager.instance.model;
      }
   }
}

