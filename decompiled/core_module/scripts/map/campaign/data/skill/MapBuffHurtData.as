package map.campaign.data.skill
{
   import com.road.yishi.proto.room.VehicleBuffStateMsg;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.manager.TempleteManager;
   
   public class MapBuffHurtData
   {
      
      public var id:int;
      
      private var _buffId:int;
      
      private var _buffTemplate:VehicleSkillBuffTemplate;
      
      public var effectId:int;
      
      public var effectServiceName:String;
      
      public var value:int;
      
      public var state:int;
      
      public var leftTime:int = 3;
      
      public function MapBuffHurtData()
      {
         super();
      }
      
      public static function createFromVehicleBuffStateMsg(param1:VehicleBuffStateMsg) : MapBuffHurtData
      {
         var _loc2_:MapBuffHurtData = new MapBuffHurtData();
         _loc2_.id = param1.id;
         _loc2_.buffId = param1.buffId;
         _loc2_.effectId = param1.playerId;
         _loc2_.effectServiceName = param1.serverName;
         _loc2_.value = param1.effectValue;
         _loc2_.state = param1.state;
         return _loc2_;
      }
      
      public function get buffId() : int
      {
         return _buffId;
      }
      
      public function set buffId(param1:int) : void
      {
         _buffId = param1;
         _buffTemplate = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(param1);
      }
      
      public function get buffTemplate() : VehicleSkillBuffTemplate
      {
         return _buffTemplate;
      }
      
      public function updateWith(param1:MapBuffHurtData) : void
      {
         this.value = param1.value;
         this.state = param1.state;
      }
   }
}

