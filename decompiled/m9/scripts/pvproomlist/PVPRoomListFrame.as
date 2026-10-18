package pvproomlist
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import pvproomlist.view.PVPPlayerListView;
   import pvproomlist.view.PVPRoomListView;
   
   public class PVPRoomListFrame extends Frame
   {
      
      private var _roomListView:PVPRoomListView;
      
      private var _playerListView:PVPPlayerListView;
      
      public function PVPRoomListFrame()
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
         _roomListView = ComponentFactory.Instance.creatCustomObject("pvproomlist.PVPRoomListView");
         _playerListView = ComponentFactory.Instance.creatCustomObject("pvproomlist.PVPPlayerListView");
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
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.pvpBtnIipData");
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_roomListView);
         _roomListView = null;
         ObjectUtils.disposeObject(_playerListView);
         _playerListView = null;
         super.dispose();
      }
   }
}

