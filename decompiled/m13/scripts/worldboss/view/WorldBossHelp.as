package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class WorldBossHelp extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _desc:Bitmap;
      
      private var _btn:TextButton;
      
      public function WorldBossHelp()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("worldboss.worldbossHelperBack");
         _desc = ComponentFactory.Instance.creatBitmap("worldboss.worldbossHelpertxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("worldboss.worldbossHelperBtn");
         addToContent(_back);
         addToContent(_desc);
         addToContent(_btn);
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
         titleText = LanguageMgr.GetTranslation("worldboss.view.WorldBossHelp.title");
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      override public function set closestyle(param1:String) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
      }
   }
}

