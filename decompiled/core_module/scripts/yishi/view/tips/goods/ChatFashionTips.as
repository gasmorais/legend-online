package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   
   public class ChatFashionTips extends FashionCardTip
   {
      
      private var _closeBtn:BaseButton;
      
      public function ChatFashionTips()
      {
         super();
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function init() : void
      {
         super.init();
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("tips.ChatEquipCloseBtn");
         _closeBtn.x = 270;
         _closeBtn.y = 0;
         addChild(_closeBtn);
         initEvent();
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         removeEvent();
         dispose();
      }
      
      override protected function updateTransform() : void
      {
         super.updateTransform();
         _closeBtn.x = _bg.width - _closeBtn.width;
      }
      
      override public function dispose() : void
      {
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

