package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class ChildControler extends FrameController
   {
      
      public static const MAIN:String = "main";
      
      public static const GROWTH:String = "growth";
      
      public static const CARE:String = "care";
      
      public static const SELECT_JOB:String = "select_job";
      
      public static const HAND_IN:String = "handin";
      
      public static const DIVIDE:String = "divide";
      
      public static const LOOK_INFORMATION:String = "look_information";
      
      public static const EMBLEM_CHANGE:String = "emblem_change";
      
      public static const EMBLEM_UP:String = "emblem_up";
      
      public function ChildControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            param1.currentLoaded = 0;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "child.ChildFrame";
         if(_data && _data.openType == "main")
         {
            _loc1_ = "child.ChildFrame";
         }
         else if(_data && _data.openType == "growth")
         {
            _loc1_ = "child.attribute.ChildUpgradeGrowthView";
         }
         else if(_data && _data.openType == "care")
         {
            _loc1_ = "child.attribute.ChildCareFrame";
         }
         else if(_data && _data.openType == "select_job")
         {
            _loc1_ = "child.attribute.ChildSelectJobFrame";
         }
         else if(_data && _data.openType == "handin")
         {
            _loc1_ = "child.handin.ChildHandInFrame";
         }
         else if(_data && _data.openType == "look_information")
         {
            _loc1_ = "child.handin.ChildLookUpView";
         }
         else if(_data && _data.openType == "divide")
         {
            _loc1_ = "child.handin.ChildDivideFrame";
         }
         else if(_data && _data.openType == "emblem_change")
         {
            _loc1_ = "child.emblem.ChildEmblemChangeView";
         }
         else if(_data && _data.openType == "emblem_up")
         {
            if(_data.frameData.pos == 0)
            {
               _loc1_ = "child.emblem.ChildEmblemUpGradeFrame";
            }
            else
            {
               _loc1_ = "child.emblem.ChildEmblemUpView";
            }
         }
         return _loc1_;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

