package avenger.view
{
   import avenger.item.AvengerChildNsPropItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AvengerManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerChildNsSwordView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _lineImage:ScaleFrameImage;
      
      private var _pointText:FilterFrameText;
      
      private var _stageText:FilterFrameText;
      
      private var _stoneImage:Image;
      
      private var _tipsImage:Image;
      
      private var _upgradeBtn:IconButton;
      
      private var _swordBtn:BaseButton;
      
      private var _trainBtn:IconButton;
      
      private var _lvImage:Image;
      
      private var _gradeCon:Component;
      
      private var _numBit:BitmapData;
      
      private var _hasMaterialText:FilterFrameText;
      
      private var _inputText:FilterFrameText;
      
      private var _expBar:ProgressCommon;
      
      private var _liveText:FilterFrameText;
      
      private var _defenceText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _skillBox:VBox;
      
      private var skillList:Vector.<BaseIconView>;
      
      private var skillTextList:Vector.<FilterFrameText>;
      
      private var levelTextList:Vector.<FilterFrameText>;
      
      private var levelBgList:Vector.<Image>;
      
      private var _addArrowMc1:MovieClip;
      
      private var _addArrowMc2:MovieClip;
      
      private var _addArrowMc3:MovieClip;
      
      private var _flickerMc:MovieClip;
      
      private var propList:Vector.<AvengerChildNsPropItem>;
      
      private var hasMaterialCount:int;
      
      private var nsInfo:AvengerChildNsInfo;
      
      private var _isFirst:Boolean = true;
      
      private var prePropAry:Array = [0,0,0];
      
      private var _delay1:uint;
      
      private var _delay2:uint;
      
      private var _delay3:uint;
      
      public function AvengerChildNsSwordView()
      {
         super();
         initView();
         initPropItemView();
         initSkillView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.back");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.lineImage");
         _pointText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.pointText");
         _stageText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.stageText");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.upgradeBtn");
         _swordBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.swordBtn");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.trainBtn");
         _lvImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.lvImage");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.gradeCon");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.AvengerChildNsSwordView.numBit");
         _hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.hasMaterialText");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.inputText");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.expBar");
         _liveText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.liveText");
         _defenceText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.defenceText");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.attackText");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.skillBox");
         _stoneImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.stoneImage");
         _tipsImage = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.tipsImage");
         _addArrowMc1 = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.AddArrowMc1");
         _addArrowMc2 = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.AddArrowMc2");
         _addArrowMc3 = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.AddArrowMc3");
         _flickerMc = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.flickerMc");
         addChild(_back);
         addChild(_lineImage);
         addChild(_tipsImage);
         addChild(_stoneImage);
         addChild(_flickerMc);
         addChild(_pointText);
         addChild(_stageText);
         addChild(_upgradeBtn);
         addChild(_swordBtn);
         addChild(_trainBtn);
         addChild(_hasMaterialText);
         addChild(_inputText);
         addChild(_expBar);
         addChild(_liveText);
         addChild(_defenceText);
         addChild(_attackText);
         addChild(_addArrowMc1);
         addChild(_addArrowMc2);
         addChild(_addArrowMc3);
         addChild(_skillBox);
         _swordBtn.addChild(_lvImage);
         _swordBtn.addChild(_gradeCon);
         _lineImage.setFrame(1);
         _inputText.text = "1";
         _pointText.text = "0";
         _addArrowMc1.gotoAndStop(1);
         _addArrowMc1.visible = false;
         _addArrowMc2.gotoAndStop(1);
         _addArrowMc2.visible = false;
         _addArrowMc3.gotoAndStop(1);
         _addArrowMc3.visible = false;
         _flickerMc.gotoAndStop(1);
         _flickerMc.visible = false;
         _tipsImage.tipData = LanguageMgr.GetTranslation("AvengerChildNsSwordView.tipsImage.tipData");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208526);
         if(_loc1_)
         {
            _stoneImage.tipData = _loc1_.TemplateName + "\n" + _loc1_.Description;
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
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.propItem" + _loc2_,[1,_loc2_]);
            addChild(_loc1_);
            propList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function initSkillView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Component = null;
         var _loc4_:BaseIconView = null;
         var _loc1_:FilterFrameText = null;
         var _loc2_:Image = null;
         var _loc5_:FilterFrameText = null;
         skillList = new Vector.<BaseIconView>();
         skillTextList = new Vector.<FilterFrameText>();
         levelTextList = new Vector.<FilterFrameText>();
         levelBgList = new Vector.<Image>();
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc3_ = new Component();
            _loc4_ = ComponentFactory.Instance.creatCustomObject("AvengerChildNsSwordView.skillIcon");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.skillText");
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.skillLevelBg");
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSwordView.skillLevelText");
            _loc3_.addChild(_loc4_);
            _loc3_.addChild(_loc2_);
            _loc3_.addChild(_loc1_);
            _loc3_.addChild(_loc5_);
            _skillBox.addChild(_loc3_);
            skillList.push(_loc4_);
            skillTextList.push(_loc1_);
            levelBgList.push(_loc2_);
            levelTextList.push(_loc5_);
            _loc6_++;
         }
      }
      
      private function addEvent() : void
      {
         _upgradeBtn.addEventListener("click",__upgradeClickHandler);
         _swordBtn.addEventListener("click",__swordClickHandler);
         _trainBtn.addEventListener("click",__trainClickHandler);
         _inputText.addEventListener("change",__textChangHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__selectTempChangeHandler);
         MsgMan.addObserver("AVENGER_CHILDNS_UPDATE",this,__selectChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeClickHandler);
         }
         if(_swordBtn)
         {
            _swordBtn.removeEventListener("click",__swordClickHandler);
         }
         if(_trainBtn)
         {
            _trainBtn.removeEventListener("click",__trainClickHandler);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("change",__textChangHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__selectTempChangeHandler);
         MsgMan.removeObserver("AVENGER_CHILDNS_UPDATE",this,__selectChangeHandler);
      }
      
      private function __selectTempChangeHandler(param1:String, param2:Object) : void
      {
         refreshView(true);
      }
      
      private function __selectChangeHandler(param1:String, param2:Object) : void
      {
         refreshView(false);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_inputText.text);
         var _loc3_:int = Math.min(hasMaterialCount,9999);
         if(_loc2_ <= 0)
         {
            _inputText.text = "1";
         }
         if(_loc2_ >= _loc3_)
         {
            _inputText.text = _loc3_ + "";
         }
      }
      
      private function __upgradeClickHandler(param1:MouseEvent) : void
      {
         if(!nsInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("avenger","CHILDNS_PROP_FRAME",nsInfo);
      }
      
      private function __swordClickHandler(param1:MouseEvent) : void
      {
         if(!nsInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("avenger","CHILDNS_SKILL_FRAME",nsInfo);
      }
      
      private function __trainClickHandler(param1:MouseEvent) : void
      {
         if(!nsInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         if(int(_inputText.text) > hasMaterialCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         AvengerManager.instance.sendChildNsUpgrade(nsInfo.childId,int(_inputText.text));
      }
      
      private function refreshView(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         if(!nsModel.selectedNsChildTemp)
         {
            return;
         }
         nsInfo = model.getNsInfoByJob(nsModel.selectedNsChildTemp.JobType);
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208526);
         _hasMaterialText.htmlText = LanguageMgr.GetTranslation("AvengerBodyView.hasItemText.text",hasMaterialCount);
         if(nsInfo)
         {
            _loc3_ = nsInfo.profileGrade + 1;
            _stageText.text = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc3_) + LanguageMgr.GetTranslation("mounts.command01",nsInfo.stageGrade - model.upgradeDic[nsInfo.profileGrade] + 1);
            _lineImage.setFrame(_loc3_);
            this.filters = [];
            this.mouseChildren = this.mouseEnabled = true;
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType(nsInfo.grade,156);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(nsInfo.grade + 1,156);
            NumberViewUtils.refreshValue(nsInfo.grade,_gradeCon,_numBit,14,22,11,14,"0123456789");
            _liveText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText13",nsInfo.addLive);
            _defenceText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText12",nsInfo.addDefence);
            _attackText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText11",nsInfo.addAttack);
            _pointText.text = nsInfo.point + "";
            if(_loc2_)
            {
               _trainBtn.enable = true;
               _expBar.value = nsInfo.exp / _loc2_.Data;
               _expBar.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",nsInfo.exp,_loc2_.Data);
            }
            else
            {
               _trainBtn.enable = false;
               _expBar.value = 1;
               _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            }
         }
         else
         {
            _stageText.text = LanguageMgr.GetTranslation("mounts.command01",0);
            this.filters = [UIFilter.getGrayFilter()];
            this.mouseChildren = this.mouseEnabled = false;
            NumberViewUtils.refreshValue(0,_gradeCon,_numBit,14,22,11,14,"0123456789");
            _liveText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText13",0);
            _defenceText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText12",0);
            _attackText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolvePropItem.propText11",0);
            _inputText.text = "0";
            _pointText.text = "0";
            _expBar.value = 0;
            _expBar.text = "";
            _lineImage.setFrame(1);
         }
         _loc4_ = 0;
         while(_loc4_ < propList.length)
         {
            propList[_loc4_].data = nsInfo;
            _loc4_++;
         }
         if(getCanLearnSkill())
         {
            _flickerMc.visible = true;
            _flickerMc.gotoAndPlay(1);
         }
         else
         {
            _flickerMc.visible = false;
            _flickerMc.gotoAndStop(1);
         }
         refreshPropMc(param1);
         refreshSkillView();
      }
      
      private function refreshPropMc(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(!nsInfo)
         {
            return;
         }
         if(!_isFirst && !param1)
         {
            _loc2_ = 1;
            while(_loc2_ <= changeAry.length)
            {
               if(changeAry[_loc2_ - 1] > 0)
               {
                  playMovie(this["_addArrowMc" + _loc2_],changeAry[_loc2_ - 1]);
                  this["_delay" + _loc2_] = setTimeout(stopMovie,2000,this["_addArrowMc" + _loc2_],_loc2_);
               }
               _loc2_++;
            }
         }
         _isFirst = false;
         prePropAry = [nsInfo.addLive,nsInfo.addDefence,nsInfo.addAttack];
      }
      
      private function get changeAry() : Array
      {
         if(!nsInfo)
         {
            return [];
         }
         return [nsInfo.addLive - prePropAry[0],nsInfo.addDefence - prePropAry[1],nsInfo.addAttack - prePropAry[2]];
      }
      
      private function playMovie(param1:MovieClip, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         param1.gotoAndPlay(1);
         param1.visible = true;
         var _loc4_:MovieClip = param1["newMc"] as MovieClip;
         var _loc3_:MovieClip = param1["oldMc"] as MovieClip;
         _loc3_.visible = false;
         _loc3_["valueTxt"]["text"] = "";
         _loc4_.gotoAndStop(1);
         _loc4_["valueTxt"]["text"] = param2 + "";
      }
      
      private function stopMovie(param1:MovieClip, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         clearTimeout(this["_delay" + param2]);
         param1.gotoAndStop(1);
         param1.visible = false;
      }
      
      private function refreshSkillView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc1_:SkillTempInfo = null;
         var _loc2_:SkillInfo = null;
         var _loc3_:Array = [];
         var _loc6_:Array = model.getNsSkillList(nsModel.selectedNsChildTemp.SkillMasterType,30);
         _loc3_ = _loc3_.concat(_loc6_);
         _loc6_ = model.getNsSkillList(nsModel.selectedNsChildTemp.SkillMasterType,31);
         _loc3_ = _loc3_.concat(_loc6_);
         _loc6_ = model.getNsSkillList(nsModel.selectedNsChildTemp.SkillMasterType,32);
         _loc3_ = _loc3_.concat(_loc6_);
         _loc4_ = 0;
         while(_loc4_ < skillList.length)
         {
            _loc5_ = _loc3_[_loc4_];
            skillList[_loc4_].icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            _loc1_ = getLearnSkill(_loc4_,_loc5_);
            _loc2_ = new SkillInfo();
            if(_loc1_)
            {
               _loc2_.templateId = _loc1_.TemplateId;
               _loc2_.grade = _loc1_.Grades;
               skillList[_loc4_].filters = [];
               skillList[_loc4_].tipData = _loc4_ == 0 ? _loc1_ : _loc2_;
               skillTextList[_loc4_].text = "";
               levelBgList[_loc4_].visible = true;
               levelTextList[_loc4_].text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",_loc1_.Grades,getSkillMaxGrade(_loc1_));
            }
            else
            {
               skillList[_loc4_].filters = [UIFilter.getGrayFilter()];
               skillList[_loc4_].tipData = null;
               levelBgList[_loc4_].visible = false;
               levelTextList[_loc4_].text = "";
               if(_loc4_ == 0)
               {
                  skillTextList[_loc4_].text = "";
               }
               else
               {
                  skillTextList[_loc4_].text = LanguageMgr.GetTranslation("AvengerChildNsSwordView.nsSkill.openGrade",model.getOpenMinLevelAry(0)[_loc4_ - 1]);
               }
            }
            _loc4_++;
         }
      }
      
      private function getLearnSkill(param1:int, param2:SkillTempInfo) : SkillTempInfo
      {
         if(!nsInfo)
         {
            return null;
         }
         if(param1 == 0)
         {
            return model.getStageSkill(nsModel.selectedNsChildTemp,nsInfo);
         }
         return nsInfo.skillTempDic[param2.Index];
      }
      
      private function getSkillMaxGrade(param1:SkillTempInfo) : int
      {
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndSonType(param1.MasterType,param1.SonType);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      private function getCanLearnSkill() : Boolean
      {
         var _loc7_:SkillTempInfo = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         if(!nsInfo)
         {
            return false;
         }
         var _loc3_:Array = [];
         var _loc13_:Array = model.getNsSkillList(nsInfo.childTemp.SkillMasterType,31);
         _loc3_ = _loc3_.concat(_loc13_);
         _loc13_ = model.getNsSkillList(nsInfo.childTemp.SkillMasterType,32);
         _loc3_ = _loc3_.concat(_loc13_);
         var _loc10_:SkillTempInfo = nsInfo.skillTempDic[31];
         var _loc1_:SkillTempInfo = nsInfo.skillTempDic[32];
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            _loc11_ = _loc4_ == 0 ? 208528 : 208529;
            if(_loc4_ == 0 && _loc10_)
            {
               _loc12_ = int(model.getOpenMinLevelAry(_loc10_.Grades)[_loc4_]);
               _loc7_ = _loc10_;
               _loc6_ = _loc7_.Grades + 1;
               _loc9_ = int(nsInfo.skillExpDic[_loc7_.Index]);
            }
            else if(_loc4_ == 1 && _loc1_)
            {
               _loc12_ = int(model.getOpenMinLevelAry(_loc1_.Grades)[_loc4_]);
               _loc7_ = _loc1_;
               _loc6_ = _loc7_.Grades + 1;
               _loc9_ = int(nsInfo.skillExpDic[_loc7_.Index]);
            }
            else
            {
               _loc7_ = _loc3_[_loc4_];
               _loc12_ = int(model.getOpenMinLevelAry(0)[_loc4_]);
               _loc6_ = int(_loc7_.Grades);
               _loc9_ = 0;
            }
            _loc2_ = _loc7_.Grades >= getSkillMaxGrade(_loc7_);
            _loc5_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc11_));
            _loc8_ = int(model.getLearnCount(_loc7_.Index,_loc6_));
            if(nsInfo.grade >= _loc12_ && _loc5_ + _loc9_ >= _loc8_ && !_loc2_)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
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
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_pointText);
         _pointText = null;
         ObjectUtils.disposeObject(_stageText);
         _stageText = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_swordBtn);
         _swordBtn = null;
         ObjectUtils.disposeObject(_trainBtn);
         _trainBtn = null;
         ObjectUtils.disposeObject(_hasMaterialText);
         _hasMaterialText = null;
         ObjectUtils.disposeObject(_stoneImage);
         _stoneImage = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_liveText);
         _liveText = null;
         ObjectUtils.disposeObject(_defenceText);
         _defenceText = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_lvImage);
         _lvImage = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         ObjectUtils.disposeObject(_tipsImage);
         _tipsImage = null;
         ObjectUtils.disposeViolentMc(_addArrowMc1);
         _addArrowMc1 = null;
         ObjectUtils.disposeViolentMc(_addArrowMc2);
         _addArrowMc1 = null;
         ObjectUtils.disposeViolentMc(_addArrowMc3);
         _addArrowMc3 = null;
         ObjectUtils.disposeViolentMc(_flickerMc);
         _flickerMc = null;
         LogicUtils.disposeDisplayCollection(propList);
         propList = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         LogicUtils.disposeDisplayCollection(skillTextList);
         skillTextList = null;
         LogicUtils.disposeDisplayCollection(levelBgList);
         levelBgList = null;
         LogicUtils.disposeDisplayCollection(levelTextList);
         levelTextList = null;
         super.dispose();
      }
   }
}

