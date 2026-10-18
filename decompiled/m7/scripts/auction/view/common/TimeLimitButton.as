package auction.view.common
{
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   
   public class TimeLimitButton extends SelectedButton
   {
      
      private var _text:String;
      
      public function TimeLimitButton()
      {
         super();
      }
      
      public function setText(param1:String) : void
      {
         _text = param1;
         if(_selectedButton)
         {
            TextButton(_selectedButton).text = _text;
         }
         if(_unSelectedButton)
         {
            TextButton(_unSelectedButton).text = _text;
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_text)
         {
            setText(_text);
         }
      }
   }
}

