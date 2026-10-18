package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class DarkMazeController extends FrameController
   {
      
      public function DarkMazeController()
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
         if(_data.frameData)
         {
            _frame["show"](_data);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1 || _data.openType == 2 || _data.openType == 3)
         {
            return "darkmaze.darkMazeCommonFrame";
         }
         if(_data.openType == 4)
         {
            return "darkmaze.darkMazeSpringFrame";
         }
         if(_data.openType == 5)
         {
            return "darkmaze.darkMazeDemonFrame";
         }
         if(_data.openType == 6)
         {
            return "darkmaze.darkMazeLierenFrame";
         }
         if(_data.openType == 8)
         {
            return "darkmaze.darkMazeShapeAdjustmentFrame";
         }
         if(_data.openType == 7)
         {
            return "darkmaze.DarkMazeBuyFrame";
         }
         return "";
      }
   }
}

