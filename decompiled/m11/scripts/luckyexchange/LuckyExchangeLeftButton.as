package luckyexchange
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.LuckExchangeTempMsg;
   
   public class LuckyExchangeLeftButton extends SelectedIconTextButton
   {
      
      private var _data:LuckExchangeTempMsg;
      
      private var _gradientText:GradientText;
      
      public function LuckyExchangeLeftButton()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         _gradientText = ComponentFactory.Instance.creatComponentByStylename("luckyexchangeLeftButton.title");
         addChild(_gradientText);
         _gradientText.visible = false;
      }
      
      public function set data(param1:LuckExchangeTempMsg) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         text = _data.name;
      }
      
      public function get data() : LuckExchangeTempMsg
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
         _data = null;
         super.dispose();
      }
   }
}

