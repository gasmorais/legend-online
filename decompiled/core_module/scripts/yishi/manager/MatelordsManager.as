package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.matelords.AltarShopInfoMsg;
   import com.road.yishi.proto.matelords.AltarShopListMsg;
   import com.road.yishi.proto.matelords.MateLordsInfoMsg;
   import com.road.yishi.proto.matelords.MateLordsListMsg;
   import mvc.module.matelords.MatelordsDemonShopInfo;
   import mvc.module.matelords.MatelordsModel;
   import mvc.module.matelords.MatelordsPlayerInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class MatelordsManager
   {
      
      public static const APPELL_ID:int = 163;
      
      public static const DEMON_LIST_REQUEST:int = 1;
      
      public static const DEMON_ITEM_BUY:int = 2;
      
      public static const SHOP_ITEM1:int = -1;
      
      public static const SHOP_ITEM2:int = -2;
      
      public static const REDUCE_PRECENT1:int = 10;
      
      public static const REDUCE_PRECENT2:int = 5;
      
      private static var _instance:MatelordsManager;
      
      private var _model:MatelordsModel;
      
      public function MatelordsManager()
      {
         super();
      }
      
      public static function get instance() : MatelordsManager
      {
         if(!_instance)
         {
            _instance = new MatelordsManager();
         }
         return _instance;
      }
      
      public function get model() : MatelordsModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new MatelordsModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4799,__matelordsMainInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4798,__matelordsRoomInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 365,__matelordsDemonShopHandler);
      }
      
      private function __matelordsMainInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:MatelordsPlayerInfo = null;
         var _loc3_:ThaneInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MateLordsListMsg = new MateLordsListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MateLordsListMsg;
         resovleMateLordsInfo(_loc2_);
         model.rankList = new Vector.<MatelordsPlayerInfo>();
         for each(var _loc4_:MateLordsInfoMsg in _loc2_.info)
         {
            _loc6_ = new MatelordsPlayerInfo();
            resovleTeamPlayerInfo(_loc4_,_loc6_);
            model.rankList.push(_loc6_);
         }
         if(_loc2_.isSign)
         {
            model.topPlayerList = [];
            model.topPlayerList.push(ArmyManager.instance.thane);
            _loc3_ = new ThaneInfo();
            if(_loc2_.hasJob)
            {
               _loc3_.job = _loc2_.job;
            }
            if(_loc2_.hasSexJob)
            {
               _loc3_.templateId = _loc2_.sexJob;
            }
            if(_loc2_.hasNickName)
            {
               _loc3_.nickName = _loc2_.nickName;
            }
            if(_loc3_.hairFashionAvata != _loc2_.fashionHair)
            {
               _loc3_.hairFashionAvata = _loc2_.fashionHair;
            }
            if(_loc3_.cloakAvata != _loc2_.fashionHat)
            {
               _loc3_.cloakAvata = _loc2_.fashionHat;
            }
            if(_loc3_.wingAvata != _loc2_.fashionWing)
            {
               _loc3_.wingAvata = _loc2_.fashionWing;
            }
            if(_loc2_.fashionArm)
            {
               if(_loc2_.fashionArm.indexOf("fashion") > -1)
               {
                  if(_loc3_.armsFashionAvata != _loc2_.fashionArm)
                  {
                     _loc3_.armsFashionAvata = _loc2_.fashionArm;
                  }
               }
               else if(_loc3_.armsEquipAvata != _loc2_.fashionArm)
               {
                  _loc3_.armsEquipAvata = _loc2_.fashionArm;
               }
            }
            if(_loc2_.fashionCloth)
            {
               if(_loc2_.fashionCloth.indexOf("fashion") > -1)
               {
                  if(_loc3_.bodyFashionAvata != _loc2_.fashionCloth)
                  {
                     _loc3_.bodyFashionAvata = _loc2_.fashionCloth;
                  }
               }
               else if(_loc3_.bodyEquipAvata != _loc2_.fashionCloth)
               {
                  _loc3_.bodyEquipAvata = _loc2_.fashionCloth;
               }
            }
            model.topPlayerList.push(_loc3_);
         }
         model.commitChanges();
      }
      
      private function __matelordsRoomInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MatelordsPlayerInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MateLordsListMsg = new MateLordsListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MateLordsListMsg;
         resovleMateLordsInfo(_loc2_);
         model.roomRankList = new Vector.<MatelordsPlayerInfo>();
         for each(var _loc3_:MateLordsInfoMsg in _loc2_.info)
         {
            _loc5_ = new MatelordsPlayerInfo();
            resovleTeamPlayerInfo(_loc3_,_loc5_);
            model.roomRankList.push(_loc5_);
         }
         model.commitChanges();
      }
      
      private function resovleMateLordsInfo(param1:MateLordsListMsg) : void
      {
         if(param1.hasIsOver)
         {
            model.isOver = param1.isOver;
         }
         if(param1.hasIsSign)
         {
            model.isSign = param1.isSign;
         }
         if(param1.hasIsOpen)
         {
            model.isOpen = param1.isOpen;
         }
         if(param1.hasOrder)
         {
            model.order = param1.order;
         }
         if(param1.hasTeamType)
         {
            model.teamType = param1.teamType;
         }
         if(param1.hasOpenTime)
         {
            model.openTime = param1.openTime;
         }
         if(param1.hasTotalScore)
         {
            model.totalScore = param1.totalScore;
         }
         if(param1.hasAltarScore)
         {
            model.altarScore = param1.altarScore;
         }
         if(param1.hasInspirLevel)
         {
            model.inspirLevel = param1.inspirLevel;
         }
         if(param1.hasMaxTurnCount)
         {
            model.maxTurnCount = param1.maxTurnCount;
         }
         if(param1.hasCurrentTurn)
         {
            model.currentTurn = param1.currentTurn;
         }
         if(param1.hasLeftTime)
         {
            model.leftTime = param1.leftTime / 1000;
         }
         if(param1.hasMasterUserId)
         {
            model.masterUserId = param1.masterUserId;
         }
         if(param1.hasTeamUid)
         {
            model.teamUid = param1.teamUid;
         }
         if(param1.hasTeamName)
         {
            model.teamName = param1.teamName;
         }
         if(param1.hasWarIndex)
         {
            model.warIndex = param1.warIndex;
         }
      }
      
      private function resovleTeamPlayerInfo(param1:MateLordsInfoMsg, param2:MatelordsPlayerInfo) : void
      {
         if(param1.hasUuid)
         {
            param2.uuid = param1.uuid;
         }
         if(param1.hasTeamUid)
         {
            param2.teamUid = param1.teamUid;
         }
         if(param1.hasUserId)
         {
            param2.userId = param1.userId;
         }
         if(param1.hasServerName)
         {
            param2.serverName = param1.serverName;
         }
         if(param1.hasUserKeys)
         {
            param2.userKeys = param1.userKeys;
         }
         if(param1.hasNickName)
         {
            param2.nickName = param1.nickName;
         }
         if(param1.hasTeamType)
         {
            param2.teamType = param1.teamType;
         }
         if(param1.hasJob)
         {
            param2.job = param1.job;
         }
         if(param1.hasSexJob)
         {
            param2.sexJob = param1.sexJob;
         }
         if(param1.hasGrades)
         {
            param2.grades = param1.grades;
         }
         if(param1.hasFightPower)
         {
            param2.fightPower = param1.fightPower;
         }
         if(param1.hasCurreOrder)
         {
            param2.curOrder = param1.curreOrder;
         }
         if(param1.hasTurnCount)
         {
            param2.turnCount = param1.turnCount;
         }
         if(param1.hasTotalScore)
         {
            param2.totalScore = param1.totalScore;
         }
         if(param1.hasWarIndex)
         {
            param2.warIndex = param1.warIndex;
         }
      }
      
      private function __matelordsDemonShopHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MatelordsDemonShopInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:AltarShopListMsg = new AltarShopListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as AltarShopListMsg;
         if(_loc2_.hasAltarScore)
         {
            model.altarScore = _loc2_.altarScore;
            model.updateAltarScore();
         }
         model.demonShopList = [];
         for each(var _loc5_:AltarShopInfoMsg in _loc2_.info)
         {
            _loc3_ = new MatelordsDemonShopInfo();
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.price = _loc5_.price;
            _loc3_.leftCount = _loc5_.leftCount;
            _loc3_.maxCount = _loc5_.maxCount;
            model.demonShopList.push(_loc3_);
         }
         model.demonShopList.sortOn("templateId",16);
         model.updateShopList();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function matelordsMainInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(8979);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function matelordsSignup() : void
      {
         var _loc1_:PackageOut = new PackageOut(8975);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function matelordsCreateRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(8976);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function sendRequestDemoOp(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9611);
         var _loc3_:AltarShopListMsg = new AltarShopListMsg();
         _loc3_.op = param1;
         _loc3_.templateId = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function matelordsInspire() : void
      {
         var _loc1_:PackageOut = new PackageOut(8981);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

