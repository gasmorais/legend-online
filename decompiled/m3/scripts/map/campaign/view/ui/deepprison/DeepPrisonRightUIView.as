package map.campaign.view.ui.deepprison
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class DeepPrisonRightUIView extends Component
   {
      
      private var _bg:Image;
      
      private var _closeBg:Image;
      
      private var _desTxt:FilterFrameText;
      
      public function DeepPrisonRightUIView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("deepPrisonRightUIView.bg");
         _closeBg = ComponentFactory.Instance.creatComponentByStylename("deepPrisonRightUIView.closeBg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonRightUIView.desTxt");
         addChild(_bg);
         addChild(_closeBg);
         addChild(_desTxt);
         _desTxt.text = LanguageMgr.GetTranslation("DeepPrisonRightUIView.desTxt");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBg);
         _closeBg = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         super.dispose();
      }
   }
}

