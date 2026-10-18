package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class DemonLandController extends FrameController
   {
      
      public var openBlackFrame:Boolean;
      
      public function DemonLandController()
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
         openBlackFrame = true;
         if(String(_data.openType) == "1")
         {
            return "demonland.DemonLandFrame";
         }
         if(String(_data.openType) == "2")
         {
            return "demonland.DemonLandLevelSelectFrame";
         }
         if(String(_data.openType) == "3")
         {
            return "demonland.AwardView";
         }
         return "demonland.DemonLandFrame";
      }
      
      override protected function exitFrame() : void
      {
         openBlackFrame = false;
         super.exitFrame();
      }
   }
}

