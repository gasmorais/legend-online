package yishi.view.base
{
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   
   public class ConsortiaSelectedButton extends SelectedCheckButton
   {
      
      public function ConsortiaSelectedButton()
      {
         super();
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         if(_field is FilterFrameText)
         {
            DisplayUtils.setFrame(_field,param1);
         }
      }
   }
}

