package chat.view
{
   import chat.ChatManager;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.utils.StringHelper;
   
   public class ChatPopView extends Component implements IManualSize
   {
      
      private var _back:ScaleUpDownImage;
      
      private var _chatTxt:ExpressionChatNotic;
      
      private var _chatBack:Function;
      
      private var _timeId:int;
      
      public function ChatPopView(param1:Function)
      {
         super();
         _chatBack = param1;
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,_back.width,_back.height);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatPopAsset");
         _chatTxt = new ExpressionChatNotic();
         _chatTxt.x = 10;
         _chatTxt.y = 5;
         _chatTxt.lineWidth = 146;
         addChild(_back);
         addChild(_chatTxt);
         mouseChildren = mouseEnabled = false;
      }
      
      public function set data(param1:ChatData) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         ObjectUtils.copyProperties(_loc3_,param1,true);
         var _loc2_:int = StringHelper.checkStringLength(_loc3_.getNormalMsg());
         if(_loc2_ < 20)
         {
            _chatTxt.x = (_back.width - _loc2_ * 7.5) / 2;
            _chatTxt.lineWidth = _loc2_ * 8;
         }
         _loc3_.msg = ChatManager.instance.analyzeExpressionAfterNormal(_loc3_.msg);
         _loc3_.channel = 104;
         _loc3_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc3_);
         _chatTxt.needFilters = false;
         _chatTxt.data = _loc3_;
         _back.beginChanges();
         _back.height = _chatTxt.y + _chatTxt.totalLine * _chatTxt.lineHeight + 35;
         _back.commitChanges();
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         _timeId = setTimeout(close,3000);
      }
      
      private function close() : void
      {
         dispose();
         if(_chatBack != null)
         {
            _chatBack();
         }
         _chatBack = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
      }
   }
}

