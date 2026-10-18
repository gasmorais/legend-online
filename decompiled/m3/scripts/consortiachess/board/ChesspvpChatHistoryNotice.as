package consortiachess.board
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   import mvc.module.groupchat.ConsortiaGroupChatHistoryData;
   import yishi.manager.ArmyManager;
   
   public class ChesspvpChatHistoryNotice extends Sprite implements Disposeable
   {
      
      private var _data:ConsortiaGroupChatHistoryData;
      
      private var _text:String;
      
      private var _noticeIcon:Bitmap;
      
      private var _chatText:FilterFrameText;
      
      private var _textFormat:TextFormat;
      
      private var _infoTextWidth:int = 234;
      
      private var _chatTextWidth:int = 250;
      
      private var _noticeIconWidth:int = 22;
      
      public function ChesspvpChatHistoryNotice()
      {
         super();
      }
      
      public function set data(param1:ConsortiaGroupChatHistoryData) : void
      {
         _data = param1 as ConsortiaGroupChatHistoryData;
         _chatText = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ChatListText");
         _chatText.multiline = false;
         _chatText.wordWrap = false;
         addChild(_chatText);
         if(_data.type == 2)
         {
            if(_data.style == 7)
            {
               _noticeIcon = ComponentFactory.Instance.creatBitmap("asset.consortiagroupchat.NoticeIcon");
               addChild(_noticeIcon);
            }
            _textFormat = ComponentFactory.Instance.model.getSet("consortiagroupchat.historyInfoTextStyle_t");
            _chatText.x = _noticeIconWidth;
            _chatText.width = _infoTextWidth;
            _chatText.defaultTextFormat = _textFormat;
            _chatText.text = _data.text;
            _chatText.setTextFormat(_textFormat);
            filters = [new GlowFilter(0,1,4,4,4)];
         }
         else if(_data.type == 1)
         {
            if(_data.style == 5)
            {
               _text = "";
            }
            else if(_data.style == 6)
            {
               _text = "   ";
            }
            if(_data.color == 3)
            {
               _textFormat = ComponentFactory.Instance.model.getSet("consortiagroupchat.historyTextStyle_t");
            }
            else if(_data.color == 4)
            {
               if(_data.uid == ArmyManager.instance.thane.userId)
               {
                  _textFormat = ComponentFactory.Instance.model.getSet("consortiagroupchat.historySelfNameTextStyle_t");
               }
               else
               {
                  _textFormat = ComponentFactory.Instance.model.getSet("consortiagroupchat.historyNameTextStyle_t");
               }
            }
            _chatText.width = _chatTextWidth;
            _chatText.defaultTextFormat = _textFormat;
            _chatText.text = _text + _data.text;
            _chatText.setTextFormat(_textFormat);
            filters = [];
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_data)
         {
            _data.dispose();
         }
         _data = null;
         if(_noticeIcon)
         {
            _noticeIcon = null;
         }
         if(_chatText)
         {
            _chatText.dispose();
         }
         _chatText = null;
         if(_textFormat)
         {
            _textFormat = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

