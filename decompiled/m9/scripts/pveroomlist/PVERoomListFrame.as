package pveroomlist
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import pveroomlist.view.PVEPlayerListView;
   import pveroomlist.view.PVERoomListView;
   
   public class PVERoomListFrame extends Frame
   {
      
      private var _roomListView:PVERoomListView;
      
      private var _playerListView:PVEPlayerListView;
      
      public function PVERoomListFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _roomListView = ComponentFactory.Instance.creatCustomObject("pveroomlist.CampaignRoomListView");
         _playerListView = ComponentFactory.Instance.creatCustomObject("pveroomlist.CampaignPlayerListView");
         addToContent(_roomListView);
         addToContent(_playerListView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("pveroomlist.PVERoomListFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
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
      
      public function getCreateBtn() : BaseButton
      {
         return _playerListView.createBtn;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

