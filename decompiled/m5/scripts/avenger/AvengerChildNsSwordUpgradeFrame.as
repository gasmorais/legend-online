package avenger
{
   import avenger.item.AvengerChildNsPropItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.avenger.AvengerModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerChildNsSwordUpgradeFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _stageImage:Image;
      
      private var _tipsImage:Image;
      
      private var _stageText:FilterFrameText;
      
      private var _lineImage:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _lvlImage:Image;
      
      private var _skillText:FilterFrameText;
      
      private var _needItem:TokenAmountItem;
      
      private var _hasItem:TokenAmountItem;
      
      private var _upgradeBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _alertText:FilterFrameText;
      
      private var propList:Vector.<AvengerChildNsPropItem>;
      
      private var hasMaterialCount:int;
      
      private var needCount:int;
      
      private var _data:AvengerChildNsInfo;
      
      public function AvengerChildNsSwordUpgradeFrame()
      {
         super();
         initView();
         initPropItemView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.back");
         _stageImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.stageImage");
         _tipsImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.tipsImage");
         _stageText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.stageText");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.lineImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordUpgradeFrame.skillIcon");
         _skillText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.skillText");
         _needItem = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.needItem");
         _hasItem = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.hasItem");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.upgradeBtn");
         _lvlImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.lvlImage");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.helpBtn");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.alertText");
         addToContent(_back);
         addToContent(_stageImage);
         addToContent(_tipsImage);
         addToContent(_stageText);
         addToContent(_lineImage);
         addToContent(_skillIcon);
         addToContent(_lvlImage);
         addToContent(_skillText);
         addToContent(_needItem);
         addToContent(_hasItem);
         addToContent(_upgradeBtn);
         addToContent(_helpBtn);
         addToContent(_alertText);
         _tipsImage.tipData = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.tipText.text");
         _lineImage.setFrame(1);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208527);
         if(_loc1_)
         {
            _needItem.iconTipData = _loc1_.TemplateName + "\n" + _loc1_.Description;
            _hasItem.iconTipData = _loc1_.TemplateName + "\n" + _loc1_.Description;
            _needItem.firstText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.needItem.firstText",_loc1_.TemplateName);
            _hasItem.firstText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.hasItem.firstText",_loc1_.TemplateName);
         }
      }
      
      private function initPropItemView() : void
      {
         var _loc1_:AvengerChildNsPropItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         propList = new Vector.<AvengerChildNsPropItem>();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _loc3_ + 1;
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordUpgradeFrame.propItem" + _loc2_,[2,_loc2_]);
            addToContent(_loc1_);
            propList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _upgradeBtn.addEventListener("click",__upgradeClickHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("AVENGER_CHILDNS_UPDATE",this,__childNsChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeClickHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         MsgMan.removeObserver("AVENGER_CHILDNS_UPDATE",this,__childNsChangeHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordUpgradeFrame.skillhelpFrame");
         _loc2_.show();
      }
      
      private function __childNsChangeHandler(param1:String, param2:Object) : void
      {
         data = model.nsInfoDic[data.childId];
      }
      
      private function __upgradeClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         SoundManager.instance.play("022");
         if(hasMaterialCount < needCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         if(!isPropGradeEnough)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.needPropGrade.alert",needMinGrade));
            return;
         }
         AvengerManager.instance.sendChildNsStage(data.childId);
      }
      
      public function get data() : AvengerChildNsInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerChildNsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc5_:int = 0;
         _data = param1;
         if(!data)
         {
            return;
         }
         var _loc3_:int = data.profileGrade + 1;
         _stageText.text = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc3_) + LanguageMgr.GetTranslation("mounts.command01",data.stageGrade - model.upgradeDic[data.profileGrade] + 1);
         var _loc7_:SkillTempInfo = model.getStageSkill(data.childTemp,data);
         if(_loc7_)
         {
            _skillIcon.icon = IconFactory.getTecIconByIcon(_loc7_.Icons);
            _skillText.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",data.profileGrade,getSkillMaxGrade(_loc7_));
            _skillIcon.tipData = _loc7_;
            _skillIcon.filters = [];
         }
         _lineImage.setFrame(_loc3_);
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208527);
         _hasItem.secondText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.tokerItem.numText",hasMaterialCount);
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(data.stageGrade,157);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(data.stageGrade + 1,157);
         if(_loc2_)
         {
            _upgradeBtn.enable = true;
            needCount = _loc2_.Data;
            _needItem.secondText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.tokerItem.numText",needCount);
            _alertText.text = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.alertText.text",needMinGrade);
            _loc4_ = _loc2_.ActiveObject + 1;
            _loc8_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc4_) + LanguageMgr.GetTranslation("mounts.command01",data.stageGrade - model.upgradeDic[_loc2_.ActiveObject] + 2);
            _stageImage.tipData = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.nextStage.tips",_loc8_);
         }
         else
         {
            _upgradeBtn.enable = false;
            _needItem.secondText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.tokerItem.numText",_loc6_.Data);
            _alertText.text = "";
            _stageImage.tipData = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.maxStage.tips");
         }
         _loc5_ = 0;
         while(_loc5_ < propList.length)
         {
            propList[_loc5_].data = data;
            _loc5_++;
         }
      }
      
      private function get isPropGradeEnough() : Boolean
      {
         return data.liveGrade >= needMinGrade && data.defenseGrade >= needMinGrade && data.attackGrade >= needMinGrade;
      }
      
      private function getSkillMaxGrade(param1:SkillTempInfo) : int
      {
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndSonType(param1.MasterType,param1.SonType);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      public function get needMinGrade() : int
      {
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(data.stageGrade + 1,157);
         if(!_loc1_)
         {
            return 0;
         }
         return int(_loc1_.TemplateName.split(",")[1]);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AvengerChildNsSwordUpgradeFrame.title.text");
         if(param1 && param1.frameData)
         {
            data = param1.frameData as AvengerChildNsInfo;
         }
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_stageImage);
         _stageImage = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_lvlImage);
         _lvlImage = null;
         ObjectUtils.disposeObject(_skillText);
         _skillText = null;
         ObjectUtils.disposeObject(_needItem);
         _needItem = null;
         ObjectUtils.disposeObject(_hasItem);
         _hasItem = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_stageText);
         _stageText = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_tipsImage);
         _tipsImage = null;
         LogicUtils.disposeDisplayCollection(propList);
         propList = null;
         super.dispose();
      }
   }
}

