package consortia.view.club
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaSearchFrame extends Frame
   {
      
      private var _creatConsortiaBtn:IconButton;
      
      private var _data:ConsortiaModel;
      
      private var _contorller:ConsortiaControler;
      
      private var _rightView:ConsortiaSearchRightView;
      
      private var _leftView:ConsortiaSeachLeftView;
      
      public function ConsortiaSearchFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchFrame.titleText");
         _contorller = FrameControllerManager.instance.consortiaController;
         _data = _contorller.model;
         _creatConsortiaBtn = ComponentFactory.Instance.creatComponentByStylename("core.creatConsortiaBtn");
         _leftView = new ConsortiaSeachLeftView(_contorller,_data);
         _rightView = new ConsortiaSearchRightView(_data);
         addToContent(_rightView);
         addToContent(_leftView);
         addToContent(_creatConsortiaBtn);
         stopConsortiaBtn();
      }
      
      private function stopConsortiaBtn() : void
      {
         ConsortiaManager.instance.isFirstRecord = false;
         MainToolBar.instance.consortiaButtonShine = false;
      }
      
      private function uninit() : void
      {
         _leftView = null;
         _rightView = null;
         _creatConsortiaBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _creatConsortiaBtn.addEventListener("click",__onCreatHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_creatConsortiaBtn)
         {
            _creatConsortiaBtn.removeEventListener("click",__onCreatHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onCreatHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:CreatConsortiaFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.CreatConsortiaFrame");
         _loc2_.show();
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

