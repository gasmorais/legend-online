package armyII.viewII.pawnupgrade
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PawnSkill extends Sprite implements Disposeable
   {
      
      private var _data:SkillTempInfo;
      
      private var _icon:BaseIconView;
      
      private var _name:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _filter:IFilterFormat;
      
      public function PawnSkill()
      {
         super();
         _icon = ComponentFactory.Instance.creatCustomObject("core.PawnSkillIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("core.PawnSkillNameText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("core.PawnSkillDescribeText");
         _name.setFrame(2);
         addChild(_icon);
         addChild(_name);
         addChild(_describe);
         _filter = new UIFilter();
         _filter.setGrayFilter(_icon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function set grade(param1:int) : void
      {
         if(param1 == 0)
         {
            _describe.text = "";
         }
         else
         {
            _describe.text = param1 + LanguageMgr.GetTranslation("buildings.casern.view.PawnSkill.describe");
         }
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _name.text = _data.TemplateName;
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _icon.tipData = _data;
         }
         else
         {
            _name.text = "";
            _icon.icon = null;
            _icon.tipData = null;
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         _filter.setNormalFilter(_icon);
         _name.setFrame(1);
      }
   }
}

