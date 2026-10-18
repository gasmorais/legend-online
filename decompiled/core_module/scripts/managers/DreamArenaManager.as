package managers
{
   import com.road.yishi.proto.module.DreamArenaFightMsg;
   import com.road.yishi.proto.module.DreamArenaMatchMsg;
   import com.road.yishi.proto.module.DreamArenaUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class DreamArenaManager
   {
      
      private static var _instance:DreamArenaManager;
      
      private var _model:DreamArenaModel;
      
      public var needOpenReportFrame:Boolean = false;
      
      public function DreamArenaManager()
      {
         super();
      }
      
      public static function get instance() : DreamArenaManager
      {
         if(!_instance)
         {
            _instance = new DreamArenaManager();
         }
         return _instance;
      }
      
      public function get model() : DreamArenaModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new DreamArenaModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4581,__dreamArenaUserInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4582,__dreamArenaFightHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4583,__dreamArenaMatchHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4584,__dreamArenaTicketHandler);
      }
      
      private function __dreamArenaUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DreamArenaUserMsg = new DreamArenaUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DreamArenaUserMsg;
         if(_loc2_.hasUserId)
         {
            model.selfInfo.userId = _loc2_.userId;
         }
         if(_loc2_.hasHeroId)
         {
            model.selfInfo.heroId = _loc2_.heroId;
         }
         if(_loc2_.hasHeroPetId)
         {
            model.selfInfo.heroPetId = _loc2_.heroPetId;
         }
         if(_loc2_.hasGoddessId)
         {
            model.selfInfo.goddessId = _loc2_.goddessId;
         }
         if(_loc2_.hasMainChildId)
         {
            model.selfInfo.mainChildId = _loc2_.mainChildId;
         }
         if(_loc2_.hasMainChildPetId)
         {
            model.selfInfo.mainChildPetId = _loc2_.mainChildPetId;
         }
         if(_loc2_.hasSalveChildId)
         {
            model.selfInfo.slaveChildId = _loc2_.salveChildId;
         }
         if(_loc2_.hasSalveChildPetId)
         {
            model.selfInfo.slaveChildPetId = _loc2_.salveChildPetId;
         }
         if(_loc2_.hasArtifactId)
         {
            model.selfInfo.artifactId = _loc2_.artifactId;
         }
         if(_loc2_.hasSkillIndex1)
         {
            model.selfInfo.skillIndex1 = _loc2_.skillIndex1;
         }
         if(_loc2_.hasSkillIndex2)
         {
            model.selfInfo.skillIndex2 = _loc2_.skillIndex2;
         }
         if(_loc2_.hasTalismanTempId1)
         {
            model.selfInfo.talismanTempId1 = _loc2_.talismanTempId1;
         }
         if(_loc2_.hasTalismanTempId2)
         {
            model.selfInfo.talismanTempId2 = _loc2_.talismanTempId2;
         }
         if(_loc2_.hasTalismanSkillId1)
         {
            model.selfInfo.talismanSkillId1 = _loc2_.talismanSkillId1;
         }
         if(_loc2_.hasTalismanSkillId2)
         {
            model.selfInfo.talismanSkillId2 = _loc2_.talismanSkillId2;
         }
         if(_loc2_.hasArmoryId1)
         {
            model.selfInfo.armoryId1 = _loc2_.armoryId1;
         }
         if(_loc2_.hasArmoryId2)
         {
            model.selfInfo.armoryId2 = _loc2_.armoryId2;
         }
         if(_loc2_.hasArmoryId3)
         {
            model.selfInfo.armoryId3 = _loc2_.armoryId3;
         }
         if(_loc2_.hasRuneId1)
         {
            model.selfInfo.runeId1 = _loc2_.runeId1;
         }
         if(_loc2_.hasRuneId2)
         {
            model.selfInfo.runeId2 = _loc2_.runeId2;
         }
         if(_loc2_.hasTitanSkills)
         {
            model.selfInfo.titanSkills = _loc2_.titanSkills;
         }
         if(_loc2_.hasHeroPos)
         {
            model.selfInfo.heroFightPos = _loc2_.heroPos;
         }
         if(_loc2_.hasDragonSkill)
         {
            model.selfInfo.dragonSkill = _loc2_.dragonSkill;
         }
         if(_loc2_.hasDragonPassiveSkill)
         {
            model.selfInfo.dragonPassiveSkill = _loc2_.dragonPassiveSkill;
         }
         model.selfInfo.setOtherData();
         model.clientSelectDic.clear();
         MsgMan.notifyObserver("USER_INFO_CHANGE");
      }
      
      private function __dreamArenaFightHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DreamArenaFightMsg = new DreamArenaFightMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DreamArenaFightMsg;
         if(_loc2_.hasIsOpen)
         {
            model.isOpen = _loc2_.isOpen;
         }
         if(_loc2_.hasWinCount)
         {
            model.winCount = _loc2_.winCount;
         }
         if(_loc2_.hasLostCount)
         {
            model.loseCount = _loc2_.lostCount;
         }
         if(_loc2_.hasIsReport && _loc2_.isReport)
         {
            model.reportData = {
               "winCount":model.winCount,
               "loseCount":model.loseCount
            };
         }
         MsgMan.notifyObserver("FIGHT_INFO_CHANGE");
      }
      
      private function winRewardReport(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dreamarena","REPORT_FRAME");
      }
      
      private function __dreamArenaMatchHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DreamArenaMatchMsg = new DreamArenaMatchMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DreamArenaMatchMsg;
         MsgMan.notifyObserver("MATCH_STATE_UPDATE",_loc2_.state);
      }
      
      private function __dreamArenaTicketHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.hasTicket = _loc2_.param1;
         MsgMan.notifyObserver("DREAM_ARENA_TICKET_CHANGE");
      }
      
      public function sendDreamArenaRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8654);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendHeroSelect(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8654);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 2;
         _loc3_.templateId = param1;
         _loc3_.index = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDragonTalkerSelect(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         var _loc7_:PackageOut = new PackageOut(8654);
         var _loc6_:PlayerOpMsg = new PlayerOpMsg();
         _loc6_.op = 2;
         _loc6_.templateId = param1;
         _loc6_.index = param2;
         _loc6_.id = param3;
         _loc6_.param1 = param4;
         _loc6_.param2 = param5;
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public function sendPetOrGoddessSelect(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8654);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.templateId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendArtifactSelect(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8654);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 4;
         _loc3_.templateId = param1;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendTitanOrRuneSelect(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8654);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendChildSelect(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8654);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.templateId = param2;
         _loc4_.id = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendHeroPosSelect(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8654);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 10;
         _loc2_.id = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

