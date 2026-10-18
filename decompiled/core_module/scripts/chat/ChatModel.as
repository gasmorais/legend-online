package chat
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import flash.utils.Dictionary;
   import mvc.module.groupchat.ConsortiaGroupChatData;
   import mvc.module.groupchat.ConsortiaGroupChatModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ChatModel
   {
      
      public static const MAX_CHAT_COUNT:int = 50;
      
      public var allChats:Vector.<ChatData>;
      
      public var tempChannel:Vector.<ChatData>;
      
      public var allSendChats:Vector.<String>;
      
      public var bigBugleList:Vector.<ChatData>;
      
      public var crossBugleList:Vector.<ChatData>;
      
      public var sendIndex:int = 0;
      
      private var _currentOutChannel:int = 0;
      
      public var currentInChannel:int = 8;
      
      public var currentBigBugleData:ChatData;
      
      public var currentCrossBugleData:ChatData;
      
      private var _filterChannels:Array = [];
      
      private var chatProtocalTime:Dictionary;
      
      private var _protocolCount:int = 0;
      
      private var _isCrossRose:Boolean;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public function ChatModel()
      {
         super();
         allChats = new Vector.<ChatData>();
         allSendChats = new Vector.<String>();
         bigBugleList = new Vector.<ChatData>();
         crossBugleList = new Vector.<ChatData>();
         tempChannel = new Vector.<ChatData>();
         chatProtocalTime = new Dictionary();
      }
      
      public function get protocalId() : int
      {
         return ++_protocolCount;
      }
      
      public function getProtocolTimeByID(param1:int) : Number
      {
         return chatProtocalTime[param1];
      }
      
      public function addSendProtocol(param1:int, param2:Number) : void
      {
         chatProtocalTime[param1] = param2;
      }
      
      public function removeReceiveProtocol(param1:Number) : void
      {
         delete chatProtocalTime[param1];
      }
      
      public function get filterChannels() : Array
      {
         return _filterChannels;
      }
      
      public function get currentOutChannel() : int
      {
         return _currentOutChannel;
      }
      
      public function set currentOutChannel(param1:int) : void
      {
         _currentOutChannel = param1;
         switch(_currentOutChannel)
         {
            case 0:
               _filterChannels = [];
               break;
            case 10:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",10);
               _filterChannels = [8,6,5,109];
               break;
            case 109:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",109);
               _filterChannels = [8,6,5,10];
               break;
            case 6:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",6);
               _filterChannels = [8,10,5,2,11,109];
               break;
            case 5:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",5);
               _filterChannels = [8,10,6,2,11,109];
               break;
            case 3:
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",3);
               _filterChannels = [8,10,5,6,109];
               break;
            case 12:
               _filterChannels = [8,10,5,2,11,6,3,109];
         }
         NotificationManager.instance.sendNotification("OUTPUT_CHANNEL_CHANGE");
         clearTempData();
      }
      
      public function addChat(param1:ChatData) : void
      {
         var _loc2_:ChatData = null;
         var _loc4_:ChatData = null;
         var _loc5_:ConsortiaGroupChatData = null;
         allChats.push(param1);
         var _loc3_:int = int(allChats.length);
         if(_loc3_ > 50)
         {
            _loc2_ = allChats.shift();
            if(_loc2_.channel == _currentOutChannel)
            {
               if(tempChannel.length > 50)
               {
                  _loc4_ = tempChannel.shift();
                  _loc4_.dispose();
                  _loc4_ = null;
               }
               tempChannel.push(_loc2_);
            }
            else
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         NotificationManager.instance.sendNotification("UPDATE_CHAT_VIEW",param1);
         if(param1.channel == 5)
         {
            _loc5_ = ObjectPool.getObject(ConsortiaGroupChatData) as ConsortiaGroupChatData;
            _loc5_.channel = param1.channel;
            _loc5_.userType = param1.userType;
            _loc5_.serverName = param1.serverName;
            _loc5_.type = param1.type;
            _loc5_.consortiaName = param1.consortiaName;
            _loc5_.is_centerTip = param1.is_centerTip;
            _loc5_.is_bigTip = param1.is_bigTip;
            _loc5_.bigBugleType = param1.bigBugleType;
            _loc5_.vipGrade = param1.vipGrade;
            _loc5_.uid = param1.uid;
            _loc5_.consortiaId = param1.consortiaId;
            _loc5_.senderName = param1.senderName;
            _loc5_.receiverName = param1.receiverName;
            _loc5_.itemList = param1.itemList;
            _loc5_.starList = param1.starList;
            _loc5_.shareSpaceList = param1.shareSpaceList;
            _loc5_.msg = param1.msg;
            _loc5_.userId = player.userId;
            groupChatModel.addChat(_loc5_);
         }
      }
      
      private function get player() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get groupChatModel() : ConsortiaGroupChatModel
      {
         return FrameControllerManager.instance.consortiaGroupChatControler.model;
      }
      
      public function addBigBugleData(param1:ChatData) : void
      {
         var _loc2_:ChatData = null;
         bigBugleList.push(param1);
         if(bigBugleList.length > 50)
         {
            _loc2_ = bigBugleList.shift();
            _loc2_.dispose();
            _loc2_ = null;
         }
         NotificationManager.instance.sendNotification("UPDATE_BIGBUGLE_VIEW",param1);
      }
      
      public function addCrossBugleData(param1:ChatData, param2:int) : void
      {
         var _loc3_:ChatData = null;
         crossBugleList.push(param1);
         if(crossBugleList.length > 50)
         {
            _loc3_ = crossBugleList.shift();
            _loc3_.dispose();
            _loc3_ = null;
         }
         if(param2 == 0)
         {
            NotificationManager.instance.sendNotification("UPDATE_BIGBUGLE_VIEW",param1);
         }
      }
      
      public function getChatsByOutputChannel() : Vector.<ChatData>
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<ChatData> = new Vector.<ChatData>();
         var _loc1_:int = int(allChats.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_filterChannels.indexOf(allChats[_loc2_].channel) < 0)
            {
               _loc3_.push(allChats[_loc2_]);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function clean() : void
      {
         var _loc2_:ChatData = null;
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc3_:int = int(allChats.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = allChats[_loc4_];
            _loc2_.dispose();
            _loc2_ = null;
            _loc4_++;
         }
         allChats.splice(0,_loc3_);
         _loc3_ = int(allSendChats.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = allSendChats[_loc4_];
            _loc1_ = "";
            _loc4_++;
         }
         allSendChats.splice(0,_loc3_);
         _loc3_ = bigBugleList.length - 1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = bigBugleList[_loc4_];
            _loc2_.dispose();
            _loc2_ = null;
            _loc4_++;
         }
         bigBugleList.splice(0,_loc3_ - 1);
         _loc3_ = crossBugleList.length - 1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = crossBugleList[_loc4_];
            _loc2_.dispose();
            _loc2_ = null;
            _loc4_++;
         }
         crossBugleList.splice(0,_loc3_);
         NotificationManager.instance.sendNotification("OUTPUT_CHANNEL_CHANGE");
      }
      
      private function clearTempData() : void
      {
         var _loc1_:ChatData = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(tempChannel.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = tempChannel[_loc3_];
            _loc1_.dispose();
            _loc1_ = null;
            _loc3_++;
         }
         tempChannel.length = 0;
      }
      
      public function get isCrossRose() : Boolean
      {
         return _isCrossRose;
      }
      
      public function set isCrossRose(param1:Boolean) : void
      {
         _isCrossRose = param1;
      }
   }
}

