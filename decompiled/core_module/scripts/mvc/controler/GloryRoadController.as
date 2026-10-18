package mvc.controler
{
   import mvc.FrameController;
   
   public class GloryRoadController extends FrameController
   {
      
      public static const GLORY_ROAD_DIFFICULTY:String = "glory_road_difficulty";
      
      public static const GLORY_ROAD_BUFF:String = "glory_road_buff";
      
      public static const GLORY_ROAD_TREASURE:String = "glory_road_treasure";
      
      public static const GLORY_ROAD_SCORE:String = "glory_road_score";
      
      public function GloryRoadController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "glory_road_difficulty")
         {
            return "gloryroad.view.GloryRoadDifficultyFrame";
         }
         if(_data.openType == "glory_road_buff")
         {
            return "gloryroad.view.GloryRoadBuffFrame";
         }
         if(_data.openType == "glory_road_treasure")
         {
            return "gloryroad.view.GloryRoadTreasureFrame";
         }
         if(_data.openType == "glory_road_score")
         {
            return "gloryroad.view.GloryRoadScoreFrame";
         }
         return "gloryroad.GloryRoadFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function closeFrame() : void
      {
         _frame.dispose();
         _frame = null;
      }
   }
}

