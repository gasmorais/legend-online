package steel.view.search
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   
   public class SteelSearchFrame extends Frame
   {
      
      private var _rightView:SteelSearchRightView;
      
      private var _leftView:SteelSeachLeftView;
      
      private var _controller:SteelController = FrameControllerManager.instance.steelController;
      
      private var _model:SteelModel = _controller.model;
      
      public function SteelSearchFrame()
      {
         super();
         initView();
         addEvent();
         _controller.sendSteelListTeams();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.titleText");
         _leftView = new SteelSeachLeftView();
         _rightView = new SteelSearchRightView();
         addToContent(_rightView);
         addToContent(_leftView);
      }
      
      private function uninitView() : void
      {
         _leftView = null;
         _rightView = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("STEEL_INFO_CHANGE",__steelInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _model.removeEventListener("STEEL_INFO_CHANGE",__steelInfoChangeHandler);
      }
      
      private function __steelInfoChangeHandler(param1:SteelEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_model.selfTeamUid))
         {
            return;
         }
         dispose();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

