package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class HookHelperFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _descText:FilterFrameText;
      
      private var _btn:TextButton;
      
      public function HookHelperFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("campaign.HookHelperBack");
         _descText = ComponentFactory.Instance.creatComponentByStylename("campaign.HookHelpText");
         _descText.htmlText = LanguageMgr.GetTranslation("map.campaign.view.frame.HookHelperFrame.helpContent");
         _btn = ComponentFactory.Instance.creatComponentByStylename("campaign.HookHelperBtn");
         addToContent(_back);
         addToContent(_descText);
         addToContent(_btn);
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.HookHelperFrame.title");
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
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         super.dispose();
      }
   }
}

