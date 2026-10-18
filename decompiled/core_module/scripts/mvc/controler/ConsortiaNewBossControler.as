package mvc.controler
{
   import mvc.FrameController;
   
   public class ConsortiaNewBossControler extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const CALL_FRAME:int = 2;
      
      public static const HELP_FRAME:int = 3;
      
      public function ConsortiaNewBossControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "newboss.ConsortiaNewBossFrame";
         }
         if(_data.openType == 2)
         {
            return "newboss.ConsortiaNewBossCallFrame";
         }
         if(_data.openType == 3)
         {
            return "newboss.ConsortiaNewBossHelpFrame";
         }
         return "";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
   }
}

