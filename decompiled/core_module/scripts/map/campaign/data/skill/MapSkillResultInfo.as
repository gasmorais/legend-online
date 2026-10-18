package map.campaign.data.skill
{
   import com.road.yishi.proto.vehicle.HurtDataMsg;
   import com.road.yishi.proto.vehicle.VehicleAttackRspMsg;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MapSkillResultInfo
   {
      
      public var casterId:int;
      
      public var casterService:String;
      
      private var _skillId:int;
      
      public var skillTemplate:VehicleSkillTempInfo;
      
      public var effectX:int;
      
      public var effectY:int;
      
      public var npcHurt:Vector.<MapSkillHurtData> = new Vector.<MapSkillHurtData>();
      
      public var playerHurt:Vector.<MapSkillHurtData> = new Vector.<MapSkillHurtData>();
      
      public var attackType:int = 0;
      
      public function MapSkillResultInfo()
      {
         super();
      }
      
      public static function createFromAttackMsg(param1:VehicleAttackRspMsg) : MapSkillResultInfo
      {
         var _loc3_:MapSkillHurtData = null;
         var _loc2_:* = null;
         var _loc4_:MapSkillResultInfo = new MapSkillResultInfo();
         _loc4_.casterId = param1.attackerId;
         _loc4_.casterService = param1.serverName;
         _loc4_.skillId = param1.skillId;
         _loc4_.effectX = param1.effectX * 20;
         _loc4_.effectY = param1.effectY * 20;
         _loc4_.attackType = param1.attackTyep;
         for each(_loc2_ in param1.npcHurtDataList)
         {
            _loc3_ = MapSkillHurtData.createFromHurtDataMsg(param1.attackerId,param1.serverName,_loc2_);
            _loc4_.npcHurt.push(_loc3_);
         }
         for each(_loc2_ in param1.playerHurtDataList)
         {
            _loc3_ = MapSkillHurtData.createFromHurtDataMsg(param1.attackerId,param1.serverName,_loc2_);
            _loc4_.playerHurt.push(_loc3_);
         }
         return _loc4_;
      }
      
      public function get skillId() : int
      {
         return _skillId;
      }
      
      public function set skillId(param1:int) : void
      {
         _skillId = param1;
         skillTemplate = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(skillId);
      }
   }
}

