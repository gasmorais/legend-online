package mvc.module.groupchat
{
   import chat.datas.ChatCellData;
   import chat.datas.ChatChannel;
   import chat.datas.ChatItemData;
   import chat.utils.GroupChatFormat;
   import com.pickgliss.utils.ObjectPool;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class ConsortiaGroupChatData
   {
      
      public var timeStr:String;
      
      public var channel:int;
      
      public var uid:int;
      
      public var serverName:String;
      
      public var type:int;
      
      public var userType:int;
      
      public var vipGrade:int;
      
      public var senderName:String;
      
      public var receiverName:String;
      
      public var grades:int;
      
      public var consortiaId:int;
      
      public var consortiaName:String;
      
      public var roomId:int;
      
      public var roomName:String;
      
      public var msg:String;
      
      public var bigBugleType:int;
      
      public var is_centerTip:Boolean;
      
      public var is_bigTip:Boolean;
      
      public var itemList:Array;
      
      public var starList:Array;
      
      public var shareSpaceList:Array;
      
      private var _userId:int = 0;
      
      public var groupHeadData:ChatItemData = ObjectPool.getObject(ChatItemData) as ChatItemData;
      
      public var groupChatData:ChatItemData = ObjectPool.getObject(ChatItemData) as ChatItemData;
      
      public function ConsortiaGroupChatData()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
         timeStr = DateFormatter.getCountDate(getSeconds());
      }
      
      public function getNormalMsg() : String
      {
         var _loc2_:Array = null;
         var _loc1_:String = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc6_:String = "";
         var _loc5_:int = 0;
         var _loc7_:String = msg;
         _loc2_ = msg.match(/\<([^>]*)>*/g);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            try
            {
               _loc1_ = _loc2_[_loc5_];
               _loc3_ = new XML(_loc1_);
               _loc4_ = _loc3_.@name;
               grades = int(_loc3_.@grades);
               consortiaId = int(_loc3_.@consortiaId);
               _loc4_ = "  [" + _loc4_ + "]  ";
               _loc7_ = _loc7_.replace(_loc1_,_loc4_);
            }
            catch(e:Error)
            {
               _loc7_ = "";
            }
            _loc5_++;
         }
         _loc7_ = StringHelper.trimLeft(_loc7_);
         return StringHelper.trimRight(_loc7_);
      }
      
      public function commit(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         var _loc3_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         if(channel == 5)
         {
            _loc4_ = channel;
            _loc5_ = msg;
            if(!StringHelper.isNullOrEmpty(senderName))
            {
               channel = param1 == uid ? 101 : 102;
               _loc2_.push(GroupChatFormat.createGeneralCellData("[",channel));
               _loc2_.push(GroupChatFormat.createPlayerCellData(channel,0,uid,serverName,0,grades,consortiaId,senderName));
               _loc2_.push(GroupChatFormat.createGeneralCellData("]",channel));
               _loc2_.push(GroupChatFormat.createGeneralCellData("    [" + timeStr + "]",channel));
               groupHeadData.channel = _loc4_;
               groupHeadData.channelName = ChatChannel.getChatChannelName(channel);
               groupHeadData.cellVector = _loc2_;
               channel = param1 == uid ? 99 : 100;
            }
            else
            {
               channel = 98;
            }
            _loc3_ = _loc3_.concat(GroupChatFormat.getContentCellData(this));
            groupChatData.channel = _loc4_;
            groupChatData.channelName = ChatChannel.getChatChannelName(channel);
            groupChatData.cellVector = _loc3_;
            msg = _loc5_;
            channel = _loc4_;
         }
      }
      
      private function getSeconds() : int
      {
         var _loc1_:Date = new Date();
         return _loc1_.hours * 60 * 60 + _loc1_.minutes * 60 + _loc1_.seconds;
      }
      
      public function dispose() : void
      {
         groupHeadData.dispose();
         groupChatData.dispose();
         timeStr = "";
         userId = 0;
         channel = 0;
         uid = 0;
         serverName = "";
         type = 0;
         userType = 0;
         vipGrade = 0;
         senderName = "";
         receiverName = "";
         consortiaName = "";
         roomName = "";
         msg = "";
         grades = 0;
         consortiaId = 0;
         roomId = 0;
         bigBugleType = 0;
         is_centerTip = false;
         is_bigTip = false;
         itemList = null;
         starList = null;
         shareSpaceList = null;
      }
   }
}

