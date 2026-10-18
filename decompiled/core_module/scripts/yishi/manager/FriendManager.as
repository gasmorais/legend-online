package yishi.manager
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.chat.ChatStateListRspMsg;
   import com.road.yishi.proto.chat.ChatStateMsg;
   import com.road.yishi.proto.friend.FriendAddedMsg;
   import com.road.yishi.proto.friend.FriendPlayer;
   import com.road.yishi.proto.friend.FriendRelationGraphMsg;
   import com.road.yishi.proto.friend.FriendRelationMsg;
   import com.road.yishi.proto.friend.MoveFriendReqMsg;
   import com.road.yishi.proto.friend.RecommendListMsg;
   import com.road.yishi.proto.friend.SimpleGlobalPlayerMsg;
   import com.road.yishi.proto.simple.FriendGroupMsg;
   import com.road.yishi.proto.simple.FriendInfoMsg;
   import com.road.yishi.proto.simple.FriendSearchRspMsg;
   import com.road.yishi.proto.simple.SNSInfoMsg;
   import com.road.yishi.proto.team.JoinTeamResMsg;
   import com.road.yishi.proto.team.JoinTeamUserMsg;
   import events.FindResultEvent;
   import events.FriendGroupEvent;
   import events.FriendUpdateEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.MarryManager;
   import managers.VIPManager;
   import mvc.module.friends.ApplyPlayerInfo;
   import mvc.module.friends.FriendGroupInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.friends.FriendModel;
   import mvc.module.friends.RecommendInfo;
   import mvc.module.friends.ToolInviteInfo;
   import mvc.module.sns.BaseSnsInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.actions.friend.ApplyFriendAction;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.PopFrameCheck;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class FriendManager extends EventDispatcher
   {
      
      public static const MAX_GROUP_NUM:int = 4;
      
      private static var _instance:FriendManager;
      
      private var _friendList:SimpleDictionary;
      
      private var _recentPrivatePerson:Array;
      
      private var _groupDic:SimpleDictionary;
      
      private var _requirDic:SimpleDictionary;
      
      private var _bufferList:SimpleDictionary;
      
      private var _crossFriendList:SimpleDictionary;
      
      private var _crossStrangerList:SimpleDictionary;
      
      private var _crossBlackList:SimpleDictionary;
      
      private var _model:FriendModel;
      
      private var _applyJoinList:Array;
      
      private var _isUpgrade:Boolean;
      
      public var recommendList:Vector.<RecommendInfo> = new Vector.<RecommendInfo>();
      
      private var _toolInviteFriend:Array;
      
      private var emptyJson:String = "{}";
      
      private var version:int;
      
      private var total:int;
      
      public function FriendManager()
      {
         super();
         if(!_model)
         {
            _model = new FriendModel();
         }
         _toolInviteFriend = [];
         _bufferList = new SimpleDictionary(true);
         _requirDic = new SimpleDictionary(true);
         _recentPrivatePerson = [];
         _friendList = new SimpleDictionary();
         _groupDic = new SimpleDictionary();
         _applyJoinList = [];
         _crossFriendList = new SimpleDictionary();
         _crossBlackList = new SimpleDictionary();
         _crossStrangerList = new SimpleDictionary();
      }
      
      public static function getInstance() : FriendManager
      {
         if(!_instance)
         {
            _instance = new FriendManager();
         }
         return _instance;
      }
      
      public static function createCrossFriendCellInfo(param1:SimpleGlobalPlayerMsg) : FriendItemCellInfo
      {
         var _loc3_:Object = JSON.parse(param1.jsonstr);
         if(!_loc3_)
         {
            return null;
         }
         var _loc2_:FriendItemCellInfo = new FriendItemCellInfo();
         _loc2_ = new FriendItemCellInfo();
         _loc2_.uuid = param1.uuid;
         _loc2_.userId = _loc3_.userId;
         _loc2_.nickName = _loc3_.nickName;
         _loc2_.serviceName = _loc3_.serverName;
         _loc2_.site = _loc3_.site;
         _loc2_.pics = _loc3_.pics;
         _loc2_.sexs = _loc3_.sexs;
         _loc2_.job = _loc3_.job;
         _loc2_.state = _loc3_.state;
         _loc2_.consortiaID = _loc3_.consortiaId;
         _loc2_.consortiaName = _loc3_.consortiaName;
         _loc2_.fightingCapacity = _loc3_.fightingCapacity;
         _loc2_.grades = _loc3_.grades;
         _loc2_.vocationGrades = _loc3_.changeGrades;
         _loc2_.vocationIndex = _loc3_.changeBranch;
         return _loc2_;
      }
      
      public function get model() : FriendModel
      {
         return _model;
      }
      
      public function setup(param1:Object, param2:Object) : void
      {
         initRelationList(param1);
         initGroupList(param2);
         initEvent();
         sendRecommendFriendRequest();
         FriendSocketOutManager.requestCrossFriendMsg(4);
      }
      
      public function addFriends(param1:Object, param2:Object) : void
      {
         initRelationList(param1,false);
         initGroupList(param2);
      }
      
      private function initRelationList(param1:Object, param2:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param1 as Array;
         for each(var _loc5_:FriendItemCellInfo in _loc3_)
         {
            _friendList.add(_loc5_.userId,_loc5_);
         }
         if(param2)
         {
            _loc3_ = SharedManager.instance.recentList;
            if(!_loc3_)
            {
               return;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               reqPrivatePerson(int(_loc3_[_loc4_]));
               _loc4_++;
            }
         }
      }
      
      private function initGroupList(param1:Object) : void
      {
         var _loc2_:FriendGroupInfo = new FriendGroupInfo();
         var _loc4_:Array = param1 as Array;
         _loc2_.groupId = 2;
         _loc2_.groupName = LanguageMgr.GetTranslation("public.friend");
         _groupDic.add(_loc2_.groupId,_loc2_);
         for each(var _loc3_:FriendGroupInfo in _loc4_)
         {
            _groupDic.add(_loc3_.groupId,_loc3_);
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 78,__addFriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 79,__removeFriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 160,__friendLogin);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 161,__friendLoginOut);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 84,__addFriendConfirmHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 85,_recommendFriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 165,__updateFriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4227,__addGroupHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4228,__delGroupHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4229,__renameGroupHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4230,__moveFriendHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4246,__friendAddHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4272,__recentContactStateUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4273,__findFriendHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4697,__joinTeamListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 347,__crossFriendListHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpgradeHandler);
         MsgMan.addObserver("MarryEventType.SELF_MARRY_INFO",this,__maryInfoUpdateHandler);
         NotificationManager.instance.addEventListener("TEAMCAPTAINCHANGE",function(param1:NotificationEvent):void
         {
            _applyJoinList = [];
         });
      }
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __maryInfoUpdateHandler(param1:String, param2:Object) : void
      {
         var _loc3_:FriendItemCellInfo = null;
         if(MarryManager.instance.model.isDivorce)
         {
            _loc3_ = getFriendById(MarryManager.instance.model.selfMarryInfo.userId) as FriendItemCellInfo;
            if(_loc3_)
            {
               _loc3_.groupId = 2;
            }
         }
      }
      
      private function __findFriendHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:BaseSnsInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendSearchRspMsg = new FriendSearchRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as FriendSearchRspMsg;
         var _loc3_:int = Math.ceil(_loc2_.totalRows / 10);
         var _loc5_:Array = [];
         for each(var _loc4_:SNSInfoMsg in _loc2_.snsInfo)
         {
            _loc7_ = new BaseSnsInfo();
            _loc7_.userId = _loc4_.userId;
            _loc7_.nickName = _loc4_.nickname;
            _loc7_.sign = _loc4_.signDesc;
            _loc7_.sex = _loc4_.sex;
            _loc7_.birthdayType = _loc4_.birthdayType;
            _loc7_.birthYear = _loc4_.birthYear;
            _loc7_.birthMonth = _loc4_.birthMonth;
            _loc7_.birthDay = _loc4_.birthDay;
            _loc7_.horoscope = _loc4_.starId;
            _loc7_.bloodType = _loc4_.bloodType;
            _loc7_.country = _loc4_.country;
            _loc7_.province = _loc4_.province;
            _loc7_.city = _loc4_.city;
            _loc7_.headId = _loc4_.headId;
            _loc5_.push(_loc7_);
         }
         dispatchEvent(new FindResultEvent("GET_FIND_RESULTS",_loc5_,_loc3_));
      }
      
      private function __recentContactStateUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ThaneInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChatStateListRspMsg = new ChatStateListRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChatStateListRspMsg;
         if(_loc2_.chatState.length > 0)
         {
            for each(var _loc4_:ChatStateMsg in _loc2_.chatState)
            {
               _loc5_ = getRecentInfoById(_loc4_.userId);
               if(_loc5_)
               {
                  _loc5_.state = _loc4_.chatState;
               }
            }
            dispatchEvent(new FriendUpdateEvent("RECENT_CONTACT_UPDATE",null));
         }
      }
      
      private function __friendAddHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendAddedMsg = new FriendAddedMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FriendAddedMsg;
         if(ArmyManager.instance.thane.grades < 6 || PlayerManager.instance.currentPlayerModel.playerInfo.refuseFriend)
         {
            return;
         }
         var _loc3_:ToolInviteInfo = new ToolInviteInfo();
         _loc3_.grades = _loc2_.grades;
         _loc3_.id = _loc2_.userId;
         _loc3_.nickName = _loc2_.nickName;
         _loc3_.sex = _loc2_.sex;
         _loc3_.vocationGrades = _loc2_.transGrade;
         _loc3_.vocationIndex = _loc2_.changeBranch;
         _loc3_.job = _loc2_.job;
         addToolInviteFriend(_loc3_);
      }
      
      private function __confirmAddFriend(param1:Boolean, param2:String, param3:int) : void
      {
         if(param1)
         {
            FriendSocketOutManager.sendAddFriendRequest(param2,1);
         }
      }
      
      public function getFriendById(param1:int) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __addFriendConfirmHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FriendRelationMsg;
         var _loc4_:String = _loc2_.nickName;
         var _loc3_:String = _loc2_.noticeMsg;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _bufferList.add(_loc4_,_loc3_);
            MainToolBar.instance.blinkFriendBtnNoTime();
         }
         else if(!_requirDic[_loc4_])
         {
            createApplyFriendFrame(_loc4_,_loc3_);
         }
      }
      
      public function noteApplyPopFrame(param1:String) : void
      {
         _requirDic[param1] = true;
      }
      
      public function removeNoteApplyPopFrame(param1:String) : void
      {
         _requirDic.del(param1);
      }
      
      public function createApplyFriendFrame(param1:String, param2:String) : void
      {
         if(thane.grades <= 6)
         {
            return;
         }
         PopFrameCheck.instance.addAction(new ApplyFriendAction(param1,param2));
      }
      
      public function popBufferFrame() : void
      {
         var _loc1_:Array = _bufferList.splice(0,1);
         if(_loc1_.length > 0)
         {
            createApplyFriendFrame(_loc1_[0].key,_loc1_[0].value);
         }
      }
      
      private function __addGroupHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendGroupMsg = new FriendGroupMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FriendGroupMsg;
         var _loc3_:FriendGroupInfo = new FriendGroupInfo();
         _loc3_.groupId = _loc2_.groupId;
         _loc3_.groupName = _loc2_.groupName;
         _groupDic.add(_loc3_.groupId,_loc3_);
         dispatchEvent(new FriendGroupEvent("ADD_GROUP",_loc3_));
      }
      
      private function __delGroupHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendGroupMsg = new FriendGroupMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FriendGroupMsg;
         var _loc3_:FriendGroupInfo = _groupDic[_loc2_.groupId];
         if(_loc3_)
         {
            changeListGroup(_loc3_.groupId,2);
            _groupDic.del(_loc3_.groupId);
            dispatchEvent(new FriendGroupEvent("DEL_GROUP",_loc3_));
         }
      }
      
      private function __renameGroupHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendGroupMsg = new FriendGroupMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FriendGroupMsg;
         var _loc4_:FriendGroupInfo = _groupDic[_loc2_.groupId];
         if(_loc4_)
         {
            _loc4_.groupName = _loc2_.groupName;
            dispatchEvent(new FriendGroupEvent("RENAME_GROUP",_loc4_));
         }
      }
      
      private function __moveFriendHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FriendItemCellInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MoveFriendReqMsg = new MoveFriendReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MoveFriendReqMsg;
         if(_loc2_.result == 1 && _friendList[_loc2_.firendId])
         {
            _loc3_ = _friendList[_loc2_.firendId];
            _loc3_.groupId = _loc2_.groupId;
            dispatchEvent(new FriendGroupEvent("MOVE_FRIEND",_loc3_));
         }
      }
      
      private function __updateFriend(param1:SLGSocketEvent) : void
      {
         var _loc6_:FriendItemCellInfo = null;
         var _loc3_:ChatData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendInfoMsg = new FriendInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FriendInfoMsg;
         var _loc4_:int = _loc2_.userId;
         if(_friendList[_loc4_])
         {
            _loc6_ = _friendList[_loc4_];
            _loc6_.beginChanges();
            _loc6_.friendGrade = _loc2_.relationGrade;
            _loc6_.friendGp = _loc2_.relationGp;
            _loc6_.relation = _loc2_.relation;
            _loc6_.groupId = _loc2_.groupId;
            if(_loc2_.expAdded > 0)
            {
               _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc3_.channel = 3;
               _loc3_.msg = LanguageMgr.GetTranslation("yishi.manager.FriendManager.chatData.msg",_loc6_.nickName,_loc2_.expAdded);
               _loc3_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc3_);
            }
            _loc6_.commit();
         }
      }
      
      private function __addFriend(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendInfoMsg = new FriendInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FriendInfoMsg;
         var _loc3_:Boolean = _loc2_.result;
         var _loc4_:String = _loc2_.addMsg;
         if(_loc3_)
         {
            SoundManager.instance.play("009",true);
            readFriendInfo(_loc2_);
            dispatchEvent(new FriendUpdateEvent("FRIEND_UPDATE",null));
            dispatchEvent(new FriendUpdateEvent("ADD_FRIEND",_loc2_.userId));
         }
         else
         {
            MessageTipManager.instance().show(_loc4_);
         }
         removeFromRecmmondList(_loc2_.userId);
      }
      
      private function __removeFriend(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FriendRelationMsg;
         if(_loc2_.result)
         {
            _loc3_ = _loc2_.otherId;
            _friendList.del(_loc3_);
            removePrivatePerson(_loc3_);
            IMManager.instance.cleanMsgListByIdAndType(_loc3_ + "",1);
            dispatchEvent(new FriendUpdateEvent("FRIEND_UPDATE",null));
            dispatchEvent(new FriendUpdateEvent("REMOVE_FRIEND",_loc3_));
         }
      }
      
      private function __friendLogin(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc5_:ChatData = null;
         var _loc4_:String = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as FriendRelationMsg;
         var _loc3_:ThaneInfo = _friendList[_loc2_.otherId] as ThaneInfo;
         if(_loc3_)
         {
            _loc7_ = _loc3_.relation;
            if(_loc7_ == 1 || _loc7_ == 3 || _loc7_ == 2)
            {
               _loc3_.beginChanges();
               _loc3_.state = 7;
               _loc3_.commit();
               dispatchEvent(new FriendUpdateEvent("friendchange",null));
            }
            if(_loc7_ == 1 || _loc7_ == 3)
            {
               _loc5_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc4_ = "<a t=\'1\' id=\'" + _loc3_.userId + "\' name=\'" + _loc3_.nickName + "\' consortiaId=\'" + _loc3_.consortiaID + "\'/>" + LanguageMgr.GetTranslation("yishi.manager.FriendManager.noticeMsg");
               _loc5_.msg = _loc4_;
               _loc5_.channel = 3;
               _loc5_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
            }
         }
      }
      
      private function __friendLoginOut(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FriendRelationMsg;
         var _loc3_:ThaneInfo = _friendList[_loc2_.otherId] as ThaneInfo;
         if(_loc3_)
         {
            _loc3_.beginChanges();
            _loc3_.state = 0;
            _loc3_.commit();
            dispatchEvent(new FriendUpdateEvent("friendchange",null));
         }
      }
      
      private function readFriendInfo(param1:FriendInfoMsg) : void
      {
         var _loc2_:FriendItemCellInfo = new FriendItemCellInfo();
         _loc2_.userId = param1.userId;
         _loc2_.templateId = param1.job;
         _loc2_.relation = param1.relation;
         _loc2_.groupId = param1.groupId;
         _loc2_.type = 0;
         _loc2_.sexs = param1.sex;
         _loc2_.pics = param1.pic;
         _loc2_.grades = param1.grades;
         _loc2_.nickName = param1.nickName;
         _loc2_.friendGrade = param1.relationGrade;
         _loc2_.friendGp = param1.relationGp;
         _loc2_.consortiaID = param1.consortiaId;
         _loc2_.consortiaName = param1.consortiaName;
         _loc2_.fightingCapacity = param1.fightCapacity;
         _loc2_.IsVipAndNoExpirt = param1.isVip;
         _loc2_.vipType = param1.vipType;
         _loc2_.state = param1.chatState;
         _loc2_.vocationGrades = param1.transGrade;
         _loc2_.vocationIndex = param1.changeBranch;
         if(param1.snsInfo)
         {
            if(param1.snsInfo.hasUserId)
            {
               _loc2_.snsInfo.userId = param1.snsInfo.userId;
            }
            if(param1.snsInfo.hasNickname)
            {
               _loc2_.snsInfo.nickName = param1.snsInfo.nickname;
            }
            if(param1.snsInfo.hasHeadId)
            {
               _loc2_.snsInfo.headId = param1.snsInfo.headId;
            }
            if(param1.snsInfo.hasSignDesc)
            {
               _loc2_.snsInfo.sign = param1.snsInfo.signDesc;
            }
            if(param1.snsInfo.hasSex)
            {
               _loc2_.snsInfo.sex = param1.snsInfo.sex;
            }
            if(param1.snsInfo.hasBirthdayType)
            {
               _loc2_.snsInfo.birthdayType = param1.snsInfo.birthdayType;
            }
            if(param1.snsInfo.hasBirthYear)
            {
               _loc2_.snsInfo.birthYear = param1.snsInfo.birthYear;
            }
            if(param1.snsInfo.hasBirthMonth)
            {
               _loc2_.snsInfo.birthMonth = param1.snsInfo.birthMonth;
            }
            if(param1.snsInfo.hasBirthDay)
            {
               _loc2_.snsInfo.birthDay = param1.snsInfo.birthDay;
            }
            if(param1.snsInfo.hasStarId)
            {
               _loc2_.snsInfo.horoscope = param1.snsInfo.starId;
            }
            if(param1.snsInfo.hasBloodType)
            {
               _loc2_.snsInfo.bloodType = param1.snsInfo.bloodType;
            }
            if(param1.snsInfo.hasCountry)
            {
               _loc2_.snsInfo.country = param1.snsInfo.country;
            }
            if(param1.snsInfo.hasProvince)
            {
               _loc2_.snsInfo.province = param1.snsInfo.province;
            }
            if(param1.snsInfo.hasCity)
            {
               _loc2_.snsInfo.city = param1.snsInfo.city;
            }
         }
         _friendList.add(_loc2_.userId,_loc2_);
         if(_loc2_.relation == 2)
         {
            removePrivatePerson(_loc2_.userId);
            IMManager.instance.cleanMsgListByIdAndType(_loc2_.userId + "",1);
         }
         updatePrivatePerson(_loc2_);
      }
      
      public function sendAddFriendRequest(param1:String, param2:int) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command01");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(!checkFriendList(param1,param2))
         {
            return false;
         }
         if(param2 == 2)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.addToBlacklistTip");
            SimpleAlertHelper.instance.data = [addRelationCall,param1,param2];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc4_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,false);
            return false;
         }
         FriendSocketOutManager.sendAddFriendRequest(param1,param2);
         return true;
      }
      
      private function addRelationCall(param1:Boolean, param2:Boolean, param3:String, param4:int) : void
      {
         if(param1)
         {
            FriendSocketOutManager.sendAddFriendRequest(param3,param4);
         }
      }
      
      private function removeFromRecmmondList(param1:int) : void
      {
         for each(var _loc2_:RecommendInfo in recommendList)
         {
            if(_loc2_.id == param1)
            {
               recommendList.splice(recommendList.indexOf(_loc2_),1);
            }
         }
      }
      
      private function checkFriendList(param1:String, param2:int) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = "";
         if(countFriend >= FriendManager.getInstance().maxFriendCount && param2 != 2)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command02");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(param1 == PlayerManager.instance.currentPlayerModel.playerInfo.nickName)
         {
            if(param2 != 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command03");
               MessageTipManager.instance().show(_loc3_);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command04");
               MessageTipManager.instance().show(_loc3_);
            }
            return false;
         }
         if(isExist(param1,param2))
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command05");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(FullBlackList(param2) >= 50)
         {
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.content");
            SimpleAlertHelper.instance.data = [];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc4_,"");
            return false;
         }
         return true;
      }
      
      public function FullBlackList(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 != 2)
         {
            return 0;
         }
         for each(var _loc3_:ThaneInfo in _friendList)
         {
            if(_loc3_.relation == 2)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get countFriend() : int
      {
         var _loc1_:int = 0;
         if(_friendList)
         {
            _loc1_ = _friendList.getList().length - FullBlackList(2);
         }
         return _loc1_;
      }
      
      public function get maxFriendCount() : int
      {
         return 200 + VIPManager.Instance.model.vipFriendPrivilege;
      }
      
      public function checkIsExistRelation(param1:int, param2:int) : Boolean
      {
         for each(var _loc3_:FriendItemCellInfo in friendList)
         {
            if(_loc3_.userId == param1 && _loc3_.relation == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkIsExistFriendInfo(param1:int) : FriendItemCellInfo
      {
         var _loc2_:FriendItemCellInfo = _friendList[param1];
         if(!_loc2_)
         {
            _loc2_ = getRecentInfoById(param1) as FriendItemCellInfo;
         }
         return _loc2_;
      }
      
      public function isExist(param1:String, param2:int) : Boolean
      {
         var _loc3_:Dictionary = friendList;
         for each(var _loc4_:ThaneInfo in _loc3_)
         {
            if(_loc4_.nickName == param1 && _loc4_.relation == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _recommendFriend(param1:SLGSocketEvent) : void
      {
         var _loc3_:FriendPlayer = null;
         var _loc6_:RecommendInfo = null;
         var _loc4_:int = 0;
         recommendList.length = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RecommendListMsg = new RecommendListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RecommendListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.girlList.length)
         {
            _loc3_ = _loc2_.girlList[_loc4_] as FriendPlayer;
            _loc6_ = new RecommendInfo();
            _loc6_.id = _loc3_.playerId;
            _loc6_.name = _loc3_.nickName;
            _loc6_.level = _loc3_.level;
            _loc6_.sex = _loc3_.sex;
            _loc6_.attack = _loc3_.attack;
            _loc6_.mapname = _loc3_.mapName;
            _loc6_.vocationGrades = _loc3_.transGrade;
            _loc6_.vocationIndex = _loc3_.changeBranch;
            _loc6_.job = _loc3_.job;
            recommendList.push(_loc6_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.boyList.length)
         {
            _loc3_ = _loc2_.boyList[_loc4_] as FriendPlayer;
            _loc6_ = new RecommendInfo();
            _loc6_.id = _loc3_.playerId;
            _loc6_.name = _loc3_.nickName;
            _loc6_.level = _loc3_.level;
            _loc6_.sex = _loc3_.sex;
            _loc6_.attack = _loc3_.attack;
            _loc6_.mapname = _loc3_.mapName;
            _loc6_.vocationGrades = _loc3_.transGrade;
            _loc6_.vocationIndex = _loc3_.changeBranch;
            _loc6_.job = _loc3_.job;
            recommendList.push(_loc6_);
            _loc4_++;
         }
         dispatchEvent(new FriendUpdateEvent("UPDATE_RECOMONDLIST",null));
         if(_isUpgrade)
         {
            _isUpgrade = false;
            MainToolBar.instance.recommendBtnIsExist();
         }
      }
      
      public function __joinTeamListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ApplyPlayerInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:JoinTeamResMsg = new JoinTeamResMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as JoinTeamResMsg;
         _applyJoinList = [];
         if(_loc2_.joinList)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.joinList.length)
            {
               _loc4_ = new ApplyPlayerInfo();
               _loc4_.userId = (_loc2_.joinList[_loc3_] as JoinTeamUserMsg).applyUserId;
               _loc4_.nickName = (_loc2_.joinList[_loc3_] as JoinTeamUserMsg).applyNickName;
               _loc4_.lv = (_loc2_.joinList[_loc3_] as JoinTeamUserMsg).applyGrade;
               _applyJoinList.push(_loc4_);
               _loc3_++;
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_JOINTEAMLIST"));
      }
      
      public function sendRemoveFriendRequest(param1:int) : void
      {
         FriendSocketOutManager.sendRemoveFriendRequest(param1);
      }
      
      public function sendRecommendFriendRequest() : void
      {
         FriendSocketOutManager.sendRecommendFriend();
      }
      
      public function getRecentInfoById(param1:int) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _recentPrivatePerson)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getRecentInfoIdList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:ThaneInfo = null;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _recentPrivatePerson.length)
         {
            _loc3_ = _recentPrivatePerson[_loc2_] as ThaneInfo;
            _loc1_.unshift(_loc3_.userId);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function reqPrivatePerson(param1:int) : void
      {
         if(!getRecentInfoById(param1))
         {
            PlayerManager.instance.sendRequestSimpleAndSnsInfo(param1,0);
            return;
         }
      }
      
      public function addPrivatePerson(param1:ThaneInfo) : void
      {
         var _loc2_:ThaneInfo = getRecentInfoById(param1.userId);
         if(_loc2_)
         {
            _recentPrivatePerson.splice(_recentPrivatePerson.indexOf(_loc2_),1);
         }
         _recentPrivatePerson.unshift(param1);
         if(_recentPrivatePerson.length > 15)
         {
            _recentPrivatePerson.splice(_recentPrivatePerson.length - 1,1);
         }
         SharedManager.instance.updateRecent(getRecentInfoIdList());
         dispatchEvent(new FriendUpdateEvent("ADD_RECENT_CONTACT",null));
      }
      
      public function removePrivatePerson(param1:int) : void
      {
         var _loc2_:ThaneInfo = getRecentInfoById(param1);
         if(_loc2_)
         {
            _recentPrivatePerson.splice(_recentPrivatePerson.indexOf(_loc2_),1);
            SharedManager.instance.updateRecent(getRecentInfoIdList());
            dispatchEvent(new FriendUpdateEvent("ADD_RECENT_CONTACT",null));
         }
      }
      
      public function updatePrivatePerson(param1:FriendItemCellInfo) : void
      {
         var _loc2_:ThaneInfo = getRecentInfoById(param1.userId);
         if(param1 && _loc2_)
         {
            _recentPrivatePerson[_recentPrivatePerson.indexOf(_loc2_)] = param1;
            addPrivatePerson(_loc2_);
         }
      }
      
      public function get privatePerson() : Array
      {
         return _recentPrivatePerson;
      }
      
      public function get friendList() : SimpleDictionary
      {
         return _friendList;
      }
      
      public function get groupDic() : SimpleDictionary
      {
         return _groupDic;
      }
      
      public function getListByGroupIdAndState(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         if(param2 == -1)
         {
            for each(var _loc5_:FriendItemCellInfo in _friendList)
            {
               if(_loc5_.groupId == param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         else
         {
            for each(var _loc4_:FriendItemCellInfo in _friendList)
            {
               if(_loc4_.groupId == param1 && _loc4_.state == param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getOnlineList(param1:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:FriendItemCellInfo in param1)
         {
            if(_loc3_.isOnline)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getOfflineList(param1:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:FriendItemCellInfo in param1)
         {
            if(!_loc3_.isOnline)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function changeListGroup(param1:int, param2:int) : void
      {
         for each(var _loc3_:FriendItemCellInfo in _friendList)
         {
            if(_loc3_.groupId == param1)
            {
               _loc3_.groupId = param2;
            }
         }
      }
      
      public function get friendListByArray() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("nickName");
         return _loc1_;
      }
      
      public function get friendListByArrayUserId() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 1)
            {
               _loc1_.push(_loc2_.userId);
            }
         }
         return _loc1_;
      }
      
      public function get onlineFriends() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 1 && _loc2_.isOnline)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("friendGrade");
         return _loc1_;
      }
      
      public function get offlineFriends() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 1 && !_loc2_.isOnline)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("friendGrade");
         return _loc1_;
      }
      
      public function get onlineBlacks() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 2 && _loc2_.isOnline)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("friendGrade");
         return _loc1_;
      }
      
      public function get offlineBlacks() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.relation == 2 && !_loc2_.isOnline)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("friendGrade");
         return _loc1_;
      }
      
      public function bufferLength() : int
      {
         return _bufferList.getList().length;
      }
      
      protected function __levelUpgradeHandler(param1:Event) : void
      {
         _isUpgrade = true;
         sendRecommendFriendRequest();
      }
      
      public function addToolInviteFriend(param1:ToolInviteInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _toolInviteFriend.length)
         {
            if(param1.id == _toolInviteFriend[_loc2_].id)
            {
               return;
            }
            _loc2_++;
         }
         _toolInviteFriend.push(param1);
         NotificationManager.instance.dispatchEvent(new FriendUpdateEvent("INVITE_UPDATE",null));
      }
      
      public function removeToolInviteFriend(param1:ToolInviteInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _toolInviteFriend.length)
         {
            if(param1.id == _toolInviteFriend[_loc2_].id)
            {
               _toolInviteFriend.splice(_loc2_,1);
               NotificationManager.instance.dispatchEvent(new FriendUpdateEvent("INVITE_UPDATE",null));
               return;
            }
            _loc2_++;
         }
      }
      
      public function get toolInviteFriendList() : Array
      {
         return _toolInviteFriend;
      }
      
      public function get applyJoinList() : Array
      {
         return _applyJoinList;
      }
      
      private function __crossFriendListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:FriendItemCellInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationGraphMsg = new FriendRelationGraphMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FriendRelationGraphMsg;
         if(_loc2_.stamp > version)
         {
            version = _loc2_.stamp;
            _crossFriendList = new SimpleDictionary(true);
            _crossStrangerList = new SimpleDictionary(true);
            _crossBlackList = new SimpleDictionary(true);
            total = 0;
         }
         total = total + 1;
         for each(var _loc6_:SimpleGlobalPlayerMsg in _loc2_.friend)
         {
            if(_loc6_.jsonstr != emptyJson)
            {
               _loc4_ = createCrossFriendCellInfo(_loc6_);
               _loc4_.groupId = 1001;
               _crossFriendList.add(_loc6_.uuid,_loc4_);
            }
         }
         for each(var _loc3_:SimpleGlobalPlayerMsg in _loc2_.stranger)
         {
            if(_loc3_.jsonstr != emptyJson)
            {
               _loc4_ = createCrossFriendCellInfo(_loc3_);
               _loc4_.groupId = 1002;
               _crossStrangerList.add(_loc3_.uuid,_loc4_);
            }
         }
         for each(var _loc7_:SimpleGlobalPlayerMsg in _loc2_.blacklist)
         {
            if(_loc7_.jsonstr != emptyJson)
            {
               _loc4_ = createCrossFriendCellInfo(_loc7_);
               _loc4_.groupId = 1003;
               _crossBlackList.add(_loc7_.uuid,_loc4_);
            }
         }
         if(total > _loc2_.totalPage)
         {
            MsgMan.notifyObserver("CROSS_FRIENDS_UPDATE");
         }
      }
      
      public function sendCrossFriendRequest(param1:int, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.command01");
            MessageTipManager.instance().show(_loc3_);
         }
         if(param1 == 2)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.manager.FriendManager.addToBlacklistTip");
            SimpleAlertHelper.instance.data = [addCrossRelationCall,param2,param1];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc4_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,false);
            return;
         }
         FriendSocketOutManager.requestCrossFriendMsg(param1,param2);
      }
      
      private function addCrossRelationCall(param1:Boolean, param2:Boolean, param3:String, param4:int) : void
      {
         if(param1)
         {
            FriendSocketOutManager.requestCrossFriendMsg(param4,param3);
         }
      }
      
      public function get crossFriendList() : SimpleDictionary
      {
         return _crossFriendList;
      }
      
      public function get crossBlackList() : SimpleDictionary
      {
         return _crossBlackList;
      }
      
      public function get crossStrangerList() : SimpleDictionary
      {
         return _crossStrangerList;
      }
      
      public function getCrossFriendsRelationByType(param1:int, param2:Boolean) : Array
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         var _loc3_:Array = [];
         if(param1 == 1)
         {
            _loc4_ = crossFriendList;
         }
         else if(param1 == 2)
         {
            _loc4_ = crossStrangerList;
         }
         else if(param1 == 3)
         {
            _loc4_ = crossBlackList;
         }
         for each(var _loc5_:ThaneInfo in _loc4_)
         {
            if(_loc5_ && _loc5_.isOnline == param2)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getCrossThaneInfoByUuid(param1:String) : ThaneInfo
      {
         if(param1 == null || param1 == "")
         {
            return null;
         }
         if(crossFriendList[param1])
         {
            return crossFriendList[param1];
         }
         if(crossStrangerList[param1])
         {
            return crossStrangerList[param1];
         }
         if(crossBlackList[param1])
         {
            return crossBlackList[param1];
         }
         return null;
      }
   }
}

