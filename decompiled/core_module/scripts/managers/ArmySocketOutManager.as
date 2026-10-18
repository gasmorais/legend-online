package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.army.ArmyFightPosEditMsg;
   import com.road.yishi.proto.army.ArmyPawnInfoMsg;
   import com.road.yishi.proto.army.HeroAddPointReqMsg;
   import com.road.yishi.proto.army.HeroFastKeyMsg;
   import com.road.yishi.proto.army.HeroHideFashionReqMsg;
   import com.road.yishi.proto.army.HeroRuneOpMsg;
   import com.road.yishi.proto.army.HeroSkillChangeMsg;
   import com.road.yishi.proto.army.LotteryRuneReqMsg;
   import com.road.yishi.proto.army.PawnChangeMsg;
   import com.road.yishi.proto.army.RuneMosReqMsg;
   import com.road.yishi.proto.army.RuneResolveReqMsg;
   import com.road.yishi.proto.army.RuneStoneUpReqMsg;
   import com.road.yishi.proto.army.RuneUnloadReqMsg;
   import com.road.yishi.proto.army.TalentUpGradeMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   
   public class ArmySocketOutManager
   {
      
      public static const LEARN_SKILL:int = 2;
      
      public static const LEARN_TALENT_SKILL:int = 3;
      
      public static const UPGRADE_MOUNT:int = 4;
      
      public static const SKILL_CHANGE:int = 5;
      
      public static const SKILL_RESET:int = 6;
      
      public static const TALENT_SKILL_RESET:int = 7;
      
      public static const SKILL_CARRY:int = 8;
      
      public static const ACTIVE_SECOND_SKILL:int = 9;
      
      public function ArmySocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendChangeHeroInfo(param1:int) : void
      {
      }
      
      public static function sendRecruitPawn(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5155);
         var _loc3_:ArmyPawnInfoMsg = new ArmyPawnInfoMsg();
         _loc3_.tempateId = param1;
         _loc3_.ownPawns = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendDismissPawn(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5157);
         var _loc3_:ArmyPawnInfoMsg = new ArmyPawnInfoMsg();
         _loc3_.tempateId = param1;
         _loc3_.ownPawns = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendEditArmyPawn(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5156);
         var _loc4_:ArmyPawnInfoMsg = new ArmyPawnInfoMsg();
         _loc4_.sites = param1;
         _loc4_.tempateId = param2;
         _loc4_.ownPawns = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendEditArmyPos(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8276);
         var _loc4_:ArmyFightPosEditMsg = new ArmyFightPosEditMsg();
         _loc4_.userId = param1;
         _loc4_.heroPos = param2;
         _loc4_.pawnPos = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendUpgradePawn(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5158);
         var _loc2_:ArmyPawnInfoMsg = new ArmyPawnInfoMsg();
         _loc2_.tempateId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendPawnChange(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         var _loc6_:PackageOut = new PackageOut(8580);
         var _loc5_:PawnChangeMsg = new PawnChangeMsg();
         _loc5_.curPawnTempId = param1;
         _loc5_.tarPawnTempId = param2;
         _loc5_.payType = param3;
         if(param3 == 1)
         {
            if(SharedManager.instance.pownConveruseBind)
            {
               _loc5_.payType = 3;
            }
         }
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public static function sendStudyRune(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8605);
         var _loc4_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc4_.opType = 1;
         _loc4_.userId = ArmyManager.instance.army.userId;
         _loc4_.runeId = param1;
         _loc4_.learnRunePos = param2;
         _loc4_.learnRuneCount = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendOpStoneRune(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8605);
         var _loc3_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc3_.opType = param2;
         _loc3_.userId = ArmyManager.instance.army.userId;
         _loc3_.runeId = param1;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendUpStoneRune(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:PackageOut = new PackageOut(9721);
         var _loc6_:RuneStoneUpReqMsg = new RuneStoneUpReqMsg();
         _loc6_.pos = param2;
         _loc6_.id = param3;
         _loc6_.runeNum = param4;
         _loc6_.bagType = param5;
         _loc6_.runeId = param1;
         sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public static function sendEquipStone(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(9719);
         var _loc5_:RuneMosReqMsg = new RuneMosReqMsg();
         _loc5_.runeId = param1;
         _loc5_.runeIndex = param2;
         _loc5_.runeStoneId = param3;
         _loc5_.beginPos = param4;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public static function sendUnEquipStone(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9722);
         var _loc3_:RuneUnloadReqMsg = new RuneUnloadReqMsg();
         _loc3_.runeId = param1;
         _loc3_.index = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendGetStone(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9724);
         var _loc2_:LotteryRuneReqMsg = new LotteryRuneReqMsg();
         _loc2_.op = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendEquipResoveStone(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(9720);
         var _loc2_:RuneResolveReqMsg = new RuneResolveReqMsg();
         _loc2_.pos = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendUpgradeRune(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8605);
         var _loc2_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc2_.opType = 2;
         _loc2_.userId = ArmyManager.instance.army.userId;
         _loc2_.runeId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendActiveRuneStone(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8605);
         var _loc2_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc2_.opType = 5;
         _loc2_.userId = ArmyManager.instance.army.userId;
         _loc2_.runeId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendBuyBox(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5010);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         _loc2_.type = 1;
         _loc2_.property1 = 1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendTakeRune(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8605);
         var _loc2_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc2_.opType = 3;
         _loc2_.userId = ArmyManager.instance.army.userId;
         _loc2_.runeKey = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendPromotRune(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8605);
         var _loc2_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc2_.opType = 4;
         _loc2_.userId = ArmyManager.instance.army.userId;
         _loc2_.runeId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendAddSkillpoint(param1:int, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         var _loc6_:PackageOut = new PackageOut(5185);
         var _loc5_:HeroAddPointReqMsg = new HeroAddPointReqMsg();
         _loc5_.skillTempId = param1;
         _loc5_.type = param2;
         if(param3 > 0)
         {
            _loc5_.powerPoint = param3;
         }
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public static function sendWashSkillPoint(param1:int, param2:int = 0, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(5184);
         var _loc4_:PayTypeMsg = new PayTypeMsg();
         _loc4_.payType = 0;
         if(!param3)
         {
            _loc4_.payType = 1;
         }
         _loc4_.type = param2;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendAddTalentpoint(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5185);
         var _loc2_:HeroAddPointReqMsg = new HeroAddPointReqMsg();
         _loc2_.skillTempId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendUpTalentGrade(param1:Boolean = false, param2:int = 2) : void
      {
         var _loc4_:PackageOut = new PackageOut(5187);
         var _loc3_:TalentUpGradeMsg = new TalentUpGradeMsg();
         _loc3_.upresult = param1;
         _loc3_.payType = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendSetFastKey(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(5167);
         var _loc2_:HeroFastKeyMsg = new HeroFastKeyMsg();
         _loc2_.fastKey = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendWashPoint() : void
      {
         var _loc1_:PackageOut = new PackageOut(5170);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendHideFashion(param1:Boolean) : void
      {
      }
      
      public static function sendActiveSecondSkill(param1:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(8479);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendSkillChange(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8480);
         var _loc2_:HeroSkillChangeMsg = new HeroSkillChangeMsg();
         _loc2_.index = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

