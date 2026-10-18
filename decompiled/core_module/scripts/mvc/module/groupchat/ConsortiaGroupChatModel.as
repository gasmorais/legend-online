package mvc.module.groupchat
{
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import events.GroupChatEvent;
   import flash.events.EventDispatcher;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class ConsortiaGroupChatModel extends EventDispatcher
   {
      
      public static const SHOW_MAX_LEN:int = 20;
      
      public static const SELF_MAX_LEN:int = 5;
      
      public static const EMPTY_TEXT:String = "   ";
      
      public static const MAX_PER_PAGE:int = 30;
      
      public var unreadGroupChat:Boolean = false;
      
      public var isOpenGroupChatTip:Boolean = true;
      
      private var _curConsortiaChats:Vector.<ConsortiaGroupChatData>;
      
      private var _curIndexs:Vector.<int>;
      
      private var _curIndex:int = 0;
      
      private var _maxIndex:int = 0;
      
      private var _historyArray:Array;
      
      private var _tempText:FilterFrameText;
      
      private var _text:String;
      
      private var _lastData:ConsortiaGroupChatData;
      
      private var _selfCount:int = 1;
      
      private var _shineSwitch:Boolean;
      
      public function ConsortiaGroupChatModel()
      {
         super();
         _curConsortiaChats = new Vector.<ConsortiaGroupChatData>();
         _curIndexs = new Vector.<int>();
         _historyArray = [];
         _tempText = new FilterFrameText();
         _tempText.wordWrap = true;
         _tempText.multiline = true;
         _tempText.mouseWheelEnabled = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Arial";
         _loc1_.size = 12;
         _loc1_.color = 1842204;
         _loc1_.align = "left";
         _loc1_.leading = 2;
         _tempText.defaultTextFormat = _loc1_;
      }
      
      public function addChat(param1:ConsortiaGroupChatData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(isSelfFollow(param1,_lastData) && _selfCount < 5)
         {
            _selfCount = _selfCount + 1;
         }
         else
         {
            _curIndexs.push(_curIndex);
            _selfCount = 1;
            _maxIndex = _maxIndex + 1;
         }
         buildHistoryArray(param1);
         _curConsortiaChats.push(param1);
         _curIndex = _curIndex + 1;
         _lastData = param1;
         if(_maxIndex > 20)
         {
            _maxIndex = _maxIndex - 1;
            _loc3_ = 0;
            _loc2_ = _curIndex - _maxIndex;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _curIndex = _curIndex - 1;
               _curConsortiaChats.shift();
               _loc3_++;
            }
         }
         dispatchEvent(new GroupChatEvent("consortiagroupchatupdate",param1));
         if(!FrameControllerManager.instance.consortiaGroupChatControler.isVisible())
         {
            unreadGroupChat = true;
            if(SceneManager.instance.currentType == "BATTLE_SCENE" || !MainToolBar.instance.poptipButtonVisible)
            {
               if(shineSwitch)
               {
                  FrameControllerManager.instance.consortiaGroupChatControler.consortiaBtnShining = true;
               }
            }
            else
            {
               MainToolBar.instance.poptipButtonShine = true;
            }
         }
      }
      
      private function buildHistoryArray(param1:ConsortiaGroupChatData) : void
      {
         var _loc3_:ConsortiaGroupChatHistoryData = null;
         var _loc2_:int = 1;
         _text = param1.getNormalMsg();
         _text = _text.replace(/\n/g,"");
         if(param1.channel == 5)
         {
            if(!StringHelper.isNullOrEmpty(param1.senderName))
            {
               _tempText.width = 250;
               _tempText.text = LanguageMgr.GetTranslation("mvc.module.groupchat.ConsortiaGroupChatModel.PointTxt");
               _tempText.width -= _tempText.textWidth;
               _tempText.text = _text;
               _loc3_ = ObjectPool.getObject(ConsortiaGroupChatHistoryData) as ConsortiaGroupChatHistoryData;
               _loc3_.uid = param1.uid;
               _loc3_.type = 1;
               _loc3_.style = 5;
               _loc3_.color = 4;
               _loc3_.text = "[" + param1.senderName + "]" + "    " + "[" + param1.timeStr + "]";
               _historyArray.push(_loc3_);
               _loc2_ = 0;
               while(_loc2_ < _tempText.numLines)
               {
                  _loc3_ = ObjectPool.getObject(ConsortiaGroupChatHistoryData) as ConsortiaGroupChatHistoryData;
                  _loc3_.uid = param1.uid;
                  _loc3_.type = 1;
                  _loc3_.style = 6;
                  _loc3_.color = 3;
                  _loc3_.text = _tempText.getLineText(_loc2_);
                  _historyArray.push(_loc3_);
                  _loc2_++;
               }
            }
            else
            {
               _tempText.width = 234;
               _tempText.text = _text;
               _loc2_ = 0;
               while(_loc2_ < _tempText.numLines)
               {
                  _loc3_ = ObjectPool.getObject(ConsortiaGroupChatHistoryData) as ConsortiaGroupChatHistoryData;
                  _loc3_.uid = param1.uid;
                  _loc3_.type = 2;
                  _loc3_.style = 8;
                  _loc3_.text = _tempText.getLineText(_loc2_);
                  if(_loc2_ == 0)
                  {
                     _loc3_.style = 7;
                  }
                  _historyArray.push(_loc3_);
                  _loc2_++;
               }
            }
         }
      }
      
      public function isSelfFollow(param1:ConsortiaGroupChatData, param2:ConsortiaGroupChatData) : Boolean
      {
         if(param2 && param1 && !StringHelper.isNullOrEmpty(param2.senderName) && !StringHelper.isNullOrEmpty(param1.senderName) && param2.uid == param1.uid && param1.uid == player.userId)
         {
            return true;
         }
         return false;
      }
      
      public function getTotalPage() : int
      {
         if(historyArray)
         {
            return Math.ceil(historyArray.length / 30);
         }
         return 0;
      }
      
      public function get shineSwitch() : Boolean
      {
         _shineSwitch = SharedManager.instance.consortiaGroupChatShineSwitch;
         return _shineSwitch;
      }
      
      public function set shineSwitch(param1:Boolean) : void
      {
         if(_shineSwitch == param1)
         {
            return;
         }
         _shineSwitch = param1;
         SharedManager.instance.consortiaGroupChatShineSwitch = _shineSwitch;
         SharedManager.instance.save();
      }
      
      public function get historyArray() : Array
      {
         if(!_historyArray)
         {
            _historyArray = [];
         }
         return _historyArray;
      }
      
      public function get curConsortiaChats() : Vector.<ConsortiaGroupChatData>
      {
         if(!_curConsortiaChats)
         {
            _curConsortiaChats = new Vector.<ConsortiaGroupChatData>();
         }
         return _curConsortiaChats;
      }
      
      public function get curIndexs() : Vector.<int>
      {
         if(!_curIndexs)
         {
            _curIndexs = new Vector.<int>();
         }
         return _curIndexs;
      }
      
      private function get player() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function getConsortiaMemberList() : SimpleDictionary
      {
         return ConsortiaManager.instance.model.consortiaMemberList;
      }
      
      public function disposeCurConsortiaChats() : void
      {
         _curConsortiaChats.splice(0,_curConsortiaChats.length);
         _curIndexs.splice(0,_curIndexs.length);
         _curIndex = 0;
         _lastData = null;
         _selfCount = 1;
      }
      
      public function disposeAllConsortiaChats() : void
      {
         for each(var _loc1_:ConsortiaGroupChatHistoryData in _historyArray)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _historyArray.splice(0,_historyArray.length);
      }
   }
}

