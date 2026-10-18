package armyII.viewII.stone
{
   import armyII.viewII.stone.view.StoneDkView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ArmyStoneDKFrame extends Frame
   {
      
      private var _view:StoneDkView;
      
      private var _preBtn:BaseButton;
      
      public function ArmyStoneDKFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new StoneDkView();
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.preBtn");
         addToContent(_view);
         addToContent(_preBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("StoneDkView.closeEvent",viewNeedCloseHandler);
         _preBtn.addEventListener("click",preHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("StoneDkView.closeEvent",viewNeedCloseHandler);
         _preBtn.removeEventListener("click",preHandler);
      }
      
      private function preHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUSHI_PRE_VIEW;
         FrameControllerManager.instance.openControllerByInfo("army");
      }
      
      private function viewNeedCloseHandler(param1:Event) : void
      {
         dispose();
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
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         super.dispose();
      }
      
      public function show(param1:RuneInfo) : void
      {
         titleText = LanguageMgr.GetTranslation("army.stone.dkTite");
         _view.data = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

