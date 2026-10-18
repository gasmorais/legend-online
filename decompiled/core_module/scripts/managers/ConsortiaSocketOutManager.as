package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.consortia.ConsortiaLinkReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaMembersInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.consortia.ConsortiaOfferReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaTreasureBoxMsg;
   import com.road.yishi.proto.consortia.ConsortiaTreasureOpMsg;
   import com.road.yishi.proto.consortia.SearchConditionMsg;
   import com.road.yishi.proto.pet.PlayerPetMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaSocketOutManager
   {
      
      private static var _intervalTime:Number = 0;
      
      public function ConsortiaSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function consortiaLink(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8343);
         var _loc2_:ConsortiaLinkReqMsg = new ConsortiaLinkReqMsg();
         _loc2_.consortiaId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function operateConsortiaApply(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5143);
         var _loc3_:ConsortiaMsg = new ConsortiaMsg();
         _loc3_.applyId = param1;
         _loc3_.result = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function creatConsortia(param1:String, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5130);
         var _loc3_:ConsortiaMsg = new ConsortiaMsg();
         _loc3_.consortiaName = param1;
         _loc3_.isPay = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function modifyConsortiaDiscription(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(5140);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.description = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function modifyConsortiaPlacard(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(5139);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.placard = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendModifyGroupPlacard(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8544);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.groupPlacard = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaUpgrade(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5133);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.upgradeType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaTransfer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5131);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.otherId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendQuickTime(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8545);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaAcceptOrRejectApply(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5134);
         var _loc3_:ConsortiaMsg = new ConsortiaMsg();
         _loc3_.applyId = param1;
         _loc3_.result = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function consortiaAltarBless(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(5145);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         _loc2_.param2 = ConsortiaManager.instance.model.altarWorshipIndex;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaStudy(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5147);
         var _loc3_:ConsortiaMsg = new ConsortiaMsg();
         _loc3_.studySkill = param1;
         _loc3_.skillType = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function changeDuty(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5137);
         var _loc3_:ConsortiaMsg = new ConsortiaMsg();
         _loc3_.positionId = param1;
         _loc3_.otherId = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function fireMember(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5132);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.otherId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaInvitePlayer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5142);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.otherId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function ifOpenApply(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(5149);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.result = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function autoInvite() : void
      {
         var _loc1_:PackageOut = new PackageOut(8197);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaUserInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8207);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaOffer(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8208);
         var _loc3_:ConsortiaOfferReqMsg = new ConsortiaOfferReqMsg();
         _loc3_.pageIndex = param1;
         _loc3_.isHistory = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function getConsortiaInviteInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8209);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaEventInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8210);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaDutyInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8211);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaInfos() : void
      {
         var _loc2_:PackageOut = new PackageOut(8212);
         var _loc1_:ConsortiaMsg = new ConsortiaMsg();
         _loc1_.consortiaId = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function getConsortiaApplyInfos(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8214);
         var _loc2_:SearchConditionMsg = new SearchConditionMsg();
         _loc2_.pageIndex = param1;
         _loc2_.isNewOpen = true;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function getAltarInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(8215);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaSite() : void
      {
         var _loc1_:PackageOut = new PackageOut(8217);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getConsortiaAddFreshItem() : void
      {
         var _loc1_:PackageOut = new PackageOut(8216);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function getVotingUserInfos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8241);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendEnterSecretLand() : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc1_:PackageOut = new PackageOut(8537);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendCallSecretTree() : void
      {
         var _loc1_:PackageOut = new PackageOut(8565);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendGetSecretBuff() : void
      {
         var _loc1_:PackageOut = new PackageOut(8566);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendCallSecretMonster() : void
      {
         var _loc1_:PackageOut = new PackageOut(8743);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function consortiaPrizeAllot(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8579);
         var _loc2_:ConsortiaTreasureBoxMsg = new ConsortiaTreasureBoxMsg();
         _loc2_.templateId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function consortiaPrizeAllotConfirm(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc6_:ConsortiaMembersInfoMsg = null;
         var _loc5_:PackageOut = new PackageOut(8578);
         var _loc3_:ConsortiaTreasureBoxMsg = new ConsortiaTreasureBoxMsg();
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc6_ = new ConsortiaMembersInfoMsg();
            _loc6_.userId = param2[_loc4_].userId;
            _loc6_.count = param2[_loc4_].count;
            _loc3_.playerInfo.push(_loc6_);
            _loc4_++;
         }
         _loc3_.consortiaId = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID;
         _loc3_.chairmanId = ConsortiaManager.instance.model.consortiaInfo.chairmanID;
         _loc3_.templateId = param1;
         sendProtoBuffer(_loc5_,_loc3_);
      }
      
      public static function enterConsortiaBoss() : void
      {
         var _loc2_:PackageOut = new PackageOut(8847);
         var _loc1_:ConsortiaMsg = new ConsortiaMsg();
         _loc1_.upgradeType = 2;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function callConsortiaBoss(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8847);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.upgradeType = 1;
         _loc2_.otherId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function upgradeConsortiaBoss() : void
      {
         var _loc1_:PackageOut = new PackageOut(8846);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendPetFormation(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8725);
         var _loc2_:PlayerPetMsg = new PlayerPetMsg();
         _loc2_.consortiaPos = param1;
         _loc2_.operateType = 3;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendTreasureInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9629);
         var _loc2_:ConsortiaTreasureOpMsg = new ConsortiaTreasureOpMsg();
         _loc2_.payType = -1;
         _loc2_.treasureId = -1;
         _loc2_.op = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendGetQuestReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5437);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function businessBuyRequest(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5438);
         var _loc4_:CommonMsg = new CommonMsg();
         _loc4_.param1 = param1;
         _loc4_.param2 = param2;
         _loc4_.param3 = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function updateRights(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9723);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

