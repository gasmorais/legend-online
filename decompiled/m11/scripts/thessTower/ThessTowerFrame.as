package thessTower
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
   import thessTower.view.ThesstowerView;
   import yishi.datas.ComponentGroupType;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ThessTowerFrame extends Frame
   {
      
      private var _view:ThesstowerView;
      
      private var _helpBtn:BaseButton;
      
      public function ThessTowerFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new ThesstowerView();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("thesstower.helpBtn");
         addToContent(_view);
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("thesstower.helpFrame");
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
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("thesstower.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

