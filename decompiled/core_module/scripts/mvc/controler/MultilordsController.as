package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class MultilordsController extends FrameController
   {
      
      public static const BET:int = 1;
      
      public static const BET_SELECT:int = 2;
      
      public static const WIN_PRIZES:int = 3;
      
      public static const CHECK_REWARD:int = 4;
      
      public static const RANK:int = 5;
      
      public static const PrelimReport:int = 6;
      
      public static const FinalReport:int = 7;
      
      public static const Worship:int = 8;
      
      public static const VIEW_LIST:int = 9;
      
      public var _isInWorship:Boolean = false;
      
      public function MultilordsController()
      {
         super();
      }
      
      public function set isInWorship(param1:Boolean) : void
      {
         _isInWorship = param1;
      }
      
      public function get isInWorship() : Boolean
      {
         return _isInWorship;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "multilords.MultilordsBetFrame";
            case 2:
               return "multilords.MultilordsBetSelectFrame";
            case 3:
               return "multilords.MultilordsWinPrizesFrame";
            case 4:
               return "multilords.MultilordsCheckRewardFrame";
            case 5:
               return "multilords.MultilordsRankFrame";
            case 6:
               return "multilords.MultilordsPrelimReportFrame";
            case 7:
               return "multilords.MultilordsFinalReportFrame";
            case 8:
               return "multilords.MultilordsWorshipFrame";
            case 9:
               return "multilords.MultilordsBattleViewFrame";
            default:
               return "multilords.MultilordsFrame";
         }
      }
      
      override protected function createFrame() : void
      {
         var _loc1_:String = frameClassName;
         LayerManager.Instance.clickPos = MainToolBar.instance.getBtnPos(_loc1_);
         _frame = ComponentFactory.Instance.createComponentGroupByStylename(_loc1_,true,_data.frameData as Array);
         if(_frame)
         {
            if(!_frame.isDie)
            {
               showFrame();
            }
            else
            {
               _frame = null;
            }
         }
         if(_isLoadingLock)
         {
            LoadingSceneView.instance.hide();
         }
         _isLoadingLock = false;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frame)
         {
            if(_data && _frame.hasOwnProperty("data"))
            {
               _frame["data"] = _data.frameData;
            }
            _frame["show"]();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

