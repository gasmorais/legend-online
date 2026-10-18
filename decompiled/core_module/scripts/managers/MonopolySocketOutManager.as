package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.RollDiceMsg;
   import com.road.yishi.proto.campaign.TriggerEventMsg;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import com.road.yishi.proto.pet.PlayerPetMsg;
   import map.campaign.CampaignManager;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.utils.WorldBossHelper;
   
   public class MonopolySocketOutManager
   {
      
      public function MonopolySocketOutManager()
      {
         super();
      }
      
      public static function sendEnterCampaign() : void
      {
         var _loc1_:PackageOut = new PackageOut(8823);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRollDice(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8824);
         var _loc3_:RollDiceMsg = new RollDiceMsg();
         _loc3_.type = param1;
         _loc3_.point = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendTriggerEvent() : void
      {
         var _loc1_:PackageOut = new PackageOut(8825);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendTriggerConfirm(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8833);
         var _loc2_:TriggerEventMsg = new TriggerEventMsg();
         _loc2_.userId = param1;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendMonopolyBuy(param1:int = 1, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8832);
         var _loc3_:TriggerEventMsg = new TriggerEventMsg();
         _loc3_.userId = param1;
         if(param2)
         {
            _loc3_.param1 = 0;
         }
         else
         {
            _loc3_.param1 = 1;
         }
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendSlotMachine() : void
      {
         var _loc1_:PackageOut = new PackageOut(8836);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendLeaveCampaign(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(8835);
         var _loc2_:TriggerEventMsg = new TriggerEventMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendPetFormation(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8725);
         var _loc2_:PlayerPetMsg = new PlayerPetMsg();
         _loc2_.monopolyPos = param1;
         _loc2_.operateType = 2;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendPetSkills(param1:int, param2:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(8726);
         var _loc3_:PetInfoMsg = new PetInfoMsg();
         var _loc4_:int = CampaignManager.instance.mapId;
         if(WorldBossHelper.checkMonopoly(_loc4_))
         {
            _loc3_.monopolySkillIndexs = param2;
         }
         _loc3_.petId = param1;
         sendProtoBuffer(_loc5_,_loc3_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

