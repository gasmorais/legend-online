package dragontalker.view
{
   import armyII.viewII.rune.FastRuneItem;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.item.DragonTalkPassitiveSkillPane;
   import dragontalker.item.DragonTalkerFastSkillItem;
   import dragontalker.item.DragonTalkerIntiativeSkillPanel;
   import dragontalker.item.DragonTalkerSkillItemViewII;
   import dragontalker.item.DragonTalkerTab;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.KingContractManager;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import utils.LogicUtils;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSkillMainViewII extends Component
   {
      
      private var _back:Bitmap;
      
      private var _bottomContiner:Component;
      
      private var _fastHbox:HBox;
      
      private var _indexBack1:Image;
      
      private var _indexTxt1:FilterFrameText;
      
      private var _indexBack2:Image;
      
      private var _indexTxt2:FilterFrameText;
      
      private var _fastKeyList:Array;
      
      private var _runeKeyList:Array;
      
      private var _curSkillInfo:DragonTalkerSkillInfo;
      
      private var _skillVbox:VBox;
      
      private var _skillPanel:ScrollPanel;
      
      private var _tabBtns:Vector.<DragonTalkerTab>;
      
      private var _tabHbox:HBox;
      
      private var _washBtn:IconButton;
      
      private var _pointText:FilterFrameText;
      
      private var _skillChooseComBox:ComboBox;
      
      private var _currChooseIdx:int = -1;
      
      private var _btnBack:Bitmap;
      
      private var _saveBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _fastBit:Bitmap;
      
      private var _pointBit:Bitmap;
      
      public function DragonTalkerSkillMainViewII()
      {
         super();
         initView();
         initEvent();
         tabIdx = 0;
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pointText);
         _pointText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bottomContiner);
         _bottomContiner = null;
         ObjectUtils.disposeObject(_fastHbox);
         _fastHbox = null;
         ObjectUtils.disposeObject(_indexBack1);
         _indexBack1 = null;
         ObjectUtils.disposeObject(_indexTxt1);
         _indexTxt1 = null;
         ObjectUtils.disposeObject(_indexBack2);
         _indexBack2 = null;
         ObjectUtils.disposeObject(_indexTxt2);
         _indexTxt2 = null;
         ObjectUtils.disposeObject(_skillVbox);
         _skillVbox = null;
         ObjectUtils.disposeObject(_tabHbox);
         _tabHbox = null;
         ObjectUtils.disposeObject(_washBtn);
         _washBtn = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_btnBack);
         _btnBack = null;
         ObjectUtils.disposeObject(_skillChooseComBox);
         _skillChooseComBox = null;
         ObjectUtils.disposeObject(_fastBit);
         _fastBit = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         ObjectUtils.disposeObject(_skillPanel);
         _skillPanel = null;
         super.dispose();
         model.clearSkillPool(true);
         _curSkillInfo = null;
         _fastKeyList = null;
         _runeKeyList = null;
         LogicUtils.disposeDisplayCollection(_tabBtns);
         _tabBtns = null;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cBack");
         _bottomContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.bottomContiner");
         _fastHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.fastHbox");
         _skillPanel = ComponentFactory.Instance.creatComponentByStylename("ui.DragonTalker.skillPanel");
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuak.washBtn");
         _pointText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n1_ppj0vhuak");
         _tabHbox = ComponentFactory.Instance.creatCustomObject("DragonTalker.tabHbox");
         _skillChooseComBox = ComponentFactory.Instance.creatComponentByStylename("dragontalker.QuickSellComBox");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.saveBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.cancelBtn");
         _btnBack = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.btnLongBg");
         _fastBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalker.resource.skill.ppj024");
         _pointBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cPt");
         _skillVbox = new VBox();
         addChild(_back);
         addChild(_bottomContiner);
         addChild(_skillPanel);
         addChild(_tabHbox);
         addChild(_pointText);
         addChild(_washBtn);
         addChild(_skillChooseComBox);
         addChild(_btnBack);
         addChild(_saveBtn);
         addChild(_cancelBtn);
         addChild(_fastBit);
         addChild(_pointBit);
         _skillPanel.setView(_skillVbox);
         _bottomContiner.addChild(_fastHbox);
         _skillChooseComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("dragontalker.case1"));
         _skillChooseComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("dragontalker.case2"));
         _skillChooseComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("dragontalker.case3"));
         refreshCombox();
         _washBtn.x = 650;
         _pointText.x = 620;
         _fastBit.x = 33;
         _fastBit.y = 378;
         initTabs();
         initFastKeyView();
         initRuneView();
         initSkillView();
      }
      
      private function initTabs() : void
      {
         var _loc1_:DragonTalkerTab = null;
         var _loc2_:int = 0;
         _tabBtns = new Vector.<DragonTalkerTab>();
         _tabHbox.beginChanges();
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc1_ = new DragonTalkerTab(_loc2_);
            _tabHbox.addChild(_loc1_);
            _tabBtns[_loc2_ - 1] = _loc1_;
            _loc2_++;
         }
         _tabHbox.commitChanges();
      }
      
      private function set tabIdx(param1:int) : void
      {
         if(param1 < 0 || param1 > 6)
         {
            return;
         }
         _tabBtns[param1].dispatchEvent(new MouseEvent("click"));
      }
      
      private function refreshView() : void
      {
         _curSkillInfo = model.getSkillInfoByIndex(model.skillTabIndex);
         _pointText.text = _curSkillInfo ? _curSkillInfo.skillPoint + "" : "0";
         _washBtn.enable = _curSkillInfo ? !StringHelper.isNullOrEmpty(_curSkillInfo.hasLearnSkill) : false;
         refreshSkillList();
         refreshRuneKeyList();
         refreshFastList();
         refreshBtns();
         refreshCombox();
      }
      
      private function initSkillView() : void
      {
         var _loc1_:Array = null;
         var _loc3_:DragonTalkerIntiativeSkillPanel = null;
         var _loc5_:int = 0;
         var _loc4_:DragonTalkPassitiveSkillPane = null;
         _skillVbox.beginChanges();
         _loc5_ = 131;
         while(_loc5_ <= 135)
         {
            _loc1_ = model.getSkillInfosBySontypeRule(_loc5_);
            if(_loc1_ && _loc1_.length > 0)
            {
               _loc3_ = new DragonTalkerIntiativeSkillPanel(_loc5_ - 130);
               _loc3_.refreshViewByList(_loc1_);
               _skillVbox.addChild(_loc3_);
            }
            _loc5_++;
         }
         var _loc2_:Array = [];
         _loc5_ = 136;
         while(_loc5_ <= 145)
         {
            _loc1_ = model.getSkillInfosBySontypeRule(_loc5_);
            if(_loc1_ && _loc1_.length > 0)
            {
               _loc2_.push(_loc1_);
            }
            _loc5_++;
         }
         if(_loc2_.length > 0)
         {
            _loc4_ = new DragonTalkPassitiveSkillPane();
            _loc4_.refreshViewByList(_loc2_);
            _skillVbox.addChild(_loc4_);
         }
         _skillVbox.commitChanges();
         _skillPanel.invalidateViewport();
      }
      
      private function refreshSkillList() : void
      {
         var _loc1_:SkillInfo = null;
         var _loc3_:Dictionary = model.skillItemDic;
         for each(var _loc2_:DragonTalkerSkillItemViewII in _loc3_)
         {
            _loc1_ = _loc2_.data;
            _loc2_.data = model.allSkillInfoDic[_loc1_.templateId];
         }
      }
      
      private function initFastKeyView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerFastSkillItem = null;
         _fastKeyList = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new DragonTalkerFastSkillItem();
            _loc1_.index = _loc2_ + 1;
            _fastHbox.addChild(_loc1_);
            _fastKeyList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshFastList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerFastSkillItem = null;
         var _loc5_:SkillInfo = null;
         var _loc3_:Array = _curSkillInfo ? _curSkillInfo.fastKeySkills : [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc4_ = int(_loc3_[_loc2_]);
            _loc1_ = _fastKeyList[_loc2_] as DragonTalkerFastSkillItem;
            if(_loc2_ < _loc3_.length)
            {
               _loc5_ = model.allSkillInfoDic[_loc4_];
               _loc1_.data = _loc5_;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      private function refreshBtns() : void
      {
         _saveBtn.enable = _cancelBtn.enable = model.isClientLearn();
      }
      
      private function refreshCombox(param1:Boolean = false) : void
      {
         if(_currChooseIdx == model.skillTabIndex - 1 && !param1)
         {
            return;
         }
         _currChooseIdx = model.skillTabIndex - 1;
         _skillChooseComBox.listPanel.list.defaultSelectItemByCellValue = _skillChooseComBox.listPanel.vectorListModel.getElementAt(_currChooseIdx);
      }
      
      private function initRuneView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:RuneTemplateInfo = null;
         var _loc7_:RuneInfo = null;
         _runeKeyList = [];
         var _loc6_:Array = thane.runeCate.runeScript.split(",");
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc2_ = new FastRuneItem();
            _bottomContiner.addChild(_loc2_);
            _loc2_.x = 544 + _loc5_ * 82;
            _loc2_.y = 12;
            _loc1_ = thane.grades < 35 + _loc5_ * 5;
            _loc2_.isLock = _loc1_;
            _loc2_.buttonMode = true;
            if(!_loc2_.isLock && _loc5_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_[_loc5_]);
               if(_loc3_)
               {
                  _loc7_ = thane.runeCate.getInfoByIndex(_loc3_.RuneIndex);
                  _loc2_.data = _loc7_;
                  _loc2_.refreshView();
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _runeKeyList.push(_loc2_);
            _loc2_.setBySkillView(true);
            _loc2_.addEventListener("click",__clickRuneHandler);
            _loc2_.width = _loc2_.height = 62;
            _loc2_.mouseEnabled = _loc2_.mouseChildren = thane.grades >= 35;
            _loc5_++;
         }
         _indexBack1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndex1");
         _indexTxt1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndexTxt1");
         _indexBack2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndex2");
         _indexTxt2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndexTxt2");
         _indexTxt1.text = "Z";
         _indexTxt2.text = "X";
         _bottomContiner.addChild(_indexBack1);
         _bottomContiner.addChild(_indexTxt1);
         _bottomContiner.addChild(_indexBack2);
         _bottomContiner.addChild(_indexTxt2);
      }
      
      private function refreshRuneKeyList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:RuneTemplateInfo = null;
         var _loc7_:RuneInfo = null;
         var _loc6_:Array = thane.runeCate.runeScript.split(",");
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc2_ = _runeKeyList[_loc5_] as FastRuneItem;
            _loc1_ = thane.grades < 35 + _loc5_ * 5;
            _loc2_.isLock = _loc1_;
            _loc2_.buttonMode = true;
            _loc2_.data = null;
            if(!_loc2_.isLock && _loc5_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_[_loc5_]);
               if(_loc3_)
               {
                  _loc7_ = thane.runeCate.getInfoByIndex(_loc3_.RuneIndex);
                  _loc2_.data = _loc7_;
               }
            }
            _loc2_.refreshView();
            _loc5_++;
         }
      }
      
      private function clickwashBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc6_:int = int(TempleteManager.instance.getConfigInfoByConfigName("ResetSkill_NeedPay").ConfigValue);
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.skill.content01",_loc6_);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(KingContractManager.Instance.checkHasBuffById(9))
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.skill.content02");
            SimpleAlertHelper.instance.data = [alertBackHandler];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [payCallBackHandler,_loc6_];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DragonTalkerManager.instance.sendSkillRequest(12,model.skillTabIndex);
         }
      }
      
      private function payCallBackHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc4_ >= param3)
         {
            _loc5_ = param2 ? 2 : 1;
            DragonTalkerManager.instance.sendSkillRequest(12,model.skillTabIndex,null,null,_loc5_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __clickRuneHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,1);
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:DragonTalkerTab in _tabBtns)
         {
            _loc1_.addEventListener("click",tabClickHandler);
         }
         _washBtn.addEventListener("click",clickwashBtnHandler);
         _saveBtn.addEventListener("click",clickSaveBtnHandler);
         _cancelBtn.addEventListener("click",clickCancelBtnHandler);
         _skillChooseComBox.listPanel.list.addEventListener("listItemClick",__onQuickSellItemClick);
         MsgMan.addObserver("SET_FAST_KEY",this,__setFastKeyHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:DragonTalkerTab in _tabBtns)
         {
            _loc1_.removeEventListener("click",tabClickHandler);
         }
         _washBtn.removeEventListener("click",clickwashBtnHandler);
         _saveBtn.removeEventListener("click",clickSaveBtnHandler);
         _cancelBtn.removeEventListener("click",clickCancelBtnHandler);
         _skillChooseComBox.listPanel.list.removeEventListener("listItemClick",__onQuickSellItemClick);
         MsgMan.removeObserver("SET_FAST_KEY",this,__setFastKeyHandler);
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function clickSaveBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = [];
         var _loc4_:Dictionary = model.opPoolDic;
         for each(var _loc3_:int in _loc4_)
         {
            _loc2_.push(_loc3_);
         }
         if(_loc2_.length > 0)
         {
            DragonTalkerManager.instance.sendSkillRequest(11,model.skillTabIndex,_loc2_);
         }
      }
      
      private function clickCancelBtnHandler(param1:MouseEvent) : void
      {
         model.clearSkillPool(true);
         clearNoSaveFlgs();
      }
      
      private function clearNoSaveFlgs() : void
      {
         var _loc2_:Dictionary = model.skillItemDic;
         for each(var _loc1_:DragonTalkerSkillItemViewII in _loc2_)
         {
            if(_loc1_)
            {
               _loc1_.clearNoSave();
            }
         }
      }
      
      private function __onQuickSellItemClick(param1:ListItemEvent) : void
      {
         var _loc2_:int = quickSellType;
         if(_loc2_ > model.skillCount)
         {
            buySkillCount(model.skillCount + 1);
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("dragontalker.case" + _loc2_);
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("dragontalker.changeCase",_loc3_));
         DragonTalkerManager.instance.sendSkillRequest(10,_loc2_);
      }
      
      public function get quickSellType() : int
      {
         return _skillChooseComBox ? _skillChooseComBox.currentSelectedIndex + 1 : 0;
      }
      
      private function buySkillCount(param1:int) : void
      {
         var _loc6_:Array = [1,1];
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("dragon_buy_skill_point");
         if(_loc2_)
         {
            _loc6_ = _loc2_.ConfigValue.split(",");
         }
         var _loc8_:int = int(_loc6_[param1 - 2]);
         var _loc3_:String = LanguageMgr.GetTranslation("dragontalker.buySkill.Tip",_loc8_,param1);
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [buySkillCallBackHandler,_loc8_,param1];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc3_,_loc4_,_loc5_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc8_);
      }
      
      private function buySkillCallBackHandler(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!param1)
         {
            refreshCombox(true);
            return;
         }
         if(param2)
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc5_ >= param3)
         {
            _loc6_ = param2 ? 2 : 1;
            DragonTalkerManager.instance.sendSkillRequest(19,param4,null,null,_loc6_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function tabClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DragonTalkerTab = null;
         var _loc3_:DisplayObject = null;
         for each(_loc2_ in _tabBtns)
         {
            _loc2_.selected = false;
         }
         _loc2_ = param1.currentTarget as DragonTalkerTab;
         _loc2_.selected = true;
         var _loc4_:int = _loc2_.idx;
         if(_skillVbox.numChildren >= _loc4_)
         {
            if(_loc4_ <= 1)
            {
               _skillPanel.vScrollbar.scrollValue = 0;
            }
            else
            {
               _loc3_ = _skillVbox.getChildAt(_loc4_ - 2);
               _skillPanel.vScrollbar.scrollValue = _loc3_.y + _loc3_.height;
            }
         }
      }
      
      private function __updateSkillViewHandler(param1:String, param2:Object) : void
      {
         if(param2)
         {
            clearNoSaveFlgs();
         }
         refreshView();
      }
      
      private function __setFastKeyHandler(param1:String, param2:Object) : void
      {
         DragonTalkerManager.instance.sendSkillRequest(13,model.skillTabIndex,null,fastKey);
      }
      
      public function get fastKey() : String
      {
         var _loc4_:int = 0;
         var _loc2_:DragonTalkerFastSkillItem = null;
         var _loc1_:String = "";
         var _loc3_:int = int(_fastKeyList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _fastKeyList[_loc4_] as DragonTalkerFastSkillItem;
            if(_loc2_.data)
            {
               _loc1_ += _loc2_.data.templateId + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

