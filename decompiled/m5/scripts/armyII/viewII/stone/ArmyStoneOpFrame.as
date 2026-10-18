package armyII.viewII.stone
{
   import armyII.viewII.stone.view.StoneOpView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   
   public class ArmyStoneOpFrame extends Frame implements IManualSize
   {
      
      private var _view:StoneOpView;
      
      public function ArmyStoneOpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,690,510);
      }
      
      private function initView() : void
      {
         _view = new StoneOpView();
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
         DragManager.getInstance().stopDrag();
         FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.SKILL_PANEL;
         FrameControllerManager.instance.armyController.setPreFrame("army",null,1);
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show(param1:Array) : void
      {
         titleText = LanguageMgr.GetTranslation("army.rune.fuwen");
         _view.needPlayOpenEffect = param1[1];
         _view.data = param1[0];
         FrameControllerManager.instance.armyController.currOpRuneInfo = param1[0];
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

