package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ThessboxAddSkillUI extends Sprite
   {
      
      protected var _addMBg:MutipleImage;
      
      protected var _addSkIcon2:BaseIconView;
      
      protected var _addSKdesTxt:FilterFrameText;
      
      protected var _addSKNkTxt:FilterFrameText;
      
      private var _data:int;
      
      public function ThessboxAddSkillUI()
      {
         super();
         initView();
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         if(_data > 0)
         {
            _loc2_ = TempleteManager.instance.getSkillById(_data);
            _addSkIcon2.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _addSKNkTxt.text = _loc2_.TemplateName;
         }
      }
      
      protected function initView() : void
      {
         _addMBg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.addMBg");
         _addSkIcon2 = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addSkIcon2");
         _addSKdesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.addSKdesTxt");
         _addSKNkTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.addSKNkTxt");
         addChild(_addMBg);
         addChild(_addSkIcon2);
         addChild(_addSKdesTxt);
         addChild(_addSKNkTxt);
         _addSKdesTxt.text = LanguageMgr.GetTranslation("thesebox.addDesSK");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_addMBg);
         _addMBg = null;
         ObjectUtils.disposeObject(_addSkIcon2);
         _addSkIcon2 = null;
         ObjectUtils.disposeObject(_addSKdesTxt);
         _addSKdesTxt = null;
         ObjectUtils.disposeObject(_addSKNkTxt);
         _addSKNkTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

