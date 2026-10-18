package friends.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class FriendsHelpFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _content:Bitmap;
      
      private var _confirm:TextButton;
      
      public function FriendsHelpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _content = ComponentFactory.Instance.creatBitmap("asset.friends.FriendsHelp");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.friendsHelpBack");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("friends.friendsHelpConfirmBtn");
         _confirm.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_bg);
         addToContent(_content);
         addToContent(_confirm);
         titleText = LanguageMgr.GetTranslation("friends.view.FriendsHelpFrame.title");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResposeHandler);
         _confirm.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResposeHandler);
         _confirm.removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __frameResposeHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_content);
         _content = null;
         super.dispose();
      }
   }
}

