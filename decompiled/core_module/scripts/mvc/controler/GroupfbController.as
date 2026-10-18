package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GroupfbController extends FrameController
   {
      
      public function GroupfbController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "groupfb.GroupfbRoomListFrame";
         }
         if(_data.openType == 2)
         {
            return "groupfb.GroupfbTeamFrame";
         }
         if(_data.openType == 3)
         {
            return "groupfb.GroupfbRoomSearchFrame";
         }
         return "groupfb.GroupfbRoomListFrame";
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
   }
}

