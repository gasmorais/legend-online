package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class DungeonexploController extends FrameController
   {
      
      private var _frameClassName:String;
      
      public function DungeonexploController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "dungenexploration.DungenexploFrame";
            case 2:
               return "dungenexploration.DungenexploTaskFrame";
            case 3:
               return "dungenexploration.DungenSkillBagFrame";
            default:
               return "view.subshop.DungenexShopFrame";
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
   }
}

