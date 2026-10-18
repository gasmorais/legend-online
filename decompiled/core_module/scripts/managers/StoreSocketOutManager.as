package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.store.RefreshPropertyReqMsg;
   import com.road.yishi.proto.store.SmithFreshReqMsg;
   import com.road.yishi.proto.store.StoreReqMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreSocketOutManager
   {
      
      public static const LIFE_SKILL_OP_MINING:int = 1;
      
      public static const LIFE_SKILL_OP_COMPOSE:int = 2;
      
      public static const LIFE_SKILL_OP_LEARN:int = 3;
      
      public static const LIFE_SKILL_OP_UPGRADE:int = 4;
      
      public static const LIFE_SKILL_OP_FORGET:int = 5;
      
      public static const LIFE_SKILL_OP_COLLECT_CONFIRM:int = 6;
      
      public static const LIFE_SKILL_OP_ENCHANT:int = 7;
      
      public static const LIFE_SKILL_OP_SELECT:int = 8;
      
      public function StoreSocketOutManager()
      {
         super();
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendItemMount(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5151);
         var _loc4_:StoreReqMsg = new StoreReqMsg();
         _loc4_.mountPos = param1;
         _loc4_.bagType = param3;
         _loc4_.bagPos = param2;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendItemIntensify(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(5150);
         var _loc2_:StoreReqMsg = new StoreReqMsg();
         _loc2_.srcItemid = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendOneKeyIntensify(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5150);
         var _loc2_:StoreReqMsg = new StoreReqMsg();
         _loc2_.srcItemid = param1;
         _loc2_.opType = 1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendTreasureIntensify() : void
      {
         var _loc2_:PackageOut = new PackageOut(5150);
         var _loc1_:StoreReqMsg = new StoreReqMsg();
         _loc1_.opType = 3;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendCompose(param1:int, param2:int, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false) : void
      {
         var _loc7_:PackageOut = new PackageOut(5153);
         var _loc6_:StoreReqMsg = new StoreReqMsg();
         _loc6_.composeId = param1;
         _loc6_.composeNum = param2;
         _loc6_.autoBuy = param3;
         _loc6_.payType = 0;
         if(!param4)
         {
            _loc6_.payType = 1;
         }
         _loc6_.operate = param5;
         sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public static function sendFashionCompose(param1:Boolean = false, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8594);
         var _loc3_:StoreReqMsg = new StoreReqMsg();
         _loc3_.count = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendFashionSwitch() : void
      {
         var _loc2_:PackageOut = new PackageOut(8595);
         var _loc1_:StoreReqMsg = new StoreReqMsg();
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendUpdateEquip(param1:int, param2:int, param3:Boolean = true, param4:Boolean = false) : void
      {
         var _loc6_:PackageOut = new PackageOut(5153);
         var _loc5_:StoreReqMsg = new StoreReqMsg();
         _loc5_.composeId = param1;
         _loc5_.composeNum = param2;
         _loc5_.payType = 0;
         if(!param3)
         {
            _loc5_.payType = 1;
         }
         _loc5_.operate = param4;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public static function sendRefreshforRandom(param1:Array, param2:int, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(8336);
         var _loc4_:SmithFreshReqMsg = new SmithFreshReqMsg();
         _loc4_.lock = param1;
         _loc4_.bindType = param2;
         _loc4_.materialPayType = 0;
         if(!param3)
         {
            _loc4_.materialPayType = 1;
         }
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendPetRefreshToServer(param1:Array, param2:int, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(8336);
         var _loc4_:SmithFreshReqMsg = new SmithFreshReqMsg();
         _loc4_.lock = param1;
         _loc4_.bindType = param2;
         _loc4_.materialPayType = 0;
         if(!param3)
         {
            _loc4_.materialPayType = 1;
         }
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendRefreshProperty(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8464);
         var _loc2_:RefreshPropertyReqMsg = new RefreshPropertyReqMsg();
         _loc2_.itemId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendRefreshforReplace() : void
      {
         var _loc1_:PackageOut = new PackageOut(8339);
         send(_loc1_);
      }
      
      public static function sendResolve() : void
      {
         var _loc1_:PackageOut = new PackageOut(8340);
         send(_loc1_);
      }
      
      public static function sendTreasureResolve() : void
      {
         var _loc2_:PackageOut = new PackageOut(8683);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.type = 4;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendSwitch(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8538);
         var _loc4_:StoreReqMsg = new StoreReqMsg();
         _loc4_.desItemid = param2;
         _loc4_.srcItemid = param1;
         _loc4_.count = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendItemMould(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8644);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendLifeSkillCollect(param1:int) : void
      {
         if(ArmyManager.instance.thane.grades < 35)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.lifeskillTips"));
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8971);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 1;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendLifeSKillCompose(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8971);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 2;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendLifeSkillLearn(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8971);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 3;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendLifeSkillUpdate(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8971);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 4;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendLifeSkillForget(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8971);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 5;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendLifeSkillCollectConfirm(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8971);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 6;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendEnchant(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8971);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 7;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendSelectNodeInfo(param1:int) : void
      {
         if(ArmyManager.instance.thane.grades < 35)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8971);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 8;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendOuterLifeSkillCollect(param1:int, param2:int, param3:int) : void
      {
         if(ArmyManager.instance.thane.grades < 35)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.lifeskillTips"));
            return;
         }
         var _loc5_:PackageOut = new PackageOut(8971);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 1;
         _loc4_.param2 = param1;
         _loc4_.param3 = param2;
         _loc4_.param4 = param3.toString();
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendOuterLifeSkillCollectConfirm(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8971);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 6;
         _loc4_.param2 = param1;
         _loc4_.param3 = param2;
         _loc4_.param4 = param3.toString();
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendYearBoxCollect(param1:int) : void
      {
         if(ArmyManager.instance.thane.grades < 35)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.lifeskillTips"));
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8994);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 1;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendYearBoxCollectConfirm(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8994);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 2;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function searchYearBox() : void
      {
         var _loc2_:PackageOut = new PackageOut(8994);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 3;
         sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

