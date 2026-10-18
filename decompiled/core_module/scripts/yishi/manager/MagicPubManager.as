package yishi.manager
{
   import com.road.yishi.proto.giftparty.GiftPartyMsg;
   import com.road.yishi.proto.magicpub.MagicPubInfoListMsg;
   import com.road.yishi.proto.magicpub.MagicPubInfoMsg;
   import com.road.yishi.proto.magicpub.MagicPubReqMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class MagicPubManager
   {
      
      public static const OP_BEGIN_CHAT:uint = 1;
      
      public static const OP_ASK_CHAT:uint = 2;
      
      public static const OP_PRESENT:uint = 3;
      
      public static const STATE_GREET:uint = 1;
      
      public static const STATE_ASK:uint = 2;
      
      public static const STATE_THANK:uint = 3;
      
      private static var _instance:MagicPubManager;
      
      public static const OP_TEAM_ENTER:uint = 1;
      
      public static const OP_TEAM_LEAVE:uint = 2;
      
      public static const OP_TEAM_READY:uint = 3;
      
      public static const OP_TEAM_KILLD:uint = 4;
      
      public static const OP_TEAM_START:uint = 5;
      
      public static const OP_FRAG_REFER:uint = 6;
      
      public static const OP_FRAG_SALED:uint = 7;
      
      public static const OP_INFO_REQUE:uint = 8;
      
      public static const OP_LIST_TEAMS:uint = 9;
      
      private var _listMsg:MagicPubInfoListMsg;
      
      private var _partyMsg:GiftPartyMsg;
      
      private var _teamMsg:GiftPartyMsg;
      
      public var openGiftWill:Boolean;
      
      public function MagicPubManager()
      {
         super();
      }
      
      public static function get instance() : MagicPubManager
      {
         if(!_instance)
         {
            _instance = new MagicPubManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 404,__magicPubHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 409,__teaminfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 412,__teamlistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 413,__openstateHandler);
      }
      
      private function __magicPubHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MagicPubInfoMsg = null;
         var _loc5_:MagicPubInfoMsg = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MagicPubInfoListMsg = new MagicPubInfoListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MagicPubInfoListMsg;
         if(_loc2_.op == 0)
         {
            _listMsg = _loc2_;
            _listMsg.infos.sortOn("templateId",16);
         }
         else if(_loc2_.op == 1)
         {
            _listMsg.tip = _loc2_.tip;
            _loc3_ = _loc2_.infos[0];
            _loc5_ = getInfoMsgById(_loc3_.templateId);
            _loc5_.templateId = _loc3_.templateId;
            _loc5_.grades = _loc3_.grades;
            _loc5_.gp = _loc3_.gp;
            _loc5_.state = _loc3_.state;
            _loc5_.presentCount = _loc3_.presentCount;
            _loc5_.isEvent = _loc3_.isEvent;
            _loc5_.isFirst = _loc3_.isFirst;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_UPDATE_CHAT_VIEW"));
      }
      
      private function __teaminfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GiftPartyMsg = new GiftPartyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GiftPartyMsg;
         _partyMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_PLAYER_INFO"));
      }
      
      private function __teamlistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GiftPartyMsg = new GiftPartyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GiftPartyMsg;
         _teamMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_PLAYER_LIST"));
      }
      
      private function __openstateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openGiftWill = _loc2_.param7;
      }
      
      public function getInfoMsgById(param1:int) : MagicPubInfoMsg
      {
         var _loc2_:int = 0;
         var _loc3_:Array = _listMsg.infos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].templateId == param1)
            {
               return _loc3_[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function canChatCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _listMsg.infos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].isFirst)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get partyMsg() : GiftPartyMsg
      {
         return _partyMsg;
      }
      
      public function get teamMsg() : GiftPartyMsg
      {
         return _teamMsg;
      }
      
      public function get listMsg() : MagicPubInfoListMsg
      {
         return _listMsg;
      }
      
      public function OperateMagicHotelReq(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9632);
         var _loc5_:MagicPubReqMsg = new MagicPubReqMsg();
         _loc5_.op = param1;
         _loc5_.templateId = param2;
         _loc5_.giftId = param3;
         _loc5_.count = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function OperateGiftParty(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) : void
      {
         var _loc8_:PackageOut = new PackageOut(9636);
         var _loc7_:GiftPartyMsg = new GiftPartyMsg();
         _loc7_.op = param1;
         _loc7_.teamId = param2;
         _loc7_.killUserId = param3;
         _loc7_.readyState = param4;
         _loc7_.pageIndex = param5;
         _loc7_.payType = param6;
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc7_);
      }
   }
}

