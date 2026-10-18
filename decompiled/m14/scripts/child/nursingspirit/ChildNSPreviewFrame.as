package child.nursingspirit
{
   import child.attribute.ChildShowAvatar;
   import child.skill.ChildSkillItemView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.component.TileContainer;
   
   public class ChildNSPreviewFrame extends Frame
   {
      
      private var border:Scale9CornerImage;
      
      private var back:MutipleImage;
      
      private var nsFigure:ChildShowAvatar;
      
      private var nsNameText:FilterFrameText;
      
      private var attackText:FilterFrameText;
      
      private var magicAttackText:FilterFrameText;
      
      private var DefenceText:FilterFrameText;
      
      private var magicDefenceText:FilterFrameText;
      
      private var liveText:FilterFrameText;
      
      private var skillTiles:TileContainer;
      
      private var itemList:Vector.<ChildSkillItemView>;
      
      public function ChildNSPreviewFrame()
      {
         super();
         initView();
         initSkillListView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.border");
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.back");
         nsNameText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.nsNameText");
         attackText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.attackText");
         magicAttackText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.magicAttackText");
         DefenceText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.DefenceText");
         magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.magicDefenceText");
         liveText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPreviewFrame.liveText");
         skillTiles = ComponentFactory.Instance.creatCustomObject("ChildNSPreviewFrame.TileContainer");
         nsFigure = new ChildShowAvatar();
         nsFigure.mouseChildren = nsFigure.mouseEnabled = false;
         addToContent(border);
         addToContent(back);
         addToContent(nsFigure);
         nsFigure.x = 50;
         nsFigure.y = 160;
         addToContent(nsNameText);
         addToContent(attackText);
         addToContent(magicAttackText);
         addToContent(DefenceText);
         addToContent(magicDefenceText);
         addToContent(liveText);
         addToContent(skillTiles);
      }
      
      private function initSkillListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildSkillItemView = null;
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
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         nsFigure.data = figureData;
         nsNameText.text = tempData.JobName;
         attackText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",tempData.Attack,maxGrade);
         magicAttackText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",tempData.MagicAttack,maxGrade);
         DefenceText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",tempData.Defence,maxGrade);
         magicDefenceText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",tempData.MagicDefence,maxGrade);
         liveText.htmlText = LanguageMgr.GetTranslation("ChildHandBookRightFrame.attackText.commonText",tempData.Live,maxGrade);
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndGrades(tempData.SkillMasterType,12);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            itemList[_loc1_].data = _loc2_[_loc1_] ? _loc2_[_loc1_] : null;
            itemList[_loc1_].setLvlText("max");
            _loc1_++;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("ChildNSPreviewFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get figureData() : ChildData
      {
         var _loc1_:ChildData = new ChildData();
         _loc1_.state = 1;
         _loc1_.job = nsModel.selectedNsChildTemp.JobType;
         _loc1_.growthGrade = maxGrade;
         return _loc1_;
      }
      
      private function get tempData() : ChildTempInfo
      {
         var _loc2_:int = int(nsModel.selectedNsChildTemp.JobType);
         var _loc1_:int = maxGrade;
         return TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc2_,_loc1_);
      }
      
      private function get maxGrade() : int
      {
         return childModel.getChildMaxGradeByJob(nsModel.selectedNsChildTemp.JobType);
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(nsFigure);
         nsFigure = null;
         ObjectUtils.disposeObject(nsNameText);
         nsNameText = null;
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

