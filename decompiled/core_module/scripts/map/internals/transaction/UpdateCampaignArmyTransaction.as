package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import com.road.yishi.proto.army.ArmyMsg;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import yishi.manager.NotificationManager;
   
   public class UpdateCampaignArmyTransaction extends TransactionBase
   {
      
      public function UpdateCampaignArmyTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         var _loc5_:String = null;
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         var _loc6_:Boolean = false;
         var _loc1_:ArmyMsg = new ArmyMsg();
         _loc1_ = _pkg.readBody(_loc1_) as ArmyMsg;
         var _loc7_:int = _loc1_.playerId;
         var _loc4_:int = _loc1_.armyId;
         var _loc2_:CampaignArmy = _loc3_.getUserArmyByArmyId(_loc4_);
         if(!_loc2_)
         {
            _loc6_ = true;
            _loc5_ = _loc1_.simpleHeroInfo.hasServerName ? _loc1_.simpleHeroInfo.serverName : "";
            _loc2_ = _loc3_.getSysArmyByArmyId(_loc4_,_loc5_);
            if(!_loc2_)
            {
               _loc2_ = new CampaignArmy();
               _loc2_.id = _loc4_;
               _loc2_.userId = _loc7_;
               _loc3_.addSysArmy(_loc2_);
            }
         }
         _loc2_.state = _loc1_.state;
         _loc2_.curPosX = _loc1_.curPosX;
         _loc2_.curPosY = _loc1_.curPosY;
         _loc2_.syncArmyInfo();
         if(_loc6_)
         {
            NotificationManager.instance.dispatchEvent(new CampaignEvent("SYS_ARMY_UPDATE",_loc2_));
         }
      }
      
      override public function getCode() : int
      {
         return 131;
      }
   }
}

