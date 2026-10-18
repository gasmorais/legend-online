package mvc.controler
{
   import mvc.FrameController;
   
   public class GodsEveningController extends FrameController
   {
      
      public static const NODE_TYPE_1:int = 1;
      
      public static const NODE_TYPE_2:int = 2;
      
      public static const NODE_TYPE_3:int = 3;
      
      public static const RANK:int = 1;
      
      public static const CHECK_REWARD:int = 2;
      
      public static const GAME_OVER:int = 3;
      
      private var _isInGodsEveningFrame:Boolean = false;
      
      public function GodsEveningController()
      {
         super();
      }
      
      public function get isInGodsEveningFrame() : Boolean
      {
         return _isInGodsEveningFrame;
      }
      
      public function set isInGodsEveningFrame(param1:Boolean) : void
      {
         _isInGodsEveningFrame = param1;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "godsevening.GERankFrame";
            case 2:
               return "godsevening.GECheckRewardFrame";
            case 3:
               return "godsevening.GEGameOverFrame";
            default:
               return "godsevening.GEMainFrame";
         }
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 3)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function get preLoad() : Boolean
      {
         return super.preLoad;
      }
      
      override protected function startPreLoad() : void
      {
         super.startPreLoad();
      }
   }
}

