package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class HookAlertFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _text:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      public var mapId:int;
      
      public var nodeId:int;
      
      private var _callBack:Function;
      
      public function HookAlertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("campaign.HookAlertBack");
         _text = ComponentFactory.Instance.creatComponentByStylename("campaign.HookAlertTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.HookAlertStartBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.HookAlertHelpBtn");
         addToContent(_back);
         addToContent(_text);
         addToContent(_startBtn);
         addToContent(_helpBtn);
         _text.text = LanguageMgr.GetTranslation("map.campaign.view.frame.HookAlertFrame.text");
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.HookAlertFrame.title");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _startBtn.addEventListener("click",__startHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _startBtn.removeEventListener("click",__startHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __startHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_callBack != null)
         {
            _callBack(true,mapId,nodeId);
         }
         dispose();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.HookHelperFrame");
         _loc2_.show();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      public function show(param1:Function) : void
      {
         _callBack = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(_callBack != null)
         {
            _callBack = null;
         }
         super.dispose();
      }
   }
}

