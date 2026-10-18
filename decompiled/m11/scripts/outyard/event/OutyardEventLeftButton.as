package outyard.event
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadActiveMsg;
   import manager.LanguageMgr;
   
   public class OutyardEventLeftButton extends SelectedIconTextButton
   {
      
      private var _data:HugeHeadActiveMsg;
      
      private var _gradientText:GradientText;
      
      public function OutyardEventLeftButton()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         _gradientText = ComponentFactory.Instance.creatComponentByStylename("outyardEventLeftButton.title");
         addChild(_gradientText);
         _gradientText.visible = false;
      }
      
      public function set data(param1:HugeHeadActiveMsg) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         text = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.titleTxt" + param1.type);
      }
      
      public function get data() : HugeHeadActiveMsg
      {
         return _data;
      }
      
      override public function set text(param1:String) : void
      {
         _gradientText.text = param1;
         if(_text)
         {
            _text.text = param1;
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(!_text)
         {
            return;
         }
         if(param1)
         {
            _text.setFrame(2);
            _text.visible = false;
            _gradientText.visible = true;
         }
         else
         {
            _text.setFrame(1);
            _text.visible = true;
            _gradientText.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_gradientText);
         _gradientText = null;
         _data = null;
         super.dispose();
      }
   }
}

