package mvc.controler
{
   import mvc.FrameController;
   
   public class ChildNswarController extends FrameController
   {
      
      public static const TEAM:String = "TEAM";
      
      public static const REWARD:String = "REWARD";
      
      public static const RANK:String = "RANK";
      
      public static const BATTLE_RESULT:String = "BATTLE_RESULT";
      
      public static const BUY_TIME:String = "BUY_TIME";
      
      public function ChildNswarController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.frameData);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "";
         switch(_data.openType)
         {
            case "TEAM":
               _loc1_ = "childnswar.frame.ChildNswarTeamFrame";
               break;
            case "REWARD":
               _loc1_ = "childnswar.frame.ChildNswarRewardFrame";
               break;
            case "RANK":
               _loc1_ = "childnswar.frame.ChildNswarRankFrame";
               break;
            case "BATTLE_RESULT":
               _loc1_ = "childnswar.frame.ChildNswarResultFrame";
               break;
            case "BUY_TIME":
               _loc1_ = "childnswar.frame.ChildNswarBuyTimeFrame";
         }
         return _loc1_;
      }
   }
}

