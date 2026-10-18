package mvc.module.friends
{
   import com.pickgliss.ui.controls.Frame;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.utils.SimpleDictionary;
   
   public class IMModel
   {
      
      public static const BUBBLETYPE_SELF:int = 1;
      
      public static const BUBBLETYPE_TARGET:int = 2;
      
      public static const MAX_OPENFRAME_NUM:int = 3;
      
      public static const MAX_MSGBOX_ITEMNUM:int = 30;
      
      public static const MSGS_PER_PAGE:int = 8;
      
      public static const MSG_DIC_UNREAD:int = 1;
      
      public static const MSG_DIC_TEMP:int = 2;
      
      public var removeMsgBoxTimeOut:uint;
      
      public var isOpenFriendBtnShine:Boolean = true;
      
      private var _stateList:SimpleDictionary;
      
      private var _curState:int = 1;
      
      private var _unreadMsgDic:SimpleDictionary;
      
      private var _openIMFrameDic:SimpleDictionary;
      
      private var _miniFrameDic:SimpleDictionary;
      
      public function IMModel()
      {
         super();
         _unreadMsgDic = new SimpleDictionary();
         _openIMFrameDic = new SimpleDictionary();
         _miniFrameDic = new SimpleDictionary();
         initStateList();
      }
      
      private function initStateList() : void
      {
         _stateList = new SimpleDictionary();
         var _loc5_:Dictionary = SharedManager.instance.autoReplyList;
         var _loc4_:IMStateInfo = new IMStateInfo();
         var _loc1_:IMStateInfo = new IMStateInfo();
         var _loc2_:IMStateInfo = new IMStateInfo();
         var _loc3_:IMStateInfo = new IMStateInfo();
         _loc4_.id = 7;
         _loc4_.name = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.online");
         _loc1_.id = 4;
         _loc1_.name = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         _loc1_.replyContent = _loc5_ && _loc5_[_loc1_.id] ? _loc5_[_loc1_.id] : LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leaveReply");
         _loc2_.id = 6;
         _loc2_.name = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.busy");
         _loc2_.replyContent = _loc5_ && _loc5_[_loc2_.id] ? _loc5_[_loc2_.id] : LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leaveReply");
         _loc3_.id = 5;
         _loc3_.name = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.noDisturb");
         _loc3_.replyContent = _loc5_ && _loc5_[_loc3_.id] ? _loc5_[_loc3_.id] : LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leaveReply");
         _stateList.add(_loc4_.id,_loc4_);
         _stateList.add(_loc1_.id,_loc1_);
         _stateList.add(_loc2_.id,_loc2_);
         _stateList.add(_loc3_.id,_loc3_);
      }
      
      public function get stateList() : SimpleDictionary
      {
         return _stateList;
      }
      
      public function get curState() : int
      {
         return _curState;
      }
      
      public function set curState(param1:int) : void
      {
         if(_curState == param1)
         {
            return;
         }
         _curState = param1;
         NotificationManager.instance.sendNotification("IMSTATE_CHANGE",_stateList[_curState]);
      }
      
      public function setStateReply(param1:int, param2:String) : void
      {
         if(_stateList[param1])
         {
            _stateList[param1].replyContent = param2;
            SharedManager.instance.autoReplyList[param1] = param2;
            SharedManager.instance.saveAutoReplyList();
         }
      }
      
      public function get unreadMsgDic() : SimpleDictionary
      {
         return _unreadMsgDic;
      }
      
      public function get openIMFrameDic() : SimpleDictionary
      {
         return _openIMFrameDic;
      }
      
      public function get miniFrameDic() : SimpleDictionary
      {
         var _loc1_:ThaneInfo = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         _miniFrameDic.clear();
         for each(var _loc4_:Frame in _openIMFrameDic)
         {
            if(!_loc4_.parent)
            {
               _loc1_ = _loc4_["data"] as ThaneInfo;
               if(_loc1_)
               {
                  _loc2_ = _loc1_.serviceName != "" && _loc1_.serviceName != null && _loc1_.serviceName != playerInfo.serviceName;
                  _loc3_ = _loc2_ ? _loc1_.serviceName + "_" + _loc1_.userId : _loc1_.userId + "";
                  _miniFrameDic.add(_loc3_,_loc4_);
               }
            }
         }
         return _miniFrameDic;
      }
      
      public function get msgBoxList() : Array
      {
         var _loc1_:BaseIMInfo = null;
         var _loc7_:String = null;
         var _loc3_:ThaneInfo = null;
         var _loc6_:Array = [];
         var _loc4_:Array = miniFrameDic.getList();
         var _loc2_:Array = unreadMsgDic.getList();
         for each(var _loc8_:Frame in _loc4_)
         {
            if(_loc8_["data"])
            {
               _loc6_.push(_loc8_["data"]);
            }
         }
         for each(var _loc5_:Vector.<BaseIMInfo> in _loc2_)
         {
            if(_loc5_.length > 0)
            {
               _loc1_ = _loc5_[0];
               _loc7_ = _loc1_.imThane ? _loc1_.imThane.serviceName + "_" + _loc1_.imThane.userId : _loc1_.userId + "";
               if(!miniFrameDic[_loc7_])
               {
                  if(_loc1_.imThane)
                  {
                     _loc6_.push(_loc1_.imThane);
                  }
                  else
                  {
                     _loc3_ = new ThaneInfo();
                     _loc3_.userId = _loc1_.userId;
                     _loc3_.nickName = _loc1_.nickName;
                     _loc6_.push(_loc3_);
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function get imHistoryDic() : Dictionary
      {
         return SharedManager.instance.imHistoryDic;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

