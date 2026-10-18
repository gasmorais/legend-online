package room.view.pve
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import room.net.RoomSocketOuterManager;
   import yishi.keyboard.KeyBoardRegister;
   
   public class CrossMatchAlertFrame extends Frame
   {
      
      private var lightBg:Bitmap;
      
      private var campaignName:FilterFrameText;
      
      private var contentText:FilterFrameText;
      
      private var leftTimeImage:Bitmap;
      
      private var leftTimeText:FilterFrameText;
      
      private var confirmBtn:IconButton;
      
      private var cancleBtn:IconButton;
      
      private var _timer:Timer;
      
      private var leftCount:int = 45;
      
      private var _data:Object;
      
      public function CrossMatchAlertFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         campaignName = ComponentFactory.Instance.creatComponentByStylename("CrossMatchAlertFrame.campaignName");
         lightBg = ComponentFactory.Instance.creatBitmap("asset.CrossMatchAlertFrame.lightBg");
         contentText = ComponentFactory.Instance.creatComponentByStylename("CrossMatchAlertFrame.contentText");
         leftTimeImage = ComponentFactory.Instance.creatBitmap("asset.CrossMatchAlertFrame.leftTimeImage");
         leftTimeText = ComponentFactory.Instance.creatComponentByStylename("CrossMatchAlertFrame.leftTimeText");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("CrossMatchAlertFrame.confirmBtn");
         cancleBtn = ComponentFactory.Instance.creatComponentByStylename("CrossMatchAlertFrame.cancleBtn");
         addToContent(campaignName);
         addToContent(lightBg);
         addToContent(contentText);
         addToContent(leftTimeImage);
         addToContent(leftTimeText);
         addToContent(confirmBtn);
         addToContent(cancleBtn);
         leftTimeText.text = leftCount.toString();
         _timer = new Timer(1000);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         confirmBtn.addEventListener("click",__confirmClick);
         cancleBtn.addEventListener("click",__cancleClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(confirmBtn)
         {
            confirmBtn.removeEventListener("click",__confirmClick);
         }
         if(cancleBtn)
         {
            cancleBtn.removeEventListener("click",__cancleClick);
         }
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         campaignName.text = _data.campaignName;
         contentText.text = LanguageMgr.GetTranslation("CrossMatchAlertFrame.contentText.text",_data.leftBoss,_data.totalBoss);
      }
      
      private function __updateLeftTimeHandler(param1:TimerEvent) : void
      {
         leftCount = leftCount - 1;
         if(leftCount <= 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
            RoomSocketOuterManager.sendCrossAlertResult(0,_data.campaignUid,_data.roomId);
            dispose();
         }
         else
         {
            leftTimeText.text = leftCount.toString();
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               RoomSocketOuterManager.sendCrossAlertResult(0,_data.campaignUid,_data.roomId);
               dispose();
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RoomSocketOuterManager.sendCrossAlertResult(1,_data.campaignUid,_data.roomId);
         dispose();
      }
      
      private function __cancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         RoomSocketOuterManager.sendCrossAlertResult(0,_data.campaignUid,_data.roomId);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         this.titleText = LanguageMgr.GetTranslation("CrossMatchAlertFrame.title.Text");
         _timer.start();
         _timer.addEventListener("timer",__updateLeftTimeHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
            _timer = null;
         }
         if(campaignName)
         {
            ObjectUtils.disposeObject(campaignName);
         }
         campaignName = null;
         if(lightBg)
         {
            ObjectUtils.disposeObject(lightBg);
         }
         lightBg = null;
         if(contentText)
         {
            ObjectUtils.disposeObject(contentText);
         }
         contentText = null;
         if(leftTimeImage)
         {
            ObjectUtils.disposeObject(leftTimeImage);
         }
         leftTimeImage = null;
         if(leftTimeText)
         {
            ObjectUtils.disposeObject(leftTimeText);
         }
         leftTimeText = null;
         if(confirmBtn)
         {
            ObjectUtils.disposeObject(confirmBtn);
         }
         confirmBtn = null;
         if(cancleBtn)
         {
            ObjectUtils.disposeObject(cancleBtn);
         }
         cancleBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

