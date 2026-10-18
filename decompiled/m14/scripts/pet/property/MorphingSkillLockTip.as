package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.view.tips.BaseTip;
   
   public class MorphingSkillLockTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _prompt:FilterFrameText;
      
      private var _desc:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function MorphingSkillLockTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _title = ComponentFactory.Instance.creatComponentByStylename("MorphingSkillLockTip.titleTxt");
         _prompt = ComponentFactory.Instance.creatComponentByStylename("MorphingSkillLockTip.promptTxt");
         _desc = ComponentFactory.Instance.creatComponentByStylename("MorphingSkillLockTip.descTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("MorphingSkillLockTip.line");
         addChild(_title);
         addChild(_line);
         addChild(_prompt);
         addChild(_desc);
         _title.text = LanguageMgr.GetTranslation("MorphingSkillLockTip.titleTxt");
         _prompt.text = LanguageMgr.GetTranslation("MorphingSkillLockTip.promptTxt");
         _desc.htmlText = LanguageMgr.GetTranslation("MorphingSkillLockTip.descTxt");
         _bg.width = 270;
         _bg.height = 160;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_prompt);
         _prompt = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         super.dispose();
      }
   }
}

