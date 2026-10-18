package mainBar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.ExternalInterfaceManager;
   import manager.LanguageMgr;
   import yishi.datas.UserInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConfigManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class IndulgeInfoFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleLeftRightImage;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _button:TextButton;
      
      public function IndulgeInfoFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame.Back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame.Back2");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame.Txt1");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame.Txt2");
         _button = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame.Button");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_txt1);
         addToContent(_txt2);
         addToContent(_button);
         _txt1.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeInfoFrame.txt1");
         if(userInfo.site.indexOf("7road") >= 0)
         {
            _button.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeInfoFrame.button1");
         }
         else
         {
            _button.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeInfoFrame.button");
         }
      }
      
      private function get userInfo() : UserInfo
      {
         return PlayerManager.instance.currentPlayerModel.userInfo;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _button.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _button.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:IndulgeFrame = null;
         if(ConfigManager.info.AAS && PlayerManager.instance.currentPlayerModel.isInAAS && userInfo.site.indexOf("kxin") >= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.view.IndulgeInfoFrame.clickTips"));
            _loc2_ = PathManager.info.AASRegisterPath;
            ExternalInterfaceManager.instance.AASRegisterPath(_loc2_);
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame");
            _loc3_.show();
         }
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function set timeTxt(param1:String) : void
      {
         _txt2.text = param1;
         _txt2.height = _txt2.textHeight + 4;
         beginChanges();
         height += _txt2.height - 20;
         commitChanges();
         _back1.height += _txt2.height - 20;
         _back2.y += _txt2.height - 20;
         _button.y += _txt2.height - 20;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.view.IndulgeInfoFrame.title");
         LayerManager.Instance.addToLayer(this,2,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

