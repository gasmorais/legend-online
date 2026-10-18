package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   
   public class ElectionHelperView extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _desc:FilterFrameText;
      
      private var _btn:TextButton;
      
      public function ElectionHelperView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionHelperBg");
         _desc = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionHelpertxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionHelperViewBtn");
         _desc.htmlText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.help");
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.helpTitle");
         addToContent(_bg);
         addToContent(_desc);
         addToContent(_btn);
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      override public function set closestyle(param1:String) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(!isDie)
         {
            removeEvent();
            _bg = null;
            _desc = null;
            _btn = null;
            super.dispose();
         }
      }
   }
}

