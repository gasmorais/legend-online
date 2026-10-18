package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.consortia.ConsortiaBoxInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaConditionMsg;
   import com.road.yishi.proto.consortia.ConsortiaDutyInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaDutyListRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaLinkRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaMembersInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.consortia.ConsortiaOrderInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaQuestMsg;
   import com.road.yishi.proto.consortia.ConsortiaQuitReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaShopRespMsg;
   import com.road.yishi.proto.consortia.ConsortiaShopSupplyRespMsg;
   import com.road.yishi.proto.consortia.ConsortiaShopTradingRespMsg;
   import com.road.yishi.proto.consortia.ConsortiaStorageInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaTreasureBoxMsg;
   import com.road.yishi.proto.consortia.ConsortiaTreasureOpMsg;
   import com.road.yishi.proto.consortia.ConsortiaUserInviteInfoListRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaUserInviteInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaUserJoinMsg;
   import com.road.yishi.proto.consortia.FamInfoMsg;
   import com.road.yishi.proto.consortia.FarmOrderList;
   import com.road.yishi.proto.consortia.FarmOrderMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.CommonMsgList;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.simple.SimplePlayerInfoMsg;
   import com.road.yishi.proto.simple.SimplePlayerListRspMsg;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.TaskTraceTipManager;
   import map.campaign.CampaignManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaDutyInfo;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaInviteInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaOrderInfo;
   import mvc.module.consortia.ConsortiaQuestInfo;
   import mvc.module.consortia.ConsortiaUserInfo;
   import mvc.module.consortia.MyTreasureInfo;
   import mvc.module.consortia.OthersTreasureInfo;
   import mvc.module.consortia.TreasureInfo;
   import mvc.module.dayGuide.DailyItemInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import tasktracetip.data.TipMessageData;
   import ui.maintoolbar.MainToolBar;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.actions.consortia.CaseGoodsSendBackByMailAction;
   import yishi.actions.consortia.ConsortiaApplyAction;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.BitArray;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.PopFrameCheck;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaManager extends EventDispatcher
   {
      
      private static var _instance:ConsortiaManager;
      
      private static const AUTO_INVITE_LEVEL:int = 15;
      
      private var _model:ConsortiaModel;
      
      public var isOpen:Boolean = false;
      
      public var isOpenTreasreFrame:Boolean = false;
      
      public var isRecruitFrameOpen:Boolean = false;
      
      private var _timesUint:uint;
      
      public var isFirstRecord:Boolean;
      
      private var _inviteId:int;
      
      private var membersCache:Array = [];
      
      public function ConsortiaManager()
      {
         super();
         _model = new ConsortiaModel();
         addEvent();
      }
      
      public static function get instance() : ConsortiaManager
      {
         if(!_instance)
         {
            _instance = new ConsortiaManager();
         }
         return _instance;
      }
      
      private function get controller() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      public function setup() : void
      {
         if(playerInfo.consortiaID)
         {
            getConsortiaDutyInfos();
            getConsortiaUserInfos();
            getConsirtiaInfo();
            sendTreasureInfo();
         }
         else
         {
            thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpgradeHandler);
            SocketManager.instance.addEventListener("SLGSocketEvent" + 41,__consortiaInviteHandler);
         }
      }
      
      protected function __levelUpgradeHandler(param1:Event) : void
      {
         if(thane.grades >= 15)
         {
            thane.removeEventListener("THANE_LEVEL_UPDATE",__levelUpgradeHandler);
            if(playerInfo.consortiaID == 0)
            {
               ConsortiaSocketOutManager.autoInvite();
            }
         }
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 164,__refreshConsortiaInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4138,__refreshConsortiaInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4135,__refreshRecordList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 162,__userLogin);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 163,__userLogout);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 117,__consortiaStageChange);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4133,__updateConsortiaMember);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4137,__refreshDutyInfos);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 50,__updataDutyInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4140,__refreshApplyList);
         playerInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__consortiaChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 35,__joinConsortiaHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 37,__operateConsortiaApplyResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4266,__operateConsortiaPassUser);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4267,__linkConsortia);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4453,__consortiaSecretUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4432,__consortiaTreeUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4466,__prizeCheckHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4465,__prizeAllotHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4728,__emeDreamStateHandler);
         _model.addEventListener("IS_CONSORTIA_EXIST",__existHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4726,__emeDreamRefreshBuffer);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 390,__updateTreasureHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4632,__consortiaSecretSortHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 180,__userJoinInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 179,__consortiaQuestInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 181,__businessInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 182,__businessSelfInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 46,__consortiaQuitHandler);
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
         var _loc3_:Dictionary = TempleteManager.instance.getCrossGuildShopTempInfoList();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __emeDreamRefreshBuffer(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.emeDreamInfo.BufferIds = _loc2_.param4;
         MsgMan.notifyObserver("ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS",null);
      }
      
      private function __emeDreamStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaInfoMsg = new ConsortiaInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaInfoMsg;
         if(_loc2_.bossInfo)
         {
            _model.emeDreamInfo.grade = _loc2_.bossInfo.grade;
            _model.emeDreamInfo.callGrade = _loc2_.bossInfo.callGrade;
            _model.emeDreamInfo.spirit = Int64Utils.int64ToNumber(_loc2_.bossInfo.spirit);
            _model.emeDreamInfo.state = _loc2_.bossInfo.state;
            _model.emeDreamInfo.endTime = _loc2_.bossInfo.endTime;
            _model.emeDreamInfo.totalHp = Int64Utils.int64ToNumber(_loc2_.bossInfo.totalHp);
            if(WorldBossHelper.checkConsortiaEmeDream(CampaignManager.instance.mapId))
            {
               CampaignManager.instance.worldBossModel.totalHp = _model.emeDreamInfo.totalHp;
            }
         }
         if(_model.emeDreamInfo.state == 1 || _model.emeDreamInfo.state == 2)
         {
            model.openEffectDic[5] = true;
         }
         else
         {
            model.emeDreamInfo.BufferIds = "";
         }
         MsgMan.notifyObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",null);
      }
      
      private function __prizeCheckHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc11_:ConsortiaBoxInfoMsg = null;
         var _loc6_:int = 0;
         var _loc9_:GoodsInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaStorageInfoMsg = new ConsortiaStorageInfoMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ConsortiaStorageInfoMsg;
         var _loc8_:Array = _loc2_.storageInfo;
         var _loc10_:SimpleDictionary = new SimpleDictionary();
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            _loc11_ = _loc8_[_loc5_] as ConsortiaBoxInfoMsg;
            _loc6_ = 0;
            while(_loc6_ < _loc11_.count)
            {
               if(_loc4_ && _loc4_.templateInfo && _loc4_.templateId == _loc11_.templateId && _loc4_.templateInfo.MaxCount > _loc4_.count)
               {
                  _loc4_.count++;
               }
               else
               {
                  _loc9_ = new GoodsInfo();
                  _loc9_.templateId = _loc11_.templateId;
                  _loc9_.count = 1;
                  _loc9_.bagType = 8;
                  _loc9_.pos = _loc3_;
                  _loc10_.add(_loc9_.pos,_loc9_);
                  _loc4_ = _loc9_;
                  _loc3_++;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         model.prizeList = _loc10_;
      }
      
      private function __prizeAllotHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc9_:ConsortiaMembersInfoMsg = null;
         var _loc3_:ThaneInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaTreasureBoxMsg = new ConsortiaTreasureBoxMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaTreasureBoxMsg;
         var _loc7_:Array = _loc2_.playerInfo;
         var _loc8_:SimpleDictionary = new SimpleDictionary();
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc5_] as ConsortiaMembersInfoMsg;
            _loc3_ = new ThaneInfo();
            _loc3_.job = _loc9_.job;
            _loc3_.nickName = _loc9_.nickName;
            _loc3_.grades = _loc9_.level;
            _loc3_.fightingCapacity = _loc9_.fightCapacity;
            _loc3_.userId = _loc9_.userId;
            _loc3_.received = _loc9_.isReceived;
            _loc3_.receivedCount = _loc9_.count;
            _loc3_.vocationGrades = _loc9_.transGrade;
            if(_model.consortiaMemberList[_loc9_.userId])
            {
               _loc3_.vocationIndex = _model.consortiaMemberList[_loc9_.userId].vocationIndex;
            }
            _loc8_.add(_loc3_.userId,_loc3_);
            _loc4_++;
            _loc5_++;
         }
         model.currentPrizeTemplateId = _loc2_.templateId;
         model.currentPrizeListCount = _loc2_.count;
         model.prizeMemberList = _loc8_;
      }
      
      private function __operateConsortiaPassUser(param1:SLGSocketEvent) : void
      {
         if(!controller.mainFrame)
         {
            MainToolBar.instance.consortiaButtonShine = true;
         }
      }
      
      private function __consortiaChangeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:String = null;
         if(playerInfo.consortiaID > 0)
         {
            TaskManage.instance.requestCanAcceptTask();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.manager.ConsortiaManager.exitConsortia");
            MessageTipManager.instance().show(_loc2_);
            TaskTraceTipManager.instance.cleanByType(26);
            SocketManager.instance.addEventListener("SLGSocketEvent" + 41,__consortiaInviteHandler);
            checkCloseFrame();
         }
      }
      
      private function __operateConsortiaApplyResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ConsortiaMsg;
         var _loc5_:Boolean = _loc2_.result;
         var _loc6_:int = _loc2_.applyId;
         if(_loc5_)
         {
            for each(var _loc4_:ConsortiaInviteInfo in _model.inviteList)
            {
               if(_loc4_.id == _loc6_)
               {
                  _loc3_ = LanguageMgr.GetTranslation("yishi.manager.ConsortiaManager.command01",_loc4_.consortiaName);
                  MessageTipManager.instance().show(_loc3_);
                  if(!controller.mainFrame)
                  {
                     MainToolBar.instance.consortiaButtonShine = true;
                  }
                  break;
               }
            }
         }
         checkCloseFrame();
      }
      
      private function __linkConsortia(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaLinkRspMsg = new ConsortiaLinkRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaLinkRspMsg;
         var _loc3_:ConsortiaInfo = new ConsortiaInfo();
         _loc3_.consortiaName = _loc2_.consortiaName;
         _loc3_.chairmanName = _loc2_.creatorName;
         _loc3_.levels = _loc2_.levels;
         _loc3_.offer = _loc2_.offer;
         _loc3_.currentCount = _loc2_.currentCount;
         _loc3_.honor = _loc2_.honor;
         _loc3_.description = _loc2_.description;
         _loc3_.consortiaId = _loc2_.consortiaId;
         FrameControllerManager.instance.openControllerByInfo("lookconsortiainfo",6,_loc3_);
      }
      
      private function __joinConsortiaHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ConsortiaMsg;
         var _loc4_:int = _loc2_.applyId;
         if(_loc4_)
         {
            controller.getConsortiaInviteInfos();
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.ConsortiaManager.command02");
            MessageTipManager.instance().show(_loc3_);
         }
         checkCloseFrame();
      }
      
      private function __refreshApplyList(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimplePlayerListRspMsg = new SimplePlayerListRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SimplePlayerListRspMsg;
         var _loc3_:Array = [];
         var _loc4_:int = Math.ceil(_loc2_.totalRows / 8);
         _model.recruitListTotalPage = _loc4_ < _model.recruitCurrentPage ? _model.recruitCurrentPage : _loc4_;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.playerInfo.length)
         {
            _loc3_.push(readApplyInfo(_loc2_.playerInfo[_loc5_] as SimplePlayerInfoMsg));
            _loc5_++;
         }
         _model.applyConsortiaList = _loc3_;
         _model.recruitNum = _loc2_.totalRows;
         giftCount();
         checkCloseFrame();
      }
      
      private function readApplyInfo(param1:SimplePlayerInfoMsg) : ThaneInfo
      {
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.consortiaID = param1.consortiaID;
         _loc2_.nickName = param1.nickName;
         _loc2_.grades = param1.grades;
         _loc2_.templateId = param1.job;
         _loc2_.jewelGrades = param1.storeGrade;
         _loc2_.fightingCapacity = param1.fightingCapacity;
         _loc2_.parameter1 = param1.parameter1;
         _loc2_.vocationGrades = param1.transGrade;
         _loc2_.vocationIndex = param1.changeBranch;
         return _loc2_;
      }
      
      private function __refreshConsortiaInfo(param1:SLGSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc8_:ConsortiaInfoMsg = new ConsortiaInfoMsg();
         _loc8_ = _loc6_.readBody(_loc8_) as ConsortiaInfoMsg;
         _model.consortiaInfo.consortiaId = _loc8_.consortiaId;
         _model.consortiaInfo.consortiaName = _loc8_.consortiaName;
         _model.consortiaInfo.creatorID = _loc8_.creatorId;
         _model.consortiaInfo.creatorName = _loc8_.creatorName;
         _model.consortiaInfo.createDate = DateFormatter.parse(_loc8_.createDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.speakTimes = _loc8_.speakTimes;
         _model.maxMave = _loc8_.maxMave;
         if(_loc8_.bossInfo)
         {
            _model.emeDreamInfo.grade = _loc8_.bossInfo.grade;
            _model.emeDreamInfo.callGrade = _loc8_.bossInfo.callGrade;
            _model.emeDreamInfo.spirit = Int64Utils.int64ToNumber(_loc8_.bossInfo.spirit);
            _model.emeDreamInfo.state = _loc8_.bossInfo.state;
            _model.emeDreamInfo.endTime = _loc8_.bossInfo.endTime;
            _model.emeDreamInfo.totalHp = Int64Utils.int64ToNumber(_loc8_.bossInfo.totalHp);
            if(_model.emeDreamInfo.state == 1 || _model.emeDreamInfo.state == 2)
            {
            }
         }
         var _loc4_:int = _loc8_.chairmanId;
         if(_loc4_ != _model.consortiaInfo.chairmanID)
         {
            _loc2_ = _model.consortiaInfo.chairmanID;
            _model.consortiaInfo.chairmanID = _loc4_;
            if(_loc2_)
            {
               refreshChairman(_loc2_,_loc4_);
               _model.dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_CHAIRMAN",_loc2_));
            }
         }
         _model.consortiaInfo.chairmanName = _loc8_.chairmanName;
         _model.consortiaInfo.description = _loc8_.description;
         _model.consortiaInfo.placard = _loc8_.placard;
         var _loc7_:int = _loc8_.levels;
         if(_loc7_ != _model.consortiaInfo.levels)
         {
            _model.consortiaInfo.levels = _loc7_;
            _model.dispatchEvent(new ConsortiaEvent("CONSORTIA_UPGRADE"));
         }
         _model.consortiaInfo.addCount = _loc8_.addCount;
         var _loc3_:int = _loc8_.currentCount;
         if(_loc3_ != _model.consortiaInfo.currentCount)
         {
            _loc5_ = _model.consortiaInfo.currentCount;
            _model.consortiaInfo.currentCount = _loc3_;
            if(_loc5_)
            {
               ConsortiaManager.instance.getConsortiaUserInfos();
            }
         }
         _model.consortiaInfo.offer = _loc8_.offer;
         _model.consortiaInfo.honor = _loc8_.honor;
         _model.consortiaInfo.openApp = _loc8_.openApp;
         _model.consortiaInfo.kickDate = DateFormatter.parse(_loc8_.kickDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.kickCount = _loc8_.kickCount;
         _model.consortiaInfo.fightPower = Int64Utils.int64ToNumber(_loc8_.fightPower);
         _model.consortiaInfo.shopLevel = _loc8_.shopLevel;
         _model.consortiaInfo.storeLevel = _loc8_.storeLevel;
         _model.consortiaInfo.altarLevel = _loc8_.altarLevel;
         _model.consortiaInfo.schoolLevel = _loc8_.schoolLevel;
         _model.consortiaInfo.attackLevel = _loc8_.attackLevel;
         _model.consortiaInfo.defenceLevel = _loc8_.defenceLevel;
         _model.consortiaInfo.agilityLevel = _loc8_.agilityLevel;
         _model.consortiaInfo.abilityLevel = _loc8_.abilityLevel;
         _model.consortiaInfo.captainLevel = _loc8_.captainLevel;
         _model.consortiaInfo.physiqueLevel = _loc8_.physiqueLevel;
         _model.consortiaInfo.goldLevel = _loc8_.goldLevel;
         _model.consortiaInfo.newPowerLv = _loc8_.newPowerLv;
         _model.consortiaInfo.newAgilityLv = _loc8_.newAgilityLv;
         _model.consortiaInfo.newIntellectLv = _loc8_.newIntellectLv;
         _model.consortiaInfo.newPhysiqueLv = _loc8_.newPhysiqueLv;
         _model.consortiaInfo.famGpLv = _loc8_.famGpLv;
         _model.consortiaInfo.medalLv = _loc8_.medalLv;
         _model.consortiaInfo.honorLv = _loc8_.honorLv;
         _model.consortiaInfo.scoreLv = _loc8_.scoreLv;
         _model.consortiaInfo.ownWildlands = _loc8_.ownWildlands;
         _model.consortiaInfo.deductDate = DateFormatter.parse(_loc8_.deductDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.warnDate = DateFormatter.parse(_loc8_.warnDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.codeType = _loc8_.codeType;
         _model.consortiaInfo.codeBeginDate = DateFormatter.parse(_loc8_.codeBeginDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.codeNeedDate = _loc8_.codeNeedDate;
         _model.consortiaInfo.currentDate = DateFormatter.parse(_loc8_.currentDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.isRobot = _loc8_.isRobot;
         _model.consortiaInfo.groupPlacard = _loc8_.groupPlacard;
         _model.consortiaInfo.storageExpireTime1 = _loc8_.storageExpireTime1;
         _model.consortiaInfo.storageExpireTime2 = _loc8_.storageExpireTime2;
         _model.consortiaInfo.isStorageExpire1 = _loc8_.isStorageExpire1;
         _model.consortiaInfo.isStorageExpire2 = _loc8_.isStorageExpire2;
         _model.consortiaInfo.votingDate = DateFormatter.parse(_loc8_.votingDate,"YYYY-MM-DD hh:mm:ss");
         _model.consortiaInfo.votingState = _loc8_.votingStatic;
         _model.consortiaInfo.votingId = _loc8_.votingId;
         _model.consortiaInfo.masterSchoolLevel = _loc8_.masterSchoolLv;
         _model.consortiaInfo.taskSchoolLevel = _loc8_.questLobbyLv;
         _model.consortiaInfo.businessLevel = _loc8_.newShopLv;
         _model.consortiaInfo.masterPowerLv = _loc8_.masterPowerLv;
         _model.consortiaInfo.masterAgilityLv = _loc8_.masterAgilityLv;
         _model.consortiaInfo.masterIntellectLv = _loc8_.masterIntellectLv;
         _model.consortiaInfo.masterPhysiqueLv = _loc8_.masterPhysiqueLv;
         _model.consortiaInfo.masterSkillResearchCd = Int64Utils.int64ToNumber(_loc8_.masterSkillResearchCdEnd) / 1000;
         _model.consortiaInfo.consortiaAsset = _loc8_.consortiaAsset;
         _model.consortiaInfo.consortiaWeeklyActivePoint = _loc8_.consortiaWeeklyActivePoint;
         _model.consortiaInfo.consortiaActivePoint = _loc8_.consortiaActivePoint;
         if(_loc8_.isRobot)
         {
            ConsortiaManager.instance.addRobot();
         }
         if(_loc8_.hasOrderInfo)
         {
            _model.consortiaInfo.orderInfo = readOrderInfo(_loc8_.orderInfo);
         }
         _model.updataResearchSkill();
         _model.dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_INFO"));
         checkCloseFrame();
      }
      
      private function sendTreasureInfo() : void
      {
         clearTimeout(_timesUint);
         ConsortiaSocketOutManager.sendTreasureInfo(0);
         ConsortiaSocketOutManager.sendTreasureInfo(1);
         ConsortiaSocketOutManager.sendTreasureInfo(2);
         _timesUint = setTimeout(sendTreasureInfo,1800000);
      }
      
      private function refreshChairman(param1:int, param2:int) : void
      {
         var _loc4_:ThaneInfo = getSimplePlayerInfoById(param1);
         if(_loc4_)
         {
            _loc4_.beginChanges();
            _loc4_.dutyId = 5;
            _loc4_.commit();
         }
         var _loc3_:ThaneInfo = getSimplePlayerInfoById(param2);
         if(_loc3_)
         {
            _loc3_.beginChanges();
            _loc3_.dutyId = 1;
            _loc3_.commit();
         }
         if(param1 == playerInfo.userId || param2 == playerInfo.userId)
         {
            ConsortiaManager.instance.setRightsList();
         }
         checkCloseFrame();
      }
      
      private function readOrderInfo(param1:ConsortiaOrderInfoMsg) : ConsortiaOrderInfo
      {
         var _loc2_:ConsortiaOrderInfo = new ConsortiaOrderInfo();
         _loc2_.consortiaID = param1.consortiaId;
         _loc2_.gradeOrder = param1.gradeOrder;
         _loc2_.fightPowerOrder = param1.fightPowerOrder;
         _loc2_.lastDayOffer = param1.lastDayOffer;
         _loc2_.lastDayOrder = param1.lastDayOrder;
         _loc2_.lastWeekOffer = param1.lastWeekOffer;
         _loc2_.lastWeekOrder = param1.lastWeekOrder;
         _loc2_.lastDayDate = DateFormatter.parse(param1.lastDayDate,"YYYY-MM-DD hh:mm:ss");
         _loc2_.lastWeekDate = DateFormatter.parse(param1.lastWeekDate,"YYYY-MM-DD hh:mm:ss");
         checkCloseFrame();
         return _loc2_;
      }
      
      private function __refreshRecordList(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:ConsortiaInviteInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaUserInviteInfoListRspMsg = new ConsortiaUserInviteInfoListRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ConsortiaUserInviteInfoListRspMsg;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.inviteInfo.length)
         {
            _loc6_ = new ConsortiaInviteInfo();
            readInviteInfo(_loc6_,_loc2_.inviteInfo[_loc5_] as ConsortiaUserInviteInfoMsg);
            if(_loc6_.fromType)
            {
               if(_loc3_.length < 10)
               {
                  _loc3_.push(_loc6_);
               }
            }
            else if(_loc4_.length < 10)
            {
               _loc4_.push(_loc6_);
            }
            _loc5_++;
         }
         _model.inviteList = _loc3_;
         _model.applyList = _loc4_;
         if(_model.inviteList.length >= 1 && isFirstRecord)
         {
            MainToolBar.instance.consortiaButtonShine = true;
         }
         if(_inviteId != 0)
         {
            MainToolBar.instance.consortiaButtonShine = true;
            showInvite();
         }
         checkCloseFrame();
      }
      
      private function showInvite() : void
      {
         var _loc1_:String = null;
         for each(var _loc2_:ConsortiaInviteInfo in _model.inviteList)
         {
            if(_loc2_.id == _inviteId)
            {
               _loc1_ = LanguageMgr.GetTranslation("yishi.manager.ConsortiaManager.msg",_loc2_.inviteNickName,_loc2_.consortiaName);
               PopFrameCheck.instance.addAction(new ConsortiaApplyAction(_inviteId,_loc1_));
            }
         }
         _inviteId = 0;
      }
      
      private function readInviteInfo(param1:ConsortiaInviteInfo, param2:ConsortiaUserInviteInfoMsg) : void
      {
         param1.id = param2.id;
         param1.consortiaId = param2.consortiaId;
         param1.consortiaName = param2.consortiaName;
         param1.chairmanName = param2.chairmanNickname;
         param1.createDate = DateFormatter.parse(param2.createDate,"YYYY-MM-DD hh:mm:ss");
         param1.userId = param2.userId;
         param1.userNickName = param2.userNickname;
         param1.inviteId = param2.inviteId;
         param1.inviteNickName = param2.inviteNickname;
         param1.inviteDate = DateFormatter.parse(param2.inviteDate,"YYYY-MM-DD hh:mm:ss");
         param1.fromType = param2.fromType;
         param1.isExist = param2.isexist;
      }
      
      private function __consortiaInviteHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaMsg;
         _inviteId = _loc2_.applyId;
         controller.getConsortiaInviteInfos();
      }
      
      private function __onContributeUpdata(param1:PlayerEvent) : void
      {
         var _loc2_:ThaneInfo = null;
         if(_model.consortiaMemberList.hasOwnProperty(playerInfo.userId))
         {
            _loc2_ = _model.consortiaMemberList[playerInfo.userId] as ThaneInfo;
            _loc2_.beginChanges();
            _loc2_.consortiaOffer = playerInfo.consortiaOffer;
            _loc2_.consortiaTotalOffer = playerInfo.consortiaTotalOffer;
            _loc2_.commit();
         }
         checkCloseFrame();
      }
      
      private function __consortiaStageChange(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaMsg;
         playerInfo.consortiaID = _loc2_.consortiaId;
         if(playerInfo.consortiaID)
         {
            setup();
            SocketManager.instance.removeEventListener("SLGSocketEvent" + 41,__consortiaInviteHandler);
            _model.dispatchEvent(new ConsortiaEvent("IS_CONSORTIA_EXIST",true));
         }
         else
         {
            if(_loc2_.returnItem)
            {
               PopFrameCheck.instance.addAction(new CaseGoodsSendBackByMailAction());
            }
            SocketManager.instance.addEventListener("SLGSocketEvent" + 41,__consortiaInviteHandler);
            _model.consortiaMemberList.clear();
            _model.baseSkillList.clear();
            _model.consortiaInfo.orderInfo = null;
            _model.secretInfo.clear();
            if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && WorldBossHelper.checkConsortiaSecretLand(CampaignManager.instance.mapModel.mapId))
            {
               SwitchPageHelp.returnToSpace();
            }
            _model.dispatchEvent(new ConsortiaEvent("IS_CONSORTIA_EXIST"));
         }
         NotificationManager.instance.sendNotification("IS_CONSORTIA_EXIST");
         checkCloseFrame();
      }
      
      private function __existHandler(param1:ConsortiaEvent) : void
      {
         if(_model && _model.applyList)
         {
            while(_model.applyList.length > 0)
            {
               _model.applyList.pop();
            }
         }
      }
      
      public function get model() : ConsortiaModel
      {
         return _model;
      }
      
      public function set model(param1:ConsortiaModel) : void
      {
         _model = param1;
      }
      
      public function getConsortiaDutyInfos() : void
      {
         ConsortiaSocketOutManager.getConsortiaDutyInfos();
      }
      
      public function getConsirtiaInfo() : void
      {
         ConsortiaSocketOutManager.getConsortiaInfos();
      }
      
      private function __refreshDutyInfos(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ConsortiaDutyInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaDutyListRspMsg = new ConsortiaDutyListRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ConsortiaDutyListRspMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.dutyInfo.length)
         {
            _loc3_ = readDutyInfo(_loc2_.dutyInfo[_loc4_] as ConsortiaDutyInfoMsg);
            _model.consortiaDutyList[_loc3_.levels] = _loc3_;
            _loc4_++;
         }
         setRightsList();
         checkCloseFrame();
      }
      
      private function __updataDutyInfo(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaMsg;
         var _loc3_:int = _loc2_.otherId;
         var _loc5_:int = _loc2_.positionId;
         var _loc4_:SimplePlayerInfo = _model.consortiaMemberList[_loc3_];
         if(_loc4_)
         {
            if(_loc4_.dutyId != _loc5_)
            {
               _loc4_.beginChanges();
               _loc4_.dutyId = _loc5_;
               if(_loc4_.userId == playerInfo.userId)
               {
                  setRightsList();
               }
               _loc4_.commit();
            }
         }
         checkCloseFrame();
      }
      
      private function readDutyInfo(param1:ConsortiaDutyInfoMsg) : ConsortiaDutyInfo
      {
         var _loc2_:ConsortiaDutyInfo = new ConsortiaDutyInfo();
         _loc2_.levels = param1.levels;
         _loc2_.dutyName = param1.dutyName;
         _loc2_.rights = param1.rights;
         _loc2_.rightsStr = param1.rightsStr;
         return _loc2_;
      }
      
      public function setRightsList() : void
      {
         var _loc3_:ConsortiaDutyInfo = null;
         var _loc2_:BitArray = null;
         var _loc4_:int = 0;
         var _loc1_:ThaneInfo = getSimplePlayerInfoById(playerInfo.userId);
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.dutyId)
         {
            _loc3_ = ConsortiaDutyInfo(_model.consortiaDutyList[_loc1_.dutyId]);
            if(!_loc3_)
            {
               return;
            }
            _loc2_ = new BitArray();
            _loc3_.rights.position = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.rights.length)
            {
               _loc2_.writeByte(_loc3_.rights.readByte());
               _loc4_++;
            }
            _model.usrRights = _loc2_;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getConsortiaUserInfos() : void
      {
         checkCloseFrame();
         ConsortiaSocketOutManager.getConsortiaUserInfos();
      }
      
      private function __updateConsortiaMember(param1:SLGSocketEvent) : void
      {
         var _loc3_:SimplePlayerListRspMsg = null;
         var _loc4_:SimplePlayerListRspMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimplePlayerListRspMsg = new SimplePlayerListRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SimplePlayerListRspMsg;
         if(!_loc2_.hasUuid)
         {
            return;
         }
         var _loc6_:String = _loc2_.uuid;
         if(_loc6_ in membersCache)
         {
            _loc3_ = membersCache[_loc6_] as SimplePlayerListRspMsg;
            _loc3_.playerInfo = _loc2_.playerInfo.concat(_loc3_.playerInfo);
         }
         else
         {
            membersCache[_loc6_] = _loc2_;
            membersCache.push(_loc2_);
         }
         while(membersCache.length > 0)
         {
            _loc4_ = membersCache[0] as SimplePlayerListRspMsg;
            if(_loc4_.playerInfo.length != _loc4_.totalRows)
            {
               break;
            }
            updateConsortiaMember(_loc4_);
            membersCache.shift();
            delete membersCache[_loc4_.uuid];
         }
         checkCloseFrame();
      }
      
      private function updateConsortiaMember(param1:SimplePlayerListRspMsg) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SimplePlayerInfoMsg = null;
         var _loc6_:String = null;
         var _loc2_:ThaneInfo = null;
         var _loc5_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.playerInfo.length)
         {
            _loc4_ = param1.playerInfo[_loc3_] as SimplePlayerInfoMsg;
            if(_loc4_)
            {
               _loc6_ = _loc4_.userId.toString();
               _loc2_ = null;
               if(_loc6_ in _model.consortiaMemberList)
               {
                  _loc2_ = _model.consortiaMemberList[_loc6_];
               }
               if(!_loc2_)
               {
                  _loc2_ = new ThaneInfo();
               }
               updataMember(_loc2_,_loc4_);
               if(_loc2_.nickName != "")
               {
                  _loc5_.push(_loc2_);
               }
            }
            _loc3_++;
         }
         refreshConsortiaMember(_loc5_);
         setRightsList();
         if(_model.consortiaInfo && _model.consortiaInfo.isRobot)
         {
            copyRobotPro();
         }
         _model.dispatchEvent(new ConsortiaEvent("UPDATA_CONSORTIA_MEMBER"));
      }
      
      public function addRobot() : void
      {
         if(_model.consortiaMemberList.hasOwnProperty(_model.consortiaInfo.chairmanID))
         {
            return;
         }
         copyRobotPro();
         _model.dispatchEvent(new ConsortiaEvent("UPDATA_CONSORTIA_MEMBER"));
      }
      
      private function copyRobotPro() : void
      {
         var _loc1_:ThaneInfo = new ThaneInfo();
         _loc1_.nickName = _model.consortiaInfo.chairmanName;
         _loc1_.userId = _model.consortiaInfo.chairmanID;
         _loc1_.job = 1;
         _loc1_.templateId = 1;
         _loc1_.grades = 12;
         _loc1_.consortiaOffer = 10;
         _loc1_.consortiaTotalOffer = 10;
         _loc1_.state = 0;
         _loc1_.right = 3;
         _loc1_.logOutTime = new Date(2000);
         _loc1_.dutyId = 1;
         _model.consortiaMemberList.add(_loc1_.userId,_loc1_);
      }
      
      private function refreshConsortiaMember(param1:Array) : void
      {
         _model.consortiaMemberList.clear();
         for each(var _loc2_:ThaneInfo in param1)
         {
            _model.consortiaMemberList.add(_loc2_.userId,_loc2_);
         }
      }
      
      private function updataMember(param1:ThaneInfo, param2:*) : void
      {
         param1.userId = param2.userId;
         param1.nickName = param2.nickName;
         param1.grades = param2.grades;
         param1.consortiaOffer = param2.consortiaOffer;
         param1.consortiaTotalOffer = param2.consortiaTotalOffer;
         param1.consortiaName = param2.consortiaName;
         param1.fightingCapacity = param2.fightingCapacity;
         param1.sexs = param2.sexs;
         param1.state = param2.state;
         param1.templateId = param2.job;
         param1.job = param2.job;
         param1.role = param2.role;
         param1.isTeamPlayer = param2.isTeamPlayer;
         param1.isInwar = param2.isInwar;
         if(param2 is ThaneInfo)
         {
            param1.logOutTime = param2.logOutTime;
         }
         else
         {
            param1.logOutTime = DateFormatter.parse(param2.logOutTime,"YYYY-MM-DD hh:mm:ss");
            param1.IsVipAndNoExpirt = param2.isVip;
            param1.vipType = param2.vipType;
            param1.headId = param2.headId;
         }
         param1.dutyId = param2.dutyId;
         param1.crossGuildTeamId = param2.crossGuildTeamId;
         param1.isBackPlayer = param2.isBackPlayer;
         if(param2 is SimplePlayerInfoMsg)
         {
            param1.vocationGrades = (param2 as SimplePlayerInfoMsg).transGrade;
            param1.vocationIndex = (param2 as SimplePlayerInfoMsg).changeBranch;
         }
         else if(param2 is ThaneInfo)
         {
            param1.vocationGrades = (param2 as ThaneInfo).vocationGrades;
            param1.vocationIndex = (param2 as ThaneInfo).vocationIndex;
         }
      }
      
      public function getSimplePlayerInfoById(param1:int) : ThaneInfo
      {
         if(_model.consortiaMemberList.hasOwnProperty(param1))
         {
            return _model.consortiaMemberList[param1];
         }
         return null;
      }
      
      public function getSimplePlayerInfoByNickname(param1:String) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _model.consortiaMemberList)
         {
            if(_loc2_.nickName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __userLogin(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc5_:ConsortiaMsg = new ConsortiaMsg();
         _loc5_ = _loc4_.readBody(_loc5_) as ConsortiaMsg;
         var _loc3_:int = _loc5_.otherId;
         var _loc2_:ThaneInfo = getSimplePlayerInfoById(_loc3_);
         if(_loc2_)
         {
            _loc2_.state = 7;
            _loc2_.dispatchEvent(new ConsortiaEvent("UPDE_MEMEBER_STATE"));
            NotificationManager.instance.dispatchEvent(new ConsortiaEvent("UPDE_MEMEBER_STATE",_loc3_));
         }
         checkCloseFrame();
      }
      
      private function __userLogout(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc5_:ConsortiaMsg = new ConsortiaMsg();
         _loc5_ = _loc4_.readBody(_loc5_) as ConsortiaMsg;
         var _loc3_:int = _loc5_.otherId;
         var _loc2_:ThaneInfo = getSimplePlayerInfoById(_loc3_);
         if(_loc2_)
         {
            _loc2_.state = 0;
            _loc2_.logOutTime = new Date();
            _loc2_.dispatchEvent(new ConsortiaEvent("UPDE_MEMEBER_STATE"));
            NotificationManager.instance.dispatchEvent(new ConsortiaEvent("UPDE_MEMEBER_STATE",_loc3_));
         }
      }
      
      private function __consortiaSecretUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FamInfoMsg = new FamInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FamInfoMsg;
         _model.secretInfo.beginChanges();
         _model.secretInfo.membersNum = _loc2_.personNum;
         _model.secretInfo.rate = _loc2_.rate;
         _model.secretInfo.secretState = _loc2_.state;
         _model.secretInfo.countDown = _loc2_.countDown;
         _model.secretInfo.commitChanges();
      }
      
      private function __consortiaTreeUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:TipMessageData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FamInfoMsg = new FamInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FamInfoMsg;
         _model.secretInfo.beginChanges();
         _model.secretInfo.consortiaId = _loc2_.consortiaId;
         _model.secretInfo.membersNum = _loc2_.personNum;
         _model.secretInfo.rate = _loc2_.rate;
         _model.secretInfo.treeGrade = _loc2_.treeGrades;
         _model.secretInfo.treeGp = _loc2_.treeGp;
         _model.secretInfo.givePowerCount = _loc2_.treeWaterCount;
         _model.secretInfo.treeState = _loc2_.treeState;
         if(_loc2_.hasOpreate)
         {
            _model.secretInfo.oper = _loc2_.opreate;
         }
         _model.secretInfo.collectRate = _loc2_.collectRate;
         _model.secretInfo.secretState = _loc2_.state;
         _model.secretInfo.countDown = _loc2_.countDown;
         _model.secretInfo.commitChanges();
         if(_model.secretInfo.oper == 2)
         {
            _loc3_ = int(CampaignManager.instance.mapModel ? CampaignManager.instance.mapModel.mapId : 0);
            if(WorldBossHelper.checkConsortiaSecretLand(_loc3_))
            {
               return;
            }
            _loc5_ = new TipMessageData();
            _loc5_.type = 25;
            _loc5_.title = LanguageMgr.GetTranslation("public.prompt");
            _loc5_.name = LanguageMgr.GetTranslation("tasktracetip.view.SecretTreeTipView.secret");
            _loc5_.content = LanguageMgr.GetTranslation("tasktracetip.view.SecretTreeTipView.content");
            _loc5_.icon = "asset.taskTraceTips.TreeIcon";
            _loc5_.btnTxt = LanguageMgr.GetTranslation("tasktracetip.view.SecretTreeTipView.text");
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc5_,showSecretTip));
         }
      }
      
      private function __consortiaSecretSortHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ConsortiaUserInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FarmOrderList = new FarmOrderList();
         _loc2_ = _loc4_.readBody(_loc2_) as FarmOrderList;
         _model.secretInfo.rankList.length = 0;
         for each(var _loc3_:FarmOrderMsg in _loc2_.orderList)
         {
            _loc5_ = new ConsortiaUserInfo();
            _loc5_.userId = _loc3_.userid;
            _loc5_.nickName = _loc3_.nickname;
            _loc5_.secretOrder = _loc3_.order;
            _loc5_.secretScore = _loc3_.score;
            _model.secretInfo.rankList.push(_loc5_);
         }
         _model.secretInfo.rankList.sortOn("secretOrder",16);
         _model.secretInfo.commitSortChange();
      }
      
      private function __userJoinInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc7_:ConsortiaQuestInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaUserJoinMsg = new ConsortiaUserJoinMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaUserJoinMsg;
         if(_loc2_.hasReputation)
         {
            model.reputation = _loc2_.reputation;
         }
         if(_loc2_.hasActivePoint)
         {
            model.activePoint = _loc2_.activePoint;
         }
         if(_loc2_.hasWeeklyActivePoint)
         {
            model.weeklyActivePoint = _loc2_.weeklyActivePoint;
         }
         if(_loc2_.questSite)
         {
            _model.consortiaQuestStateAry = new BitArray();
            _loc3_ = _loc2_.questSite;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _model.consortiaQuestStateAry.writeByte(_loc3_.readByte());
               _loc5_++;
            }
         }
         for each(var _loc4_:ConsortiaConditionMsg in _loc2_.conditionList)
         {
            _loc7_ = model.getQuestInfoById(_loc4_.conditionId);
            if(_loc7_ == null)
            {
               _loc7_ = new ConsortiaQuestInfo();
               model.questInfoList.push(_loc7_);
            }
            _loc7_.conditionId = _loc4_.conditionId;
            _loc7_.process = _loc4_.process;
         }
         MsgMan.notifyObserver("UPDATE_QUEST_INFO");
         giftCount();
      }
      
      private function __consortiaQuestInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc7_:ConsortiaQuestInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaQuestMsg = new ConsortiaQuestMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaQuestMsg;
         if(_loc2_.questSite)
         {
            _model.questStateByteAry = new BitArray();
            _loc3_ = _loc2_.questSite;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _model.questStateByteAry.writeByte(_loc3_.readByte());
               _loc5_++;
            }
         }
         for each(var _loc4_:ConsortiaConditionMsg in _loc2_.conditionList)
         {
            _loc7_ = model.getQuestInfoById(_loc4_.conditionId);
            if(_loc7_ == null)
            {
               _loc7_ = new ConsortiaQuestInfo();
               model.questInfoList.push(_loc7_);
            }
            _loc7_.conditionId = _loc4_.conditionId;
            _loc7_.process = _loc4_.process;
         }
         MsgMan.notifyObserver("UPDATE_QUEST_INFO");
         giftCount();
      }
      
      private function __businessInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaShopSupplyRespMsg = new ConsortiaShopSupplyRespMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaShopSupplyRespMsg;
         model.supplyList = _loc2_.mapShopId;
         MsgMan.notifyObserver("UPDATE_BUSINESS_INFO");
      }
      
      private function __businessSelfInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:ConsortiaShopRespMsg = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaShopTradingRespMsg = new ConsortiaShopTradingRespMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaShopTradingRespMsg;
         model.tradeList = [];
         model.tradeStateList = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.shopInfo.length)
         {
            _loc5_ = _loc2_.shopInfo[_loc3_];
            if(_loc5_)
            {
               model.tradeList.push(_loc5_.mapShopId);
               model.tradeStateList.push(_loc5_.state);
            }
            _loc3_++;
         }
         model.refreshCounts = _loc2_.refreshCounts;
         MsgMan.notifyObserver("UPDATE_BUSINESS_INFO");
      }
      
      private function showSecretTip(param1:Object) : void
      {
         TaskTraceTipManager.instance.showView(param1 as TipMessageData);
      }
      
      private function __consortiaQuitHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaQuitReqMsg = new ConsortiaQuitReqMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaQuitReqMsg;
         _model.secretInfo.clear();
         model.questInfoList = [];
         model.businessList = [];
      }
      
      public function getDailyInfoById(param1:String) : DailyItemInfo
      {
         var _loc2_:* = null;
         var _loc3_:Dictionary = TempleteManager.instance.activeTemplateCate.getTemplates();
         for each(var _loc4_:DailyItemInfo in _loc3_)
         {
            if(_loc4_ && _loc4_.TemplateId == param1 && _loc4_.Type == 2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function checkCloseFrame() : void
      {
         if(playerInfo.consortiaID <= 0)
         {
            NotificationManager.instance.sendNotification("CLOSECONSORTIAFRAME");
         }
      }
      
      public function checkConsortiaSkillByGrade() : Boolean
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:Array = [6,8,9,10,11,12];
         var _loc1_:int = int(playerInfo.consortiaOffer > ResourceManager.instance.gold.count / 1000 ? playerInfo.consortiaOffer : ResourceManager.instance.gold.count / 1000);
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            _loc7_ = int(_loc8_[_loc5_]);
            _loc6_ = ConsortiaSkillHelper.getLevelByType(_loc7_,playerInfo);
            _loc9_ = consortiaInfo.getLevelByUpgradeType(_loc7_);
            _loc2_ = _loc6_ < _loc9_ ? _loc6_ : _loc9_;
            if(_loc2_ >= 1)
            {
               if(_loc2_ >= 2)
               {
                  _loc4_ += 2;
               }
               else
               {
                  _loc4_++;
               }
            }
            if(_loc9_ > 0)
            {
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc4_ >= 2)
         {
            return false;
         }
         if(_loc4_ == 0 && _loc1_ >= 200 && _loc3_)
         {
            return true;
         }
         if(_loc4_ == 1 && _loc1_ >= 500)
         {
            return true;
         }
         return false;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      private function __updateTreasureHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:Array = null;
         var _loc6_:int = 0;
         var _loc18_:TreasureInfo = null;
         var _loc10_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc11_:Array = null;
         var _loc17_:int = 0;
         var _loc3_:MyTreasureInfo = null;
         var _loc4_:int = 0;
         var _loc13_:Array = null;
         var _loc5_:int = 0;
         var _loc15_:OthersTreasureInfo = null;
         var _loc12_:Array = null;
         var _loc16_:int = 0;
         var _loc9_:MyTreasureInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaTreasureOpMsg = new ConsortiaTreasureOpMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ConsortiaTreasureOpMsg;
         _model.treasureGroupInfo.payType = _loc2_.payType;
         _model.treasureGroupInfo.treasureId = _loc2_.treasureId;
         _model.treasureGroupInfo.errorID = _loc2_.errorID;
         if(_loc2_.errorID == 5)
         {
            _model.treasureGroupInfo.NoOpen = true;
            if(_loc2_.op == 0)
            {
               _model.dispatchEvent(new ConsortiaEvent("OPEN_TREASURES"));
            }
            else if(_loc2_.op == 2)
            {
               _model.dispatchEvent(new ConsortiaEvent("OPEN_OTHERS_TREASURES"));
            }
            return;
         }
         switch(_loc2_.op)
         {
            case 0:
               _model.treasureGroupInfo.leftCount = _loc2_.teasurePageInfo.leftCount;
               _model.treasureGroupInfo.freeTime = _loc2_.teasurePageInfo.freeTime;
               _model.treasureGroupInfo.totalTime = _loc2_.teasurePageInfo.freeTemplateSecond;
               _model.treasureGroupInfo.refreshTimes = _loc2_.teasurePageInfo.refreshTimes;
               _loc7_ = _loc2_.teasurePageInfo.treasures;
               _model.treasureGroupInfo.treasures.length = 0;
               _loc6_ = 0;
               while(_loc6_ < _loc7_.length)
               {
                  _loc18_ = new TreasureInfo();
                  _loc18_.treasureId = _loc7_[_loc6_].treasureId;
                  _loc18_.treasureTemplateId = _loc7_[_loc6_].treasureTemplateId;
                  _model.treasureGroupInfo.treasures[_loc6_] = _loc18_;
                  _loc6_++;
               }
               _model.dispatchEvent(new ConsortiaEvent("OPEN_TREASURES"));
               if(_model.treasureGroupInfo.leftCount <= 0)
               {
                  return;
               }
               _loc10_ = PlayerManager.instance.currentPlayerModel.nowDate;
               _loc14_ = _model.treasureGroupInfo.newFreeTime;
               if(_loc10_ >= _loc14_ && !isOpen)
               {
                  openTaskTraceTip();
               }
               break;
            case 1:
               _loc11_ = _loc2_.myTreasures;
               _model.treasureGroupInfo.myTreasures.length = 0;
               _loc17_ = 0;
               while(_loc17_ < _loc11_.length)
               {
                  _loc3_ = new MyTreasureInfo();
                  _loc3_.treasureId = _loc11_[_loc17_].treasureId;
                  _loc3_.openTime = _loc11_[_loc17_].openTime;
                  _loc3_.treasureTemplateId = _loc11_[_loc17_].treasureTemplateId;
                  _loc3_.helperName = _loc11_[_loc17_].helperName;
                  _loc3_.requestHelpCount = _loc11_[_loc17_].requestHelpCount;
                  _loc3_.status = _loc11_[_loc17_].status;
                  _model.treasureGroupInfo.myTreasures[_loc17_] = _loc3_;
                  if(_loc3_.status == 2 && !isOpen)
                  {
                     openTaskTraceTip();
                  }
                  _loc17_++;
               }
               giftCount();
               _model.dispatchEvent(new ConsortiaEvent("OPEN_MY_TREASURES"));
               break;
            case 2:
               _model.treasureGroupInfo.helpLeftCount = _loc2_.helpList.leftCount;
               _loc4_ = _loc2_.helpList.leftCount;
               _loc13_ = _loc2_.helpList.othersTreasures;
               _model.treasureGroupInfo.helpList.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc13_.length)
               {
                  _loc15_ = new OthersTreasureInfo();
                  _loc15_.treasureId = _loc13_[_loc5_].treasureId;
                  _loc15_.openTime = _loc13_[_loc5_].openTime;
                  _loc15_.treasureTemplateId = _loc13_[_loc5_].treasureTemplateId;
                  _loc15_.ownerName = _loc13_[_loc5_].ownerName;
                  _loc15_.ownerHeadId = _loc13_[_loc5_].ownerHeadId;
                  _loc15_.helperRewardTime = _loc13_[_loc5_].helperRewardTime;
                  _loc15_.status = _loc13_[_loc5_].status;
                  _model.treasureGroupInfo.helpList[_loc5_] = _loc15_;
                  _loc5_++;
               }
               _model.treasureGroupInfo.helpList.sort(GoodsSortFuncDesc);
               _loc15_ = _model.treasureGroupInfo.helpList[0];
               if(_loc15_ && _loc15_.status != 1 && !isOpen && _loc4_ > 0)
               {
                  openTaskTraceTip();
               }
               giftCount();
               _model.dispatchEvent(new ConsortiaEvent("OPEN_OTHERS_TREASURES"));
               break;
            case 3:
               _model.dispatchEvent(new ConsortiaEvent("REFRESH"));
               break;
            case 4:
               _loc12_ = _loc2_.myTreasures;
               _model.treasureGroupInfo.open_treasure.length = 0;
               _loc16_ = 0;
               while(_loc16_ < _loc12_.length)
               {
                  _loc9_ = new MyTreasureInfo();
                  _loc9_.treasureId = _loc12_[_loc16_].treasureId;
                  _loc9_.openTime = _loc12_[_loc16_].openTime;
                  _loc9_.treasureTemplateId = _loc12_[_loc16_].treasureTemplateId;
                  _loc9_.helperName = _loc12_[_loc16_].helperName;
                  _loc9_.requestHelpCount = _loc12_[_loc16_].requestHelpCount;
                  _loc9_.status = _loc12_[_loc16_].status;
                  _model.treasureGroupInfo.open_treasure[_loc16_] = _loc9_;
                  _loc16_++;
               }
               _model.dispatchEvent(new ConsortiaEvent("OPEN_TREASURE"));
               break;
            case 5:
               if(_loc2_.errorID == 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasureHelp.haveOpen"));
               }
               _model.dispatchEvent(new ConsortiaEvent("HELP_OPEN_TREASURE"));
               break;
            case 6:
               _model.dispatchEvent(new ConsortiaEvent("GET_REWARD"));
               break;
            case 7:
               _model.dispatchEvent(new ConsortiaEvent("SPEED_UP"));
               break;
            case 9:
               _model.dispatchEvent(new ConsortiaEvent("OPEN_TREASURES"));
         }
      }
      
      private function openTaskTraceTip() : void
      {
         if(isOpenTreasreFrame)
         {
            return;
         }
         TaskTraceTipManager.instance.cleanByType(51);
         var _loc1_:TipMessageData = new TipMessageData();
         _loc1_.type = 51;
         _loc1_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         _loc1_.content = LanguageMgr.GetTranslation("yishi.manager.ConsortiaManager.ConsortiaTreasurt");
         showSecretTip(_loc1_);
      }
      
      public function giftCount() : void
      {
         var _loc1_:int = _model.treasureCount;
         if(_model.applyConsortiaList.length > 0 && PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            if(FrameControllerManager.instance.consortiaController.getRightsByIndex(9))
            {
               _loc1_ += _model.recruitNum;
            }
         }
         _loc1_ += model.taskCanRewardCount;
         _loc1_ += FrameControllerManager.instance.guildFbController.model.getReaNum();
         InfoTipsManager.instance.updateValue(4,_loc1_);
         _model.dispatchEvent(new ConsortiaEvent("recruitnum_changed"));
      }
      
      public function loadConfigInfos() : void
      {
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_treasure_refresh_cost");
         if(_loc4_)
         {
            _model.refresh_costArr = _loc4_.ConfigValue.split(",");
         }
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_treasure_open_cost");
         if(_loc1_)
         {
            _model.open_costArr = _loc1_.ConfigValue.split(",");
         }
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_treasure_Count");
         if(_loc2_)
         {
            _model.CountArr = _loc2_.ConfigValue.split(",");
         }
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_treasure_speed_up_cost");
         if(_loc3_)
         {
            _model.speed_up_costArr = _loc3_.ConfigValue.split(",");
         }
      }
      
      public function getTreasureTempByID(param1:int) : ConsortiaTreasureTemplateInfo
      {
         return TempleteManager.instance.consortiaTreasureTemplateCate.getTemplateByID(param1);
      }
      
      private function GoodsSortFuncDesc(param1:OthersTreasureInfo, param2:OthersTreasureInfo) : int
      {
         var _loc4_:ConsortiaTreasureTemplateInfo = null;
         var _loc3_:ConsortiaTreasureTemplateInfo = null;
         if(param1.status > param2.status)
         {
            return -1;
         }
         if(param1.status < param2.status)
         {
            return 1;
         }
         _loc4_ = ConsortiaManager.instance.getTreasureTempByID(param1.treasureTemplateId);
         _loc3_ = ConsortiaManager.instance.getTreasureTempByID(param2.treasureTemplateId);
         if(_loc4_.Quality > _loc3_.Quality)
         {
            return -1;
         }
         if(_loc4_.Quality < _loc3_.Quality)
         {
            return 1;
         }
         return 0;
      }
   }
}

