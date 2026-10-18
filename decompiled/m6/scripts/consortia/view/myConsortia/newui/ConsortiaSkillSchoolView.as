package consortia.view.myConsortia.newui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.item.ConsortiaSkillNewItem;
   import events.ConsortiaEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaSkillSchoolView extends Component
   {
      
      private var _gradeText:FilterFrameText;
      
      private var _nextDescText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _assetText:FilterFrameText;
      
      private var _coldDownText:FilterFrameText;
      
      private var _costAssetText:FilterFrameText;
      
      private var _studyBtn:IconButton;
      
      private var _back:MutipleImage;
      
      private var _costAssetImage:ScaleFrameImage;
      
      private var _hasAssetImage:ScaleFrameImage;
      
      private var _coldDownImage:Image;
      
      private var _researchBtn:IconButton;
      
      private var _alertText:FilterFrameText;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _itemHbox:HBox;
      
      private var skillList:Vector.<ConsortiaSkillNewItem>;
      
      private var curPage:int;
      
      private var pageCount:int = 4;
      
      private var learnType:int;
      
      private var selectSkillTemp:ConsortiaTemplete;
      
      private var curTemp:ConsortiaTemplete;
      
      private var nextTemp:ConsortiaTemplete;
      
      public function ConsortiaSkillSchoolView()
      {
         super();
         initView();
         initListView();
         addEvent();
         curPage = 1;
         selectSkillTemp = pageShowData[0];
      }
      
      private function initView() : void
      {
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.gradeText");
         _nextDescText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.nextDescText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.descText");
         _assetText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.assetText");
         _coldDownText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.coldDownText");
         _costAssetText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.costAssetText");
         _studyBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.studyBtn");
         _back = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolView.back");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.nextBtn");
         _itemHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.itemHbox");
         _hasAssetImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.hasAssetImage");
         _costAssetImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.constAssetImage");
         _coldDownImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.coldDownImage");
         _researchBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.researchBtn");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.alertText");
         addChild(_back);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_itemHbox);
         addChild(_alertText);
         addChild(_gradeText);
         addChild(_descText);
         addChild(_nextDescText);
         addChild(_costAssetImage);
         addChild(_costAssetText);
         addChild(_coldDownImage);
         addChild(_coldDownText);
         addChild(_researchBtn);
         addChild(_studyBtn);
         addChild(_hasAssetImage);
         addChild(_assetText);
      }
      
      private function initListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ConsortiaSkillNewItem = null;
         skillList = new Vector.<ConsortiaSkillNewItem>();
         _loc1_ = 0;
         while(_loc1_ < pageCount)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ConsortiaSkillSchoolView.skillItem");
            _itemHbox.addChild(_loc2_);
            skillList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         _researchBtn.addEventListener("click",_researchBtnClickHandler);
         _studyBtn.addEventListener("click",_studyBtnClickHandler);
         _nextBtn.addEventListener("click",_nextBtnClickHandler);
         _preBtn.addEventListener("click",_preBtnClickHandler);
         MsgMan.addObserver("SKILL_ICON_SELECT",this,__onSkillIconSelectHandler);
         model.addEventListener("UPDA_CONSORTIA_RIGHTS",__setRightsChangeHandler);
         playerModel.playerInfo.addEventListener("CONSORTIA_STUDY",__updataSkillGradeHandler);
         playerModel.playerInfo.addEventListener("CONSORTIA_STUDY_UPGRADE",__updataSkillGradeHandler);
         MsgMan.addObserver("UPDATE_QUEST_INFO",this,__updateReputionHandler);
      }
      
      private function removeEvent() : void
      {
         if(_researchBtn)
         {
            _researchBtn.removeEventListener("click",_researchBtnClickHandler);
         }
         if(_studyBtn)
         {
            _studyBtn.removeEventListener("click",_studyBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextBtnClickHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",_preBtnClickHandler);
         }
         MsgMan.removeObserver("SKILL_ICON_SELECT",this,__onSkillIconSelectHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerHandler);
         model.removeEventListener("UPDA_CONSORTIA_RIGHTS",__setRightsChangeHandler);
         playerModel.playerInfo.removeEventListener("CONSORTIA_STUDY",__updataSkillGradeHandler);
         playerModel.playerInfo.removeEventListener("CONSORTIA_STUDY_UPGRADE",__updataSkillGradeHandler);
         MsgMan.removeObserver("UPDATE_QUEST_INFO",this,__updateReputionHandler);
      }
      
      private function __updataSkillGradeHandler(param1:ConsortiaEvent) : void
      {
         refreshView(learnType);
      }
      
      private function __updateReputionHandler(param1:String, param2:Object) : void
      {
         if(learnType != 1)
         {
            _assetText.text = model.reputation + "";
         }
      }
      
      private function __setRightsChangeHandler(param1:ConsortiaEvent) : void
      {
         refreshView(learnType);
      }
      
      private function _nextBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage + 1;
         selectSkillTemp = pageShowData[0];
         refreshView(learnType);
      }
      
      private function _preBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage - 1;
         selectSkillTemp = pageShowData[0];
         refreshView(learnType);
      }
      
      private function __onSkillIconSelectHandler(param1:String, param2:Object) : void
      {
         selectSkillTemp = param2 as ConsortiaTemplete;
         refreshView(learnType);
      }
      
      private function _studyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!nextTemp)
         {
            return;
         }
         if(model.reputation < nextTemp.Property2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noreputation.alert"));
            return;
         }
         ConsortiaSocketOutManager.consortiaStudy(nextTemp.Types,2);
      }
      
      private function _researchBtnClickHandler(param1:MouseEvent) : void
      {
         if(!nextTemp)
         {
            return;
         }
         var _loc2_:int = consortiaInfo.masterSkillResearchCd - playerModel.sysCurTimeBySecond;
         if(_loc2_ > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.consortiaSkillSchoolView.cdAlert"));
            return;
         }
         if(model.consortiaInfo.consortiaAsset < nextTemp.NeedOffer)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noAsset.alert"));
            return;
         }
         ConsortiaSocketOutManager.consortiaUpgrade(nextTemp.Types);
      }
      
      public function refreshView(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         learnType = param1;
         if(!selectSkillTemp)
         {
            return;
         }
         _costAssetImage.setFrame(learnType);
         _hasAssetImage.setFrame(learnType);
         var _loc4_:int = int(consortiaInfo.getLevelByUpgradeType(selectSkillTemp.Types));
         var _loc2_:int = int(ConsortiaSkillHelper.getLevelByType(selectSkillTemp.Types,playerModel.playerInfo));
         if(learnType == 1)
         {
            _alertText.text = LanguageMgr.GetTranslation("ConsortiaSkillSchoolView.alertText.text");
            _loc5_ = "NeedOffer";
            _loc3_ = _loc4_;
            _coldDownImage.visible = true;
            _assetText.text = consortiaInfo.consortiaAsset + "";
            _studyBtn.visible = false;
            _researchBtn.visible = control.getRightsByIndex(3);
            _researchBtn.enable = _loc3_ < 10;
            _costAssetText.x = 165;
            _assetText.x = 623;
         }
         else
         {
            _alertText.text = "";
            _loc5_ = "Property2";
            _loc3_ = _loc2_;
            _coldDownImage.visible = false;
            _coldDownText.text = "";
            _assetText.text = model.reputation + "";
            _researchBtn.visible = false;
            _studyBtn.visible = true;
            _studyBtn.enable = _loc3_ < _loc4_;
            _costAssetText.x = 155;
            _assetText.x = 640;
         }
         curTemp = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(selectSkillTemp.Types,_loc3_);
         nextTemp = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(selectSkillTemp.Types,_loc3_ + 1);
         _gradeText.text = _loc3_ + "";
         _costAssetText.text = nextTemp ? nextTemp[_loc5_] + "" : "0";
         _descText.text = curTemp ? curTemp.Description : "";
         _nextDescText.text = nextTemp ? nextTemp.Description : "";
         refreshTimer();
         refreshSkillView();
      }
      
      private function refreshSkillView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ConsortiaSkillNewItem = null;
         _preBtn.visible = curPage > 1;
         _nextBtn.visible = curPage < Math.ceil(model.masterSkillTempAry.length / pageCount);
         var _loc1_:Array = pageShowData;
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = skillList[_loc3_];
            _loc2_.setViewType(learnType);
            _loc2_.tempInfo = _loc1_[_loc3_];
            if(_loc2_.tempInfo && _loc2_.tempInfo.Types == selectSkillTemp.Types)
            {
               _loc2_.selected = true;
            }
            else
            {
               _loc2_.selected = false;
            }
            _loc3_++;
         }
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:int = 0;
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerHandler);
         if(learnType == 1)
         {
            _loc1_ = consortiaInfo.masterSkillResearchCd - playerModel.sysCurTimeBySecond;
            if(_loc1_ > 0)
            {
               playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerHandler);
            }
            else
            {
               _coldDownText.text = "00:00:00";
            }
         }
      }
      
      private function __updateTimerHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = consortiaInfo.masterSkillResearchCd - playerModel.sysCurTimeBySecond;
         if(_loc2_ <= 0)
         {
            playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerHandler);
            _coldDownText.text = "00:00:00";
         }
         else
         {
            _coldDownText.text = DateFormatter.getConsortiaCountDate(_loc2_);
         }
      }
      
      private function get pageShowData() : Array
      {
         var _loc2_:Array = [];
         var _loc1_:int = (curPage - 1) * pageCount;
         var _loc3_:int = Math.min(_loc1_ + pageCount,model.masterSkillTempAry.length);
         return model.masterSkillTempAry.slice(_loc1_,_loc3_ + 1);
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_nextDescText);
         _nextDescText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_assetText);
         _assetText = null;
         ObjectUtils.disposeObject(_coldDownText);
         _coldDownText = null;
         ObjectUtils.disposeObject(_costAssetText);
         _costAssetText = null;
         ObjectUtils.disposeObject(_studyBtn);
         _studyBtn = null;
         ObjectUtils.disposeObject(_researchBtn);
         _researchBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hasAssetImage);
         _hasAssetImage = null;
         ObjectUtils.disposeObject(_coldDownImage);
         _coldDownImage = null;
         ObjectUtils.disposeObject(_costAssetImage);
         _costAssetImage = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_itemHbox);
         _itemHbox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

