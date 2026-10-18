package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class NavigationControler extends FrameController
   {
      
      public function NavigationControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "navigation.NavigationFrame";
         }
         if(_data.openType == 2)
         {
            return "navigation.NavigationBoatFrame";
         }
         if(_data.openType == 3)
         {
            return "navigation.NavigationPortFrame";
         }
         if(_data.openType == 4)
         {
            return "navigation.NavigationInviteFrame";
         }
         if(_data.openType == 5)
         {
            return "navigation.NavigationBoatPreviewFrame";
         }
         if(_data.openType == 6)
         {
            return "navigation.NavigationBoatPatrolFrame";
         }
         if(_data.openType == 7)
         {
            return "navigation.NavigationBoatPatrolFrameII";
         }
         return "navigation.NavigationFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData && _data.openType != null)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

