package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GameHallController extends FrameController
   {
      
      public static const OPEN_EAST_SHOP:String = "OPEN_EAST_SHOP";
      
      public static const EAST_SHOP_ANIMATION:String = "EAST_SHOP_ANIMATION";
      
      public static const EAST_SHOP_RESULT:String = "EAST_SHOP_RESULT";
      
      public static const EAST_SHOP_DESC:String = "EAST_SHOP_DESC";
      
      public function GameHallController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "OPEN_EAST_SHOP")
         {
            return "gamehall.GameHallEastShopFrame";
         }
         if(_data.openType == "EAST_SHOP_ANIMATION")
         {
            return "gamehall.GameHallEastShopAnimationFrame";
         }
         if(_data.openType == "EAST_SHOP_RESULT")
         {
            return "gamehall.GameHallEastShopResultFrame";
         }
         if(_data.openType == "EAST_SHOP_DESC")
         {
            return "gamehall.GameHallEastShopDescFrame";
         }
         return "gamehall.GameHallFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
         {
            _frame["isTeamViewState"] = Boolean(_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
   }
}

