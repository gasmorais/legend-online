package managers
{
   import battle.utils.Int64Utils;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectPool;
   import com.road.yishi.proto.chat.ChatStateMsg;
   import com.road.yishi.proto.friend.GlobalImMsg;
   import com.road.yishi.proto.im.ChatFriendMsg;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import im.view.IMMsgBoxView;
   import manager.LanguageMgr;
   import mvc.module.friends.BaseIMInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.friends.IMEvent;
   import mvc.module.friends.IMFrameEvent;
   import mvc.module.friends.IMModel;
   import mvc.module.friends.IMStateInfo;
   import mvc.module.friends.ToolInviteInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.maintoolbar.view.MainToolButton;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NoOperationCallUtil;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class IMManager extends EventDispatcher
   {
      
      private static var _instance:IMManager;
      
      private var _model:IMModel;
      
      private var _tempMsgDic:SimpleDictionary;
      
      private var _noOperationSetLeave:NoOperationCallUtil;
      
      private var _msgBox:IMMsgBoxView;
      
      private var _friendBtnShining:Boolean;
      
      public function IMManager(param1:IEventDispatcher = null)
      {
         super(param1);
         if(!_model)
         {
            _model = new IMModel();
         }
         if(!_tempMsgDic)
         {
            _tempMsgDic = new SimpleDictionary();
         }
         if(!_noOperationSetLeave)
         {
            _noOperationSetLeave = new NoOperationCallUtil(300000,setLeaveIMState,setOnlineIMState);
         }
         addEvent();
         sendChangeIMState(7,"");
      }
      
      public static function get instance() : IMManager
      {
         if(!_instance)
         {
            _instance = new IMManager();
         }
         return _instance;
      }
      
      public function get model() : IMModel
      {
         return _model;
      }
      
      public function setup() : void
      {
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4236,__imSendMsgResponseHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4231,__receiveIMMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4232,__imStateChangeHandler);
         playerManager.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__requestFriendInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 348,__crossFriendChatHandler);
      }
      
      private function __imStateChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FriendItemCellInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChatStateMsg = new ChatStateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChatStateMsg;
         if(_loc2_.result == 1)
         {
            if(_loc2_.userId == thane.userId)
            {
               model.setStateReply(_loc2_.chatState,_loc2_.replayStr);
               model.curState = _loc2_.chatState;
            }
            else
            {
               _loc3_ = getFriendInfo(_loc2_.userId);
               if(_loc3_)
               {
                  _loc3_.beginChanges();
                  _loc3_.state = _loc2_.chatState;
                  _loc3_.commit();
               }
            }
         }
      }
      
      private function __imSendMsgResponseHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:ChatData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChatFriendMsg = new ChatFriendMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChatFriendMsg;
         if(_loc2_.result == -1)
         {
            _loc3_ = LanguageMgr.GetTranslation("friends.im.IMFrame.command02");
            MessageTipManager.instance().show(_loc3_);
            _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc4_.channel = 3;
            _loc4_.msg = _loc3_;
            _loc4_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc4_);
            return;
         }
         var _loc6_:BaseIMInfo = new BaseIMInfo();
         _loc6_.userId = _loc2_.fromId;
         _loc6_.nickName = _loc2_.fromNick;
         _loc6_.toId = _loc2_.toId;
         _loc6_.msg = _loc2_.encodeMsg;
         _loc6_.date = DateFormatter.parse(_loc2_.sendDate,"YYYY-MM-DD hh:mm:ss");
         _loc6_.sendResult = _loc2_.result;
         saveMsgCache(_loc6_);
         dispatchEvent(new IMEvent("MSG_SEND_RESPONSE",_loc6_));
         var _loc7_:FriendItemCellInfo = friendManager.checkIsExistFriendInfo(_loc6_.toId);
         if(!_loc7_)
         {
            playerManager.sendRequestSimpleAndSnsInfo(_loc6_.toId,0);
         }
         else
         {
            friendManager.addPrivatePerson(_loc7_);
         }
      }
      
      private function __receiveIMMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChatFriendMsg = new ChatFriendMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChatFriendMsg;
         var _loc4_:BaseIMInfo = new BaseIMInfo();
         _loc4_.userId = _loc2_.fromId;
         _loc4_.nickName = _loc2_.fromNick;
         _loc4_.msg = _loc2_.encodeMsg;
         _loc4_.date = DateFormatter.parse(_loc2_.sendDate,"YYYY-MM-DD hh:mm:ss");
         _loc4_.sendResult = _loc2_.result;
         var _loc6_:FriendItemCellInfo = friendManager.checkIsExistFriendInfo(_loc4_.userId);
         if(!_loc6_)
         {
            if(_tempMsgDic[_loc4_.userId])
            {
               _tempMsgDic[_loc4_.userId].push(_loc4_);
            }
            else
            {
               _loc5_ = new Vector.<BaseIMInfo>();
               _loc5_.push(_loc4_);
               _tempMsgDic.add(_loc4_.userId,_loc5_);
            }
            playerManager.sendRequestSimpleAndSnsInfo(_loc4_.userId,0);
            return;
         }
         friendManager.addPrivatePerson(_loc6_);
         handleIMInfo(_loc4_);
      }
      
      private function handleIMInfo(param1:BaseIMInfo, param2:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:String = param2 && param1.imThane ? param1.imThane.serviceName + "_" + param1.userId : param1.userId + "";
         var _loc3_:Frame = model.openIMFrameDic[_loc5_];
         if(!_loc3_ || !_loc3_.parent)
         {
            if(model.unreadMsgDic[_loc5_])
            {
               model.unreadMsgDic[_loc5_].push(param1);
            }
            else
            {
               _loc4_ = new Vector.<BaseIMInfo>();
               _loc4_.push(param1);
               model.unreadMsgDic.add(_loc5_,_loc4_);
            }
         }
         saveMsgCache(param1);
         model.isOpenFriendBtnShine = true;
         dispatchEvent(new IMEvent("RECEIVE_MSG",param1));
      }
      
      private function __crossFriendChatHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ThaneInfo = null;
         var _loc7_:BaseIMInfo = null;
         var _loc5_:ToolInviteInfo = null;
         var _loc3_:ChatData = null;
         var _loc8_:String = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:GlobalImMsg = new GlobalImMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as GlobalImMsg;
         if(_loc2_.fromChannel == 1)
         {
            _loc4_ = FriendManager.createCrossFriendCellInfo(_loc2_.from);
            _loc7_ = new BaseIMInfo();
            _loc7_.imThane = _loc4_;
            _loc7_.userId = _loc4_.userId;
            _loc7_.nickName = _loc4_.nickName;
            _loc7_.channel = _loc2_.fromChannel;
            _loc7_.toId = int(_loc2_.target);
            _loc7_.msg = _loc2_.msg;
            _loc7_.date = new Date(Int64Utils.int64ToNumber(_loc2_.sendDate));
            _loc7_.sendResult = 0;
            if(_loc4_.userId == playerInfo.userId && _loc4_.serviceName == playerInfo.serviceName)
            {
               saveMsgCache(_loc7_);
               dispatchEvent(new IMEvent("MSG_SEND_RESPONSE",_loc7_));
            }
            else
            {
               handleIMInfo(_loc7_,true);
            }
         }
         else if(_loc2_.fromChannel == 3)
         {
            _loc4_ = FriendManager.createCrossFriendCellInfo(_loc2_.from);
            if(ArmyManager.instance.thane.grades < 6 || PlayerManager.instance.currentPlayerModel.playerInfo.refuseFriend)
            {
               return;
            }
            _loc5_ = new ToolInviteInfo();
            _loc5_.uuid = _loc4_.uuid;
            _loc5_.serverName = _loc4_.serviceName;
            _loc5_.site = _loc4_.site;
            _loc5_.grades = _loc4_.grades;
            _loc5_.id = _loc4_.userId;
            _loc5_.nickName = _loc4_.nickName;
            _loc5_.sex = _loc4_.sexs;
            _loc5_.vocationGrades = _loc4_.vocationGrades;
            _loc5_.vocationIndex = _loc4_.vocationIndex;
            _loc5_.job = _loc4_.job;
            friendManager.addToolInviteFriend(_loc5_);
         }
         else if(_loc2_.fromChannel == 5 || _loc2_.fromChannel == 6 || _loc2_.fromChannel == 7)
         {
            _loc8_ = "";
            _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
            if(_loc3_)
            {
               _loc3_.channel = 109;
               _loc3_.msg = ChatManager.instance.analyzeExpression2(_loc2_.msg);
               if(_loc2_.hasFrom)
               {
                  _loc4_ = FriendManager.createCrossFriendCellInfo(_loc2_.from);
                  _loc3_.uuid = _loc4_.uuid;
                  _loc3_.uid = _loc4_.userId;
                  _loc3_.serverName = _loc4_.serviceName;
                  _loc3_.senderName = "[" + _loc4_.serviceName + "-" + _loc4_.nickName + "]";
               }
               _loc3_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc3_);
            }
         }
      }
      
      private function __requestFriendInfoHandler(param1:RequestInfoEvent) : void
      {
         var _loc4_:* = undefined;
         if(param1.orientation != 0)
         {
            return;
         }
         var _loc3_:FriendItemCellInfo = param1.data as FriendItemCellInfo;
         _loc3_.relation = 4;
         _loc3_.groupId = 1;
         var _loc5_:String = getIsCrossByThane(_loc3_) ? _loc3_.serviceName + "_" + _loc3_.userId : _loc3_.userId + "";
         if(friendManager.friendList[_loc3_.userId])
         {
            _loc3_.friendGp = (friendManager.friendList[_loc3_.userId] as FriendItemCellInfo).friendGp;
            _loc3_.friendGrade = (friendManager.friendList[_loc3_.userId] as FriendItemCellInfo).friendGrade;
         }
         friendManager.addPrivatePerson(_loc3_);
         if(_tempMsgDic[_loc5_])
         {
            _loc4_ = _tempMsgDic[_loc5_];
            for each(var _loc2_:BaseIMInfo in _loc4_)
            {
               handleIMInfo(_loc2_);
            }
            cleanMsgListByIdAndType(_loc5_,2);
         }
      }
      
      private function setLeaveIMState() : void
      {
         var _loc1_:IMStateInfo = model.stateList[4];
         if(_loc1_)
         {
            sendChangeIMState(_loc1_.id,_loc1_.replyContent);
         }
      }
      
      private function setOnlineIMState() : void
      {
         var _loc1_:IMStateInfo = model.stateList[7];
         if(_loc1_)
         {
            sendChangeIMState(_loc1_.id,"");
         }
      }
      
      public function dispatchFrameRemoveEvent() : void
      {
         dispatchEvent(new IMFrameEvent("IMFRAME_REMOVE"));
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get friendManager() : FriendManager
      {
         return FriendManager.getInstance();
      }
      
      private function get playerManager() : PlayerManager
      {
         return PlayerManager.instance;
      }
      
      public function createIMFrame(param1:ThaneInfo) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.friendControler.startFrameByType(4,param1);
         }
      }
      
      public function removeIMFrame(param1:String) : void
      {
         var _loc2_:Frame = null;
         if(model.openIMFrameDic[param1])
         {
            _loc2_ = model.openIMFrameDic[param1];
            model.openIMFrameDic.del(param1);
            if(_loc2_)
            {
               _loc2_["needDispose"] = true;
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
      }
      
      public function get showIMFrameNum() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:Frame in model.openIMFrameDic)
         {
            if(_loc2_.parent)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function createIMMsgBox() : IMMsgBoxView
      {
         removeIMMsgBox();
         if(model.msgBoxList.length > 0)
         {
            _msgBox = new IMMsgBoxView();
            return _msgBox;
         }
         return null;
      }
      
      public function removeIMMsgBox() : void
      {
         if(_msgBox)
         {
            if(_msgBox.parent)
            {
               _msgBox.parent.removeChild(_msgBox);
            }
            _msgBox.dispose();
            _msgBox = null;
         }
      }
      
      public function cleanMsgListByIdAndType(param1:String, param2:int) : void
      {
         var _loc3_:* = undefined;
         switch(param2 - 1)
         {
            case 0:
               if(model.unreadMsgDic[param1])
               {
                  _loc3_ = model.unreadMsgDic[param1];
                  while(_loc3_.length > 0)
                  {
                     _loc3_.pop();
                  }
                  _loc3_ = null;
                  model.unreadMsgDic.del(param1);
               }
               else
               {
                  model.unreadMsgDic.del(param1);
               }
               break;
            case 1:
               if(_tempMsgDic[param1])
               {
                  _loc3_ = _tempMsgDic[param1];
                  while(_loc3_.length > 0)
                  {
                     _loc3_.pop();
                  }
                  _loc3_ = null;
                  _tempMsgDic.del(param1);
                  break;
               }
               _tempMsgDic.del(param1);
         }
         friendBtnShining = true;
         dispatchEvent(new IMEvent("MSG_LIST_DEL"));
      }
      
      public function saveMsgCache(param1:BaseIMInfo) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:String = param1.userId == playerInfo.userId ? param1.toId + "" : param1.userId + "";
         var _loc2_:BaseIMInfo = new BaseIMInfo();
         _loc2_.userId = param1.userId;
         _loc2_.nickName = param1.nickName;
         _loc2_.toId = param1.toId;
         _loc2_.msg = param1.msg;
         _loc2_.date = param1.date;
         _loc2_.sendResult = param1.sendResult;
         _loc2_.imThane = null;
         if(model.imHistoryDic[_loc4_])
         {
            model.imHistoryDic[_loc4_].push(_loc2_);
         }
         else
         {
            _loc3_ = new Vector.<BaseIMInfo>();
            _loc3_.push(_loc2_);
            model.imHistoryDic[_loc4_] = _loc3_;
         }
         SharedManager.instance.saveIMHistory();
      }
      
      public function getFriendInfo(param1:int) : FriendItemCellInfo
      {
         var _loc2_:Object = friendManager.friendList[param1];
         if(!_loc2_)
         {
            _loc2_ = friendManager.getRecentInfoById(param1);
         }
         return _loc2_ as FriendItemCellInfo;
      }
      
      public function get friendBtnShining() : Boolean
      {
         return _friendBtnShining;
      }
      
      public function set friendBtnShining(param1:Boolean) : void
      {
         var _loc2_:MainToolButton = MainToolBar.instance.getFriendBtn();
         if(_loc2_)
         {
            if(param1 && model.isOpenFriendBtnShine && model.unreadMsgDic.keys.length > 0)
            {
               _loc2_.buttonBtn.isPlaying = true;
               _loc2_.buttonBtn.playEffect();
               _friendBtnShining = true;
               dispatchEvent(new IMEvent("MSGBOX_SHINING_UPDATE"));
            }
            else
            {
               _loc2_.buttonBtn.isPlaying = false;
               _loc2_.buttonBtn.stopEffect();
               _friendBtnShining = false;
               dispatchEvent(new IMEvent("MSGBOX_SHINING_UPDATE"));
            }
         }
      }
      
      public function getIMHistoryList(param1:int) : Vector.<BaseIMInfo>
      {
         return model.imHistoryDic[param1];
      }
      
      public function getIMHistoryTotalPages(param1:int) : int
      {
         var _loc2_:Vector.<BaseIMInfo> = getIMHistoryList(param1);
         if(_loc2_)
         {
            return Math.ceil(_loc2_.length / 8);
         }
         return 0;
      }
      
      public function getCurPageIMHistoryList(param1:int, param2:int) : Vector.<BaseIMInfo>
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<BaseIMInfo> = getIMHistoryList(param1);
         if(_loc4_)
         {
            _loc5_ = Math.ceil(_loc4_.length / 8);
            if(param2 > 0 && param2 <= _loc5_)
            {
               _loc3_ = int(param2 * 8 > _loc4_.length ? _loc4_.length : param2 * 8);
               return _loc4_.slice((param2 - 1) * 8,_loc3_);
            }
         }
         return null;
      }
      
      public function getIsCrossByThane(param1:ThaneInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.serviceName != null && param1.serviceName != "" && param1.serviceName != playerInfo.serviceName)
         {
            return true;
         }
         return false;
      }
      
      public function sendIMMsg(param1:int, param2:String, param3:Date = null) : void
      {
         var _loc5_:PackageOut = new PackageOut(15023);
         var _loc4_:ChatFriendMsg = new ChatFriendMsg();
         _loc4_.fromId = playerInfo.userId;
         _loc4_.fromNick = playerInfo.nickName;
         _loc4_.toId = param1;
         _loc4_.encodeMsg = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendChangeIMState(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(15029);
         var _loc3_:ChatStateMsg = new ChatStateMsg();
         _loc3_.chatState = param1;
         _loc3_.replayStr = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

