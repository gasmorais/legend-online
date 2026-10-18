package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import managers.MountsManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class MountsController extends FrameController
   {
      
      public function MountsController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(String(_data.openType) == "1")
         {
            return "mounts.MountsFrame";
         }
         if(String(_data.openType) == "2")
         {
            return "mounts.WildSoulFrame";
         }
         if(String(_data.openType) == "3")
         {
            return "mountrefiningsoul.MountRefiningSoulFrame";
         }
         return "mounts.MountsFrame";
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < MountsManager.instance.isShineArray.length)
         {
            if(MountsManager.instance.isShineArray[_loc3_] != 0)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            param1.openType = "2";
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         if(String(_data.openType) == "2")
         {
            if(_data.frameData)
            {
               _frame["showPromotionView"](int(_data.frameData));
            }
         }
      }
      
      override protected function exitFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         super.exitFrame();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

