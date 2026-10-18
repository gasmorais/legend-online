package mainBar.vicePassword
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class BtnResetVp extends Component
   {
      
      private var _btn:IconButton;
      
      private var _txt:FilterFrameText;
      
      public function BtnResetVp()
      {
         super();
         this.buttonMode = true;
         initUI();
      }
      
      private function initUI() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("vicepassword.imgReset");
         this.addChild(_btn);
         _txt = ComponentFactory.Instance.creatComponentByStylename("vicepassword.btnresettxt");
         this.addChild(_txt);
         _txt.htmlText = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewreset");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

