package armyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class SkillHelpFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _helpText:FilterFrameText;
      
      private var _confirm:TextButton;
      
      public function SkillHelpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.SkillHelpBack");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("army.SkillHelpConfirmBtn");
         _confirm.text = LanguageMgr.GetTranslation("public.confirm");
         _helpText = ComponentFactory.Instance.creatComponentByStylename("armyII.HelpContentTxt");
         _helpText.htmlText = LanguageMgr.GetTranslation("armyII.SkillHelpFrame.helpContent");
         addToContent(_bg);
         addToContent(_helpText);
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
         ObjectUtils.disposeObject(_helpText);
         _helpText = null;
         super.dispose();
      }
   }
}

