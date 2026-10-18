package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import war2023.view.SecretWarEnterView;
   import yishi.datas.ComponentGroupType;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SecretwarEnterFrame extends Frame
   {
      
      private var _view:SecretWarEnterView;
      
      private var _helpBtn:BaseButton;
      
      public function SecretwarEnterFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new SecretWarEnterView();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("secretwar.enterFrame.HelpBtn");
         addToContent(_view);
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",helpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",helpHandler);
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("secretwar.enterFrame.helperFrame");
         _loc2_.show();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("secretwar.warEnter.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

