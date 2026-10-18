package mvc.controler
{
   import mvc.FrameController;
   
   public class SettingControler extends FrameController
   {
      
      public function SettingControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "setting.settingFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
   }
}

