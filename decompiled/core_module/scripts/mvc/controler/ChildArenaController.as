package mvc.controler
{
   import mvc.FrameController;
   
   public class ChildArenaController extends FrameController
   {
      
      public static const SIGN_FRAME:String = "SIGN_FRAME";
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const FORMATION_FRAME:String = "FORMATION_FRAME";
      
      public function ChildArenaController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "childarena.ChildArenaSignFrame";
         if(_data && _data.openType == "SIGN_FRAME")
         {
            _loc1_ = "childarena.ChildArenaSignFrame";
         }
         else if(_data && _data.openType == "MAIN_FRAME")
         {
            _loc1_ = "childarena.ChildArenaMainFrame";
         }
         else if(_data && _data.openType == "FORMATION_FRAME")
         {
            _loc1_ = "child.commonFormationFrame";
         }
         return _loc1_;
      }
   }
}

