package armyII
{
   import armyII.viewII.lineUp.LineUpView;
   import armyII.viewII.rune.RuneView;
   import armyII.viewII.skill.SkillView;
   import armyII.viewII.skill.SkillitemView;
   import armyII.viewII.stone.view.StoneGetView;
   import armyII.viewII.talent.TalentTabBtnView;
   import armyII.viewII.talent.TalentView;
   import armyII.viewII.talent.TransferTalentView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.guild.QteSkillGuide;
   import yishi.view.tips.MessageTipManager;
   
   public class SkillFrame extends Frame
   {
      
      private var _skillView:SkillView;
      
      private var _talentView:TalentView;
      
      private var _transferTalentView:TransferTalentView;
      
      private var _runeView:RuneView;
      
      private var _lineUpView:LineUpView;
      
      private var _stoneView:StoneGetView;
      
      private var _talentTabView:TalentTabBtnView;
      
      private var _helpBtn:BaseButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _buttonMc1:MovieClip;
      
      private var _buttonMc2:MovieClip;
      
      private var _talentBtn:SelectedIconButton;
      
      private var _runeBtn:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _armyBtn:SelectedIconButton;
      
      private var _stoneBtn:SelectedIconButton;
      
      private var _back1:Scale9CornerImage;
      
      private var _currentGroupIndex:int = 0;
      
      private var _addFlagIcon1:Bitmap;
      
      private var _addFlagIcon2:Bitmap;
      
      private var _runeCarryTwoLevel:int = int(TempleteManager.instance.getConfigInfoByConfigName("CarryTwoRune").ConfigValue);
      
      private var _runeOpenLevel:int = int(TempleteManager.instance.getConfigInfoByConfigName("OpenRuneGrade").ConfigValue);
      
      private var _runeSwallowMax:int = int(TempleteManager.instance.getConfigInfoByConfigName("RuneSwallowMax").ConfigValue);
      
      private var _skillBtnTipsView:MovieClip;
      
      private var _runeBtnTipsView:MovieClip;
      
      private var _talentTipsView:MovieClip;
      
      private var _armyBtnStrip:StripView;
      
      private var _runeBtnStrip:StripView;
      
      private var _talentBtnStrip:StripView;
      
      private var _btnVbox:VBox;
      
      private var _canStudyRunCount:int;
      
      public function SkillFrame()
      {
         super();
         initView();
         initEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("army.SkillFrameBack");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.SkillHelpBtn");
         _tabGroup = new SelectedButtonGroup();
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("army.navigate.SkillBtn");
         _talentBtn = ComponentFactory.Instance.creatComponentByStylename("army.navigate.TalentBtn");
         _armyBtn = ComponentFactory.Instance.creatComponentByStylename("army.navigate.armyBtn");
         _runeBtn = ComponentFactory.Instance.creatComponentByStylename("army.navigate.RuneBtn");
         _stoneBtn = ComponentFactory.Instance.creatComponentByStylename("army.navigate.stoneBtn");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("army.runeBtnMc");
         _buttonMc2 = ComponentFactory.Instance.creatCustomObject("army.talentBtnMc");
         _addFlagIcon1 = ComponentFactory.Instance.creatBitmap("army.navigate.AddFlagIcon");
         _addFlagIcon2 = ComponentFactory.Instance.creatBitmap("army.navigate.AddFlagIcon");
         _armyBtnStrip = ComponentFactory.Instance.creatCustomObject("army.navigate.armyBtnStrip");
         _runeBtnStrip = ComponentFactory.Instance.creatCustomObject("army.navigate.runeBtnStrip");
         _talentBtnStrip = ComponentFactory.Instance.creatCustomObject("army.navigate.talentBtnStrip");
         _btnVbox = new VBox();
         _tabGroup.addSelectItem(_skillBtn);
         _tabGroup.addSelectItem(_runeBtn);
         _tabGroup.addSelectItem(_talentBtn);
         _tabGroup.addSelectItem(_armyBtn);
         _buttonMc1.gotoAndStop(1);
         _buttonMc1["pos"].addChild(_runeBtn);
         _buttonMc1["pos"].addChild(_addFlagIcon1);
         stopRuneMc();
         addToContent(_buttonMc1);
         _buttonMc2.gotoAndStop(1);
         _buttonMc2["pos"].addChild(_talentBtn);
         _buttonMc2["pos"].addChild(_addFlagIcon2);
         stopTalentMc();
         addToContent(_buttonMc2);
         addToContent(_skillBtn);
         addToContent(_armyBtn);
         if(thane.runeStoneOpen && Boolean(VersionSwitch.RUNE_STONE))
         {
            _tabGroup.addSelectItem(_stoneBtn);
            addToContent(_stoneBtn);
            _buttonMc2.y = 305;
            _talentBtnStrip.x = 1;
            _talentBtnStrip.y = 330;
         }
         else
         {
            _buttonMc2.y = 286;
            _talentBtnStrip.x = 1;
            _talentBtnStrip.y = 250;
         }
         addToContent(_back1);
         addToContent(_armyBtnStrip);
         addToContent(_runeBtnStrip);
         addToContent(_talentBtnStrip);
         _talentBtn.enable = true;
         initSkillView();
         _tabGroup.selectIndex = 0;
         setButtonState();
         _skillBtnTipsView = getBtnTipView();
         _runeBtnTipsView = getBtnTipView();
         _talentTipsView = getBtnTipView();
         _skillBtn.addChild(_skillBtnTipsView);
         _runeBtn.addChild(_runeBtnTipsView);
         _talentBtn.addChild(_talentTipsView);
         _armyBtn.enable = thane.grades >= 11;
         _runeBtn.enable = thane.grades >= 35;
         _stoneBtn.enable = thane.grades >= 35;
         _talentBtn.enable = thane.grades >= 50;
         _armyBtnStrip.setTarget(_armyBtn);
         _armyBtnStrip.x = 1;
         _armyBtnStrip.y = 83;
         _runeBtnStrip.setTarget(_runeBtn);
         _runeBtnStrip.x = 1;
         _runeBtnStrip.y = 164;
         _talentBtnStrip.setTarget(_talentBtn);
         _armyBtnStrip.visible = thane.grades < 11;
         _runeBtnStrip.visible = thane.grades < 35;
         _talentBtnStrip.visible = thane.grades < 50;
         _armyBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",11);
         _runeBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",35);
         _talentBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",50);
         updateBtnTipView();
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
      
      private function updateBtnTipView(param1:Event = null) : void
      {
         _skillBtnTipsView.visible = false;
         _runeBtnTipsView.visible = false;
         _talentTipsView.visible = false;
         if(thane.skillCate.skillPoint > 0)
         {
            _skillBtnTipsView.txt.text = thane.skillCate.skillPoint.toString();
            _skillBtnTipsView.visible = true;
         }
         if(thane.talentData.talentPoint > 0)
         {
            _talentTipsView.txt.text = thane.talentData.talentPoint.toString();
            _talentTipsView.visible = true;
         }
         if(thane.talentData.talentPoint <= 0 && thane.talentData.advTalentPoint > 0)
         {
            _talentTipsView.txt.text = thane.talentData.advTalentPoint;
            _talentTipsView.visible = true;
         }
         var _loc2_:int = int(InfoTipsManager.instance.getValueByKey(16));
         if(_loc2_ > 0)
         {
            _runeBtnTipsView.txt.text = _loc2_.toString();
            _runeBtnTipsView.visible = true;
         }
      }
      
      private function setButtonState() : void
      {
         if(runeBtnNeedShine && thane.grades >= _runeOpenLevel)
         {
         }
         if(talentBtnNeedShine && thane.grades >= 50)
         {
         }
      }
      
      private function canStudy(param1:RuneInfo) : Boolean
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         _loc2_.sortOn("pos",16);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as GoodsInfo;
            if(_loc4_.templateInfo.Property1 == param1.templateInfo.RuneType)
            {
               if(_loc4_.isBinds)
               {
                  _loc5_ = _loc4_;
                  return true;
               }
               if(!_loc5_)
               {
                  _loc5_ = _loc4_;
               }
            }
            _loc3_++;
         }
         if(_loc5_)
         {
            return true;
         }
         return false;
      }
      
      private function get runeBtnNeedShine() : Boolean
      {
         var _loc3_:int = 0;
         var _loc8_:RuneInfo = null;
         var _loc4_:RuneTemplateInfo = null;
         var _loc1_:RuneTemplateInfo = null;
         var _loc7_:Array = thane.runeCate.allRuneList.getList();
         var _loc5_:Boolean = this.hasRuneGoods;
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         for(var _loc6_:String in _loc7_)
         {
            _loc3_ = int(_loc6_);
            _loc8_ = _loc7_[_loc3_];
            if(_loc8_)
            {
               if(_loc8_.grade == 0)
               {
                  if(canStudy(_loc8_))
                  {
                     return true;
                  }
               }
               else if(_loc5_)
               {
                  _loc4_ = _loc8_.templateInfo;
                  _loc1_ = _loc8_.nextTemplateInfo;
                  if(_loc4_)
                  {
                     if(_loc1_)
                     {
                        if(_loc4_.Level == 0)
                        {
                           if(_loc8_.grade < 10 && _loc8_.swallowCount < _runeSwallowMax && thane.grades >= _loc1_.NeedGrade)
                           {
                              return true;
                           }
                        }
                        else if(_loc4_.Level == 1)
                        {
                           if(_loc8_.grade < 8 && _loc8_.swallowCount < _runeSwallowMax && _loc2_.vocationGrades >= _loc1_.NeedGrade)
                           {
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      private function get canStudyRune() : int
      {
         var _loc3_:int = 0;
         var _loc8_:RuneInfo = null;
         var _loc4_:RuneTemplateInfo = null;
         var _loc1_:RuneTemplateInfo = null;
         _canStudyRunCount = 0;
         var _loc7_:Array = thane.runeCate.allRuneList.getList();
         var _loc5_:Boolean = this.hasRuneGoods;
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         for(var _loc6_:String in _loc7_)
         {
            _loc3_ = int(_loc6_);
            _loc8_ = _loc7_[_loc3_];
            if(_loc8_)
            {
               if(_loc8_.grade == 0)
               {
                  if(canStudy(_loc8_))
                  {
                     _canStudyRunCount = _canStudyRunCount + 1;
                  }
               }
               if(_loc5_)
               {
                  _loc4_ = _loc8_.templateInfo;
                  _loc1_ = _loc8_.nextTemplateInfo;
                  if(_loc4_)
                  {
                     if(_loc1_)
                     {
                        if(_loc4_.Level == 0)
                        {
                           if(_loc8_.grade < 10 && _loc8_.swallowCount < _runeSwallowMax && thane.grades >= _loc1_.NeedGrade)
                           {
                              _canStudyRunCount = _canStudyRunCount + 1;
                           }
                        }
                        else if(_loc4_.Level == 1)
                        {
                           if(_loc8_.grade < 8 && _loc8_.swallowCount < _runeSwallowMax && _loc2_.vocationGrades >= _loc1_.NeedGrade)
                           {
                              _canStudyRunCount = _canStudyRunCount + 1;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _canStudyRunCount;
      }
      
      private function get talentBtnNeedShine() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.talentData.talentGrade + 1,21);
         if(_loc1_)
         {
            _loc2_ = int(_loc1_.TemplateId);
            _loc3_ = int(_loc1_.Data);
            if(ResourceManager.instance.gold.count >= _loc2_ && thane.gp >= _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get hasRuneGoods() : Boolean
      {
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         return _loc1_.length > 0 ? true : false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showSkillView() : void
      {
         if(_skillView)
         {
            return;
         }
         _skillView = ComponentFactory.Instance.creatCustomObject("army.SkillPanel");
         addToContent(_skillView);
         _skillView.addEventListener("OPEN_RUNE_VIEW",__openRuneViewhandler);
      }
      
      private function showTransferTalentView() : void
      {
         if(_transferTalentView)
         {
            return;
         }
         _transferTalentView = new TransferTalentView();
         addToContent(_transferTalentView);
      }
      
      private function showTalentView() : void
      {
         if(_talentView)
         {
            return;
         }
         _talentView = new TalentView();
         addToContent(_talentView);
      }
      
      private function showRuneView() : void
      {
         if(_runeView)
         {
            return;
         }
         _runeView = new RuneView();
         addToContent(_runeView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
         _tabGroup.addEventListener("change",panelChangeHandler);
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",updateBtnTipView);
         NotificationManager.instance.addEventListener("OPEN_RUNESTONE",updateStoneBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
         _tabGroup.removeEventListener("change",panelChangeHandler);
         NotificationManager.instance.removeEventListener("INFO_TIPS_DATA_UPDATE",updateBtnTipView);
         NotificationManager.instance.removeEventListener("OPEN_RUNESTONE",updateStoneBtnHandler);
      }
      
      private function updateStoneBtnHandler(param1:Event) : void
      {
         if(thane.runeStoneOpen && _stoneBtn.parent == null)
         {
            _tabGroup.addSelectItem(_stoneBtn);
            addToContent(_stoneBtn);
         }
      }
      
      private function __openRuneViewhandler(param1:Event) : void
      {
         _tabGroup.selectIndex = 1;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("022");
         QteSkillGuide.cleanAlert();
         switch(int(_tabGroup.selectIndex))
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.SkillHelpFrame");
               break;
            case 1:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.RuneHelpFrame");
               break;
            case 2:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.TalentHelpFrame");
               break;
            case 3:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.ArmyHelpFrame");
               break;
            default:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.SkillHelpFrame");
         }
         _loc2_.show();
      }
      
      private function panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ISelectable = _tabGroup.getSelectedItem();
         if(_talentTabView)
         {
            _talentTabView.parent.removeChild(_talentTabView);
            ObjectUtils.disposeObject(_talentTabView);
            _talentTabView = null;
         }
         switch(_loc2_)
         {
            case _skillBtn:
               initSkillView();
               this.containerY = 67;
               this.height = 520;
               _helpBtn.y = -47;
               break;
            case _talentBtn:
               initTalentView();
               if(thane.grades > 50 && !thane.isChangeJob)
               {
                  this.containerY = 87;
                  this.height = 540;
                  _helpBtn.y = -67;
                  if(!_talentTabView)
                  {
                     _talentTabView = ComponentFactory.Instance.creatCustomObject("army.talentTabView");
                     addToContent(_talentTabView);
                  }
               }
               else
               {
                  this.containerY = 67;
                  this.height = 520;
                  _helpBtn.y = -47;
               }
               break;
            case _runeBtn:
               initRuneView();
               this.containerY = 67;
               this.height = 520;
               _helpBtn.y = -47;
               break;
            case _armyBtn:
               initLineUp();
               this.containerY = 67;
               this.height = 520;
               _helpBtn.y = -47;
               break;
            case _stoneBtn:
               initStoneView();
               this.containerY = 67;
               this.height = 520;
               _helpBtn.y = -47;
         }
         _currentGroupIndex = _tabGroup.selectIndex;
      }
      
      private function initSkillView() : void
      {
         disposeTalent();
         disposeRune();
         disposeLineUp();
         disposeStone();
         showSkillView();
         titleText = LanguageMgr.GetTranslation("armyII.SkillFrame.title");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.HelpBtn.Tipdata");
      }
      
      private function stopRuneMc() : void
      {
         _addFlagIcon1.visible = false;
      }
      
      private function initRuneView() : void
      {
         if(thane.grades < _runeOpenLevel)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",_runeOpenLevel));
            _tabGroup.selectIndex = _currentGroupIndex;
            return;
         }
         disposeTalent();
         disposeSkill();
         disposeLineUp();
         disposeStone();
         showRuneView();
         titleText = LanguageMgr.GetTranslation("armyII.SkillFrame.runeTitle");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.HelpBtn.RuneTipdata");
         stopRuneMc();
      }
      
      private function initStoneView() : void
      {
         disposeTalent();
         disposeRune();
         disposeSkill();
         disposeLineUp();
         showStoneView();
         titleText = LanguageMgr.GetTranslation("runetip.stone.title");
      }
      
      private function showStoneView() : void
      {
         if(_stoneView)
         {
            return;
         }
         _stoneView = new StoneGetView();
         _stoneView.x = 37;
         addToContent(_stoneView);
      }
      
      private function disposeStone() : void
      {
         ObjectUtils.disposeObject(_stoneView);
         _stoneView = null;
         QteSkillGuide.cleanAlert();
      }
      
      private function initLineUp() : void
      {
         if(thane.grades < 11)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",11));
            _tabGroup.selectIndex = _currentGroupIndex;
            return;
         }
         disposeRune();
         disposeSkill();
         disposeTalent();
         disposeStone();
         showLineUp();
         titleText = LanguageMgr.GetTranslation("armyII.SkillFrame.lineUpTitle");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.HelpBtn.LineUpTipdata");
      }
      
      private function showLineUp() : void
      {
         if(_lineUpView)
         {
            return;
         }
         _lineUpView = new LineUpView();
         _lineUpView.x = 42;
         _lineUpView.y = 1;
         addToContent(_lineUpView);
      }
      
      private function stopTalentMc() : void
      {
         _addFlagIcon2.visible = false;
      }
      
      private function initTalentView() : void
      {
         if(thane.grades < 50)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",50));
            _tabGroup.selectIndex = _currentGroupIndex;
            return;
         }
         disposeSkill();
         disposeRune();
         disposeLineUp();
         disposeStone();
         if(thane.isChangeJob)
         {
            showTransferTalentView();
         }
         else
         {
            showTalentView();
         }
         titleText = LanguageMgr.GetTranslation("armyII.SkillFrame.talentTitle");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.HelpBtn.TalentTipdata");
         stopTalentMc();
      }
      
      public function show(param1:int = 0) : void
      {
         _tabGroup.selectIndex = param1;
         panelChangeHandler(null);
         LayerManager.Instance.addToLayer(this,3,true,true);
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
      
      public function getSkillItemByIndex(param1:int) : SkillitemView
      {
         return _skillView.getSkillItemByIndex(param1);
      }
      
      public function getSkillItemByInfo(param1:SkillInfo) : SkillitemView
      {
         return _skillView.getSkillItemByInfo(param1);
      }
      
      private function disposeSkill() : void
      {
         if(_skillView)
         {
            ObjectUtils.disposeObject(_skillView);
            _skillView.removeEventListener("OPEN_RUNE_VIEW",__openRuneViewhandler);
            _skillView = null;
         }
         QteSkillGuide.cleanAlert();
      }
      
      private function disposeTalent() : void
      {
         if(_talentView)
         {
            ObjectUtils.disposeObject(_talentView);
            _talentView = null;
         }
         if(_transferTalentView)
         {
            ObjectUtils.disposeObject(_transferTalentView);
            _transferTalentView = null;
         }
         QteSkillGuide.cleanAlert();
      }
      
      private function disposeLineUp() : void
      {
         if(_lineUpView)
         {
            ObjectUtils.disposeObject(_lineUpView);
            _lineUpView = null;
         }
         QteSkillGuide.cleanAlert();
      }
      
      private function disposeRune() : void
      {
         if(_runeView)
         {
            ObjectUtils.disposeObject(_runeView);
            _runeView = null;
         }
         QteSkillGuide.cleanAlert();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_buttonMc2);
         _buttonMc2 = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_talentBtn);
         _talentBtn = null;
         ObjectUtils.disposeObject(_runeBtn);
         _runeBtn = null;
         ObjectUtils.disposeObject(_stoneBtn);
         _stoneBtn = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_addFlagIcon1);
         _addFlagIcon1 = null;
         ObjectUtils.disposeObject(_addFlagIcon2);
         _addFlagIcon2 = null;
         ObjectUtils.disposeViolentMc(_skillBtnTipsView);
         _skillBtnTipsView = null;
         ObjectUtils.disposeViolentMc(_runeBtnTipsView);
         _runeBtnTipsView = null;
         ObjectUtils.disposeViolentMc(_talentTipsView);
         _talentTipsView = null;
         ObjectUtils.disposeObject(_armyBtnStrip);
         _armyBtnStrip = null;
         ObjectUtils.disposeObject(_runeBtnStrip);
         _runeBtnStrip = null;
         ObjectUtils.disposeObject(_talentBtnStrip);
         _talentBtnStrip = null;
         if(_armyBtn)
         {
            ObjectUtils.disposeObject(_armyBtn);
         }
         _armyBtn = null;
         disposeSkill();
         disposeTalent();
         disposeRune();
         disposeLineUp();
         disposeStone();
         if(_talentTabView)
         {
            ObjectUtils.disposeObject(_talentTabView);
            _talentTabView = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
      }
   }
}

