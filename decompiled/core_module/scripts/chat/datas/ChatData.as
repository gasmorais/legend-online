package chat.datas
{
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectPool;
   import yishi.utils.StringHelper;
   
   public class ChatData implements Disposeable
   {
      
      public var uuid:String;
      
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
      
      public var appellId:int;
      
      public var msg:String;
      
      public var bigBugleType:int;
      
      public var crossBugleType:int;
      
      public var is_centerTip:Boolean;
      
      public var is_bigTip:Boolean;
      
      public var itemList:Array;
      
      public var starList:Array;
      
      public var cardList:Array;
      
      public var shareSpaceList:Array;
      
      public var isLookInfo:Boolean;
      
      public var msgUrl:String;
      
      public var chatItemData:ChatItemData = ObjectPool.getObject(ChatItemData) as ChatItemData;
      
      public var friendId:int;
      
      public function ChatData()
      {
         super();
      }
      
      public function getNormalMsg() : String
      {
         var _loc2_:Array = null;
         var _loc1_:String = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc6_:String = "";
         var _loc5_:int = 0;
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
               if(_loc3_.@t == 7)
               {
                  msg = msg.replace(_loc1_,"");
               }
               else
               {
                  msg = msg.replace(_loc1_,"[" + _loc4_ + "]");
               }
            }
            catch(e:Error)
            {
               msg = "";
            }
            _loc5_++;
         }
         return msg;
      }
      
      public function commit() : void
      {
         var _loc1_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         _loc1_.push(ChatFormat.createChannelCellData(channel));
         if(channel != 2 && channel != 3 && channel != 11 && channel != 12)
         {
            _loc1_ = _loc1_.concat(ChatFormat.createSpeakerCellData(channel,userType,serverName,vipGrade,uid,grades,consortiaId,senderName,appellId));
         }
         _loc1_ = _loc1_.concat(ChatFormat.getContentCellData(this));
         if(channel == 12)
         {
            if(!StringHelper.isNullOrEmpty(msgUrl))
            {
               _loc1_.push(ChatFormat.createChannelCellLinkData(msgUrl));
            }
         }
         chatItemData.channel = channel;
         chatItemData.channelName = ChatChannel.getChatChannelName(channel);
         chatItemData.cellVector = _loc1_;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(chatItemData)
         {
            chatItemData.dispose();
         }
         chatItemData = null;
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
         msgUrl = "";
         grades = 0;
         consortiaId = 0;
         roomId = 0;
         bigBugleType = 0;
         crossBugleType = 0;
         friendId = 0;
         is_centerTip = false;
         is_bigTip = false;
         isLookInfo = false;
         itemList = null;
         starList = null;
         cardList = null;
         shareSpaceList = null;
      }
   }
}

