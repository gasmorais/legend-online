package war2023.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import war2023.ui.SecretwarRightTopUI;
   
   public class SecretwarRightView extends Sprite
   {
      
      private var _topUI:SecretwarRightTopUI;
      
      private var _bottomView:SecretwarRightBottomView;
      
      private var _hideBtn:BaseButton;
      
      private var _isHide:Boolean = false;
      
      public function SecretwarRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _topUI = new SecretwarRightTopUI();
         _bottomView = new SecretwarRightBottomView();
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.HideBtn");
         addChild(_topUI);
         addChild(_bottomView);
         addChild(_hideBtn);
         _bottomView.y = 37;
      }
      
      private function initEvent() : void
      {
         _hideBtn.addEventListener("click",onHideBtnClick);
      }
      
      private function removeEvent() : void
      {
         _hideBtn.removeEventListener("click",onHideBtnClick);
      }
      
      private function onHideBtnClick(param1:MouseEvent) : void
      {
         _isHide = !_isHide;
         if(_isHide)
         {
            _hideBtn.scaleX = -1;
            TweenLite.to(_hideBtn,0.5,{
               "x":165,
               "scaleX":-1
            });
            TweenLite.to(_bottomView,0.5,{"x":173});
         }
         else
         {
            _hideBtn.scaleX = 1;
            TweenLite.to(_hideBtn,0.5,{
               "x":140,
               "scaleX":1
            });
            TweenLite.to(_bottomView,0.5,{"x":0});
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_topUI);
         _topUI = null;
         if(_bottomView)
         {
            TweenLite.killTweensOf(_bottomView);
         }
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         if(_hideBtn)
         {
            TweenLite.killTweensOf(_hideBtn);
         }
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

