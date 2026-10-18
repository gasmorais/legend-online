package friends.findfriend
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class FindFriendFrame extends Frame
   {
      
      private var _scaleBg:Scale9CornerImage;
      
      private var _bg:Scale9CornerImage;
      
      private var _findFriendView:FindFriendView;
      
      public function FindFriendFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.im.IMFrame.addFriend");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("friends.FindFriendFrameScaleBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.FindFriendFrameBg");
         _findFriendView = ComponentFactory.Instance.creatCustomObject("friends.FindFriendView");
         addToContent(_scaleBg);
         addToContent(_bg);
         addToContent(_findFriendView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function removeAllPanelView() : void
      {
         if(_findFriendView && _findFriendView.parent)
         {
            _findFriendView.parent.removeChild(_findFriendView);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_scaleBg)
         {
            _scaleBg.dispose();
         }
         _scaleBg = null;
         if(_findFriendView)
         {
            _findFriendView.dispose();
         }
         _findFriendView = null;
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

