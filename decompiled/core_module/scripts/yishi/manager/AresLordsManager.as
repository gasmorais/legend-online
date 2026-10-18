package yishi.manager
{
   import com.road.yishi.proto.areslords.AresLordsInfoMsg;
   import com.road.yishi.proto.areslords.AresLordsListMsg;
   import com.road.yishi.proto.areslords.AresSkillListMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.CommonMsgList;
   import events.AresLordsEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsModel;
   import mvc.module.areslords.AresLordsPlayerInfo;
   import mvc.module.areslords.AresLordsRankInfo;
   import mvc.module.areslords.AresLordsRoomInfo;
   import mvc.module.areslords.AresLordsSignUpInfo;
   import mvc.module.areslords.AresLordsSkillInfo;
   import mvc.module.areslords.AresLordsSkillListInfo;
   import mvc.module.areslords.AresLordsStartInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AresLordsManager
   {
      
      private static var _instance:AresLordsManager;
      
      public static const CLIENT_OP_REQOPENTABLE:int = 1;
      
      public static const CLIENT_OP_REQUESTSIGNS:int = 2;
      
      public static const CLIENT_OP_REFERSHSKILL:int = 3;
      
      public static const CLIENT_OP_REQUESTORDER:int = 4;
      
      public static const CLIENT_OP_REQENTERGAME:int = 5;
      
      private var _model:AresLordsModel;
      
      public function AresLordsManager()
      {
         super();
      }
      
      public static function get instance() : AresLordsManager
      {
         _instance ||= new AresLordsManager();
         return _instance;
      }
      
      public function get model() : AresLordsModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new AresLordsModel();
         addEvent();
      }
      
      public function requestViewInfo() : void
      {
         if(ArmyManager.instance.thane.grades < 36)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.areslordsShopPrompt",36));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(9615);
         var _loc1_:AresLordsListMsg = new AresLordsListMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestSignUp() : void
      {
         var _loc2_:PackageOut = new PackageOut(9615);
         var _loc1_:AresLordsListMsg = new AresLordsListMsg();
         _loc1_.op = 2;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestRankInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9615);
         var _loc1_:AresLordsListMsg = new AresLordsListMsg();
         _loc1_.op = 4;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestEnterRoom() : void
      {
         if(!_model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("areslords.Error.str01"));
            return;
         }
         if(!_model.isSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("areslords.Error.str02"));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(9615);
         var _loc1_:AresLordsListMsg = new AresLordsListMsg();
         _loc1_.op = 5;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestRefreshSkill() : void
      {
         var _loc2_:PackageOut = new PackageOut(9615);
         var _loc1_:AresLordsListMsg = new AresLordsListMsg();
         _loc1_.op = 3;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function clearRoomInfo() : void
      {
         _model.roomInfo.rankList.length = 0;
         _model.roomInfo.skillInfo.skill.length = 0;
      }
      
      public function clearRankInfo() : void
      {
         _model.rankInfo.rankList.length = 0;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 370,__aresLordsMainInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 371,__aresLordsViewInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 372,__aresLordsSkillInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 373,__aresLordsRankInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 528,shopBuyHandler);
      }
      
      private function shopBuyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ShopGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsgList = new CommonMsgList();
         _loc2_ = _loc5_.readBody(_loc2_) as CommonMsgList;
         for each(var _loc3_:CommonMsg in _loc2_.list)
         {
            _loc4_ = getShopInfo(_loc3_.param1);
            if(_loc4_)
            {
               _loc4_.OneCurrentCount = _loc3_.param2;
            }
         }
      }
      
      private function getShopInfo(param1:int) : ShopGoodsInfo
      {
         var _loc3_:Dictionary = TempleteManager.instance.getAreslordsShopTempInfoList();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __aresLordsMainInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AresLordsListMsg = new AresLordsListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AresLordsListMsg;
         resovleRoomInfo(_loc2_);
         _model.dispatchEvent(new AresLordsEvent("AresLordsEvent.INFO_UPDATE"));
      }
      
      private function __aresLordsViewInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AresLordsListMsg = new AresLordsListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AresLordsListMsg;
         resovleBaseInfo(_loc2_);
         if(_model.isOpen)
         {
            FrameControllerManager.instance.openControllerByInfo("areslords",1,resovleStartInfo(_loc2_));
         }
         else if(_model.isSign)
         {
            FrameControllerManager.instance.openControllerByInfo("areslords",1,resovleStartInfo(_loc2_));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("areslords",0,resovleSignUpInfo(_loc2_));
         }
      }
      
      private function __aresLordsSkillInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AresSkillListMsg = new AresSkillListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AresSkillListMsg;
         resovleSkillInfo(_loc2_);
         _model.dispatchEvent(new AresLordsEvent("AresLordsEvent.SKILL_INFO",_model.roomInfo));
      }
      
      private function __aresLordsRankInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AresLordsListMsg = new AresLordsListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AresLordsListMsg;
         resovleRankInfo(_loc2_);
         _model.dispatchEvent(new AresLordsEvent("AresLordsEvent.RANK_INFO",_model.rankInfo));
      }
      
      private function resovleBaseInfo(param1:AresLordsListMsg) : void
      {
         if(param1.hasIsSign)
         {
            _model.isSign = param1.isSign;
         }
         if(param1.hasIsOpen)
         {
            _model.isOpen = param1.isOpen;
         }
         if(param1.hasSeason)
         {
            _model.season = param1.season;
         }
         if(param1.hasWarIndex)
         {
            _model.warIndex = param1.warIndex;
         }
         if(param1.hasCurrentTurn)
         {
            _model.currentTurn = param1.currentTurn;
         }
         if(param1.hasMaxTurnCount)
         {
            _model.maxTurnCount = param1.maxTurnCount;
         }
         if(param1.hasTotalScore)
         {
            _model.totalScore = param1.totalScore;
         }
         if(param1.hasTeamType)
         {
            _model.teamType = param1.teamType;
         }
         if(param1.hasOrder)
         {
            _model.order = param1.order;
         }
         if(param1.hasIsOver)
         {
            _model.isOver = param1.isOver;
         }
         if(param1.hasLeftWarIndex)
         {
            _model.leftWarIndex = param1.leftWarIndex;
         }
      }
      
      private function resovleSignUpInfo(param1:AresLordsListMsg) : AresLordsSignUpInfo
      {
         var _loc5_:AresLordsPlayerInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:AresLordsSignUpInfo = new AresLordsSignUpInfo();
         if(param1.hasOpenTime)
         {
            _loc4_.openTime = param1.openTime;
         }
         _loc4_.isOver = _model.isOver;
         _loc4_.season = _model.season;
         _loc4_.warIndex = _model.warIndex;
         _loc4_.topList = new Vector.<AresLordsPlayerInfo>();
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc5_ = resovlePlayerInfo(param1.info[_loc3_]);
            _loc5_.thaneInfo = resovlePlayerThaneInfo(param1.info[_loc3_]);
            _loc4_.topList.push(_loc5_);
            _loc3_++;
         }
         _loc4_.topList.sort(sortByRank);
         while(_loc4_.topList.length < 3)
         {
            _loc4_.topList.push(null);
         }
         return _loc4_;
      }
      
      private function resovleStartInfo(param1:AresLordsListMsg) : AresLordsStartInfo
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:AresLordsPlayerInfo = null;
         var _loc3_:AresLordsPlayerInfo = null;
         var _loc5_:AresLordsStartInfo = new AresLordsStartInfo();
         if(param1.hasOpenTime)
         {
            _loc5_.openTime = param1.openTime;
         }
         _loc5_.isOpen = _model.isOpen;
         _loc5_.season = _model.season;
         _loc5_.warIndex = _model.warIndex;
         _loc5_.currentTurn = _model.currentTurn;
         _loc5_.maxTurnCount = _model.maxTurnCount;
         _loc5_.totalScore = _model.totalScore;
         _loc5_.teamType = _model.teamType;
         _loc5_.order = _model.order;
         _loc5_.leftWarIndex = _model.leftWarIndex;
         _loc5_.rankList = new Vector.<AresLordsPlayerInfo>();
         _loc4_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc4_ < _loc2_)
         {
            _loc6_ = resovlePlayerInfo(param1.info[_loc4_]);
            _loc5_.rankList.push(_loc6_);
            _loc4_++;
         }
         _loc5_.rankList.sort(sortByRank);
         while(_loc5_.rankList.length % 5 != 0 || _loc5_.rankList.length == 0)
         {
            _loc3_ = new AresLordsPlayerInfo();
            _loc3_.rankOrder = _loc5_.rankList.length + 1;
            _loc3_.uuid = null;
            _loc5_.rankList.push(_loc3_);
         }
         return _loc5_;
      }
      
      private function resovleRoomInfo(param1:AresLordsListMsg) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:AresLordsPlayerInfo = null;
         resovleBaseInfo(param1);
         var _loc4_:AresLordsRoomInfo = _model.roomInfo;
         _loc4_.season = param1.season;
         _loc4_.warIndex = param1.warIndex;
         _loc4_.currentTurn = param1.currentTurn;
         _loc4_.maxTurnCount = param1.maxTurnCount;
         _loc4_.totalScore = param1.totalScore;
         _loc4_.teamType = param1.teamType;
         _loc4_.order = param1.order;
         if(param1.hasLeftTime)
         {
            _loc4_.leftTime = param1.leftTime;
         }
         _loc4_.rankList = new Vector.<AresLordsPlayerInfo>();
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc5_ = resovlePlayerInfo(param1.info[_loc3_]);
            _loc4_.rankList.push(_loc5_);
            _loc3_++;
         }
      }
      
      private function resovleSkillInfo(param1:AresSkillListMsg) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:AresLordsSkillInfo = null;
         var _loc5_:AresLordsRoomInfo = _model.roomInfo;
         var _loc6_:AresLordsSkillListInfo = _loc5_.skillInfo;
         _loc6_.freeCount = param1.freeCount;
         _loc6_.skill = new Vector.<AresLordsSkillInfo>();
         _loc4_ = 0;
         _loc3_ = int(param1.info.length);
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new AresLordsSkillInfo();
            _loc2_.skillTempId = param1.info[_loc4_].skillTempId;
            _loc2_.skillCount = param1.info[_loc4_].skillCount;
            _loc6_.skill.push(_loc2_);
            _loc4_++;
         }
      }
      
      private function resovlePlayerInfo(param1:AresLordsInfoMsg) : AresLordsPlayerInfo
      {
         var _loc2_:AresLordsPlayerInfo = new AresLordsPlayerInfo();
         _loc2_.uuid = param1.uuid;
         _loc2_.userId = param1.userId;
         _loc2_.serverName = param1.serverName;
         _loc2_.nickName = param1.nickName;
         _loc2_.sexJob = param1.sexJob;
         _loc2_.grades = param1.grades;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.totalScore = param1.totalScore;
         _loc2_.teamType = param1.teamType;
         _loc2_.rankOrder = param1.rankOrder;
         _loc2_.fashionArm = param1.fashionArm;
         _loc2_.fashionWing = param1.fashionWing;
         _loc2_.fashionCloth = param1.fashionCloth;
         _loc2_.fashionHair = param1.fashionHair;
         _loc2_.fashionHat = param1.fashionHat;
         return _loc2_;
      }
      
      private function resovlePlayerThaneInfo(param1:AresLordsInfoMsg) : ThaneInfo
      {
         var _loc2_:ThaneInfo = new ThaneInfo();
         if(param1.hasSexJob)
         {
            _loc2_.templateId = param1.sexJob;
         }
         if(param1.hasNickName)
         {
            _loc2_.nickName = param1.nickName;
         }
         if(_loc2_.hairFashionAvata != param1.fashionHair)
         {
            _loc2_.hairFashionAvata = param1.fashionHair;
         }
         if(_loc2_.cloakAvata != param1.fashionHat)
         {
            _loc2_.cloakAvata = param1.fashionHat;
         }
         if(_loc2_.wingAvata != param1.fashionWing)
         {
            _loc2_.wingAvata = param1.fashionWing;
         }
         if(param1.fashionArm)
         {
            if(param1.fashionArm.indexOf("fashion") > -1)
            {
               if(_loc2_.armsFashionAvata != param1.fashionArm)
               {
                  _loc2_.armsFashionAvata = param1.fashionArm;
               }
            }
            else if(_loc2_.armsEquipAvata != param1.fashionArm)
            {
               _loc2_.armsEquipAvata = param1.fashionArm;
            }
         }
         if(param1.fashionCloth)
         {
            if(param1.fashionCloth.indexOf("fashion") > -1)
            {
               if(_loc2_.bodyFashionAvata != param1.fashionCloth)
               {
                  _loc2_.bodyFashionAvata = param1.fashionCloth;
               }
            }
            else if(_loc2_.bodyEquipAvata != param1.fashionCloth)
            {
               _loc2_.bodyEquipAvata = param1.fashionCloth;
            }
         }
         return _loc2_;
      }
      
      private function resovleRankInfo(param1:AresLordsListMsg) : AresLordsRankInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:AresLordsPlayerInfo = null;
         var _loc4_:AresLordsRankInfo = _model.rankInfo;
         _loc4_.order = param1.order;
         _loc4_.teamType = param1.teamType;
         _loc4_.totalScore = param1.totalScore;
         _loc4_.rankList = new Vector.<AresLordsPlayerInfo>();
         _loc4_.lastUpdate = param1.openTime;
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc5_ = resovlePlayerInfo(param1.info[_loc3_]);
            _loc4_.rankList.push(_loc5_);
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function sortByRank(param1:Object, param2:Object) : int
      {
         if(param1.rankOrder < param2.rankOrder)
         {
            return -1;
         }
         if(param1.rankOrder > param2.rankOrder)
         {
            return 1;
         }
         return 0;
      }
   }
}

