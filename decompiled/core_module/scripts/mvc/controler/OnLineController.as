package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class OnLineController extends FrameController
   {
      
      public function OnLineController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data)
         {
            switch(_data.openType)
            {
               case 14:
                  return "specialfunny.OnLineRewardFrame";
               case 50:
                  return "specialfunny.TimingRewardFrame";
               case 51:
                  return "specialfunny.karneval.KarnevalFrame";
            }
         }
         return "specialfunny.OnLineRewardFrame";
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
         _frame["show"](_data);
      }
   }
}

