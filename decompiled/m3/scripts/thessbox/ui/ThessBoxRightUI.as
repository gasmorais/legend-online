package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ThessBoxRightUI extends Sprite
   {
      
      protected var _rightBtn1:BaseButton;
      
      protected var _rightBtn2:BaseButton;
      
      public function ThessBoxRightUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _rightBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rightBtn1");
         _rightBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rightBtn2");
         addChild(_rightBtn1);
         addChild(_rightBtn2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rightBtn1);
         _rightBtn1 = null;
         ObjectUtils.disposeObject(_rightBtn2);
         _rightBtn2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

