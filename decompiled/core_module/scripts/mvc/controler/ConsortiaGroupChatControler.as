package mvc.controler
{
   import chat.datas.ChatData;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectPool;
   import com.road.yishi.proto.simple.RelationPlayerMsg;
   import com.road.yishi.proto.vip.VipToConsortiaMsg;
   import events.GroupChatEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import map.internals.utils.SocketGameReader;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.groupchat.ConsortiaGroupChatModel;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaGroupChatControler extends FrameController
   {
      
      private var _model:ConsortiaGroupChatModel;
      
      private var _consortiaBtnShining:Boolean;
      
      public function ConsortiaGroupChatControler()
      {
         super();
         _model = new ConsortiaGroupChatModel();
         addEvent();
      }
      
      override public function get frameClassName() : String
      {
         return "consortiagroupchat.ConsortiaGroupChatFrame";
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:ChatData = null;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command05");
            if(SceneManager.instance.currentType == "BATTLE_SCENE")
            {
               _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc3_.channel = 3;
               _loc3_.msg = _loc2_;
               _loc3_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc3_);
            }
            else
            {
               MessageTipManager.instance().show(_loc2_);
            }
            return;
         }
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function isVisible() : Boolean
      {
         return _frame && _frame.parent ? true : false;
      }
      
      public function hideFrame() : void
      {
         _frame.dispose();
      }
      
      public function set frame(param1:Frame) : void
      {
         _frame = param1;
      }
      
      public function get frame() : Frame
      {
         if(_frame)
         {
            return _frame;
         }
         return null;
      }
      
      public function get model() : ConsortiaGroupChatModel
      {
         return _model;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4256,__getSimpleAndSnsInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4455,__vipInfoChangeHandler);
      }
      
      private function __vipInfoChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipToConsortiaMsg = new VipToConsortiaMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VipToConsortiaMsg;
         var _loc3_:ThaneInfo = _model.getConsortiaMemberList()[_loc2_.userid];
         if(_loc3_)
         {
            _loc3_.IsVipAndNoExpirt = _loc2_.isVip;
            _loc3_.vipType = _loc2_.vipType;
            _model.dispatchEvent(new GroupChatEvent("consortiagroupchatitemupdate",null));
         }
      }
      
      private function __getSimpleAndSnsInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ThaneInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RelationPlayerMsg = new RelationPlayerMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RelationPlayerMsg;
         var _loc3_:int = _loc2_.from;
         var _loc4_:FriendItemCellInfo = new FriendItemCellInfo();
         SocketGameReader.readSimpleAndSnsInfo(_loc4_,_loc2_);
         if(_loc3_ == 3 || _loc3_ == 2)
         {
            _loc5_ = _model.getConsortiaMemberList()[_loc4_.userId];
            if(_loc5_)
            {
               _loc5_.headId = _loc4_.snsInfo.headId;
               _model.dispatchEvent(new GroupChatEvent("consortiagroupchatitemupdate",null));
            }
         }
      }
      
      public function sendModifyGroupPlacard(param1:String) : void
      {
         if(checkWord(param1))
         {
            ConsortiaSocketOutManager.sendModifyGroupPlacard(param1);
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
      
      public function get consortiaBtnShining() : Boolean
      {
         return _consortiaBtnShining;
      }
      
      public function set consortiaBtnShining(param1:Boolean) : void
      {
      }
      
      public function get groupChatShining() : Boolean
      {
         return model.shineSwitch && model.unreadGroupChat;
      }
   }
}

