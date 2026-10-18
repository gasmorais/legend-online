package friends.view
{
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   
   public class FriendSelectedButton extends SelectedCheckButton
   {
      
      public function FriendSelectedButton()
      {
         super();
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         if(_field is FilterFrameText && !selected)
         {
            DisplayUtils.setFrame(_field,param1);
         }
      }
   }
}

