package yishi.service.managers
{
   import battle.BattleManager;
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.active.RentalBagOpReqMsg;
   import com.road.yishi.proto.battle.AttackModeMsg;
   import com.road.yishi.proto.battle.BattleItemMsg;
   import com.road.yishi.proto.battle.BattleReqMsg;
   import com.road.yishi.proto.battle.LoadOverMsg;
   import com.road.yishi.proto.battle.UseSkillMsg;
   import com.road.yishi.proto.campaign.BatterLastInfoMsg;
   import com.road.yishi.proto.campaign.CallBackReqMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.CaptainSpeakMsg;
   import com.road.yishi.proto.campaign.TowerInfoReqMsg;
   import com.road.yishi.proto.castle.CastleReqMsg;
   import com.road.yishi.proto.children.ConfirmMsg;
   import com.road.yishi.proto.item.ItemRemoveMsg;
   import com.road.yishi.proto.item.ItemReqMsg;
   import com.road.yishi.proto.item.ItemUseMsg;
   import com.road.yishi.proto.medal.MedalOpMsg;
   import com.road.yishi.proto.player.LoginReqMsg;
   import com.road.yishi.proto.player.LoginStateMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.player.PlayerDataMsg;
   import com.road.yishi.proto.player.PlayerRenameReqMsg;
   import com.road.yishi.proto.quest.QuestInfo;
   import com.road.yishi.proto.rebate.RebateOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.store.StoreReqMsg;
   import com.road.yishi.proto.worldmap.WorldBossMsg;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.VIPManager;
   import map.internals.data.SpaceNode;
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SocketSendManager
   {
      
      private static var _instance:SocketSendManager;
      
      private var _chatSocket:ByteSocket;
      
      public function SocketSendManager()
      {
         super();
         _chatSocket = SocketManager.instance.socket;
      }
      
      public static function get instance() : SocketSendManager
      {
         if(!_instance)
         {
            _instance = new SocketSendManager();
         }
         return _instance;
      }
      
      public function loginCmd() : void
      {
         _chatSocket.resetKey();
         var _loc2_:PackageOut = new PackageOut(20001);
         var _loc1_:LoginReqMsg = new LoginReqMsg();
         _loc1_.key = PlayerManager.instance.currentPlayerModel.userInfo.key;
         var _loc3_:Array = [Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255)];
         _loc1_.ekeys = _loc3_;
         sendProtoBuffer(_loc2_,_loc1_);
         _chatSocket.setKey(_loc3_);
      }
      
      public function loginState() : void
      {
         var _loc1_:PackageOut = new PackageOut(5020);
         send(_loc1_);
      }
      
      public function loginDataReq(param1:PlayerDataMsg) : void
      {
         var _loc2_:PackageOut = new PackageOut(8224);
         sendProtoBuffer(_loc2_,param1);
      }
      
      public function sendBattlePlotComplete() : void
      {
         var _loc2_:PackageOut = null;
         var _loc1_:BattleReqMsg = null;
         if(BattleManager.getInstance().battleModel)
         {
            _loc2_ = new PackageOut(10022);
            _loc1_ = new BattleReqMsg();
            _loc1_.battleId = BattleManager.getInstance().battleModel.battleId;
            sendProtoBuffer(_loc2_,_loc1_);
         }
      }
      
      public function sendCurrentClientState(param1:uint = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(5035);
         var _loc2_:LoginStateMsg = new LoginStateMsg();
         _loc2_.state = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBattleCount(param1:uint) : void
      {
         var _loc3_:PackageOut = new PackageOut(8282);
         var _loc2_:BatterLastInfoMsg = new BatterLastInfoMsg();
         _loc2_.count = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function send(param1:PackageOut) : void
      {
         _chatSocket.send(param1);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         _chatSocket.sendProtobuffer(param1,param2);
      }
      
      public function sendMoveCastle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(5176);
         var _loc5_:CastleReqMsg = new CastleReqMsg();
         _loc5_.magId = param1;
         _loc5_.posX = param2;
         _loc5_.posY = param3;
         _loc5_.payType = param4;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function sendMoveBagToBag(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int = 0) : void
      {
         var _loc10_:PackageOut = new PackageOut(5005);
         var _loc9_:ItemReqMsg = new ItemReqMsg();
         _loc9_.beginBagType = param1;
         _loc9_.beginObjId = param2;
         _loc9_.beginPos = param3;
         _loc9_.endBagType = param4;
         _loc9_.endPos = param6;
         _loc9_.endObjId = param5;
         _loc9_.count = param7;
         if(param8 > 0)
         {
            _loc9_.objectId = param8;
         }
         sendProtoBuffer(_loc10_,_loc9_);
      }
      
      public function sendUseItem(param1:int, param2:int = 1, param3:int = 1, param4:String = "", param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(5006);
         var _loc6_:ItemUseMsg = new ItemUseMsg();
         _loc6_.pos = param1;
         _loc6_.count = param2;
         _loc6_.bagType = param3;
         _loc6_.battleId = param4;
         _loc6_.friendId = param5;
         sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public function sendUseStelaItem(param1:int, param2:int = 1, param3:int = 1, param4:String = "", param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(8665);
         var _loc6_:ItemUseMsg = new ItemUseMsg();
         _loc6_.pos = param1;
         _loc6_.count = param2;
         _loc6_.bagType = param3;
         _loc6_.battleId = param4;
         _loc6_.friendId = param5;
         sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public function sendUseSexChangeCard(param1:int) : void
      {
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var pos:int = param1;
         SimpleAlertHelper.instance.data = [function(param1:Boolean, param2:Boolean):void
         {
            if(param1)
            {
               sendUseItem(pos);
            }
         }];
         confirm = LanguageMgr.GetTranslation("public.confirm");
         cancel = LanguageMgr.GetTranslation("public.cancel");
         prompt = LanguageMgr.GetTranslation("public.prompt");
         content = LanguageMgr.GetTranslation("yishi.service.managers.SocketSendManager.sendUseSexChangeCard");
         SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,false,true);
      }
      
      public function sendUseVipMoney() : void
      {
         var _loc1_:PackageOut = new PackageOut(8521);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function gameCommand(param1:String, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(10008);
         var _loc5_:UseSkillMsg = new UseSkillMsg();
         _loc5_.battleId = param1;
         _loc5_.heroId = param2;
         _loc5_.skillId = param3;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function gameCommand2(param1:String, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(10522);
         var _loc5_:UseSkillMsg = new UseSkillMsg();
         _loc5_.battleId = param1;
         _loc5_.heroId = param2;
         _loc5_.skillId = param3;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function gameChildCommand(param1:String, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(10516);
         var _loc5_:UseSkillMsg = new UseSkillMsg();
         _loc5_.battleId = param1;
         _loc5_.heroId = param2;
         _loc5_.skillId = param3;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function childnswarSkill(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(25240);
         var _loc4_:UseSkillMsg = new UseSkillMsg();
         _loc4_.battleId = param1;
         _loc4_.heroId = param2;
         _loc4_.skillId = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function gameMonsterCommand(param1:String, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(10520);
         var _loc5_:UseSkillMsg = new UseSkillMsg();
         _loc5_.battleId = param1;
         _loc5_.heroId = param2;
         _loc5_.skillId = param3;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function sendUseBattleTrialProp(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(10507);
         var _loc4_:BattleItemMsg = new BattleItemMsg();
         _loc4_.userId = param3;
         _loc4_.battleId = param1;
         _loc4_.skillTempId = param2;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendBattleAvengerChange(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(10521);
         var _loc4_:UseSkillMsg = new UseSkillMsg();
         _loc4_.battleId = param1;
         _loc4_.skillId = param2;
         _loc4_.heroId = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendUsePetBattleSkill(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(14001);
         var _loc3_:UseSkillMsg = new UseSkillMsg();
         _loc3_.battleId = param1;
         _loc3_.skillId = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendUsePetSacristySkill(param1:String, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(10519);
         var _loc5_:UseSkillMsg = new UseSkillMsg();
         _loc5_.battleId = param1;
         _loc5_.heroId = param2;
         _loc5_.skillId = param3;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function sendLoadOver(param1:String, param2:int) : void
      {
         sendLoadOverByType(10007,param1,param2);
      }
      
      public function sendReinfoLoadOver(param1:String, param2:int) : void
      {
         sendLoadOverByType(10018,param1,param2);
      }
      
      private function sendLoadOverByType(param1:uint, param2:String, param3:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(param1);
         var _loc4_:LoadOverMsg = new LoadOverMsg();
         var _loc5_:int = ArmyManager.instance.army.id;
         _loc4_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc4_.armyId = _loc5_;
         _loc4_.battleId = param2;
         sendProtoBuffer(_loc6_,_loc4_);
      }
      
      public function sendPunch(param1:int, param2:Boolean, param3:Boolean = true) : void
      {
         PunchConfirm(true,false,param1,param2,param3);
      }
      
      private function PunchConfirm(param1:Boolean, param2:Boolean, param3:int, param4:Boolean, param5:Boolean = true) : void
      {
         var _loc7_:PackageOut = null;
         var _loc6_:StoreReqMsg = null;
         if(param1)
         {
            _loc7_ = new PackageOut(5152);
            _loc6_ = new StoreReqMsg();
            if(param5)
            {
               _loc6_.payType = 0;
            }
            else
            {
               _loc6_.payType = 1;
            }
            _loc6_.holePos = param3;
            _loc6_.operate = param4;
            sendProtoBuffer(_loc7_,_loc6_);
         }
      }
      
      public function sendSellItem(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(5007);
         var _loc3_:ItemReqMsg = new ItemReqMsg();
         _loc3_.beginPos = param1;
         _loc3_.beginBagType = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDeleteGoods(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8346);
         var _loc3_:ItemRemoveMsg = new ItemRemoveMsg();
         _loc3_.bagType = param1;
         _loc3_.pos = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendSessionOverToBattle(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5032);
         var _loc4_:CallBackReqMsg = new CallBackReqMsg();
         _loc4_.mapId = param1;
         _loc4_.nodeId = param2;
         _loc4_.cmd = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendUseItemInBattle(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(10499);
         var _loc4_:BattleItemMsg = new BattleItemMsg();
         _loc4_.userId = param2;
         _loc4_.skillTempId = param3;
         _loc4_.battleId = param1;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendAutoAttack(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(10020);
         var _loc3_:AttackModeMsg = new AttackModeMsg();
         _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc3_.battleId = param1;
         _loc3_.armyId = ArmyManager.instance.army.id;
         _loc3_.mode = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendRefreshInviteHall() : void
      {
         var _loc1_:PackageOut = new PackageOut(5027);
         send(_loc1_);
      }
      
      public function sendCoolColosseun(param1:int = 0, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8265);
         var _loc3_:PayTypeMsg = new PayTypeMsg();
         if(!param2)
         {
            _loc3_.payType = 1;
         }
         else
         {
            _loc3_.payType = 2;
         }
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            _loc3_.payType = 0;
         }
         _loc3_.type = 0;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendFriendRefuse() : void
      {
         var _loc1_:PackageOut = new PackageOut(8285);
         send(_loc1_);
      }
      
      public function sendRefuseInvite() : void
      {
         var _loc1_:PackageOut = new PackageOut(8286);
         send(_loc1_);
      }
      
      public function sendRefuseTeamInvite() : void
      {
         var _loc1_:PackageOut = new PackageOut(8746);
         send(_loc1_);
      }
      
      public function requestTowerInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8297);
         var _loc2_:TowerInfoReqMsg = new TowerInfoReqMsg();
         _loc2_.index = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendTowerRiver(param1:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(8300);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendQteGuideComplete() : void
      {
         var _loc1_:PackageOut = new PackageOut(8302);
         send(_loc1_);
      }
      
      public function sendRename(param1:String, param2:int, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8345);
         var _loc4_:PlayerRenameReqMsg = new PlayerRenameReqMsg();
         _loc4_.nickName = param1;
         _loc4_.type = param2;
         _loc4_.pos = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendQuickInvite(param1:Array, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8353);
         var _loc3_:CaptainSpeakMsg = new CaptainSpeakMsg();
         _loc3_.inviteContent = param1;
         _loc3_.type = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendCancelTransport() : void
      {
         var _loc1_:PackageOut = new PackageOut(8535);
         send(_loc1_);
      }
      
      public function sendGetFeedBack(param1:String, param2:String, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8574);
         var _loc4_:RebateOpMsg = new RebateOpMsg();
         _loc4_.id = param1;
         _loc4_.packageid = param2;
         _loc4_.op = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendRemoveBattle() : void
      {
         var _loc2_:PackageOut = new PackageOut(10497);
         var _loc1_:BattleReqMsg = new BattleReqMsg();
         _loc1_.battleId = BattleManager.getInstance().battleModel.battleId;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendMsg(param1:Message) : void
      {
         var _loc2_:PackageOut = new PackageOut(8598);
         sendProtoBuffer(_loc2_,param1);
      }
      
      public function enterPetLand(param1:int = 20000) : void
      {
         var _loc3_:PackageOut = new PackageOut(8694);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendSpaceCollectOver(param1:SpaceNode) : void
      {
         var _loc3_:PackageOut = new PackageOut(8733);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1.nodeId;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function enterCastle(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8747);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param7 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function challengeSelf(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8635);
         var _loc2_:QuestInfo = new QuestInfo();
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function vipCustomAdd() : void
      {
         var _loc1_:PackageOut = new PackageOut(8756);
         send(_loc1_);
      }
      
      public function startDragonSoulTransferCampaign() : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.WarlordsManager.str04"));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(5039);
         var _loc1_:CampaignReqMsg = new CampaignReqMsg();
         _loc1_.paraInt1 = 1;
         _loc1_.paraInt2 = 4401;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendEnterCampaign(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(8332);
         var _loc3_:WorldBossMsg = new WorldBossMsg();
         _loc3_.param1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function sendUseMarrSkill(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(10509);
         var _loc4_:BattleItemMsg = new BattleItemMsg();
         _loc4_.userId = param2;
         _loc4_.skillTempId = param3;
         _loc4_.battleId = param1;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendUseStoneSkill(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(10523);
         var _loc4_:UseSkillMsg = new UseSkillMsg();
         _loc4_.heroId = param2;
         _loc4_.battleId = param1;
         _loc4_.skillId = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendRentalBagOp(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8819);
         var _loc3_:RentalBagOpReqMsg = new RentalBagOpReqMsg();
         _loc3_.opType = 1;
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendConsortiaRentalBagOp(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8995);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function buyStoreBag(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(9569);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         if(param1)
         {
            _loc2_.payType = 0;
         }
         else
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendMedalOp(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8838);
         var _loc3_:MedalOpMsg = new MedalOpMsg();
         _loc3_.opType = param1;
         _loc3_.cost = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendJumpNovice() : void
      {
         var _loc1_:PackageOut = new PackageOut(8871);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function sendPvpCampaignInviteReply(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8967);
         var _loc2_:ConfirmMsg = new ConfirmMsg();
         _loc2_.opType = 3;
         if(param1)
         {
            _loc2_.property1 = 1;
         }
         else
         {
            _loc2_.property1 = 0;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

