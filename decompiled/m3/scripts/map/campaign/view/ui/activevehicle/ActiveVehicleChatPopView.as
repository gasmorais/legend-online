package map.campaign.view.ui.activevehicle
{
   import chat.ChatManager;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import chat.view.ExpressionChatNotic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.utils.StringHelper;
   
   public class ActiveVehicleChatPopView extends Component
   {
      
      private var _back:ScaleLeftRightImage;
      
      private var _chatTxt:ExpressionChatNotic;
      
      private var _timeId:int;
      
      public function ActiveVehicleChatPopView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("vehicle.ChatPopBottom");
         _back.height = 66;
         _chatTxt = new ExpressionChatNotic();
         _chatTxt.x = 9;
         _chatTxt.y = 9;
         _chatTxt.lineWidth = 190;
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
         var _loc2_:int = int(StringHelper.checkStringLength(_loc3_.getNormalMsg()));
         if(_loc2_ <= 20)
         {
            _chatTxt.x = (_back.width - _loc2_ * 7.5) / 2;
            _chatTxt.lineWidth = _loc2_ * 8;
         }
         _loc3_.msg = ChatManager.instance.analyzeExpressionAfterNormal(_loc3_.msg);
         _loc3_.channel = 8;
         _loc3_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc3_);
         _chatTxt.needFilters = false;
         _chatTxt.data = _loc3_;
         _chatTxt.y = 10 + (50 - _chatTxt.height) / 2;
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
      }
      
      override public function dispose() : void
      {
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_chatTxt)
         {
            ObjectUtils.disposeObject(_chatTxt);
         }
         _chatTxt = null;
         super.dispose();
      }
   }
}

