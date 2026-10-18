package mvc.controler
{
   import battle.utils.Int64Utils;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.pb.helper.item.ItemHelper;
   import com.road.yishi.proto.consortia.ConsortiaContributeMsg;
   import com.road.yishi.proto.consortia.ConsortiaContributeRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaEventInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaEventListRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaInfoMsg;
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.consortia.ConsortiaSearchRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaVotingRspMsg;
   import com.road.yishi.proto.consortia.ConsortiaVotingUserMsg;
   import com.road.yishi.proto.consortia.ConsortiaVotingUsersMsg;
   import com.road.yishi.proto.item.ItemInfoMsg;
   import com.road.yishi.proto.simple.SimplePlayerSearchReqMsg;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.EmailSocketOutManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.consortia.ConsortiaDutyInfo;
   import mvc.module.consortia.ConsortiaEventInfo;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaInviteInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import mvc.module.consortia.ConsortiaTempleteInfo;
   import mvc.module.consortia.ConsortiaUserInfo;
   import mvc.module.consortia.ConsortiaVotingUserInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaControler extends FrameController
   {
      
      private var _model:ConsortiaModel;
      
      private var _contributeFrame:*;
      
      private var _buildingFrame:*;
      
      private var _skillFrame:*;
      
      private var _altarFrame:*;
      
      public var openTypeAry:Array = [1,5,8,9,10,11,13,3,"15"];
      
      private var _openFromConsortiaFrame:int = -1000;
      
      public var randomCount:int = 1;
      
      private var _devilFrame:Frame;
      
      public function ConsortiaControler()
      {
         super();
         _model = ConsortiaManager.instance.model;
         shineConsortiaBtn();
      }
      
      private function shineConsortiaBtn() : void
      {
         ConsortiaManager.instance.isFirstRecord = true;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("IS_CONSORTIA_EXIST",__existHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 35,__joinConsortiaHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 36,__deleteApplyConsortiaHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 37,__operateConsortiaApplyResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 42,__consortiaContributeResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 40,__consortiaAcceptApplyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 45,__getAltarBlessInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4134,__updataOfferList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4136,__refreshEventList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4139,__refreshConsortiaList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4141,__refreshAltarInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4142,__refreshAltarGoods);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4144,__setGoods);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4143,__addFreshItem);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4389,__setVotingUsers);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4390,__updateVotingState);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("IS_CONSORTIA_EXIST",__existHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 35,__joinConsortiaHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 36,__deleteApplyConsortiaHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 37,__operateConsortiaApplyResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 42,__consortiaContributeResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 40,__consortiaAcceptApplyHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 45,__getAltarBlessInfo);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4134,__updataOfferList);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4136,__refreshEventList);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4139,__refreshConsortiaList);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4141,__refreshAltarInfo);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4142,__refreshAltarGoods);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4144,__setGoods);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4143,__addFreshItem);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4389,__setVotingUsers);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4390,__updateVotingState);
      }
      
      private function outOfDate() : Boolean
      {
         var _loc1_:Date = new Date();
         _loc1_.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         if(_model.consortiaInfo.warnDate == null)
         {
            return false;
         }
         var _loc2_:Number = _loc1_.time - _model.consortiaInfo.warnDate.time;
         return _loc2_ / 86400000 >= 8;
      }
      
      override protected function showFrame() : void
      {
         if(_data.openType == 6)
         {
            _frame["data"] = _data.frameData;
            _frame["show"]();
            return;
         }
         MainToolBar.instance.consortiaButtonShine = false;
         super.showFrame();
         addEvent();
         if(_openFromConsortiaFrame != -1000)
         {
            _frame["show"](_openFromConsortiaFrame);
            _openFromConsortiaFrame = -1000;
         }
         else if(openTypeAry.indexOf(_data.openType) != -1)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
         if(_data.openType == 1)
         {
            sendGetConsortiaApplyInfos();
         }
      }
      
      override protected function createFrame() : void
      {
         var _loc1_:String = null;
         super.createFrame();
         if(_frame)
         {
            if(playerInfo.consortiaID == 0)
            {
               return;
            }
            if(outOfDate())
            {
               _loc1_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command01");
               MessageTipManager.instance().show(_loc1_);
            }
         }
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(param1.openType != 1 && param1.openType != 6 && param1.openType != 8 && playerInfo.consortiaID == 0)
         {
            return;
         }
         var _loc2_:Object = param1.openType;
         if(4 === _loc2_)
         {
            if(model.consortiaInfo.altarLevel <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.controler.ConsortiaControler.altarUnopen"));
               return;
            }
         }
         super.start(param1);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "consortia.ConsortiaContributeFrame";
         }
         if(_data.openType == 4)
         {
            return "consortia.ConsortiaNewAltarFrame";
         }
         if(_data.openType == 5)
         {
            return "consortia.ConsortiaStudySkillFrame";
         }
         if(_data.openType == 6)
         {
            return "lookconsortiainfoe.ConsortiaInfoFrame";
         }
         if(_data.openType == 7)
         {
            return "consortia.ConsortiaPrizeAllotFrame";
         }
         if(_data.openType == 8)
         {
            return "consortia.ConsortiaSkillSchoolFrame";
         }
         if(_data.openType == 9)
         {
            return "consortia.ConsortiaBusinessFrame";
         }
         if(_data.openType == 10)
         {
            return "consortia.ConsortiaTaskSchoolFrame";
         }
         if(_data.openType == 11)
         {
            return "consortia.ConsortiaTreasureFrame";
         }
         if(_data.openType == 12)
         {
            return "consortia.view.myConsortia.emedream.ConsortiaEmeDreamFrame";
         }
         if(_data.openType == 13)
         {
            return "consortia.ConsortiaCommerceShopFrame";
         }
         if(playerInfo.consortiaID == 0)
         {
            return "consortia.ConsortiaSearchFrame";
         }
         return "consortia.ConsortiaFrame";
      }
      
      override protected function exitFrame() : void
      {
         removeEvent();
         if(_data.openType != 2)
         {
            closeContributeFrame(false);
            closeBuildingFrame(false);
            skillFrameClosed();
         }
         super.exitFrame();
      }
      
      public function get frameIsDie() : Boolean
      {
         if(!_frame)
         {
            return true;
         }
         return _frame.isDie;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get model() : ConsortiaModel
      {
         return _model;
      }
      
      public function hide() : void
      {
         if(_frame)
         {
            _frame.visible = false;
         }
      }
      
      public function show() : void
      {
         if(_frame)
         {
            _frame.visible = true;
            StageReferance.stage.focus = _frame;
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("consortia");
         }
      }
      
      public function get mainFrame() : Frame
      {
         return _frame;
      }
      
      public function showContributeFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",2);
      }
      
      public function closeContributeFrame(param1:Boolean = true) : void
      {
         if(_contributeFrame && _contributeFrame.parent)
         {
            _contributeFrame.dispose();
         }
         _contributeFrame = null;
         if(param1)
         {
            show();
         }
      }
      
      public function showBuildingView() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",1,3);
      }
      
      public function showFacilitiesView() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",1,4);
      }
      
      public function showActivityView() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",1,5);
      }
      
      public function showAltarFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",4);
      }
      
      public function closeAltarFrame() : void
      {
         _altarFrame = null;
         showBuildingView();
      }
      
      public function closeBuildingFrame(param1:Boolean = true) : void
      {
         if(_buildingFrame && _buildingFrame.parent)
         {
            _buildingFrame.dispose();
         }
         _buildingFrame = null;
         if(param1)
         {
            show();
         }
      }
      
      public function showSkillFrame(param1:int) : void
      {
         this._openFromConsortiaFrame = param1;
         FrameControllerManager.instance.openControllerByInfo("consortia",5);
      }
      
      public function showMasterSkillFrame(param1:int) : void
      {
         this._openFromConsortiaFrame = param1;
         FrameControllerManager.instance.openControllerByInfo("consortia",8);
      }
      
      public function showBusinessFrame(param1:int) : void
      {
         this._openFromConsortiaFrame = param1;
         FrameControllerManager.instance.openControllerByInfo("consortia",9);
      }
      
      public function showTaskSchoolFrame(param1:int) : void
      {
         this._openFromConsortiaFrame = param1;
         FrameControllerManager.instance.openControllerByInfo("consortia",10);
      }
      
      public function showTreasureFrame(param1:int) : void
      {
         this._openFromConsortiaFrame = param1;
         FrameControllerManager.instance.openControllerByInfo("consortia",11);
      }
      
      public function closeSkillFrame(param1:int = 0, param2:Boolean = true) : void
      {
         skillFrameClosed();
         if(!param2)
         {
            return;
         }
         switch(param1 - 1)
         {
            case 0:
               show();
               break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               showBuildingView();
               break;
            case 6:
               showActivityView();
         }
      }
      
      private function skillFrameClosed() : void
      {
         if(_skillFrame && _skillFrame.parent)
         {
            _skillFrame.dispose();
         }
         _skillFrame = null;
      }
      
      public function getConsortiaInviteInfos() : void
      {
         ConsortiaSocketOutManager.getConsortiaInviteInfos();
      }
      
      private function __refreshConsortiaList(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaSearchRspMsg = new ConsortiaSearchRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ConsortiaSearchRspMsg;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.consortiaInfo.length)
         {
            _loc3_.push(readConsortiaInfo(_loc2_.consortiaInfo[_loc4_] as ConsortiaInfoMsg));
            _loc4_++;
         }
         _model.consortiaList = _loc3_;
         _model.setTotalRows = _loc2_.totalRows;
         if(_loc2_.isReset)
         {
            randomCount = 1;
         }
      }
      
      private function readConsortiaInfo(param1:ConsortiaInfoMsg) : ConsortiaInfo
      {
         var _loc2_:ConsortiaInfo = new ConsortiaInfo();
         _loc2_.consortiaId = param1.consortiaId;
         _loc2_.consortiaName = param1.consortiaName;
         _loc2_.chairmanName = param1.chairmanName;
         _loc2_.levels = param1.levels;
         _loc2_.offer = param1.offer;
         _loc2_.currentCount = param1.currentCount;
         _loc2_.honor = param1.honor;
         _loc2_.description = param1.description;
         _loc2_.isRobot = param1.isRobot;
         _loc2_.currentCount = param1.currentCount;
         return _loc2_;
      }
      
      private function __joinConsortiaHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaMsg;
         var _loc3_:int = _loc2_.applyId;
         if(_loc3_)
         {
            getConsortiaInviteInfos();
            NotificationManager.instance.dispatchEvent(new ConsortiaEvent("APPLY_CONSORTIA_SUCCESS"));
         }
      }
      
      private function __deleteApplyConsortiaHandler(param1:SLGSocketEvent) : void
      {
         getConsortiaInviteInfos();
      }
      
      public function operateConsortiaApply(param1:int, param2:Boolean) : void
      {
         ConsortiaSocketOutManager.operateConsortiaApply(param1,param2);
      }
      
      private function __operateConsortiaApplyResult(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaMsg;
         var _loc4_:Boolean = _loc2_.result;
         var _loc5_:int = _loc2_.applyId;
         for each(var _loc3_:ConsortiaInviteInfo in _model.inviteList)
         {
            if(_loc3_.id == _loc5_)
            {
               _model.inviteList.splice(_model.inviteList.indexOf(_loc3_),1);
               _model.dispatchEvent(new ConsortiaEvent("UPDA_RECORD_LIST"));
               break;
            }
         }
      }
      
      private function __existHandler(param1:ConsortiaEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia");
      }
      
      public function getConsortiaInfos() : void
      {
         ConsortiaSocketOutManager.getConsortiaInfos();
      }
      
      public function getRightsByIndex(param1:int) : Boolean
      {
         return _model.usrRights.getBit(param1 - 1);
      }
      
      public function getSimplePlayerInfoById(param1:int) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _model.consortiaMemberList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRightsByNum(param1:int) : Boolean
      {
         var _loc4_:ConsortiaDutyInfo = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         if(getRightsByIndex(19))
         {
            _loc4_ = ConsortiaDutyInfo(model.consortiaDutyList[2]);
            if(_loc4_ && _loc4_.rightsStr)
            {
               _loc2_ = _loc4_.rightsStr.split(",");
               if(_loc2_.length > 0)
               {
                  for each(var _loc3_:String in _loc2_)
                  {
                     _loc6_ = parseInt(_loc3_);
                     if(_loc6_ == param1)
                     {
                        _loc5_ = true;
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      public function creatConsortia(param1:String) : void
      {
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var point:String;
         var content:String;
         var alertHandler:*;
         var consortiaName:String = param1;
         var num:Number = PlayerManager.instance.currentPlayerModel.playerInfo.lastOutConsortia;
         var isAuto:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.isAuto;
         if(isAuto && num + 86400 > PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond)
         {
            alertHandler = function(param1:Boolean, param2:Boolean):void
            {
               if(param1)
               {
                  if(PlayerManager.instance.currentPlayerModel.playerInfo.point < int(TempleteManager.instance.getConfigInfoByConfigName("Consortia_ClearCD_Point").ConfigValue))
                  {
                     RechargeAlertMannager.show();
                     return;
                  }
                  ConsortiaSocketOutManager.creatConsortia(consortiaName,true);
               }
            };
            confirm = LanguageMgr.GetTranslation("public.confirm");
            cancel = LanguageMgr.GetTranslation("public.cancel");
            prompt = LanguageMgr.GetTranslation("public.prompt");
            point = TempleteManager.instance.getConfigInfoByConfigName("Consortia_ClearCD_Point").ConfigValue;
            content = LanguageMgr.GetTranslation("Consortia.ConsortiaSocketOutManager.content2",point);
            SimpleAlertHelper.instance.data = [alertHandler];
            SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,true,true);
         }
         else
         {
            ConsortiaSocketOutManager.creatConsortia(consortiaName,false);
         }
      }
      
      public function updateConsortiaName(param1:String) : void
      {
         ConsortiaSocketOutManager.creatConsortia(param1,false);
      }
      
      public function modifyConsortiaDiscription(param1:String) : void
      {
         if(checkWord(param1))
         {
            ConsortiaSocketOutManager.modifyConsortiaDiscription(param1);
         }
      }
      
      public function modifyConsortiaPlacard(param1:String) : void
      {
         if(checkWord(param1))
         {
            ConsortiaSocketOutManager.modifyConsortiaPlacard(param1);
         }
      }
      
      private function checkWord(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(FilterWordManager.isGotForbiddenWords(param1,"name") || FilterWordManager.isGotForbiddenWords(param1,"chat"))
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command05");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         return true;
      }
      
      private function __consortiaContributeResult(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaMsg;
         var _loc3_:Boolean = _loc2_.result;
         if(_loc3_ && _model)
         {
            _model.dispatchEvent(new ConsortiaEvent("ON_CONSORTIA_CONTRIBUTE_SUCCEED"));
         }
      }
      
      public function getConsortiaOffer(param1:Boolean) : void
      {
         _model.isHistory = param1;
         _model.contributeListCurrentPage = 1;
         sendGetConsortiaOffer();
      }
      
      public function sendGetConsortiaOffer() : void
      {
         ConsortiaSocketOutManager.getConsortiaOffer(_model.contributeListCurrentPage,_model.isHistory);
      }
      
      private function __updataOfferList(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ConsortiaUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaContributeRspMsg = new ConsortiaContributeRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaContributeRspMsg;
         var _loc4_:Array = [];
         _model.contributeListTotalPage = Math.ceil(_loc2_.totalRows / 8);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.contributeInfo.length)
         {
            _loc3_ = new ConsortiaUserInfo();
            copyProperty(_loc3_,_loc2_.contributeInfo[_loc5_] as ConsortiaContributeMsg);
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         _model.totalOffer = _loc2_.selfInfo.totalOffer;
         _model.todayOffer = _loc2_.selfInfo.todayOffer;
         _model.todaySpirit = Int64Utils.int64ToNumber(_loc2_.selfInfo.todaySpirit);
         _model.totalSpirit = Int64Utils.int64ToNumber(_loc2_.selfInfo.totalSpirit);
         _model.nickName = _loc2_.selfInfo.nickName;
         _model.selfOrder = _loc2_.selfOrder;
         _model.consortiaContributionList = _loc4_;
      }
      
      private function copyProperty(param1:ConsortiaUserInfo, param2:ConsortiaContributeMsg) : void
      {
         param1.nickName = param2.nickName;
         param1.todayOffer = param2.todayOffer;
         param1.totalOffer = param2.totalOffer;
         param1.todaySpirit = Int64Utils.int64ToNumber(param2.todaySpirit);
         param1.totalSpirit = Int64Utils.int64ToNumber(param2.totalSpirit);
      }
      
      public function contributeSearchPageHandler(param1:Boolean) : void
      {
         if(param1 && _model.contributeListCurrentPage > 1)
         {
            _model.contributeListCurrentPage -= 1;
         }
         else
         {
            if(!(!param1 && _model.contributeListCurrentPage < _model.contributeListTotalPage))
            {
               return;
            }
            _model.contributeListCurrentPage += 1;
         }
         sendGetConsortiaOffer();
      }
      
      public function consortiaUpgrade(param1:Object) : void
      {
         if(param1 is ConsortiaTemplete)
         {
            ConsortiaSocketOutManager.consortiaUpgrade(ConsortiaTemplete(param1).Types);
         }
         else
         {
            ConsortiaSocketOutManager.consortiaUpgrade(int(param1));
         }
      }
      
      public function SearchPlayer(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8257);
         var _loc2_:SimplePlayerSearchReqMsg = new SimplePlayerSearchReqMsg();
         _loc2_.otherNickname = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function consortiaTransfer(param1:int) : void
      {
         ConsortiaSocketOutManager.consortiaTransfer(param1);
      }
      
      public function sendQuickTime(param1:Boolean) : void
      {
         ConsortiaSocketOutManager.sendQuickTime(param1);
      }
      
      public function getConsortiaEventInfos() : void
      {
         ConsortiaSocketOutManager.getConsortiaEventInfos();
      }
      
      private function __refreshEventList(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaEventListRspMsg = new ConsortiaEventListRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ConsortiaEventListRspMsg;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.eventInfo.length)
         {
            _loc3_.push(readEventInfo(_loc2_.eventInfo[_loc4_] as ConsortiaEventInfoMsg));
            _loc4_++;
         }
         _model.consortiaEventList = _loc3_.sortOn("createDate",0x10 | 2);
      }
      
      private function readEventInfo(param1:ConsortiaEventInfoMsg) : ConsortiaEventInfo
      {
         var _loc2_:ConsortiaEventInfo = new ConsortiaEventInfo();
         _loc2_.id = param1.id;
         _loc2_.consortiaId = param1.consortiaId;
         _loc2_.remark = param1.remark;
         _loc2_.createDate = DateFormatter.parse(param1.createDate,"YYYY-MM-DD hh:mm:ss");
         _loc2_.types = param1.type;
         _loc2_.isExist = param1.isExist;
         return _loc2_;
      }
      
      public function getConsortiaApplyInfos(param1:Boolean) : void
      {
         if(param1 && _model.recruitCurrentPage > 1)
         {
            _model.recruitCurrentPage--;
         }
         else
         {
            if(!(!param1 && _model.recruitCurrentPage < _model.recruitListTotalPage))
            {
               return;
            }
            _model.recruitCurrentPage++;
         }
         sendGetConsortiaApplyInfos();
      }
      
      public function sendGetConsortiaApplyInfos() : void
      {
         ConsortiaSocketOutManager.getConsortiaApplyInfos(_model.recruitCurrentPage);
      }
      
      public function consortiaAcceptOrRejectApply(param1:Array, param2:Boolean) : void
      {
         var _loc3_:String = null;
         _model.beginChanges();
         for each(var _loc4_:ThaneInfo in param1)
         {
            if(_loc4_.consortiaID && param2)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command08");
               MessageTipManager.instance().show(_loc3_);
            }
            else
            {
               ConsortiaSocketOutManager.consortiaAcceptOrRejectApply(_loc4_.parameter1,param2);
               _model.removeFromApplyConsortiaList(_loc4_);
            }
         }
         _model.commit();
      }
      
      private function __consortiaAcceptApplyHandler(param1:SLGSocketEvent) : void
      {
         _model.recruitNum--;
         if(_model.recruitNum <= 0)
         {
            _model.recruitNum == 0;
            sendGetConsortiaApplyInfos();
         }
      }
      
      public function initAltarFrameInfo() : void
      {
         _model.isBlessing = false;
         getAltarInfo();
      }
      
      public function getAltarInfo() : void
      {
         ConsortiaSocketOutManager.getAltarInfo();
      }
      
      private function __refreshAltarInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaMsg;
         _model.alTarBlessLeftTime = _loc2_.blessLeftTime;
      }
      
      public function consortiaAltarBless(param1:int = 1) : void
      {
         _model.isBlessing = true;
         ConsortiaSocketOutManager.consortiaAltarBless(param1);
      }
      
      private function __getAltarBlessInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaMsg;
         _model.alTarBlessLeftTime = _loc2_.blessLeftTime;
         _model.blessInfo.site = _loc2_.blessSite;
         _model.blessInfo.templateId = _loc2_.blessTempId;
         _model.blessInfo.count = _loc2_.blessCount;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _model.blessInfo.templateId;
         _loc3_.count = _model.blessInfo.count;
         _model.altarGoods = _loc3_;
         _model.dispatchEvent(new ConsortiaEvent("UPDA_ALTAR_BLESS_INFO"));
      }
      
      private function __refreshAltarGoods(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ItemInfoMsg = new ItemInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ItemInfoMsg;
         var _loc4_:GoodsInfo = new GoodsInfo();
         _model.lastaltarGoods = ItemHelper.readGoodsInfo(_loc2_,_loc4_);
      }
      
      public function getConsortiaAddFreshItem() : void
      {
         ConsortiaSocketOutManager.getConsortiaAddFreshItem();
      }
      
      private function __addFreshItem(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaMsg;
         if(_loc2_.result)
         {
            _model.altarGoods = _model.lastaltarGoods = null;
         }
         NotificationManager.instance.dispatchEvent(new ConsortiaEvent("GET_ALTAR_GOODS",_loc2_.result));
      }
      
      public function getShowSkills() : void
      {
         var _loc4_:int = 0;
         var _loc3_:ConsortiaTemplete = null;
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:ConsortiaTemplete = null;
         _loc4_ = 1;
         while(_loc4_ <= 10)
         {
            _loc3_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(4,_loc4_);
            if(_loc3_.NextTemplateId)
            {
               _loc1_ = _loc3_.NextTemplateId.split(",");
               _loc5_ = 0;
               while(_loc5_ < _loc1_.length)
               {
                  _loc2_ = TempleteManager.instance.getConsortiaTempleteById(int(_loc1_[_loc5_]));
                  if(_loc2_)
                  {
                     sort(_loc2_);
                  }
                  _loc5_++;
               }
            }
            _loc4_++;
         }
         if(model.consortiaInfo.schoolLevel < 10)
         {
            getNextLevelSkill(model.consortiaInfo.schoolLevel + 1);
         }
         model.dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_SKILL_LIST"));
      }
      
      private function getNextLevelSkill(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:ConsortiaTemplete = null;
         var _loc4_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(4,param1);
         if(_loc4_.NextTemplateId)
         {
            _loc2_ = _loc4_.NextTemplateId.split(",");
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc3_ = TempleteManager.instance.getConsortiaTempleteById(int(_loc2_[_loc5_]));
               if(_loc3_)
               {
                  sort(_loc3_,true);
               }
               _loc5_++;
            }
         }
      }
      
      private function sort(param1:ConsortiaTemplete, param2:Boolean = false) : void
      {
         var _loc3_:ConsortiaTempleteInfo = null;
         if(!_model.baseSkillList.hasOwnProperty("type_" + param1.Types))
         {
            _loc3_ = new ConsortiaTempleteInfo();
            _loc3_.type = param1.Types;
            _loc3_.isNext = param2;
            _loc3_.level = _model.consortiaInfo.getLevelByUpgradeType(_loc3_.type);
            _model.baseSkillList.add("type_" + _loc3_.type,_loc3_);
         }
         else
         {
            _loc3_ = _model.baseSkillList["type_" + param1.Types];
            _loc3_.isNext = param2;
            _loc3_.level = _model.consortiaInfo.getLevelByUpgradeType(param1.Types);
         }
      }
      
      public function consortiaStudy(param1:ConsortiaTemplete) : void
      {
         var _loc2_:int = isCommonSkill(param1.Types) ? 0 : 1;
         if(ifCanUpdata(param1))
         {
            ConsortiaSocketOutManager.consortiaStudy(param1.Types,_loc2_);
         }
      }
      
      private function ifCanUpdata(param1:ConsortiaTemplete) : Boolean
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = ConsortiaSkillHelper.getLevelByType(param1.Types,playerInfo);
         if(_loc4_ >= 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command09");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         var _loc3_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(param1.Types,_loc4_ + 1);
         if(isCommonSkill(param1.Types))
         {
            if(_loc3_.NeedOffer > playerInfo.consortiaOffer)
            {
               ConsortiaSkillHelper.addOffer();
               return false;
            }
         }
         else
         {
            _loc5_ = GoodsManager.instance.getBagCountByTempId(1,ConsortiaModel.UPSKILL_GOODS_TEMPID);
            if(_loc3_.Property2 > _loc5_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.ConsortiaControler.noGoodsInBag"));
               return false;
            }
         }
         return true;
      }
      
      private function isCommonSkill(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1 - 6)
         {
            case 0:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function changeDuty(param1:int, param2:int) : void
      {
         ConsortiaSocketOutManager.changeDuty(param1,param2);
      }
      
      public function fireMember(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            ConsortiaSocketOutManager.fireMember(param3);
         }
      }
      
      public function sendConsortiaInvitePlayer(param1:int) : void
      {
         ConsortiaSocketOutManager.consortiaInvitePlayer(param1);
         var _loc2_:String = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command10");
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function ifOpenApply(param1:Boolean) : void
      {
         ConsortiaSocketOutManager.ifOpenApply(param1);
      }
      
      public function getConsortiaSite() : void
      {
         ConsortiaSocketOutManager.getConsortiaSite();
      }
      
      private function __setGoods(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaInfoMsg = new ConsortiaInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaInfoMsg;
         NotificationManager.instance.dispatchEvent(new ConsortiaEvent("UPDE_ALTAR_SIZE",_loc2_.site));
      }
      
      public function sendEmail(param1:Array, param2:String, param3:String, param4:Boolean = true) : void
      {
         EmailSocketOutManager.sendEmail(param1,param2,param3,2,param4);
      }
      
      public function getVotingUserInfos() : void
      {
         ConsortiaSocketOutManager.getVotingUserInfos();
      }
      
      private function __setVotingUsers(param1:SLGSocketEvent) : void
      {
         var _loc3_:ConsortiaVotingUserInfo = null;
         var _loc6_:int = playerInfo.userId;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaVotingUsersMsg = new ConsortiaVotingUsersMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ConsortiaVotingUsersMsg;
         var _loc4_:Vector.<ConsortiaVotingUserInfo> = new Vector.<ConsortiaVotingUserInfo>();
         for each(var _loc5_:ConsortiaVotingUserMsg in _loc2_.info)
         {
            _loc3_ = new ConsortiaVotingUserInfo();
            _loc3_.isVotingman = _loc5_.isVotingman;
            _loc3_.nickName = _loc5_.nickName;
            _loc3_.userId = _loc5_.userId;
            _loc3_.votingData = _loc5_.votingData;
            _loc3_.votingId = _loc5_.votingId;
            _loc3_.votingTime = _loc5_.votingTime;
            _loc4_.push(_loc3_);
            if(_loc3_.userId == _loc6_)
            {
               _model.hasVoted = _loc3_.votingTime > 0;
            }
         }
         _model.votingUsers = _loc4_;
         _loc4_ = null;
      }
      
      private function __updateVotingState(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaVotingRspMsg = new ConsortiaVotingRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaVotingRspMsg;
         _model.hasVoted = _loc2_.result;
         if(_loc2_.result)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.successTxt");
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.failTxt");
         }
         MessageTipManager.instance().show(_loc3_);
         getVotingUserInfos();
      }
      
      public function openDevilFrame() : void
      {
         if(!_devilFrame)
         {
            _devilFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaDevilFrame");
            _devilFrame.addEventListener("dispose",__devilFrameDisposeHandler);
         }
         _devilFrame["show"]();
      }
      
      private function __devilFrameDisposeHandler(param1:Event) : void
      {
         _devilFrame.removeEventListener("dispose",__devilFrameDisposeHandler);
         _devilFrame = null;
      }
   }
}

