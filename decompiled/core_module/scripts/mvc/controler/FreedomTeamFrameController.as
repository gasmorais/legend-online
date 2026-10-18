package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class FreedomTeamFrameController extends FrameController
   {
      
      public function FreedomTeamFrameController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "OPEN_INVITEFRAME")
         {
            return "team.FreedomTeamInviteFrame";
         }
         if(_data && _data.openType == "OPEN_SORTFRAME")
         {
            return "team.FreedomTeamSortFrame";
         }
         return "team.FreedomTeamManageFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

