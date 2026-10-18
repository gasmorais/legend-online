package armyII.viewII.pawnupgrade
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PawnSpecialTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PawnLevelUpFrame extends Frame implements IManualSize
   {
      
      public static const SKILL_COUNT:int = 1;
      
      private var _9cornerBack:ScaleBitmapImage;
      
      private var _title2:Bitmap;
      
      private var _back:Bitmap;
      
      private var _soulIcon:Image;
      
      private var _numBitmapData:BitmapData;
      
      private var _numBitmapData2:BitmapData;
      
      private var _soulVaueTxt:FilterFrameText;
      
      private var _needSoulContainer:Sprite;
      
      private var _needSoulValue:Number;
      
      private var _soulTip:StripView;
      
      private var _iconBack:Bitmap;
      
      private var _iconImg:Bitmap;
      
      private var _upGrade:BaseButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _attributeBox:VBox;
      
      private var _levelUpMC:MovieClip;
      
      private var _maxLevelTxt:FilterFrameText;
      
      private var _physicalAttackItem:PawnLevelUpAttributeItem;
      
      private var _magicAttackItem:PawnLevelUpAttributeItem;
      
      private var _physicalDefenceItem:PawnLevelUpAttributeItem;
      
      private var _magicDefenceItem:PawnLevelUpAttributeItem;
      
      private var _hpItem:PawnLevelUpAttributeItem;
      
      private var _pawnFigure:PawnFigureView;
      
      private var _list:Array;
      
      private var _tempArr:Array;
      
      private var _dic:Dictionary;
      
      private var _buttonDic:Dictionary;
      
      private var _vBox:VBox;
      
      private var _skillContain:Sprite;
      
      private var _specialAbility:BaseIconView;
      
      private var _specialName:FilterFrameText;
      
      private var _specialAbilityOpenTip:Bitmap;
      
      private var _apperceiveBtn:BaseButton;
      
      private var _convertBtn:BaseButton;
      
      private var _attackType:int;
      
      private var _skillDic:Dictionary;
      
      private var _isOver:Boolean;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _currentSelected:ArmyPawn;
      
      public function PawnLevelUpFrame()
      {
         super();
         initData();
         initList();
         iniView();
         addEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,492,513);
      }
      
      private function initData() : void
      {
         _dic = new Dictionary();
         _skillDic = new Dictionary();
         _buttonDic = new Dictionary();
         _tempArr = ArmyManager.instance.casernPawnList.getList();
         _tempArr.sort(sortByNeedBuild);
      }
      
      private function sortByNeedBuild(param1:ArmyPawn, param2:ArmyPawn) : int
      {
         var _loc4_:int = int(param1.templateInfo.NeedBuilding);
         var _loc3_:int = int(param2.templateInfo.NeedBuilding);
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         return 0;
      }
      
      private function initList() : void
      {
         var _loc1_:SelectedIconButton = null;
         _selectedButtonGroup = new SelectedButtonGroup();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnLevelupBox");
         for each(var _loc2_:ArmyPawn in _tempArr)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnButton");
            _loc1_.beginChanges();
            _loc1_.selectedIconStyle = getPawnNameSelectIcon(_loc2_.templateInfo.MasterType);
            _loc1_.unselectedIconStyle = getPawnNameUnselectIcon(_loc2_.templateInfo.MasterType);
            _loc1_.commitChanges();
            _loc1_.selected = false;
            _loc1_.enable = _loc2_.canRecruit;
            switch(int(_loc2_.templateInfo.MasterType) - 1)
            {
               case 0:
                  _loc1_.selectedIconInnerRectString = "4,50,4,15,13";
                  _loc1_.unselectedIconInnerRectString = "4,47,4,14,13";
                  break;
               case 1:
                  _loc1_.selectedIconInnerRectString = "4,53,4,18,13";
                  _loc1_.unselectedIconInnerRectString = "4,50,4,17,13";
                  break;
               case 2:
                  _loc1_.selectedIconInnerRectString = "4,44,4,26,13";
                  _loc1_.unselectedIconInnerRectString = "4,41,4,26,13";
                  break;
               case 3:
                  _loc1_.selectedIconInnerRectString = "9,40,4,15,13";
                  _loc1_.unselectedIconInnerRectString = "9,38,4,14,13";
                  break;
               case 4:
                  _loc1_.selectedIconInnerRectString = "-1,59,8,15,13";
                  _loc1_.unselectedIconInnerRectString = "-1,56,8,14,13";
                  break;
               case 5:
                  _loc1_.selectedIconInnerRectString = "-1,55,8,15,13";
                  _loc1_.unselectedIconInnerRectString = "-1,52,8,15,13";
                  break;
               case 6:
                  _loc1_.selectedIconInnerRectString = "8,31,9,18,13";
                  _loc1_.unselectedIconInnerRectString = "8,29,9,17,13";
                  break;
               case 7:
                  _loc1_.selectedIconInnerRectString = "1,52,4,14,13";
                  _loc1_.unselectedIconInnerRectString = "1,55,4,15,13";
                  break;
               case 8:
                  _loc1_.selectedIconInnerRectString = "-2,58,4,16,13";
                  _loc1_.unselectedIconInnerRectString = "-2,55,4,15,13";
                  break;
               case 9:
                  _loc1_.selectedIconInnerRectString = "-2,60,4,25,13";
                  _loc1_.unselectedIconInnerRectString = "-2,62,4,25,13";
                  break;
               case 10:
                  _loc1_.selectedIconInnerRectString = "0,52,4,29,13";
                  _loc1_.unselectedIconInnerRectString = "0,49,4,28,13";
            }
            _selectedButtonGroup.addSelectItem(_loc1_);
            _vBox.addChild(_loc1_);
            _dic[_loc2_.templateInfo.SonType] = _loc1_;
            _buttonDic[_loc1_] = _loc2_;
         }
      }
      
      private function iniView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PawnSkill = null;
         _levelUpMC = MovieClip(ComponentFactory.Instance.creat("asset.armyII.PawnLevelUpMC"));
         titleText = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command01");
         _9cornerBack = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnLevelup9CornerBack");
         _title2 = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnLevelupBack2");
         _back = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnLevelupBack");
         _soulIcon = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnLevelupSoulIcon");
         addToContent(_9cornerBack);
         addToContent(_vBox);
         addToContent(_back);
         addToContent(_title2);
         addToContent(_soulIcon);
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_04").clone();
         _numBitmapData2 = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1").clone();
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.armyII.IconBack1");
         _iconImg = ComponentFactory.Instance.creatBitmap("asset.armyII.IconBack");
         addToContent(_iconBack);
         addToContent(_iconImg);
         _soulVaueTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulValueTxt");
         _needSoulContainer = ComponentFactory.Instance.creatCustomObject("armyII.NeedSoulContainer");
         addToContent(_needSoulContainer);
         _soulTip = ComponentFactory.Instance.creatCustomObject("armyII.SoulTip");
         _soulTip.setHitArea(0,0,180,92);
         _soulTip.tipData = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command02");
         addToContent(_soulVaueTxt);
         addToContent(_soulTip);
         _upGrade = ComponentFactory.Instance.creatComponentByStylename("armyII.upgradeButton");
         addToContent(_upGrade);
         _skillContain = new Sprite();
         _skillContain.x = 88;
         _skillContain.y = 262;
         addToContent(_skillContain);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc2_ = new PawnSkill();
            _loc2_.x = (_loc2_.width + 57) * _loc1_;
            _skillContain.addChild(_loc2_);
            _skillDic[_loc1_] = _loc2_;
            _loc1_++;
         }
         _specialAbility = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialAbilityIcon");
         _specialName = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialAbilityName");
         _specialAbilityOpenTip = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialAbilityOpenTip");
         _convertBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.ConvertButton");
         _apperceiveBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.ApperceiveButton");
         addToContent(_specialAbility);
         addToContent(_specialName);
         _maxLevelTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.NeexSoulValueTxt");
         addToContent(_levelUpMC);
         addToContent(_maxLevelTxt);
         _maxLevelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
         _pawnFigure = new PawnFigureView();
         _pawnFigure.x = 160;
         _pawnFigure.y = 196;
         addToContent(_pawnFigure);
         _physicalAttackItem = new PawnLevelUpAttributeItem("physicalAttack");
         _physicalDefenceItem = new PawnLevelUpAttributeItem("physicalDefence");
         _magicAttackItem = new PawnLevelUpAttributeItem("magicAttack");
         _magicDefenceItem = new PawnLevelUpAttributeItem("magicDefence");
         _hpItem = new PawnLevelUpAttributeItem("live");
         _attributeBox = ComponentFactory.Instance.creatComponentByStylename("armyII.AttributeBox");
         addToContent(_attributeBox);
         addToContent(_convertBtn);
         addToContent(_apperceiveBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _convertBtn.addEventListener("click",__onConvertBtnClick);
         _apperceiveBtn.addEventListener("click",__onApperceiveClick);
         _upGrade.addEventListener("click",__upgradeHandler);
         _upGrade.addEventListener("mouseOver",__overHandler);
         _upGrade.addEventListener("mouseOut",__outHandler);
         for each(var _loc1_:SelectedIconButton in _dic)
         {
            _loc1_.addEventListener("click",__selectedHandler);
         }
         for each(var _loc2_:ArmyPawn in _tempArr)
         {
            _loc2_.addEventListener("pawnProppertyChager",__pawnChangeHandler);
            _loc2_.addEventListener("SPECIAL_ALIBITY",__specialAblityChange);
         }
      }
      
      private function __onConvertBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PawnAbilityConvertFrame = null;
         if(thane.grades < 40)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command08"));
            return;
         }
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _tempArr.length)
         {
            if(_tempArr[_loc3_].templateId != _currentSelected.templateId && _tempArr[_loc3_].templateInfo.Level >= 10)
            {
               _loc2_ += 1;
            }
            _loc3_++;
         }
         if(_loc2_ > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame");
            _loc4_.show(_currentSelected);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.PawnLevelUpFrame.noToConver"));
         }
      }
      
      public function setApperceiveEffect() : void
      {
         if(_apperceiveBtn.enable)
         {
            _disEffect = new NoviceBtnGlowEffect(_apperceiveBtn);
            _disEffect.play();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _convertBtn.removeEventListener("click",__onConvertBtnClick);
         _apperceiveBtn.removeEventListener("click",__onApperceiveClick);
         _upGrade.removeEventListener("click",__upgradeHandler);
         _upGrade.removeEventListener("mouseOver",__overHandler);
         _upGrade.removeEventListener("mouseOut",__outHandler);
         for each(var _loc1_:SelectedIconButton in _dic)
         {
            _loc1_.removeEventListener("click",__selectedHandler);
         }
         for each(var _loc2_:ArmyPawn in _tempArr)
         {
            _loc2_.removeEventListener("pawnProppertyChager",__pawnChangeHandler);
            _loc2_.removeEventListener("SPECIAL_ALIBITY",__specialAblityChange);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _isOver = true;
         _physicalAttackItem.showUpgrade();
         _magicAttackItem.showUpgrade();
         _physicalDefenceItem.showUpgrade();
         _magicDefenceItem.showUpgrade();
         _hpItem.showUpgrade();
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _isOver = false;
         _physicalAttackItem.hideUpgrade();
         _magicAttackItem.hideUpgrade();
         _physicalDefenceItem.hideUpgrade();
         _magicDefenceItem.hideUpgrade();
         _hpItem.hideUpgrade();
      }
      
      private function __onApperceiveClick(param1:MouseEvent) : void
      {
         if(_disEffect)
         {
            _disEffect.dispose();
            _disEffect = null;
         }
         if(thane.grades < 40)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command08"));
            return;
         }
         var _loc2_:PawnSpecialAbilityFrame = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialAbilityFrame");
         _loc2_.show(_currentSelected);
      }
      
      private function __upgradeHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(model.playerInfo.strategy < _needSoulValue)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(402);
         var _loc3_:PawnTemplate = _currentSelected.nextTemplate;
         if(_loc4_ && _loc3_.Level > _loc4_.templeteInfo.BuildingGrade)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command06",_loc3_.Level);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         control.sendUpgradePawn(_currentSelected.templateId);
      }
      
      private function __pawnChangeHandler(param1:PawnEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.data == _currentSelected)
         {
            refreshRight(true);
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command07",_currentSelected.templateInfo.Level);
            MessageTipManager.instance().show(_loc2_,true);
         }
         if(_currentSelected.templateInfo.Level == 10 && Boolean(VersionSwitch.PAWNSPECIAL))
         {
            _loc3_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command09",_currentSelected.templateInfo.PawnName);
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.data = [];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc3_);
         }
      }
      
      private function __specialAblityChange(param1:PawnEvent) : void
      {
         if(param1.data == _currentSelected)
         {
            refreshSpecialAbility();
         }
      }
      
      private function __selectedHandler(param1:MouseEvent) : void
      {
         _currentSelected = _buttonDic[param1.currentTarget] as ArmyPawn;
         _pawnFigure.data = _currentSelected.templateInfo;
         refreshRight();
      }
      
      public function set defaultSelected(param1:ArmyPawn) : void
      {
         var _loc2_:SelectedIconButton = _dic[param1.templateInfo.SonType];
         _loc2_.dispatchEvent(new MouseEvent("click"));
      }
      
      private function clean() : void
      {
         _attributeBox.removeAllChild();
         _attributeBox.refreshChildPos();
         ObjectUtils.disposeAllChildren(_needSoulContainer);
         _maxLevelTxt.visible = false;
      }
      
      private function refreshAttribute(param1:ArmyPawn, param2:PawnLevelUpAttributeItem, param3:String) : void
      {
         if(param1[param3] > 0)
         {
            param2.setData(param1,param3);
            _attributeBox.addChild(param2);
         }
      }
      
      private function refreshRight(param1:Boolean = false) : void
      {
         clean();
         var _loc3_:PawnTemplate = _currentSelected.templateInfo;
         var _loc2_:PawnTemplate = _currentSelected.nextTemplate;
         if(param1)
         {
            NumberViewUtils.refreshValue(_loc3_.Level - 1,_levelUpMC["preLevel"]["content"],_numBitmapData2,19,25,15,19,"0123456789");
            NumberViewUtils.refreshValue(_loc3_.Level,_levelUpMC["nextLevel"]["content"],_numBitmapData2,19,25,15,19,"0123456789");
            _levelUpMC.gotoAndPlay(1);
         }
         else
         {
            NumberViewUtils.refreshValue(_loc3_.Level,_levelUpMC["preLevel"]["content"],_numBitmapData2,19,25,15,19,"0123456789");
            _levelUpMC.gotoAndStop(1);
         }
         if(_loc2_)
         {
            _upGrade.enable = true;
         }
         else
         {
            _upGrade.enable = false;
         }
         refreshAttribute(_currentSelected,_physicalAttackItem,"attack");
         refreshAttribute(_currentSelected,_magicAttackItem,"magicAttack");
         refreshAttribute(_currentSelected,_physicalDefenceItem,"defence");
         refreshAttribute(_currentSelected,_magicDefenceItem,"magicDefence");
         refreshAttribute(_currentSelected,_hpItem,"live");
         refreshSkill();
         refreshSpecialAbility();
         if(_isOver)
         {
            __overHandler(null);
         }
      }
      
      private function refreshSkill() : void
      {
         var _loc6_:int = 0;
         var _loc2_:PawnSkill = null;
         var _loc3_:SkillTempInfo = null;
         var _loc1_:int = int(ThaneInfoHelper.getPawnMaxTempIDBySontype(_currentSelected.templateInfo.SonType));
         var _loc5_:PawnTemplate = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc1_);
         var _loc4_:Array = _currentSelected.templateInfo.HighSkill.split(",");
         var _loc7_:Array = _loc5_.HighSkill.split(",");
         _loc6_ = 0;
         while(_loc6_ < 1)
         {
            _loc2_ = _skillDic[_loc6_] as PawnSkill;
            if(_loc6_ < _loc7_.length)
            {
               _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc7_[_loc6_]));
               _loc2_.data = _loc3_;
            }
            else
            {
               _loc2_.data = null;
            }
            if(_loc4_.indexOf(_loc7_[_loc6_]) >= 0)
            {
               _loc2_.enable = true;
            }
            _loc6_++;
         }
      }
      
      private function refreshSpecialAbility() : void
      {
         var _loc3_:int = 0;
         var _loc2_:PawnSpecialTempInfo = null;
         var _loc1_:PawnTemplate = _currentSelected.nextTemplate;
         var _loc4_:UpgradeTemplateInfo = _loc1_ ? TempleteManager.instance.getTemplateByTypeAndLevelAndID(_loc1_.Level,1,_loc1_.TemplateId) : null;
         _soulVaueTxt.text = model.playerInfo.strategy.toString();
         _soulVaueTxt.setFrame(1);
         if(!_loc4_)
         {
            _maxLevelTxt.visible = true;
         }
         else
         {
            _loc3_ = int(_loc4_.Data);
            _needSoulValue = _loc1_ ? _loc3_ : 0;
            NumberViewUtils.refreshValue(_needSoulValue,_needSoulContainer,_numBitmapData,19,25,15,19,"0123456789");
            _needSoulContainer.x = 445 - _needSoulContainer.width;
            if(_needSoulValue > Number(_soulVaueTxt.text))
            {
               _soulVaueTxt.setFrame(2);
            }
         }
         if(VersionSwitch.PAWNSPECIAL)
         {
            _specialAbility.icon = null;
            _specialAbility.tipData = null;
            _specialName.text = "";
            _apperceiveBtn.visible = false;
            _convertBtn.visible = false;
            if(_currentSelected)
            {
               _loc2_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_currentSelected.specialAbility));
               if(_loc2_)
               {
                  _specialAbility.icon = IconFactory.getCommonIconPath(_loc2_.ResPath);
                  _specialAbility.tipData = _loc2_;
                  _specialName.text = _loc2_.TemplateName + "  " + LanguageMgr.GetTranslation("public.level2",_loc2_.Grades);
                  if(_specialAbilityOpenTip.parent)
                  {
                     _specialAbilityOpenTip.parent.removeChild(_specialAbilityOpenTip);
                  }
               }
               if(_currentSelected.templateInfo.Level < 10)
               {
                  addToContent(_specialAbilityOpenTip);
               }
               else
               {
                  _apperceiveBtn.visible = true;
                  _convertBtn.visible = true;
               }
            }
         }
         else
         {
            _apperceiveBtn.visible = false;
            _convertBtn.visible = true;
         }
      }
      
      public function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function getPawnNameSelectIcon(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "asset.armyII.Pawn1Select";
            case 1:
               return "asset.armyII.Pawn2Select";
            case 2:
               return "asset.armyII.Pawn3Select";
            case 3:
               return "asset.armyII.Pawn6Select";
            case 4:
               return "asset.armyII.Pawn5Select";
            case 5:
               return "asset.armyII.Pawn4Select";
            case 6:
               return "asset.armyII.Pawn7Select";
            case 7:
               return "asset.armyII.Pawn8Select";
            case 8:
               return "asset.armyII.Pawn9Select";
            case 9:
               return "asset.armyII.Pawn10Select";
            case 10:
               return "asset.armyII.Pawn11Select";
            default:
               return "";
         }
      }
      
      private function getPawnNameUnselectIcon(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "asset.armyII.Pawn1UnSelect";
            case 1:
               return "asset.armyII.Pawn2UnSelect";
            case 2:
               return "asset.armyII.Pawn3UnSelect";
            case 3:
               return "asset.armyII.Pawn6UnSelect";
            case 4:
               return "asset.armyII.Pawn5UnSelect";
            case 5:
               return "asset.armyII.Pawn4UnSelect";
            case 6:
               return "asset.armyII.Pawn7UnSelect";
            case 7:
               return "asset.armyII.Pawn8UnSelect";
            case 8:
               return "asset.armyII.Pawn9UnSelect";
            case 9:
               return "asset.armyII.Pawn10UnSelect";
            case 10:
               return "asset.armyII.Pawn11UnSelect";
            default:
               return "";
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get upGradeBtn() : BaseButton
      {
         return _upGrade;
      }
      
      override public function dispose() : void
      {
         if(_disEffect)
         {
            _disEffect.dispose();
            _disEffect = null;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(_skillContain);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

