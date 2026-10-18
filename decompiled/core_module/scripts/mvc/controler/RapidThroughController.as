package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import managers.RapidThroughPassManager;
   import mvc.FrameController;
   import mvc.module.rapidThrough.RapidThroughModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.view.community.LoadingSceneView;
   
   public class RapidThroughController extends FrameController
   {
      
      public static const RAPID_THROUGH_RANK:int = 1;
      
      public function RapidThroughController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:Object = _data.openType;
         if(1 !== _loc1_)
         {
            return "";
         }
         return "rapidthrouh.RapidThrouhtRankFrame";
      }
      
      public function get model() : RapidThroughModel
      {
         return RapidThroughPassManager.instance.model;
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
      
      public function pageBtnHandler(param1:Boolean) : void
      {
         if(param1)
         {
            model.currentPage--;
         }
         else if(!param1)
         {
            model.currentPage++;
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

