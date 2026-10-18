package mvc.controler
{
   import mvc.FrameController;
   
   public class SkyTreasureController extends FrameController
   {
      
      public function SkyTreasureController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "skytreasure.SkyTreasureFrame";
         }
         if(_data.openType == 2)
         {
            return "skytreasure.pro.SkyTraesureProFrame";
         }
         if(_data.openType == 3)
         {
            return "skytreasure.reward.SkyTreasureCoinRankFrame";
         }
         if(_data.openType == 4)
         {
            return "skytreasure.rank.SkyTreasureRankFrame";
         }
         return "skytreasure.SkyTreasureFrame";
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
         if(_data.openType == 2 || _data.openType == 4)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
   }
}

