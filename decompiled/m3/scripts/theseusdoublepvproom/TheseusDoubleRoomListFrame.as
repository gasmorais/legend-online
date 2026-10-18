package theseusdoublepvproom
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import yishi.manager.FrameControllerManager;
   
   public class TheseusDoubleRoomListFrame extends Frame
   {
      
      private var _roomListView:TheseusDoubleRoomListView;
      
      private var _playerListView:TheseusPlayerListView;
      
      public function TheseusDoubleRoomListFrame()
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
         _roomListView = ComponentFactory.Instance.creatCustomObject("theseusdoublepvproom.TheseusDoubleRoomListView");
         _playerListView = ComponentFactory.Instance.creatCustomObject("theseusdoublepvproom.TheseusPlayerListView");
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
         titleText = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.title");
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
         FrameControllerManager.instance.theseusRoomListControler.searchId = 0;
         super.dispose();
      }
   }
}

