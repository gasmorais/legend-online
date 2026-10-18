package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import mvc.FrameController;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class BattleMountController extends FrameController
   {
      
      public static const BATTLE_MOUNT_MAIN_FRAME:String = "BATTLE_MOUNT_MAIN_FRAME";
      
      public static const BATTLE_MOUNT_CHANGE_FRAME:String = "BATTLE_MOUNT_CHANGE_FRAME";
      
      public static const BATTLE_MOUNT_COMPARE_FRAME:String = "BATTLE_MOUNT_COMPARE_FRAME";
      
      public function BattleMountController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = null;
         switch(_data.openType)
         {
            case "BATTLE_MOUNT_MAIN_FRAME":
               _loc1_ = "battleMount.BattleMountMainFrame";
               break;
            case "BATTLE_MOUNT_CHANGE_FRAME":
               _loc1_ = "battleMount.BattleMountChangeFrame";
               break;
            case "BATTLE_MOUNT_COMPARE_FRAME":
               _loc1_ = "battleMount.BattleMountCompareFrame";
               break;
            default:
               throw new Error("error frame type!");
         }
         return _loc1_;
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
         _frame["show"]();
         if(_data.openType != "BATTLE_MOUNT_MAIN_FRAME" && _data.openType != "BATTLE_MOUNT_COMPARE_FRAME")
         {
            setPreFrame(_data.moduleUIName,"BATTLE_MOUNT_MAIN_FRAME");
         }
      }
      
      override protected function exitFrame() : void
      {
         _frame.dispose();
         super.exitFrame();
      }
   }
}

