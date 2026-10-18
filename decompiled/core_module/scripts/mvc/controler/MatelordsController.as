package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class MatelordsController extends FrameController
   {
      
      public static const RANK:int = 1;
      
      public static const DEMON_SHOP:int = 3;
      
      public function MatelordsController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "matelords.MatelordsRankFrame";
            case 3:
               return "matelords.room.MatelordsDemonShopFrame";
            default:
               return "matelords.MatelordsFrame";
         }
      }
      
      public function openFormationFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.MatelordsSortFrame");
         _loc1_["show"]();
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

