package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SharedManager;
   
   public class MultiFailedAlertFrame extends Frame
   {
      
      private var _confirm:BaseButton;
      
      private var _content:FilterFrameText;
      
      private var _checkBtm:SelectedButton;
      
      private var _text:FilterFrameText;
      
      public function MultiFailedAlertFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _confirm = ComponentFactory.Instance.creatComponentByStylename("core.MultiFailedAlertConfirmBtn");
         _content = ComponentFactory.Instance.creatComponentByStylename("core.MultiFailedAlertTextStyle");
         _checkBtm = ComponentFactory.Instance.creatComponentByStylename("core.MultiFailedCheckBtn");
         _text = ComponentFactory.Instance.creatComponentByStylename("core.MultiFailedCheckTxt");
         _text.text = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc1_:String = LanguageMgr.GetTranslation("Campaign.MultiFailedAlert");
         _content.text = _loc1_;
         addToContent(_confirm);
         addToContent(_content);
         addToContent(_text);
         addToContent(_checkBtm);
      }
      
      public function show() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.prompt");
         titleText = _loc1_;
         _content.width = 330;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,0,true,true,2);
         addEventListener("response",__responseHandler);
         _confirm.addEventListener("click",onConfirmClick);
      }
      
      private function onConfirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.instance.multiFailded = _checkBtm.selected;
         SharedManager.instance.multiFaildedCheckDate = new Date();
         SharedManager.instance.saveMultiFailedCheck();
         dispose();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         if(_confirm)
         {
            _confirm.removeEventListener("click",onConfirmClick);
         }
         removeEventListener("response",__responseHandler);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

