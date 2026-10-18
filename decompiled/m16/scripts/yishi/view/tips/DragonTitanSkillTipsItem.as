package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanSkillTipsItem extends Component
   {
      
      public var index:int = 0;
      
      public var state:int = 0;
      
      private var _data:SkillTempInfo;
      
      private var _skillName:FilterFrameText;
      
      private var _skillDesc:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      public function DragonTitanSkillTipsItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillName = ComponentFactory.Instance.creatComponentByStylename("DragonTitanSkillTipsItem.skillName");
         _skillDesc = ComponentFactory.Instance.creatComponentByStylename("DragonTitanSkillTipsItem.skillDesc");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanSkillTipsItem.icon");
         addChild(_skillName);
         addChild(_skillDesc);
         addChild(_icon);
      }
      
      private function freshView() : void
      {
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            _skillName.htmlText = LanguageMgr.GetTranslation("DragonTitanSkillTipsItem.round" + index);
            _skillDesc.text = "";
            return;
         }
         _skillName.htmlText = LanguageMgr.GetTranslation("DragonTitanSkillTipsItem.round" + index) + "  <font color=\'#299fdb\'>" + _data.TemplateName + "</font>";
         if(state == 1)
         {
            _skillName.htmlText += " <font color=\'#cd0000\'>" + LanguageMgr.GetTranslation("DragonTitanSkillTipsItem.isUsed") + "</font>";
         }
         else if(state == 2)
         {
            _skillName.htmlText += " <font color=\'#6F6F6F\'>" + LanguageMgr.GetTranslation("DragonTitanSkillTipsItem.notCanUse") + "</font>";
         }
         _skillDesc.text = _data.Description;
         _icon.icon = IconFactory.getCommonIconPath(_data.Icons);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function unInitView() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
   }
}

