package chat.view
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.utils.DisplayUtils;
   
   public class ChatPanelButton extends AbstractTextButton
   {
      
      public function ChatPanelButton()
      {
         super();
      }
      
      override public function setFrame(param1:int) : void
      {
         _currentFrameIndex = param1;
         DisplayUtils.setFrame(_back,_currentFrameIndex);
         if(_frameFilter == null || param1 <= 0 || param1 > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[param1 - 1];
      }
   }
}

