package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import tasktracetip.data.TipMessageData;
   
   public class MessageBtnView extends Sprite implements Disposeable
   {
      
      private var _messageBtn:BaseButton;
      
      private var _data:TipMessageData;
      
      public function MessageBtnView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _messageBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.MessageBtn");
         addChild(_messageBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : TipMessageData
      {
         return _data;
      }
      
      public function set data(param1:TipMessageData) : void
      {
         _data = param1;
      }
   }
}

