package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MarrySkillInfoItem extends Component
   {
      
      private var _vBox:VBox;
      
      private var txt:FilterFrameText;
      
      private var arr:Array = [];
      
      private var skill:SkillTempInfo;
      
      private var description:String = "";
      
      public function MarrySkillInfoItem(param1:String)
      {
         super();
         initView();
         setData(param1);
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassVBox");
         _vBox.removeAllChild();
         addChild(_vBox);
      }
      
      private function setData(param1:String) : void
      {
         var _loc2_:int = 0;
         arr = TempleteManager.instance.getSkillTemplateInfoByIds(param1);
         _loc2_ = 0;
         while(_loc2_ < arr.length)
         {
            skill = arr[_loc2_] as SkillTempInfo;
            if(skill == null)
            {
               break;
            }
            if(skill.UseWay == 1)
            {
               description += LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillDecribe1",skill.Description) + "\n";
               txt = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               txt.width = 240;
               txt.wordWrap = true;
               txt.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillName") + skill.TemplateName + "  " + skill.Grades;
               txt.setFrame(3);
               txt.setTextFormat(ComponentFactory.Instance.model.getSet("tips.SinglePassRewardTxt_t8"),txt.length - 2,txt.length);
               txt.setTextFormat(txt.defaultTextFormat,txt.length - 3,txt.length);
               _vBox.addChild(txt);
               txt = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               txt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",skill.CoolDown / 1000);
               txt.setFrame(8);
               _vBox.addChild(txt);
            }
            else if(skill.UseWay == 2)
            {
               description += LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillDecribe2",skill.Description) + "\n";
            }
            _loc2_++;
         }
         txt = ComponentFactory.Instance.creatComponentByStylename("tips.MarryTipsDescribeText");
         txt.y = 0;
         txt.width = 222;
         txt.htmlText = description;
         _vBox.addChild(txt);
      }
      
      override public function dispose() : void
      {
         if(txt)
         {
            txt.dispose();
         }
         txt = null;
         if(arr)
         {
            arr = null;
         }
         if(description)
         {
            description = null;
         }
         if(skill)
         {
            skill = null;
         }
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

