package im.view
{
   import chat.ChatManager;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import chat.view.ExpressionChatNotic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.friends.BaseIMInfo;
   import yishi.utils.DateFormatter;
   
   public class IMChatInfoItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _msg:BaseIMInfo;
      
      private var _chatNotic:ExpressionChatNotic;
      
      private var _chatType:int;
      
      public function IMChatInfoItem(param1:int, param2:BaseIMInfo)
      {
         _type = param1;
         _msg = param2;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMChatTimeTxt");
         _chatNotic = new ExpressionChatNotic();
         _chatNotic.y = 7;
         switch(_type - 1)
         {
            case 0:
               _bg = ComponentFactory.Instance.creatComponentByStylename("core.IMSelfMsgBg");
               _chatNotic.x = 10;
               _chatNotic.needFilters = true;
               _chatType = 105;
               break;
            case 1:
               _bg = ComponentFactory.Instance.creatComponentByStylename("core.IMTargetMsgBg");
               _chatNotic.x = 21;
               _chatNotic.needFilters = false;
               _chatType = 106;
         }
         if(_bg)
         {
            addChild(_bg);
         }
         addChild(_timeTxt);
         addChild(_chatNotic);
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:ChatData = null;
         if(_msg)
         {
            _timeTxt.text = DateFormatter.format(_msg.date,"hh:mm");
            _loc1_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc1_.channel = _chatType;
            _loc1_.msg = _msg.msg;
            _loc1_.commit();
            _loc1_.msg = ChatManager.instance.analyzeExpressionForIMChat(_loc1_.msg);
            _loc1_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc1_);
            _chatNotic.data = _loc1_;
         }
         if(_bg)
         {
            _bg.beginChanges();
            _bg.width = _chatNotic.firstLineWidth + 35 < 59 ? 59 : _chatNotic.firstLineWidth + 35;
            _bg.height = _chatNotic.height + 20;
            _bg.commitChanges();
            _timeTxt.y = (_bg.height - _timeTxt.height) / 2;
            switch(_type - 1)
            {
               case 0:
                  _timeTxt.x = _bg.x - _timeTxt.width - 5;
                  break;
               case 1:
                  _timeTxt.x = _bg.x + _bg.width + 5;
            }
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_chatNotic)
         {
            _chatNotic.dispose();
         }
         _chatNotic = null;
         if(_timeTxt)
         {
            _timeTxt.dispose();
         }
         _timeTxt = null;
         _msg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

