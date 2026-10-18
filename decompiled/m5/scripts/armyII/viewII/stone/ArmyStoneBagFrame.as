package armyII.viewII.stone
{
   import armyII.viewII.stone.view.StoneBagOPView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   
   public class ArmyStoneBagFrame extends Frame
   {
      
      private var _view:StoneBagOPView;
      
      public function ArmyStoneBagFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new StoneBagOPView();
         addToContent(_view);
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
      
      override public function dispose() : void
      {
         FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.SKILL_PANEL;
         FrameControllerManager.instance.armyController.setPreFrame("army",null,4);
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("army.stone.bagTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

