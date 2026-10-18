package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class TeamSortControler extends FrameController
   {
      
      public static const GROUP_SORT_FRAME:String = "GROUP_SORT_FRAME";
      
      public static const MATELORDS_SORT_FRAME:String = "MATELORDS_SORT_FRAME";
      
      public static const GAME_HALL_SORT_FRAME:String = "GAME_HALL_SORT_FRAME";
      
      public function TeamSortControler()
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
         var _loc1_:String = null;
         if(_data.openType == "GROUP_SORT_FRAME")
         {
            _loc1_ = "teammanager.groupSortFrame";
         }
         else if(_data.openType == "MATELORDS_SORT_FRAME")
         {
            _loc1_ = "matelordsroom.MatelordsSortFrame";
         }
         else if(_data.openType == "GAME_HALL_SORT_FRAME")
         {
            _loc1_ = "gamehall.GameHallSortFrame";
         }
         else
         {
            _loc1_ = "core.TeamSortFrame";
         }
         return _loc1_;
      }
   }
}

