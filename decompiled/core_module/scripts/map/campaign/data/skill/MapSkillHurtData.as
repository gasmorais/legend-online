package map.campaign.data.skill
{
   import com.road.yishi.proto.vehicle.HurtDataMsg;
   
   public class MapSkillHurtData
   {
      
      public var effectId:int;
      
      public var effectServiceName:String;
      
      public var effectValue:int;
      
      public var realValue:int;
      
      public var skillId:int;
      
      public var effectType:int = 0;
      
      public var shootId:int = 0;
      
      public var shoorServiceName:String;
      
      public var attackType:int = 0;
      
      public var buffLeftTime:int = 0;
      
      public function MapSkillHurtData(param1:int = 0)
      {
         super();
         skillId = param1;
      }
      
      public static function createFromHurtDataMsg(param1:int, param2:String, param3:HurtDataMsg) : MapSkillHurtData
      {
         var _loc4_:MapSkillHurtData = new MapSkillHurtData();
         _loc4_.shootId = param1;
         _loc4_.shoorServiceName = param2;
         _loc4_.effectId = param3.affecteId;
         _loc4_.effectServiceName = param3.serverName;
         _loc4_.effectValue = param3.value;
         _loc4_.effectType = param3.damageType;
         return _loc4_;
      }
   }
}

