package mvc.controler
{
   import mvc.FrameController;
   
   public class CrossGuildControler extends FrameController
   {
      
      public static const SIGN_FRAME:int = 1;
      
      public static const POLICY_FRAME:int = 2;
      
      public static const WAR_TOWER_DETAIL:int = 7;
      
      public function CrossGuildControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "crossguild.CrossGuildSignFrame";
         }
         if(_data.openType == 2)
         {
            return "crossguild.CrossGuildPolicyFrame";
         }
         return "crossguild.CrossGuildSignFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
   }
}

