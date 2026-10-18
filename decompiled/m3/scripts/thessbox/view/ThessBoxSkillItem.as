package thessbox.view
{
   import manager.LanguageMgr;
   import thessbox.ui.ThessBoxSkillItemUI;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   
   public class ThessBoxSkillItem extends ThessBoxSkillItemUI
   {
      
      private var _data:SkillTempInfo;
      
      public function ThessBoxSkillItem()
      {
         super();
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _sknameTxt.text = _data.TemplateName;
            _skDesTxt.htmlText = _data.Description;
            _skicon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _skCdTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_data.CoolDown * 0.001);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
      }
   }
}

