package child.handbook
{
   import child.skill.ChildSkillItemView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.component.TileContainer;
   
   public class ChildHandBookRightFrame extends Frame
   {
      
      private var titleImage:MutipleImage;
      
      private var attackText:FilterFrameText;
      
      private var magicAttackText:FilterFrameText;
      
      private var DefenceText:FilterFrameText;
      
      private var magicDefenceText:FilterFrameText;
      
      private var liveText:FilterFrameText;
      
      private var maxSkillGrade:int = 8;
      
      private var skillTiles:TileContainer;
      
      private var itemList:Vector.<ChildSkillItemView>;
      
      private var _data:ChildTempInfo;
      
      public function ChildHandBookRightFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildSkillItemView = null;
         titleText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.title.text");
         titleImage = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.titleImage");
         attackText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.attackText");
         magicAttackText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.magicAttackText");
         DefenceText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.DefenceText");
         magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.magicDefenceText");
         liveText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookRightFrame.liveText");
         skillTiles = ComponentFactory.Instance.creatCustomObject("ChildHandBookRightFrame.TileContainer");
         addToContent(titleImage);
         addToContent(attackText);
         addToContent(magicAttackText);
         addToContent(DefenceText);
         addToContent(magicDefenceText);
         addToContent(liveText);
         addToContent(skillTiles);
         itemList = new Vector.<ChildSkillItemView>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new ChildSkillItemView();
            skillTiles.appendItem(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set data(param1:ChildTempInfo) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.JobType,12);
         if(!_loc2_)
         {
            return;
         }
         attackText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",_loc2_.Attack,12);
         magicAttackText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",_loc2_.MagicAttack,12);
         DefenceText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",_loc2_.Defence,12);
         magicDefenceText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",_loc2_.MagicDefence,12);
         liveText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",_loc2_.Live,12);
         var _loc4_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndGrades(_loc2_.SkillMasterType,maxSkillGrade);
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            itemList[_loc3_].data = _loc4_[_loc3_] ? _loc4_[_loc3_] : null;
            itemList[_loc3_].setLvlText("max");
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(titleImage);
         titleImage = null;
         ObjectUtils.disposeObject(attackText);
         attackText = null;
         ObjectUtils.disposeObject(magicAttackText);
         magicAttackText = null;
         ObjectUtils.disposeObject(DefenceText);
         DefenceText = null;
         ObjectUtils.disposeObject(magicDefenceText);
         magicDefenceText = null;
         ObjectUtils.disposeObject(liveText);
         liveText = null;
         ObjectUtils.disposeObject(skillTiles);
         skillTiles = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

