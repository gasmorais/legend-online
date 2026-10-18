package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class AresLordsController extends FrameController
   {
      
      public static const SIGNUP:int = 0;
      
      public static const START:int = 1;
      
      public static const RANK:int = 2;
      
      public static const REWARD:int = 3;
      
      public static const SKILL:int = 4;
      
      public function AresLordsController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 0:
               return "areslords.AresLordsSignUpFrame";
            case 1:
               return "areslords.AresLordsStartFrame";
            case 2:
               return "areslords.AresLordsRankFrame";
            case 3:
               return "areslords.AresLordsRewardFrame";
            case 4:
               return "areslords.AresLordsSkillFrame";
            default:
               return "areslords.AresLordsSignUpFrame";
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
      
      public function openFormationFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("warlords.room.WarlordsPetFormationFrame");
         _loc1_["show"]();
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

