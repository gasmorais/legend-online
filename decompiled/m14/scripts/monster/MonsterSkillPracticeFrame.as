package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import monster.item.MonsterIconCell;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MonsterManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterSkillPracticeFrame extends Frame implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _nextContiner:Component;
      
      private var _nextImage:MutipleImage;
      
      private var _nextGradeCon:Component;
      
      private var _curGradeCon:Component;
      
      private var _numBit:BitmapData;
      
      private var _expBar:ProgressCommon;
      
      private var _skillIcon:BaseIconView;
      
      private var _curDescText:FilterFrameText;
      
      private var _nextDescText:FilterFrameText;
      
      private var _materialBox:SimpleTileList;
      
      private var materialList:Vector.<MonsterIconCell>;
      
      private var _bagList:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var bagList:Vector.<MonsterIconCell>;
      
      private var _goldText:FilterFrameText;
      
      private var _practiceBtn:IconButton;
      
      private var skillTemp:SkillTempInfo;
      
      private var skillInfo:SkillInfo;
      
      private var upgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var needGold:Number = 0;
      
      private var curMonster:MonsterInfo;
      
      public function MonsterSkillPracticeFrame()
      {
         super();
         initView();
         initMaterialView();
         initBagView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,507,521);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.back");
         _nextContiner = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.nextContiner");
         _nextImage = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.nextImage");
         _nextGradeCon = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.nextGradeCon");
         _curGradeCon = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.curGradeCon");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.MonsterPropView.lvBmd");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.expBar");
         _goldText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.goldText");
         _practiceBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.practiceBtn");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("MonsterSkillPracticeFrame.skillIcon");
         _curDescText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.curDescText");
         _nextDescText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.nextDescText");
         _materialBox = ComponentFactory.Instance.creatCustomObject("MonsterSkillPracticeFrame.materialBox",[3]);
         _bagList = ComponentFactory.Instance.creatCustomObject("MonsterSkillPracticeFrame.SimpleTileList",[5]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillPracticeFrame.EquipScrollPanel");
         addToContent(_back);
         addToContent(_skillIcon);
         addToContent(_curDescText);
         addToContent(_nextDescText);
         addToContent(_curGradeCon);
         addToContent(_nextContiner);
         addToContent(_expBar);
         addToContent(_materialBox);
         addToContent(_bagScroll);
         addToContent(_goldText);
         addToContent(_practiceBtn);
         _bagScroll.setView(_bagList);
         _nextContiner.addChild(_nextImage);
         _nextContiner.addChild(_nextGradeCon);
      }
      
      private function initMaterialView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterIconCell = null;
         materialList = new Vector.<MonsterIconCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new MonsterIconCell(2);
            _materialBox.addChild(_loc1_);
            materialList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initBagView() : void
      {
         var _loc2_:* = 0;
         var _loc1_:MonsterIconCell = null;
         bagList = new Vector.<MonsterIconCell>();
         _bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 70)
         {
            _loc1_ = new MonsterIconCell(1);
            _bagList.addChild(_loc1_);
            bagList.push(_loc1_);
            _loc2_++;
         }
         _bagList.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMoveHandler);
         _practiceBtn.addEventListener("click",__practiceClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMoveHandler);
         if(_practiceBtn)
         {
            _practiceBtn.removeEventListener("click",__practiceClickHandler);
         }
      }
      
      private function __practiceClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = model.getMonsterIds(model.monsterMaterialList);
         if(_loc2_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterSkillPracticeFrame.noMonster.alert"));
            return;
         }
         if(ResourceManager.instance.gold.count < needGold)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
            return;
         }
         MonsterManager.instance.sendMonsterSkillPractice(curMonster.monsterId,skillTemp.TemplateId,_loc2_);
      }
      
      private function __updateMoveHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function setCurMonster(param1:MonsterInfo) : void
      {
         curMonster = param1;
      }
      
      public function setSkillTemp(param1:SkillTempInfo) : void
      {
         skillTemp = param1;
         refreshView();
      }
      
      private function getCurSkillTemp() : SkillTempInfo
      {
         for each(var _loc1_:SkillTempInfo in curMonster.skillAry)
         {
            if(_loc1_.SonType == skillTemp.SonType)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:SkillTempInfo = null;
         if(!skillTemp || !curMonster)
         {
            return;
         }
         curMonster = model.monsterDic[curMonster.monsterId];
         skillTemp = getCurSkillTemp();
         skillInfo = new SkillInfo();
         skillInfo.templateId = skillTemp.TemplateId;
         skillInfo.grade = skillTemp.Grades;
         refreshBagView();
         upgradeTemp = model.skillUpgradeTempAry[skillTemp.Grades - 1];
         nextUpgradeTemp = model.skillUpgradeTempAry.length > skillTemp.Grades ? model.skillUpgradeTempAry[skillTemp.Grades] : null;
         _skillIcon.icon = IconFactory.getTecIconByIcon(skillTemp.Icons);
         _skillIcon.tipData = skillInfo;
         _curDescText.text = skillTemp.Description;
         NumberViewUtils.refreshValue(skillTemp.Grades,_curGradeCon,_numBit,18,22,14,18,"0123456789");
         needGold = model.getSkillPracticeNeedGold(model.monsterMaterialList);
         _goldText.text = needGold + "";
         var _loc2_:int = int(model.getSkillExp(curMonster,skillTemp.TemplateId));
         if(model.monsterMaterialList.length <= 0)
         {
            _nextContiner.visible = false;
            _expBar.text = _loc2_ + "/" + upgradeTemp.Data;
            _expBar.value = _loc2_ / upgradeTemp.Data;
            _nextDescText.text = "";
            _practiceBtn.enable = false;
         }
         else
         {
            _practiceBtn.enable = true;
            _nextContiner.visible = true;
            _loc5_ = int(model.getSkillPracticeTotalExp(_loc2_,model.monsterMaterialList));
            _loc3_ = int(TempleteManager.instance.getUpgradeTempMaxGradeByType(149));
            _loc1_ = TempleteManager.instance.getUpgradeTotalInfo(149,_loc5_,upgradeTemp.Grades,_loc3_);
            _loc6_ = int(_loc1_[1]);
            _loc4_ = model.getUpgradeSkillTemp(skillTemp,_loc6_);
            _nextDescText.text = _loc4_.Description;
            NumberViewUtils.refreshValue(_loc4_.Grades,_nextGradeCon,_numBit,18,22,14,18,"0123456789");
            if(_loc6_ <= upgradeTemp.Grades)
            {
               _nextContiner.visible = false;
               _nextDescText.text = "";
               _expBar.text = _loc5_ + "/" + upgradeTemp.Data;
               _expBar.value = _loc5_ / upgradeTemp.Data;
            }
            else if(_loc6_ >= _loc3_)
            {
               _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
               _expBar.value = _loc5_ / upgradeTemp.Data;
            }
            else
            {
               _expBar.text = _loc1_[2] + "/" + _loc1_[3];
               _expBar.value = int(_loc1_[2]) / int(_loc1_[3]);
            }
         }
         if(!nextUpgradeTemp)
         {
            _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
            _expBar.value = 1;
         }
      }
      
      private function refreshBagView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:MonsterInfo = null;
         var _loc4_:int = 0;
         var _loc6_:MonsterInfo = null;
         clearBagView();
         var _loc1_:Array = model.getMonsterBagShowList();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc3_] as MonsterInfo;
            bagList[_loc3_].data = _loc5_;
            _loc3_++;
         }
         _bagScroll.invalidateViewport();
         var _loc2_:Array = model.monsterMaterialList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_] as MonsterInfo;
            materialList[_loc4_].data = _loc6_;
            _loc4_++;
         }
         _bagScroll.invalidateViewport();
      }
      
      private function clearBagView() : void
      {
         for each(var _loc1_:MonsterIconCell in bagList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:MonsterIconCell in materialList)
         {
            _loc2_.data = null;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("MonsterSkillPracticeFrame.title.text");
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.resetMonsterBagList();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_nextContiner);
         _nextContiner = null;
         ObjectUtils.disposeObject(_nextImage);
         _nextImage = null;
         ObjectUtils.disposeObject(_nextGradeCon);
         _nextGradeCon = null;
         ObjectUtils.disposeObject(_curGradeCon);
         _curGradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_materialBox);
         _materialBox = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_goldText);
         _goldText = null;
         ObjectUtils.disposeObject(_practiceBtn);
         _practiceBtn = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_curDescText);
         _curDescText = null;
         ObjectUtils.disposeObject(_nextDescText);
         _nextDescText = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         LogicUtils.disposeDisplayCollection(bagList);
         bagList = null;
         super.dispose();
      }
   }
}

