package avenger.item
{
   import avenger.AvengerChildNsSkillInputFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.ProgressCommon;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerChildNsSkillItem extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _typeBg:ScaleFrameImage;
      
      private var _descItem:TokenAmountItem;
      
      private var _skillIcon:BaseIconView;
      
      private var _lvlImage:Image;
      
      private var _lvlText:FilterFrameText;
      
      private var _skillName:FilterFrameText;
      
      private var _skillNeedText:FilterFrameText;
      
      private var _learnBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _expBar:ProgressCommon;
      
      private var _hideBg:Bitmap;
      
      private var index:int;
      
      private var _tempInfo:SkillTempInfo;
      
      public var nsInfo:AvengerChildNsInfo;
      
      private var curState:int;
      
      private var learnNeedGrade:int;
      
      private var canLearnMaxGrade:int;
      
      private var hasBookCount:int;
      
      private var learnNeedCount:int;
      
      private var curSkillTemp:SkillTempInfo;
      
      private var gTemp:GoodsTemplateInfo;
      
      public function AvengerChildNsSkillItem(param1:int)
      {
         super();
         index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.back");
         _typeBg = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.typeBg");
         _learnBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.learnBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.upgradeBtn");
         _skillName = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.ChildSkillNameTxt");
         _skillNeedText = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.needBookTxt");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSkillItem.skillIcon");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.expBar");
         _lvlImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.lvlImage");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.skillText");
         _descItem = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillItem.descItem");
         _hideBg = ComponentFactory.Instance.creatBitmap("asset.AvengerChildNsSkillItem.hideBg");
         addChild(_back);
         addChild(_skillIcon);
         addChild(_typeBg);
         _typeBg.setFrame(index);
         addChild(_descItem);
         addChild(_lvlImage);
         addChild(_lvlText);
         addChild(_skillName);
         _skillName.y = 40;
         addChild(_skillNeedText);
         _skillNeedText.y = 40;
         addChild(_expBar);
         addChild(_hideBg);
         addChild(_learnBtn);
         addChild(_upgradeBtn);
         _descItem.firstText = LanguageMgr.GetTranslation("AvengerChildNsSkillItem.descItem.text" + index);
      }
      
      private function initEvent() : void
      {
         _learnBtn.addEventListener("click",__learnBtnClickHandler);
         _upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_learnBtn)
         {
            _learnBtn.removeEventListener("click",__learnBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         }
      }
      
      private function __learnBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(curState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerChildNsSkillItem.needTxt.text1",learnNeedGrade));
            return;
         }
         if(curState == 2 && hasBookCount < learnNeedCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerChildNsSkillItem.needTxt.text2",gTemp.TemplateName,learnNeedCount));
            return;
         }
         AvengerManager.instance.sendChildNsLearnSkill(nsInfo.childId,curSkillTemp.TemplateId);
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(curState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerChildNsSkillItem.needTxt.text1",learnNeedGrade));
            return;
         }
         if(hasBookCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerChildNsSkillItem.upgrade.noBook.alert",gTemp.TemplateName));
            return;
         }
         var _loc2_:AvengerChildNsSkillInputFrame = ComponentFactory.Instance.creatComponentByStylename("avenger.AvengerChildNsSkillInputFrame");
         _loc2_.hasCount = hasBookCount;
         _loc2_.callBack = inputHandler;
         _loc2_.show();
      }
      
      private function inputHandler(param1:int) : void
      {
         AvengerManager.instance.sendChildNsUpgradeSkill(nsInfo.childId,curSkillTemp.TemplateId,param1);
      }
      
      public function get tempInfo() : SkillTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:SkillTempInfo) : void
      {
         var _loc6_:int = 0;
         var _loc3_:SkillInfo = null;
         _tempInfo = param1;
         if(!tempInfo)
         {
            return;
         }
         var _loc5_:int = tempInfo.Index == 31 ? 208528 : 208529;
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         gTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
         hasBookCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc5_);
         _skillIcon.icon = IconFactory.getTecIconByIcon(tempInfo.Icons);
         curSkillTemp = nsInfo.skillTempDic[tempInfo.Index];
         canLearnMaxGrade = model.getCanLearnMaxGrade(nsInfo.grade)[tempInfo.Index - 31];
         if(curSkillTemp)
         {
            _loc2_ = int(curSkillTemp.Grades);
            _loc6_ = _loc2_ + 1;
            learnNeedGrade = model.getOpenMinLevelAry(curSkillTemp.Grades)[tempInfo.Index - 31];
            _learnBtn.visible = false;
            _upgradeBtn.visible = true;
            if(curSkillTemp.Grades >= getSkillMaxGrade(curSkillTemp))
            {
               _loc4_ = true;
               _upgradeBtn.enable = false;
               _skillNeedText.text = "";
               _expBar.value = 1;
               _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            }
            _loc3_ = new SkillInfo();
            _loc3_.templateId = curSkillTemp.TemplateId;
            _loc3_.grade = curSkillTemp.Grades;
            _skillIcon.tipData = _loc3_;
         }
         else
         {
            curSkillTemp = tempInfo;
            _skillIcon.tipData = curSkillTemp;
            _loc6_ = int(curSkillTemp.Grades);
            learnNeedGrade = model.getOpenMinLevelAry(0)[tempInfo.Index - 31];
            _learnBtn.visible = true;
            _upgradeBtn.visible = false;
         }
         _hideBg.visible = false;
         learnNeedCount = model.getLearnCount(curSkillTemp.Index,_loc6_);
         if(nsInfo.grade < learnNeedGrade)
         {
            curState = 1;
            _skillNeedText.text = LanguageMgr.GetTranslation("AvengerChildNsSkillItem.needTxt.text1",learnNeedGrade);
            _expBar.text = "";
            _expBar.value = 0;
            _hideBg.visible = true;
         }
         else if(!_loc4_)
         {
            curState = 2;
            _skillNeedText.text = LanguageMgr.GetTranslation("AvengerChildNsSkillItem.needTxt.text2",gTemp.TemplateName,learnNeedCount);
            if(nsInfo.skillExpDic[curSkillTemp.Index])
            {
               _expBar.value = int(nsInfo.skillExpDic[curSkillTemp.Index]) / learnNeedCount;
               _expBar.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",nsInfo.skillExpDic[curSkillTemp.Index],learnNeedCount);
            }
            else
            {
               _expBar.value = 0;
               _expBar.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",0,learnNeedCount);
            }
         }
         _lvlText.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",_loc2_,getSkillMaxGrade(tempInfo));
         _skillName.text = curSkillTemp.TemplateName;
      }
      
      private function getSkillMaxGrade(param1:SkillTempInfo) : int
      {
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndSonType(param1.MasterType,param1.SonType);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_skillNeedText)
         {
            ObjectUtils.disposeObject(_skillNeedText);
         }
         _skillNeedText = null;
         if(_typeBg)
         {
            ObjectUtils.disposeObject(_typeBg);
         }
         _typeBg = null;
         if(_learnBtn)
         {
            ObjectUtils.disposeObject(_learnBtn);
         }
         _learnBtn = null;
         if(_upgradeBtn)
         {
            ObjectUtils.disposeObject(_upgradeBtn);
         }
         _upgradeBtn = null;
         if(_skillName)
         {
            ObjectUtils.disposeObject(_skillName);
         }
         _skillName = null;
         if(_skillIcon)
         {
            ObjectUtils.disposeObject(_skillIcon);
         }
         _skillIcon = null;
         if(_expBar)
         {
            ObjectUtils.disposeObject(_expBar);
         }
         _expBar = null;
         if(_hideBg)
         {
            ObjectUtils.disposeObject(_hideBg);
         }
         _hideBg = null;
         ObjectUtils.disposeObject(_lvlImage);
         _lvlImage = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         ObjectUtils.disposeObject(_descItem);
         _descItem = null;
         super.dispose();
      }
   }
}

