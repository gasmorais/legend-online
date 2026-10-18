package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.ylex.ChildCampInfo;
   
   public class YLExpeditionController extends FrameController
   {
      
      private var _info:ChildCampInfo;
      
      public function YLExpeditionController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _info = param1.frameData as ChildCampInfo;
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["data"] = _info;
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "ylex.YLExpeditionMainFrame";
         }
         if(_data.openType == 2)
         {
            return "ylex.YLXpedtionYeildFrame";
         }
         if(_data.openType == 3)
         {
            return "ylex.YLExpedtionChooseFrame";
         }
         if(_data.openType == 4)
         {
            return "ylex.YLExpedtionFightInfoFrame";
         }
         if(_data.openType == 5)
         {
            return "ylex.YLEpedtionRewardFrame";
         }
         return "ylex.YLExpeditionMainFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

