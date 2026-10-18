package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.star.StarInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChatStarTip extends StarTip
   {
      
      private var _starIcon:BaseIconView;
      
      private var _closeBtn:BaseButton;
      
      public function ChatStarTip()
      {
         super();
         _starIcon = ComponentFactory.Instance.creatCustomObject("chat.StarItemIcon");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("tips.ChatEquipCloseBtn");
         addChild(_closeBtn);
         addChild(_starIcon);
         initEvent();
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:StarInfo = null;
         super.updateTransform();
         if(tipData)
         {
            _starIcon.x = 44;
            _starIcon.y = 33;
            _closeBtn.x = 109;
            _loc1_ = tipData as StarInfo;
            _starIcon.icon = IconFactory.getCommonIconPath(_loc1_.template.Icon);
            _starIcon.mouseChildren = _starIcon.mouseEnabled = false;
            _title.y = 53;
            _totalVBox.y = _title.y + _title.height;
            _bg.height = _totalVBox.y + _totalVBox.height + 10;
            _closeBtn.x = _bg.width - _closeBtn.width + 5;
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
         ObjectUtils.disposeObject(_starIcon);
         _starIcon = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_starIcon)
         {
            _starIcon.dispose();
         }
         _starIcon = null;
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

