package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   
   public class ChatMonsterAccesoriesTips extends MonsterAccessoriesTips
   {
      
      private var _closeBtn:BaseButton;
      
      public function ChatMonsterAccesoriesTips()
      {
         super();
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function init() : void
      {
         super.init();
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("tips.ChatEquipCloseBtn");
         addChild(_closeBtn);
         initEvent();
         _totalBox.x = 10;
         _totalBox.y = 10;
      }
      
      override protected function updateTransform() : void
      {
         super.updateTransform();
         if(tipData)
         {
            _closeBtn.x = _bg.width - 15;
            _closeBtn.y = 0;
         }
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
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

