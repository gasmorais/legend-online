package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.scene.SceneManager;
   import yishi.view.community.LoadingSceneView;
   
   public class SpaceController extends FrameController
   {
      
      public static const MAP:int = 1;
      
      public static const DIALOG:int = 2;
      
      public static const PETLAND_MAP:int = 3;
      
      public static const MINERAL_MAP:int = 4;
      
      public static const BATTLE_CD_VIEW:int = 5;
      
      public static const GODSEVENING_MAP:int = 7;
      
      public function SpaceController()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "map.space.SpaceMapFrame";
            case 2:
               return "map.space.SpaceDialogFrame";
            case 3:
            case 4:
               break;
            case 5:
               return "map.space.view.frame.BattleCDViewFrame";
            case 7:
               return "map.campaign.view.frame.GodsEveningMapFrame";
            default:
               return "map.space.SpaceMapFrame";
         }
         return "campaign.CampaignMapFrame";
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
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         switch(param1.openType)
         {
            case 3:
            case 4:
            case 7:
               if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
               {
                  super.start(param1);
               }
               break;
            case 5:
               super.start(param1);
               break;
            default:
               if(SceneManager.instance.currentType == "SPACE_SCENE")
               {
                  super.start(param1);
               }
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == 2)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

