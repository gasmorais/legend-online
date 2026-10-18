package guidetask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.GuideTaskManager;
   
   public class GuideTaskButton extends SelectedButton
   {
      
      private var _gradientText:GradientText;
      
      private var _getIcon:Bitmap;
      
      private var _state:Boolean;
      
      private var _text:String = "";
      
      public function GuideTaskButton()
      {
         super();
      }
      
      public function set state(param1:Boolean) : void
      {
         if(_getIcon)
         {
            ObjectUtils.disposeObject(_getIcon);
            _getIcon = null;
         }
         _getIcon = ComponentFactory.Instance.creatBitmap("asset.guidetask.getIcon");
         addChild(_getIcon);
         if(param1)
         {
            _getIcon.visible = true;
         }
         else
         {
            _getIcon.visible = false;
         }
         if(GuideTaskManager.instance.model.statu == 0)
         {
            _getIcon.visible = false;
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         setGradientText(_text,param1);
      }
      
      public function setGradientText(param1:String, param2:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         if(_gradientText)
         {
            removeChild(_gradientText);
            ObjectUtils.disposeObject(_gradientText);
            _gradientText = null;
         }
         if(param2)
         {
            _gradientText = ComponentFactory.Instance.creatComponentByStylename("guidetask.btnTxt02");
         }
         else
         {
            _gradientText = ComponentFactory.Instance.creatComponentByStylename("guidetask.btnTxt01");
         }
         _text = param1;
         _gradientText.text = param1;
         addChild(_gradientText);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_gradientText)
         {
            ObjectUtils.disposeObject(_gradientText);
            _gradientText = null;
         }
         if(_getIcon)
         {
            ObjectUtils.disposeObject(_getIcon);
            _getIcon = null;
         }
      }
   }
}

