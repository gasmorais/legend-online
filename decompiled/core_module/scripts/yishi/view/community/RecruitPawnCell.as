package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.events.ServiceReceiveEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.tips.MessageTipManager;
   
   public class RecruitPawnCell extends Sprite implements Disposeable
   {
      
      private var _headFrameImg:Bitmap;
      
      private var _infoBg:Bitmap;
      
      private var _recruitPawnBtn:TextButton;
      
      private var _upgradeButton:TextButton;
      
      private var _pawnTitleText:FilterFrameText;
      
      private var _pawnLevelTxt:FilterFrameText;
      
      private var _pawnDepict:FilterFrameText;
      
      private var _pawnInfo:FilterFrameText;
      
      private var _pawnLevelUpFrame:Frame;
      
      private var _icon:BaseIconView;
      
      private var _data:ArmyPawn;
      
      private var _model:PlayerModel;
      
      private var _number:int;
      
      private var _maxNumber:int;
      
      private var pawnTemp:PawnTemplate;
      
      private var _filter:IFilterFormat;
      
      public function RecruitPawnCell()
      {
         super();
         initView();
         _icon = ComponentFactory.Instance.creatCustomObject("casern.RecruitPawnIcon");
         addChild(_icon);
         addEvent();
         _model = PlayerManager.instance.currentPlayerModel;
         _filter = new UIFilter();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initView() : void
      {
         _headFrameImg = ComponentFactory.Instance.creatBitmap("asset.casern.headFrameImg");
         addChild(_headFrameImg);
         _infoBg = ComponentFactory.Instance.creatBitmap("asset.casern.ItemBgImg");
         addChild(_infoBg);
         _recruitPawnBtn = ComponentFactory.Instance.creatComponentByStylename("casern.RecruitPawnBtn");
         _recruitPawnBtn.enable = false;
         _recruitPawnBtn.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command01");
         addChild(_recruitPawnBtn);
         _upgradeButton = ComponentFactory.Instance.creatComponentByStylename("casern.UpgradeBtn");
         _upgradeButton.enable = false;
         _upgradeButton.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command02");
         addChild(_upgradeButton);
         _upgradeButton.visible = thane.grades >= 8;
         _pawnTitleText = ComponentFactory.Instance.creatComponentByStylename("casern.PawnTitle");
         addChild(_pawnTitleText);
         _pawnLevelTxt = ComponentFactory.Instance.creatComponentByStylename("casern.PawnLevel");
         addChild(_pawnLevelTxt);
         _pawnDepict = ComponentFactory.Instance.creatComponentByStylename("casern.PawnDepict");
         _pawnInfo = ComponentFactory.Instance.creatComponentByStylename("casern.PawnInfo");
         addChild(_pawnInfo);
      }
      
      private function uninit() : void
      {
         _headFrameImg = null;
         _infoBg = null;
         _recruitPawnBtn = null;
         _upgradeButton = null;
         _pawnTitleText = null;
         _pawnLevelTxt = null;
         _pawnDepict = null;
         _pawnInfo = null;
         _icon = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function addEvent() : void
      {
         _recruitPawnBtn.addEventListener("click",__recruitPawnBtn);
         _upgradeButton.addEventListener("click",__upgradePawnHandler);
         ArmyManager.instance.addEventListener("upgrade_pawn_success",__pawnLevelUpHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("pawnProppertyChager",__pawnChangeHandler);
         }
         _recruitPawnBtn.removeEventListener("click",__recruitPawnBtn);
         _upgradeButton.removeEventListener("click",__upgradePawnHandler);
         ArmyManager.instance.removeEventListener("upgrade_pawn_success",__pawnLevelUpHandler);
      }
      
      private function __pawnLevelUpHandler(param1:ServiceReceiveEvent) : void
      {
         if(pawnTemp && int(param1.data) == pawnTemp.SonType)
         {
            updateIconData();
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _icon.tipData = _data;
         pawnTemp = _data.templateInfo;
         var _loc1_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(int(pawnTemp.NeedBuilding));
         var _loc3_:BuildInfo = _loc1_ ? BuildingManager.instance.getBuildingInfoBySonType(_loc1_.SonType) : null;
         var _loc2_:Boolean = _loc3_ ? _loc3_.templeteInfo.BuildingGrade >= _loc1_.BuildingGrade : true;
         if(_data.canRecruit && _loc2_)
         {
            _pawnTitleText.text = pawnTemp.PawnName;
            _pawnLevelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",pawnTemp.Level);
            _pawnDepict.text = pawnTemp.Description;
            number = _data.ownPawns;
            _pawnInfo.text = "";
            _recruitPawnBtn.visible = true;
            _upgradeButton.visible = thane.grades >= 8;
            _recruitPawnBtn.enable = true;
            _upgradeButton.enable = true;
            setNormalFilter();
         }
         else
         {
            _pawnTitleText.text = pawnTemp.PawnName;
            _pawnLevelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",pawnTemp.Level);
            _pawnInfo.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command05",getNeedBuilding(int(_data.templateInfo.NeedBuilding)));
            _recruitPawnBtn.visible = _upgradeButton.visible = false;
            _pawnDepict.text = pawnTemp.Description;
            setDisableFilter();
            _recruitPawnBtn.enable = false;
            _upgradeButton.enable = false;
         }
         _pawnLevelTxt.x = _pawnTitleText.x + _pawnTitleText.textWidth + 3;
      }
      
      public function setDisableFilter() : void
      {
         _filter.setGrayFilter(_icon);
         var _loc1_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(int(_data.templateInfo.NeedBuilding));
         _pawnInfo.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command05",_loc1_.BuildingName + " " + _loc1_.BuildingGrade);
         _recruitPawnBtn.visible = false;
         _upgradeButton.visible = false;
      }
      
      public function setNormalFilter() : void
      {
         _filter.setNormalFilter(_icon);
      }
      
      private function getNeedBuilding(param1:int) : String
      {
         var _loc2_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(param1);
         return "" + _loc2_.BuildingName + " " + _loc2_.BuildingGrade;
      }
      
      protected function __recruitPawnBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc9_:int = ResourceManager.instance.population.count;
         var _loc4_:int = ResourceManager.instance.population.limit;
         var _loc6_:int = (_data as ArmyPawn).templateInfo.NeedPopulation;
         var _loc3_:int = (_loc4_ - _loc9_) / _loc6_;
         var _loc8_:BuildingTempInfo = BuildingManager.instance.getMaxEffectBuildingTemplate(pawnTemp).sortOn("Property4",0x10 | 2)[0];
         var _loc5_:Number = _loc8_.Property4 / 100;
         var _loc7_:int = _model.playerEffect.getRecruitPawnResourceAddition(pawnTemp.GoldConsume * (1 - _loc5_));
         var _loc2_:String = "";
         if(_loc3_ <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command03");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(_loc7_ > ResourceManager.instance.gold.count)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            FrameControllerManager.instance.armyController.openCasernRecruitFrame(_data);
         }
      }
      
      private function __upgradePawnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.PAWNUPGRADE,data);
      }
      
      public function set data(param1:ArmyPawn) : void
      {
         _data = param1;
         if(_data)
         {
            _data.addEventListener("pawnProppertyChager",__pawnChangeHandler);
         }
         refreshView();
         updateIconData();
      }
      
      private function __pawnChangeHandler(param1:PawnEvent) : void
      {
         refreshView();
         updateIconData();
      }
      
      private function updateIconData() : void
      {
         _icon.icon = IconFactory.getSoldierIconByIcon((_data as ArmyPawn).templateInfo.Icon);
      }
      
      public function get data() : ArmyPawn
      {
         return _data;
      }
      
      public function set number(param1:int) : void
      {
         _number = param1;
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      public function set maxNumber(param1:int) : void
      {
         _maxNumber = param1;
      }
      
      public function get maxNumber() : int
      {
         return _maxNumber;
      }
      
      public function get recruitPawnBtn() : TextButton
      {
         return _recruitPawnBtn;
      }
      
      public function get upgradeButton() : TextButton
      {
         return _upgradeButton;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
      }
   }
}

