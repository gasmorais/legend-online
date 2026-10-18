package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import map.campaign.CampaignSocketOutManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   
   public class CrossCampaignKillOutFrame extends Frame
   {
      
      private var contentText:FilterFrameText;
      
      private var leftTimeImage:Image;
      
      private var leftTimeText:FilterFrameText;
      
      private var confirmBtn:IconButton;
      
      private var cancleBtn:IconButton;
      
      private var _content:String;
      
      private var _timer:Timer;
      
      private var leftCount:int = 45;
      
      public function CrossCampaignKillOutFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         contentText = ComponentFactory.Instance.creatComponentByStylename("CrossCampaignKillOutFrame.contentText");
         leftTimeImage = ComponentFactory.Instance.creatComponentByStylename("CrossCampaignKillOutFrame.leftTimeImage");
         leftTimeText = ComponentFactory.Instance.creatComponentByStylename("CrossCampaignKillOutFrame.leftTimeText");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("CrossCampaignKillOutFrame.confirmBtn");
         cancleBtn = ComponentFactory.Instance.creatComponentByStylename("CrossCampaignKillOutFrame.cancleBtn");
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
      
      private function __updateLeftTimeHandler(param1:TimerEvent) : void
      {
         leftCount = leftCount - 1;
         if(leftCount <= 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
            CampaignSocketOutManager.instance.sendCrossCmapignKillOutSelect(0,playInfo.serviceName);
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
               CampaignSocketOutManager.instance.sendCrossCmapignKillOutSelect(0,playInfo.serviceName);
               dispose();
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         CampaignSocketOutManager.instance.sendCrossCmapignKillOutSelect(1,playInfo.serviceName);
         dispose();
      }
      
      private function __cancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CampaignSocketOutManager.instance.sendCrossCmapignKillOutSelect(0,playInfo.serviceName);
         dispose();
      }
      
      public function set content(param1:String) : void
      {
         _content = param1;
         contentText.text = _content;
      }
      
      public function show() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.getInstanceByStyleName("crossCampaign.CrossCampaignKillOutFrame") as CrossCampaignKillOutFrame;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         ComponentFactory.Instance.addInstanceByStyleName("crossCampaign.CrossCampaignKillOutFrame",this);
         this.titleText = LanguageMgr.GetTranslation("public.prompt");
         _timer.start();
         _timer.addEventListener("timer",__updateLeftTimeHandler);
      }
      
      private function get playInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ComponentFactory.Instance.removeInstanceByStyleName("crossCampaign.CrossCampaignKillOutFrame");
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
            _timer = null;
         }
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

