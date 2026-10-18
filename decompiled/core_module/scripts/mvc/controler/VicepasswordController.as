package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.manager.FrameControllerManager;
   
   public class VicepasswordController extends FrameController
   {
      
      public static const VIEW_SET:int = 1;
      
      public static const VIEW_CHANGE:int = 2;
      
      public static const VIEW_CHECK:int = 3;
      
      public function VicepasswordController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      public function startFrameByType(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vicepassword",null,param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "vicepassword.setvpviewui";
            case 2:
               return "vicepassword.changevpview";
            case 3:
               return "vicepassword.checkvpview";
            default:
               return "vicepassword.setvpviewui";
         }
      }
   }
}

