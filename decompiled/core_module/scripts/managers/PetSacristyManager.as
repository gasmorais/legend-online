package managers
{
   import com.road.yishi.proto.battle.AwakeMsg;
   import com.road.yishi.proto.pet.PetSkillMsg;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class PetSacristyManager
   {
      
      private static var _instance:PetSacristyManager;
      
      private var _petSkillMsg:PetSkillMsg;
      
      private var _awake:int;
      
      public function PetSacristyManager()
      {
         super();
      }
      
      public static function get instance() : PetSacristyManager
      {
         if(!_instance)
         {
            _instance = new PetSacristyManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 392,__petSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 391,__updatePowerHandler);
      }
      
      private function __petSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetSkillMsg = new PetSkillMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PetSkillMsg;
         if(!_petSkillMsg)
         {
            _petSkillMsg = _loc2_;
         }
         _petSkillMsg.userId = _loc2_.userId;
         _petSkillMsg.livingId = _loc2_.livingId;
         _petSkillMsg.skillId = _loc2_.skillId;
         _petSkillMsg.relicSkillId = _loc2_.relicSkillId;
      }
      
      private function __updatePowerHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AwakeMsg = new AwakeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AwakeMsg;
         _awake = _loc2_.awake[0].awake;
         NotificationManager.instance.sendNotification("UPDATE_PET_POWER");
      }
      
      public function get awake() : int
      {
         return _awake;
      }
      
      public function set awake(param1:int) : void
      {
         _awake = param1;
      }
      
      public function get petSkillMsg() : PetSkillMsg
      {
         return _petSkillMsg;
      }
      
      public function set petSkillMsg(param1:PetSkillMsg) : void
      {
         _petSkillMsg = param1;
      }
   }
}

