package magicpub
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.magicpub.MagicPubInfoMsg;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.MagicPubManager;
   import yishi.manager.NotificationManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MagicPubFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _listView:MagicPubListView;
      
      private var _chatView:MagicPubChatView;
      
      private var _giftWillView:MagicPubGiftWillView;
      
      private var _helpBtn:BaseButton;
      
      public function MagicPubFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,966,625);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("magicpub.MagicPubFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("magicpub.magicpubFrameBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.magicpub.Bg");
         _listView = ComponentFactory.Instance.creatCustomObject("magicpub.MagicPubListView");
         _chatView = ComponentFactory.Instance.creatCustomObject("magicpub.MagicPubChatView");
         _giftWillView = ComponentFactory.Instance.creatCustomObject("magicpub.MagicPubGiftWillView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubFrame.helpBtn");
         addToContent(_back);
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_listView);
         addToContent(_chatView);
         addToContent(_giftWillView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("MAGICPUB_OPEN_CHAT_VIEW",__openChatHandler);
         NotificationManager.instance.addEventListener("MAGICPUB_GIFTWILL_OPEN",__openGiftWillHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("MAGICPUB_OPEN_CHAT_VIEW",__openChatHandler);
         NotificationManager.instance.removeEventListener("MAGICPUB_GIFTWILL_OPEN",__openGiftWillHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __openChatHandler(param1:NotificationEvent) : void
      {
         var _loc2_:MagicPubInfoMsg = param1.data as MagicPubInfoMsg;
         if(_loc2_)
         {
            _listView.visible = false;
            _giftWillView.visible = false;
            _chatView.visible = true;
            _chatView.data = _loc2_;
         }
         else
         {
            _listView.visible = true;
            _giftWillView.visible = false;
            _chatView.visible = false;
            _chatView.data = null;
         }
      }
      
      private function __openGiftWillHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         showGiftWill(_loc2_);
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
      
      private function showGiftWill(param1:int = 0) : void
      {
         if(param1 == 3)
         {
            _listView.visible = _chatView.visible = _giftWillView.visible = false;
            _giftWillView.visible = true;
            MagicPubManager.instance.OperateGiftParty(8);
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_OPEN_CHAT_VIEW",null));
         }
      }
      
      public function show(param1:int = 0) : void
      {
         showGiftWill(param1);
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_chatView);
         _chatView = null;
         ObjectUtils.disposeObject(_giftWillView);
         _giftWillView = null;
         super.dispose();
      }
   }
}

