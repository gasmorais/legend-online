package armyII
{
   import armyII.viewII.allocate.AllocateView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class AllocateFrame extends Frame
   {
      
      private var _allocateView:AllocateView;
      
      public function AllocateFrame()
      {
         super();
         initView();
         initEvent();
         control.setOldData();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _allocateView = ComponentFactory.Instance.creatCustomObject("army.AllocatePanel");
         addToContent(_allocateView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("armyII.AllocateFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      public function get allocateView() : AllocateView
      {
         return _allocateView;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_allocateView);
         _allocateView = null;
         super.dispose();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

