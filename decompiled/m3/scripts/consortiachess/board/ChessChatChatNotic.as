package consortiachess.board
{
   import chat.utils.ChatFormat;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.text.engine.ContentElement;
   import flash.text.engine.GroupElement;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import manager.LanguageMgr;
   import mvc.module.groupchat.ConsortiaGroupChatData;
   import yishi.manager.ArmyManager;
   import yishi.utils.StringHelper;
   
   public class ChessChatChatNotic extends Sprite implements Disposeable, IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _data:ConsortiaGroupChatData;
      
      private var _noticeIcon:Bitmap;
      
      private var _chatText1:FilterFrameText;
      
      private var _chatText2:FilterFrameText;
      
      private var _chatText3:FilterFrameText;
      
      private var _chatText4:FilterFrameText;
      
      private var _chatText5:FilterFrameText;
      
      private var _chatCount:int = 0;
      
      private var _pointVisible:Boolean = false;
      
      private var _textFormat:TextFormat;
      
      private var _firstMsg:String;
      
      private var _text:String;
      
      private var _groupElement:GroupElement;
      
      private var _filters:Array;
      
      private var _noticeIconWidth:int = 22;
      
      private var _paddingTop:int = 9;
      
      private var _paddingLeft:int = 0;
      
      private var _lineWidth:int = 296;
      
      private var _bgWidth:int = 296;
      
      private var _textBlock:TextBlock;
      
      private var _faceHeigth:Number = 18;
      
      public var totalLine:int = 0;
      
      public function ChessChatChatNotic()
      {
         _rect = new Rectangle(0,0,_lineWidth,_faceHeigth);
         super();
         mouseEnabled = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      public function set data(param1:ConsortiaGroupChatData) : void
      {
         var _loc2_:int = 0;
         _data = param1 as ConsortiaGroupChatData;
         ObjectUtils.disposeAllChildren(this);
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            this["_chatText" + _loc2_] = ComponentFactory.Instance.creatComponentByStylename("chesspvp.ChatListText");
            this["_chatText" + _loc2_].visible = false;
            this["_chatText" + _loc2_].text = LanguageMgr.GetTranslation("mvc.module.groupchat.ConsortiaGroupChatModel.PointTxt");
            addChild(this["_chatText" + _loc2_]);
            _loc2_++;
         }
         _data.commit(_data.userId);
         var _loc4_:Vector.<ContentElement> = _data.groupHeadData.getAllElements();
         var _loc3_:Vector.<ContentElement> = _data.groupChatData.getAllElements();
         if(_data && _data.channel == 5)
         {
            if(!StringHelper.isNullOrEmpty(_data.senderName))
            {
               if(!_loc4_ || _loc4_.length == 0 || !_loc3_ || _loc3_.length == 0)
               {
                  return;
               }
               if(_data.uid == ArmyManager.instance.thane.userId)
               {
                  _textFormat = ComponentFactory.Instance.model.getSet("chesspvp.outputSelfTextStyle_t");
               }
               else
               {
                  _textFormat = ComponentFactory.Instance.model.getSet("chesspvp.outputTextStyle_t");
               }
               _filters = [];
               _lineWidth = _bgWidth - 4;
               _paddingLeft = 4;
               _groupElement = new GroupElement(_loc4_);
               _textBlock = new TextBlock();
               _textBlock.baselineZero = "ideographicCenter";
               _textBlock.content = _groupElement;
               createTextLines();
               _chatCount = 0;
               _lineWidth -= _noticeIconWidth;
               _paddingLeft = _noticeIconWidth;
               _groupElement = new GroupElement(_loc3_);
               _textBlock = new TextBlock();
               _textBlock.baselineZero = "ideographicCenter";
               _textBlock.content = _groupElement;
               createTextLines();
               drawBack();
            }
            else
            {
               if(!_loc3_ || _loc3_.length == 0)
               {
                  return;
               }
               _textFormat = ComponentFactory.Instance.model.getSet("chesspvp.infoTextStyle_t");
               _noticeIcon = ComponentFactory.Instance.creatBitmap("asset.chesspvp.NoticeIcon");
               addChild(_noticeIcon);
               _lineWidth -= _noticeIconWidth;
               _paddingLeft = _noticeIconWidth;
               _filters = [new GlowFilter(0,1,4,4,4)];
               _groupElement = new GroupElement(_loc3_);
               _textBlock = new TextBlock();
               _textBlock.baselineZero = "ideographicCenter";
               _textBlock.content = _groupElement;
               createTextLines();
               drawBack();
            }
         }
      }
      
      private function createTextLines() : void
      {
         _chatCount = _chatCount + 1;
         this["_chatText" + _chatCount].y = _paddingTop - 7;
         if(_pointVisible)
         {
            this["_chatText" + _chatCount].visible = true;
         }
         var _loc1_:int = 0;
         var _loc2_:Boolean = true;
         var _loc3_:TextLine = _textBlock.createTextLine(null,_lineWidth);
         _loc3_.mouseEnabled = false;
         _loc3_.doubleClickEnabled = false;
         while(_loc3_)
         {
            totalLine = totalLine + 1;
            addChild(_loc3_);
            _loc3_.x = _paddingLeft;
            if(_loc2_)
            {
               _loc2_ = false;
               _loc1_ = _loc3_.y = _paddingTop;
            }
            else
            {
               _loc1_ = _loc3_.y = _loc1_ + _faceHeigth;
            }
            _loc3_ = _textBlock.createTextLine(_loc3_,_lineWidth);
         }
         filters = _filters;
         _paddingTop = _loc1_ + _faceHeigth;
      }
      
      public function appendText(param1:ConsortiaGroupChatData) : void
      {
         _chatText1.visible = true;
         _pointVisible = true;
         param1.commit(param1.userId);
         _groupElement = new GroupElement(param1.groupChatData.getAllElements());
         _textBlock = new TextBlock();
         _textBlock.baselineZero = "ideographicCenter";
         _textBlock.content = _groupElement;
         createTextLines();
         drawBack();
      }
      
      private function drawBack() : void
      {
         graphics.beginFill(16711680,0);
         graphics.drawRect(0,0,_bgWidth,totalLine * _faceHeigth);
         graphics.endFill();
         _rect.height = totalLine * _faceHeigth;
      }
      
      public function dispose() : void
      {
         graphics.clear();
         totalLine = 0;
         _chatCount = 0;
         _paddingTop = 9;
         _paddingLeft = 0;
         _pointVisible = false;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_noticeIcon);
         _noticeIcon = null;
         ObjectUtils.disposeObject(_chatText1);
         _chatText1 = null;
         ObjectUtils.disposeObject(_chatText2);
         _chatText2 = null;
         ObjectUtils.disposeObject(_chatText3);
         _chatText3 = null;
         ObjectUtils.disposeObject(_chatText4);
         _chatText4 = null;
         ObjectUtils.disposeObject(_chatText5);
         _chatText5 = null;
         ChatFormat.clearTextLine(_textBlock);
         _textFormat = null;
         _filters = null;
         _textBlock = null;
         _groupElement = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

