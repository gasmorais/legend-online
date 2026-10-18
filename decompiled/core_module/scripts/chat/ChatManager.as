package chat
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.chat.ChatChannelMsg;
   import com.road.yishi.proto.cross.CrossBigBugleMsg;
   import flash.utils.getTimer;
   import mainBar.ChatBar;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ChatManager
   {
      
      private static var _instance:ChatManager;
      
      private var _model:ChatModel;
      
      public function ChatManager()
      {
         super();
      }
      
      public static function get instance() : ChatManager
      {
         if(!_instance)
         {
            _instance = new ChatManager();
         }
         return _instance;
      }
      
      public function get model() : ChatModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new ChatModel();
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4541,__crossBugleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 83,__channelChatHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4500,__samllBugleFreeCountHandler);
         NotificationManager.instance.addEventListener("ADD_CHAT",__addChatHandler);
      }
      
      private function __crossBugleHandler(param1:SLGSocketEvent) : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            return;
         }
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossBigBugleMsg = new CrossBigBugleMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CrossBigBugleMsg;
         var _loc3_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc3_.userType = 1;
         _loc3_.uuid = _loc2_.uuid;
         _loc3_.uid = _loc2_.userId;
         _loc3_.grades = _loc2_.grade;
         _loc3_.type = 0;
         _loc3_.bigBugleType = 4;
         _loc3_.crossBugleType = _loc2_.param1;
         _loc3_.serverName = _loc2_.serverName;
         var _loc4_:String = "[" + _loc2_.serverName + "-" + _loc2_.nickName + "]";
         _loc3_.senderName = _loc4_;
         _loc3_.isLookInfo = _loc2_.isLookInfo;
         _loc3_.friendId = _loc2_.friendUserId;
         _loc3_.msg = analyzeCross(_loc2_.content);
         if(_loc3_.crossBugleType == 0 || _loc3_.crossBugleType == 1)
         {
            _loc3_.channel = 13;
         }
         else if(_loc3_.crossBugleType == 2)
         {
            _loc3_.channel = 108;
         }
         _loc3_.commit();
         _model.isCrossRose = true;
         if(_loc3_.crossBugleType == 0 || _loc3_.crossBugleType == 1)
         {
            _model.addCrossBugleData(_loc3_,_loc3_.crossBugleType);
         }
         else if(_loc3_.crossBugleType == 2)
         {
            _model.addChat(_loc3_);
         }
      }
      
      private function __samllBugleFreeCountHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CampaignReqMsg;
         ArmyManager.instance.thane.beginChanges();
         ArmyManager.instance.thane.smallBugleFreeCount = _loc2_.paraInt1;
         ArmyManager.instance.thane.crossBugleFreeCount = _loc2_.paraInt2;
         ArmyManager.instance.thane.commit();
      }
      
      private function __channelChatHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         if(!ChatManager.instance.model)
         {
            return;
         }
         var _loc5_:Number = getTimer() - ChatManager.instance.model.getProtocolTimeByID(_loc6_.extend1);
         if(_loc5_ >= 3)
         {
         }
         model.removeReceiveProtocol(_loc6_.extend1);
         if(!ChatBar.instance.isLoaded)
         {
            return;
         }
         var _loc2_:ChatChannelMsg = new ChatChannelMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ChatChannelMsg;
         var _loc4_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_.job != 0 && _loc2_.job != ThaneInfoHelper.getJob(ArmyManager.instance.thane.job))
         {
            return;
         }
         _loc4_.uuid = _loc2_.playerUuid;
         _loc4_.channel = _loc2_.channel;
         _loc4_.userType = _loc2_.userType;
         _loc4_.serverName = _loc2_.serverName;
         _loc4_.type = _loc2_.type;
         _loc4_.grades = _loc2_.grades;
         _loc4_.consortiaName = _loc2_.consortiaName;
         _loc4_.senderName = _loc2_.name;
         _loc4_.receiverName = _loc2_.receiveName;
         _loc4_.is_centerTip = _loc2_.isCenterTip;
         _loc4_.is_bigTip = _loc2_.isBigTip;
         _loc4_.bigBugleType = _loc2_.bigBugleType;
         _loc4_.vipGrade = _loc2_.vipGrade;
         if(_loc2_.otherId == playerInfo.userId)
         {
         }
         if(_loc4_.channel != 3 && _loc4_.channel != 2)
         {
            _loc4_.uid = _loc2_.otherId;
            _loc4_.consortiaId = _loc2_.consortiaId;
            _loc4_.appellId = _loc2_.appellid;
         }
         var _loc7_:String = analyzeExpression(_loc2_);
         var _loc3_:int = _loc7_.indexOf("http://");
         if(_loc3_ != -1 && _loc2_.channel == 12)
         {
            _loc4_.msg = _loc7_.substring(0,_loc3_ - 1);
            _loc4_.msgUrl = _loc7_.substring(_loc3_,_loc7_.length);
         }
         else
         {
            _loc4_.msg = _loc7_;
            _loc4_.msgUrl = "";
         }
         _loc4_.commit();
         if(_loc4_.channel == 12 && isMarryBugleType(_loc4_.bigBugleType))
         {
            _model.addBigBugleData(_loc4_);
         }
         else if(_loc4_.channel == 1)
         {
            _model.addBigBugleData(_loc4_);
         }
         else if(_loc4_.channel == 15)
         {
            _loc4_.userType = 1;
            _model.addBigBugleData(_loc4_);
         }
         else if(_loc4_.bigBugleType != 5 && _loc4_.bigBugleType != 10)
         {
            _model.addChat(_loc4_);
         }
         if(_loc4_.channel == 5)
         {
            NotificationManager.instance.sendNotification("CHAT_FROM_CONSORTIA",_loc4_);
         }
         if(_loc4_.is_bigTip)
         {
            MessageTipManager.instance().show(_loc4_.getNormalMsg());
            NotificationManager.instance.sendNotification("UPDATE_BIGBUGLE_VIEW",_loc4_);
         }
         if(_loc4_.is_centerTip)
         {
            MessageTipManager.instance().show(_loc4_.getNormalMsg());
         }
         if(_loc4_.channel == 11)
         {
            NotificationManager.instance.sendNotification("UPDATE_BIGBUGLE_VIEW",_loc4_);
         }
      }
      
      private function analyzeExpression(param1:ChatChannelMsg) : String
      {
         var _loc2_:String = param1.encodeMsg.replace(/\<([^>]*)>*/g,"");
         if(_loc2_.search(/(#)([0-3][0-9])/g) != -1 && _loc2_ != "#36" && _loc2_ != "#25")
         {
            _loc2_ = param1.encodeMsg.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
            return filterSpecialChar(_loc2_);
         }
         return filterSpecialChar(param1.encodeMsg);
      }
      
      public function analyzeExpression2(param1:String) : String
      {
         var _loc2_:String = param1.replace(/\<([^>]*)>*/g,"");
         if(_loc2_.search(/(#)([0-3][0-9])/g) != -1 && _loc2_ != "#36" && _loc2_ != "#25")
         {
            _loc2_ = _loc2_.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
            return filterSpecialChar(_loc2_);
         }
         return filterSpecialChar(param1);
      }
      
      private function analyzeCross(param1:String) : String
      {
         var _loc2_:String = param1.replace(/\<([^>]*)>*/g,"");
         if(_loc2_.search(/(#)([0-3][0-9])/g) != -1 && _loc2_ != "#36" && _loc2_ != "#25")
         {
            _loc2_ = param1.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
            return filterSpecialChar(_loc2_);
         }
         return filterSpecialChar(param1);
      }
      
      public function analyzeExpressionAfterNormal(param1:String) : String
      {
         if(param1 == "#36" || param1 == "#25")
         {
            return filterSpecialChar(param1);
         }
         var _loc2_:String = param1.replace(/(\[)([0-3][0-9])(\])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
         return filterSpecialChar(_loc2_);
      }
      
      public function analyzeExpressionForIMChat(param1:String) : String
      {
         if(param1 == "#36" || param1 == "#25")
         {
            return filterSpecialChar(param1);
         }
         var _loc2_:String = param1.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
         return filterSpecialChar(_loc2_);
      }
      
      private function filterSpecialChar(param1:String) : String
      {
         return param1.replace(/­/g,"-");
      }
      
      private function __addChatHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ChatData = param1.data as ChatData;
         _model.addChat(_loc2_);
      }
      
      public function chatNormal(param1:String, param2:int, param3:String = "", param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null) : void
      {
         var _loc8_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc8_.uuid = playerInfo.uuid;
         _loc8_.channel = param2;
         _loc8_.msg = param1;
         _loc8_.receiverName = param3;
         _loc8_.senderName = playerInfo.nickName;
         _loc8_.itemList = param4;
         _loc8_.starList = param5;
         _loc8_.cardList = param6;
         _loc8_.shareSpaceList = param7;
         _loc8_.commit();
         _model.allSendChats.push(_loc8_.msg);
         _model.sendIndex = _model.allSendChats.length - 1;
         ChatSocketOutManager.sendChat(_loc8_);
      }
      
      public function chatByCross(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc6_.uuid = playerInfo.uuid;
         _loc6_.msg = param1;
         _loc6_.channel = 13;
         _loc6_.itemList = param2;
         _loc6_.starList = param3;
         _loc6_.cardList = param4;
         _loc6_.shareSpaceList = param5;
         _loc6_.commit();
         _model.allSendChats.push(_loc6_.msg);
         _model.sendIndex = _model.allSendChats.length - 1;
         ChatSocketOutManager.sendCrossChat(_loc6_);
      }
      
      public function chatByBugle(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc6_.uuid = playerInfo.uuid;
         _loc6_.msg = param1;
         _loc6_.channel = 1;
         _loc6_.itemList = param2;
         _loc6_.starList = param3;
         _loc6_.cardList = param4;
         _loc6_.shareSpaceList = param5;
         _loc6_.commit();
         _model.allSendChats.push(_loc6_.msg);
         _model.sendIndex = _model.allSendChats.length - 1;
         ChatSocketOutManager.sendBugleChat(_loc6_);
      }
      
      public function chatBySmallBugle(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc6_.uuid = playerInfo.uuid;
         _loc6_.msg = param1;
         _loc6_.itemList = param2;
         _loc6_.starList = param3;
         _loc6_.cardList = param4;
         _loc6_.shareSpaceList = param5;
         _loc6_.channel = 10;
         _loc6_.commit();
         ChatSocketOutManager.sendSmallBugleChat(_loc6_);
         _model.allSendChats.push(_loc6_.msg);
         _model.sendIndex = _model.allSendChats.length - 1;
      }
      
      public function chatByOutyard(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc6_.uuid = playerInfo.uuid;
         _loc6_.msg = param1;
         _loc6_.channel = 109;
         _loc6_.itemList = param2;
         _loc6_.starList = param3;
         _loc6_.cardList = param4;
         _loc6_.shareSpaceList = param5;
         _loc6_.commit();
         _model.allSendChats.push(_loc6_.msg);
         _model.sendIndex = _model.allSendChats.length - 1;
         ChatSocketOutManager.sendOutyardChat(_loc6_);
      }
      
      private function isMarryBugleType(param1:int) : Boolean
      {
         return param1 == 6 || param1 == 7 || param1 == 8 || param1 == 9 || param1 == 12;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function getCurrentChatsByChannel() : Vector.<ChatData>
      {
         var _loc4_:int = 0;
         var _loc3_:ChatData = null;
         var _loc1_:Vector.<ChatData> = new Vector.<ChatData>();
         var _loc2_:int = int(_model.allChats.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _model.allChats[_loc4_];
            if(_loc3_.channel)
            {
               _loc1_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
   }
}

