package managers
{
   import com.road.yishi.proto.gamebox.DitchNpcInfoListMsg;
   import com.road.yishi.proto.gamebox.DitchNpcInfoMsg;
   import com.road.yishi.proto.gamebox.LastDitchBattleMsg;
   import com.road.yishi.proto.gamebox.LastDitchMsg;
   import com.road.yishi.proto.minigame.DropItemInfoMsg;
   import com.road.yishi.proto.minigame.GemMazeInfoMsg;
   import flash.utils.Dictionary;
   import mvc.module.finaldefense.FinalDefenseModel;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class FinalDefenseManager
   {
      
      private static var _ins:FinalDefenseManager;
      
      private var _model:FinalDefenseModel;
      
      public function FinalDefenseManager()
      {
         super();
         _model = new FinalDefenseModel();
      }
      
      public static function get ins() : FinalDefenseManager
      {
         if(_ins == null)
         {
            _ins = new FinalDefenseManager();
         }
         return _ins;
      }
      
      public function get model() : FinalDefenseModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 258,onInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 262,onAddNPC);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 264,onGameStar);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 267,onBattleResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 270,onBoxReward);
      }
      
      private function onInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DitchNpcInfoMsg = null;
         var _loc3_:DitchNpcInfoData = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:LastDitchMsg = new LastDitchMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as LastDitchMsg;
         if(_loc2_.hasDitchTempId1)
         {
            _model.info.ditchTempId1 = _loc2_.ditchTempId1;
         }
         if(_loc2_.hasDitchTempId2)
         {
            _model.info.ditchTempId2 = _loc2_.ditchTempId2;
         }
         if(_loc2_.hasDitchTempId3)
         {
            _model.info.ditchTempId3 = _loc2_.ditchTempId3;
         }
         if(_loc2_.hasDitchTempId4)
         {
            _model.info.ditchTempId4 = _loc2_.ditchTempId4;
         }
         if(_loc2_.hasSkillCount1)
         {
            _model.info.skillCount1 = _loc2_.skillCount1;
         }
         if(_loc2_.hasSkillCount2)
         {
            _model.info.skillCount2 = _loc2_.skillCount2;
         }
         if(_loc2_.hasSkillCount3)
         {
            _model.info.skillCount3 = _loc2_.skillCount3;
         }
         if(_loc2_.hasEnergy)
         {
            _model.info.energy = _loc2_.energy;
         }
         if(_loc2_.hasScore)
         {
            _model.info.score = _loc2_.score;
         }
         if(_loc2_.hasBoxTakeMark)
         {
            _model.info.boxTakeMark = _loc2_.boxTakeMark;
         }
         if(_loc2_.op != 2)
         {
            if(_loc2_.hasRounds)
            {
               _model.info.rounds = _loc2_.rounds;
            }
         }
         if(_loc2_.hasId)
         {
            _model.info.id = _loc2_.id;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.ditchNpcInfo.length)
         {
            _loc5_ = _loc2_.ditchNpcInfo[_loc4_];
            _loc3_ = new DitchNpcInfoData();
            _loc3_.id = _loc5_.id;
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.types = _loc5_.types;
            _loc3_.bornPoint = _loc5_.bornPoint;
            _loc3_.rowIndex = _loc5_.rowIndex;
            _model.info.selfNPCList[_loc3_.id] = _loc3_;
            _loc4_++;
         }
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_INFO");
      }
      
      private function onAddNPC(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DitchNpcInfoMsg = null;
         var _loc3_:DitchNpcInfoData = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:DitchNpcInfoListMsg = new DitchNpcInfoListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as DitchNpcInfoListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.ditchNpcInfo.length)
         {
            _loc5_ = _loc2_.ditchNpcInfo[_loc4_];
            _loc3_ = new DitchNpcInfoData();
            _loc3_.id = _loc5_.id;
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.types = _loc5_.types;
            _loc3_.bornPoint = _loc5_.bornPoint;
            _loc3_.rowIndex = _loc5_.rowIndex;
            _model.npcList[_loc3_.id] = _loc3_;
            _loc4_++;
         }
         if(_loc2_.hasLeftSecond)
         {
            _model.info.leftSecond = _loc2_.leftSecond;
         }
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_ADD_NPC");
      }
      
      private function onGameStar(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DitchNpcInfoListMsg = new DitchNpcInfoListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DitchNpcInfoListMsg;
         if(_loc2_.hasRounds)
         {
            _model.info.rounds = _loc2_.rounds;
         }
         if(_loc2_.hasLeftSecond)
         {
            _model.info.leftSecond = _loc2_.leftSecond;
         }
         model.isGameStar = true;
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_GAME_STAR");
      }
      
      public function getInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9560);
         var _loc1_:LastDitchMsg = new LastDitchMsg();
         _loc1_.op = 5;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function exitGame() : void
      {
         var _loc2_:PackageOut = new PackageOut(9560);
         var _loc1_:LastDitchMsg = new LastDitchMsg();
         _loc1_.op = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function starTrun() : void
      {
         var _loc2_:PackageOut = new PackageOut(9560);
         var _loc1_:LastDitchMsg = new LastDitchMsg();
         _loc1_.op = 6;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function monsterMove(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9562);
         var _loc3_:DitchNpcInfoMsg = new DitchNpcInfoMsg();
         _loc3_.id = param1;
         _loc3_.bornPoint = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAttack(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9563);
         var _loc3_:LastDitchBattleMsg = new LastDitchBattleMsg();
         _loc3_.attakDitchId = param1;
         _loc3_.defenceDitchId = param2;
         _loc3_.op = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function onBattleResult(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DitchNpcInfoMsg = null;
         var _loc4_:DitchNpcInfoData = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:LastDitchBattleMsg = new LastDitchBattleMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as LastDitchBattleMsg;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.ditchNpcInfo.length)
         {
            _loc6_ = _loc2_.ditchNpcInfo[_loc5_];
            _loc4_ = new DitchNpcInfoData();
            _loc4_.id = _loc6_.id;
            _loc4_.templateId = _loc6_.templateId;
            _loc4_.isBeaten = _loc6_.isBeaten;
            _loc4_.hp = _loc6_.hp;
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         if(_loc2_.op == 1)
         {
            NotificationManager.instance.sendNotification("FINAL_DEFENSE_BATTLE_RESULT",_loc3_);
         }
         else if(_loc2_.op == 2)
         {
            var _loc8_:String = "skillCount" + _loc2_.useSkillId;
            var _loc9_:Number = model.info[_loc8_] - 1;
            model.info[_loc8_] = _loc9_;
            NotificationManager.instance.sendNotification("FINAL_DEFENSE_USE_SKILL",_loc2_.useSkillId);
         }
      }
      
      public function npcLvUp(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(9560);
         var _loc4_:LastDitchMsg = new LastDitchMsg();
         _loc4_.op = 2;
         _loc4_.id = param1;
         _loc4_.nextTempIndex = param3;
         _loc4_.npcIndex = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function buySkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9560);
         var _loc2_:LastDitchMsg = new LastDitchMsg();
         _loc2_.op = 3;
         _loc2_.skillIndex = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function useBuySkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9563);
         var _loc2_:LastDitchBattleMsg = new LastDitchBattleMsg();
         _loc2_.useSkillId = param1;
         _loc2_.op = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function onBoxReward(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:DropItemInfoMsg = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemMazeInfoMsg = new GemMazeInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as GemMazeInfoMsg;
         _loc2_.dropItemList.length;
         model.dropDict = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.dropItemList.length)
         {
            _loc5_ = _loc2_.dropItemList[_loc3_];
            if(!model.dropDict[_loc5_.score])
            {
               model.dropDict[_loc5_.score] = [];
            }
            (model.dropDict[_loc5_.score] as Array).push({
               "tempId":_loc5_.itemTempId,
               "count":_loc5_.count
            });
            _loc3_++;
         }
      }
      
      public function getBox(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9560);
         var _loc2_:LastDitchMsg = new LastDitchMsg();
         _loc2_.op = 1;
         _loc2_.boxId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function cleanData() : void
      {
         _model.npcList = new Dictionary();
         model.info.selfNPCList = new Dictionary();
         model.info.leftSecond = 0;
         model.info.rounds = 0;
      }
   }
}

