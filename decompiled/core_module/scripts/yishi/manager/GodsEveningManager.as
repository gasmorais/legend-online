package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.gods.CrossGodsInfoMsg;
   import com.road.yishi.proto.gods.CrossGodsMsg;
   import com.road.yishi.proto.gods.GodsPlayerInfoMsg;
   import com.road.yishi.proto.gods.GodsTaskInfoMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import events.GodsEveningEvent;
   import flash.events.EventDispatcher;
   import mvc.module.godsevening.GERankItemPersonData;
   import mvc.module.godsevening.GERankItemServerData;
   import mvc.module.godsevening.GodsEveningModel;
   import ui.toptoolbar.TopToolsBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class GodsEveningManager extends EventDispatcher
   {
      
      private static var _instance:GodsEveningManager;
      
      private var _model:GodsEveningModel;
      
      public function GodsEveningManager()
      {
         super();
         _model = new GodsEveningModel();
      }
      
      public static function get instance() : GodsEveningManager
      {
         if(_instance == null)
         {
            _instance = new GodsEveningManager();
         }
         return _instance;
      }
      
      public function get model() : GodsEveningModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 242,__mainInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 245,__npcNodeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 247,__campaignInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 246,__stateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 248,__mainFrameRankInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4171,__godsBufferHandler);
      }
      
      private function __godsBufferHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.bossDebuffId = _loc2_.param1;
         model.bossDebuffShowFlag = _loc2_.param2;
         dispatchEvent(new GodsEveningEvent("BUFF_LORD_KILLDE"));
      }
      
      private function __mainFrameRankInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:GERankItemPersonData = null;
         var _loc7_:GodsPlayerInfoMsg = null;
         var _loc4_:int = 0;
         var _loc8_:GERankItemServerData = null;
         var _loc9_:CrossGodsInfoMsg = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CrossGodsMsg;
         if(_loc2_.myInfo)
         {
            model.teamId = _loc2_.myInfo.teamId;
            model.readyScore = _loc2_.myInfo.readyScore;
            model.readyOrder = _loc2_.myInfo.readyOrder;
            model.finalScore = _loc2_.myInfo.finalScore;
            model.finalOrder = _loc2_.myInfo.finalOrder;
            model.totalRank = _loc2_.myInfo.rank;
         }
         model.serverOrder = Int64Utils.int64ToNumber(_loc2_.param2);
         model.serverScore = _loc2_.param3;
         _loc2_.playerInfo.sort(playerRankSortFun);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.playerInfo.length)
         {
            _loc7_ = _loc2_.playerInfo[_loc4_];
            _loc3_ = model.mainFramePersonRankDic[_loc4_ + 1];
            if(_loc3_ == null)
            {
               _loc3_ = new GERankItemPersonData();
               model.mainFramePersonRankDic[_loc4_ + 1] = _loc3_;
            }
            _loc3_.rank = _loc4_ + 1;
            _loc3_.nickName = _loc7_.nickName;
            _loc3_.serverName = _loc7_.serverName;
            _loc3_.fightPower = _loc7_.fightPower;
            _loc3_.score = _loc7_.readyScore + _loc7_.finalScore;
            _loc4_++;
         }
         _loc2_.info.sort(serverRankSortFun);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.info.length)
         {
            _loc9_ = _loc2_.info[_loc5_];
            _loc8_ = model.mainFrameServerRankDic[_loc5_ + 1];
            if(_loc8_ == null)
            {
               _loc8_ = new GERankItemServerData();
               model.mainFrameServerRankDic[_loc5_ + 1] = _loc8_;
            }
            _loc8_.rank = _loc5_ + 1;
            _loc8_.serverName = _loc9_.serverName;
            _loc8_.fightPower = _loc9_.fightPower;
            _loc8_.score = _loc9_.readyScore + _loc9_.finalScore;
            _loc5_++;
         }
         dispatchEvent(new GodsEveningEvent("MAIN_FRAME_RANK_INFO"));
      }
      
      private function playerRankSortFun(param1:GodsPlayerInfoMsg, param2:GodsPlayerInfoMsg) : int
      {
         var _loc4_:int = param1.readyScore + param1.finalScore;
         var _loc3_:int = param2.readyScore + param2.finalScore;
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      private function serverRankSortFun(param1:CrossGodsInfoMsg, param2:CrossGodsInfoMsg) : int
      {
         var _loc4_:int = param1.readyScore + param1.finalScore;
         var _loc3_:int = param2.readyScore + param2.finalScore;
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      private function __stateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.gameState = _loc2_.param1;
         model.isShowIcon = _loc2_.param7;
         dispatchEvent(new GodsEveningEvent("IS_SHOWICON"));
         TopToolsBar.instance.godsEveningLightState = model.gameState;
      }
      
      private function __mainInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CrossGodsMsg;
         model.gameState = _loc2_.gameType;
         model.openTime = DateFormatter.parse(_loc2_.openTime,"YYYY-MM-DD hh:mm:ss");
         model.endTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss");
         for each(var _loc3_:CrossGodsInfoMsg in _loc2_.info)
         {
            model.teamDataDic[_loc3_.teamId] = _loc3_.serverName;
         }
         dispatchEvent(new GodsEveningEvent("MAIN_FRAME_INFO"));
      }
      
      private function __campaignInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:GERankItemPersonData = null;
         var _loc14_:GERankItemServerData = null;
         var _loc12_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = _loc12_.readBody(_loc2_) as CrossGodsMsg;
         if(_loc2_.myInfo)
         {
            model.teamId = _loc2_.myInfo.teamId;
            model.readyScore = _loc2_.myInfo.readyScore;
            model.readyOrder = _loc2_.myInfo.readyOrder;
            model.finalScore = _loc2_.myInfo.finalScore;
            model.finalOrder = _loc2_.myInfo.finalOrder;
         }
         var _loc16_:Boolean = false;
         for each(var _loc10_:CrossGodsInfoMsg in _loc2_.info)
         {
            model.teamDataDic[_loc10_.teamId] = _loc10_.serverName;
            if(_loc10_.teamId == model.teamId)
            {
               model.inspireLevel = _loc10_.bufferLv;
               _loc16_ = true;
            }
         }
         var _loc9_:Boolean = false;
         for each(var _loc5_:GodsTaskInfoMsg in _loc2_.taskInfo)
         {
            model.taskProgressDic[_loc5_.templateId] = _loc5_.curCount;
            model.taskGotRewardDic[_loc5_.templateId] = _loc5_.hasReward;
            model.taskCompleteCountsDic[_loc5_.templateId] = _loc5_.repeatCount;
            _loc9_ = true;
         }
         var _loc15_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc8_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(model.gameState == 1)
         {
            for each(var _loc6_:GodsPlayerInfoMsg in _loc2_.playerInfo)
            {
               _loc4_ = model.personRankDataDic[_loc6_.readyOrder];
               if(_loc4_ == null)
               {
                  _loc4_ = new GERankItemPersonData();
                  model.personRankDataDic[_loc6_.readyOrder] = _loc4_;
               }
               _loc4_.userId = _loc6_.userId;
               _loc4_.rank = _loc6_.readyOrder;
               _loc4_.nickName = _loc6_.nickName;
               _loc4_.serverName = _loc6_.serverName;
               _loc4_.score = _loc6_.readyScore;
               _loc4_.teamId = _loc6_.teamId;
               _loc15_ = true;
            }
            if(selfOrderInRank != 0)
            {
               model.readyOrder = selfOrderInRank;
            }
            for each(var _loc13_:CrossGodsInfoMsg in _loc2_.info)
            {
               _loc14_ = model.serverRankDataDic[_loc13_.readyOrder];
               if(_loc14_ == null)
               {
                  _loc14_ = new GERankItemServerData();
                  model.serverRankDataDic[_loc13_.readyOrder] = _loc14_;
               }
               _loc14_.rank = _loc13_.readyOrder;
               _loc14_.serverName = _loc13_.serverName;
               _loc14_.score = _loc13_.readyScore;
               _loc14_.teamId = _loc13_.teamId;
               _loc3_ = true;
            }
         }
         else if(model.gameState == 2)
         {
            for each(var _loc7_:GodsPlayerInfoMsg in _loc2_.playerInfo)
            {
               _loc4_ = model.personRankDataDic[_loc7_.finalOrder];
               if(_loc4_ == null)
               {
                  _loc4_ = new GERankItemPersonData();
                  model.personRankDataDic[_loc7_.finalOrder] = _loc4_;
               }
               _loc4_.userId = _loc7_.userId;
               _loc4_.rank = _loc7_.finalOrder;
               _loc4_.nickName = _loc7_.nickName;
               _loc4_.serverName = _loc7_.serverName;
               _loc4_.score = _loc7_.finalScore;
               _loc4_.teamId = _loc7_.teamId;
               _loc15_ = true;
               if(_loc7_.userId == _loc8_.userId && _loc7_.serverName == _loc8_.serviceName)
               {
                  model.finalOrder = _loc7_.finalOrder;
               }
            }
            if(selfOrderInRank != 0)
            {
               model.finalOrder = selfOrderInRank;
            }
            for each(var _loc11_:CrossGodsInfoMsg in _loc2_.info)
            {
               _loc14_ = model.serverRankDataDic[_loc11_.finalOrder];
               if(_loc14_ == null)
               {
                  _loc14_ = new GERankItemServerData();
                  model.serverRankDataDic[_loc11_.finalOrder] = _loc14_;
               }
               _loc14_.rank = _loc11_.finalOrder;
               _loc14_.serverName = _loc11_.serverName;
               _loc14_.score = _loc11_.finalScore;
               _loc14_.teamId = _loc11_.teamId;
               _loc3_ = true;
            }
         }
         dispatchEvent(new GodsEveningEvent("MY_INFO"));
         if(_loc9_)
         {
            dispatchEvent(new GodsEveningEvent("TASK_INFO"));
         }
         if(_loc15_)
         {
            dispatchEvent(new GodsEveningEvent("PERSON_RANK_INFO"));
         }
         if(_loc3_)
         {
            dispatchEvent(new GodsEveningEvent("SERVER_RANK_INFO"));
         }
         if(_loc16_)
         {
            dispatchEvent(new GodsEveningEvent("INSPIRE_INFO"));
         }
      }
      
      private function get selfOrderInRank() : int
      {
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         for each(var _loc1_:GERankItemPersonData in model.personRankDataDic)
         {
            if(_loc1_.userId == _loc2_.userId && _loc1_.serverName == _loc2_.serviceName)
            {
               return _loc1_.rank;
            }
         }
         return 0;
      }
      
      private function __npcNodeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CrossGodsMsg;
         for each(var _loc4_:GodsPlayerInfoMsg in _loc2_.playerInfo)
         {
            _loc3_ = model.npcNodeInfoDic[_loc4_.teamId + "_" + _loc4_.id];
            if(_loc3_ == null)
            {
               _loc3_ = new ThaneInfo();
               model.npcNodeInfoDic[_loc4_.teamId + "_" + _loc4_.id] = _loc3_;
            }
            _loc3_.templateId = _loc4_.templateId;
            _loc3_.nickName = _loc4_.nickName;
            _loc3_.serviceName = _loc4_.serverName;
            _loc3_.snsInfo.headId = _loc4_.headId;
            if(!StringHelper.isNullOrEmpty(_loc4_.wingAvata))
            {
               _loc3_.wingAvata = _loc4_.wingAvata;
            }
            if(!StringHelper.isNullOrEmpty(_loc4_.slotAvata))
            {
               _loc3_.armsEquipAvata = _loc4_.slotAvata;
            }
            if(!StringHelper.isNullOrEmpty(_loc4_.clothAvate))
            {
               _loc3_.bodyEquipAvata = _loc4_.clothAvate;
            }
            if(!StringHelper.isNullOrEmpty(_loc4_.hatAvata))
            {
               _loc3_.hairEquipAvata = _loc4_.hatAvata;
            }
            if(!StringHelper.isNullOrEmpty(_loc4_.fashionArmAvata))
            {
               _loc3_.armsFashionAvata = _loc4_.fashionArmAvata;
            }
            if(!StringHelper.isNullOrEmpty(_loc4_.fashionClothAvata))
            {
               _loc3_.bodyFashionAvata = _loc4_.fashionClothAvata;
            }
         }
         GodsEveningManager.instance.model.copyNodeData();
         dispatchEvent(new GodsEveningEvent("NPC_NODE_INFO"));
      }
      
      public function sendRequestMainFrameInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(5101);
         var _loc1_:CrossGodsMsg = new CrossGodsMsg();
         _loc1_.opType = 2;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendRequstMainFrameRankInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5101);
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_.opType = 3;
         _loc2_.param1 = Int64Utils.numberToInt64(param1);
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendEnterCampaign() : void
      {
         var _loc2_:PackageOut = new PackageOut(5101);
         var _loc1_:CrossGodsMsg = new CrossGodsMsg();
         _loc1_.opType = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendGetTaskReward(param1:int, param2:int, param3:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(25041);
         var _loc4_:CrossGodsMsg = new CrossGodsMsg();
         _loc4_.opType = 1;
         _loc4_.param1 = Int64Utils.numberToInt64(param1);
         _loc4_.userId = param2;
         _loc4_.serverName = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendCancelTransport(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25041);
         var _loc3_:CrossGodsMsg = new CrossGodsMsg();
         _loc3_.opType = 2;
         _loc3_.userId = param1;
         _loc3_.serverName = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendInspire(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5101);
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_.opType = 4;
         _loc2_.param1 = Int64Utils.numberToInt64(param1);
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

