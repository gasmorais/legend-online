package mvc.controler
{
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class BraveLegController extends FrameController
   {
      
      public static const SIGNUP:int = 0;
      
      public static const TEAM:int = 1;
      
      public static const RANK:int = 2;
      
      public static const INVITE:int = 3;
      
      public static const MATRIX:int = 4;
      
      public function BraveLegController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return className(_data.openType.tab);
      }
      
      public function className(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "braveleg.BraveLegSignUpFrame";
            case 1:
               return "braveleg.BraveLegTeamFrame";
            case 2:
               return "braveleg.BraveLegRankFrame";
            case 3:
               return "braveleg.BraveLegInviteFrame";
            case 4:
               return "braveleg.BraveLegMatrixFrame";
            default:
               return "braveleg.BraveLegSignUpFrame";
         }
      }
      
      override protected function createFrame() : void
      {
         var _loc1_:String = frameClassName;
         LayerManager.Instance.clickPos = MainToolBar.instance.getBtnPos(_loc1_);
         if(_data.openType.refresh)
         {
            if(ComponentGroupManager.Instance.hasInstanceClass(_loc1_))
            {
               _frame = ComponentGroupManager.Instance.getInstanceByKey(_loc1_) as Frame;
            }
            else
            {
               _frame = ComponentFactory.Instance.createComponentGroupByStylename(_loc1_,true,_data.frameData as Array);
            }
         }
         else
         {
            _frame = ComponentFactory.Instance.createComponentGroupByStylename(_loc1_,true,_data.frameData as Array);
         }
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
   }
}

