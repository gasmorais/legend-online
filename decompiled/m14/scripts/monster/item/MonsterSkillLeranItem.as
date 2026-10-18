package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monster.MonsterSkillPracticeFrame;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.MonsterManager;
   import yishi.view.base.ProgressCommon;
   
   public class MonsterSkillLeranItem extends Component
   {
      
      private var _alertText:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _skillIcon:MonsterSkillIItem;
      
      private var _nameText:FilterFrameText;
      
      private var _back:Image;
      
      private var _practiceBtn:IconButton;
      
      private var _expBar:ProgressCommon;
      
      private var _tempInfo:SkillTempInfo;
      
      private var data:SkillTempInfo;
      
      private var upgradeTemp:UpgradeTemplateInfo;
      
      public function MonsterSkillLeranItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _alertText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterSkillLeranItem.alertText");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("MonsterSkillLeranItem.skillItem",[2,0]);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterSkillLeranItem.nameText");
         _back = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterSkillLeranItem.back");
         _practiceBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterSkillLeranItem.practiceBtn");
         _progressText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillLeranItem.progressText");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillLeranItem.expBar");
         addChild(_back);
         addChild(_skillIcon);
         addChild(_nameText);
         addChild(_alertText);
         addChild(_progressText);
         addChild(_expBar);
         addChild(_practiceBtn);
      }
      
      private function addEvent() : void
      {
         _practiceBtn.addEventListener("click",_practiceBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_practiceBtn)
         {
            _practiceBtn.removeEventListener("click",_practiceBtnClickHandler);
         }
      }
      
      private function _practiceBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MonsterSkillPracticeFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterSkillPracticeFrame");
         _loc2_.setCurMonster(model.selectMonster);
         _loc2_.setSkillTemp(data);
         _loc2_.show();
      }
      
      public function get tempInfo() : SkillTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:SkillTempInfo) : void
      {
         var _loc2_:SkillTempInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _tempInfo = param1;
         if(tempInfo)
         {
            data = model.getLearnSkillTemp(tempInfo,model.selectMonster);
            _practiceBtn.visible = true;
            _loc2_ = model.getMonsterMaxSkillTemp(tempInfo.SonType);
            if(data)
            {
               upgradeTemp = model.skillUpgradeTempAry[data.Grades - 1];
               _skillIcon.data = data;
               _nameText.text = data.TemplateName;
               _practiceBtn.enable = data.Grades < _loc2_.Grades;
               _expBar.visible = true;
               _loc3_ = int(model.getSkillExp(model.selectMonster,data.TemplateId));
               if(data.Grades >= _loc2_.Grades)
               {
                  _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
                  _expBar.value = 1;
               }
               else
               {
                  _expBar.text = _loc3_ + "/" + upgradeTemp.Data;
                  _expBar.value = _loc3_ / upgradeTemp.Data;
               }
               _progressText.text = LanguageMgr.GetTranslation("MonsterSkillLeranItem.progressText.text");
               _alertText.text = "";
            }
            else
            {
               _skillIcon.data = tempInfo;
               _nameText.text = tempInfo.TemplateName;
               _practiceBtn.enable = false;
               _expBar.visible = false;
               _progressText.text = "";
               _loc4_ = int(model.getSkillResolveGrade(model.selectMonster,tempInfo));
               _alertText.text = LanguageMgr.GetTranslation("MonsterSkillLeranItem.alertText.text",_loc4_);
            }
         }
         else
         {
            _skillIcon.data = null;
            _practiceBtn.visible = false;
            _nameText.text = "";
            _alertText.text = "";
            _progressText.text = "";
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_practiceBtn);
         _practiceBtn = null;
         ObjectUtils.disposeObject(_progressText);
         _progressText = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         super.dispose();
      }
   }
}

