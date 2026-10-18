package buildings
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.BuildingEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class BaseBuildFrame extends Frame
   {
      
      protected var _describeBackground:ScaleBitmapImage;
      
      protected var _lineBg:ScaleBitmapImage;
      
      private var _buildingBoxImg:Bitmap;
      
      private var _recouceIcon:Bitmap;
      
      private var _current:FilterFrameText;
      
      private var _currentValue:FilterFrameText;
      
      private var _next:FilterFrameText;
      
      private var _nextValue:FilterFrameText;
      
      private var _needResource:FilterFrameText;
      
      private var _resourceValue:FilterFrameText;
      
      private var _maxGrade:FilterFrameText;
      
      private var _iconView:BaseIconView;
      
      protected var _upgradeBtn:BaseButton;
      
      protected var _headContain:Sprite;
      
      private var _data:BuildInfo;
      
      public function BaseBuildFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      protected function initView() : void
      {
         _headContain = new Sprite();
         _buildingBoxImg = ComponentFactory.Instance.creatBitmap("asset.castle.buildingBoxImg");
         _lineBg = ComponentFactory.Instance.creatComponentByStylename("castle.LineBg");
         _describeBackground = ComponentFactory.Instance.creatComponentByStylename("castle.DescribeBackground");
         _recouceIcon = ComponentFactory.Instance.creatBitmap("asset.castle.ResourceIcon");
         _current = ComponentFactory.Instance.creatComponentByStylename("castle.CurrentTxt");
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("castle.CurrentValueTxt");
         _next = ComponentFactory.Instance.creatComponentByStylename("castle.NextTxt");
         _nextValue = ComponentFactory.Instance.creatComponentByStylename("castle.NextValueTxt");
         _needResource = ComponentFactory.Instance.creatComponentByStylename("castle.ResourceTxt");
         _resourceValue = ComponentFactory.Instance.creatComponentByStylename("castle.ResourceValueTxt");
         _maxGrade = ComponentFactory.Instance.creatComponentByStylename("castle.MaxGrade");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("castle.UpgradeBuildBtn");
         _iconView = ComponentFactory.Instance.creatCustomObject("castle.BuildIcon");
         _headContain.addChild(_buildingBoxImg);
         _headContain.addChild(_describeBackground);
         _headContain.addChild(_lineBg);
         _headContain.addChild(_current);
         _current.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.current");
         _headContain.addChild(_currentValue);
         _headContain.addChild(_next);
         _next.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.next");
         _headContain.addChild(_nextValue);
         _headContain.addChild(_needResource);
         _needResource.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.needResource");
         _headContain.addChild(_resourceValue);
         _headContain.addChild(_maxGrade);
         _maxGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
         _maxGrade.visible = false;
         _headContain.addChild(_iconView);
         addToContent(_headContain);
      }
      
      protected function uninit() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_maxGrade);
         _maxGrade = null;
         ObjectUtils.disposeObject(_resourceValue);
         _resourceValue = null;
         ObjectUtils.disposeObject(_needResource);
         _needResource = null;
         ObjectUtils.disposeObject(_nextValue);
         _nextValue = null;
         ObjectUtils.disposeObject(_next);
         _next = null;
         ObjectUtils.disposeObject(_currentValue);
         _currentValue = null;
         ObjectUtils.disposeObject(_current);
         _current = null;
         ObjectUtils.disposeObject(_recouceIcon);
         _recouceIcon = null;
         ObjectUtils.disposeObject(_buildingBoxImg);
         _buildingBoxImg = null;
         ObjectUtils.disposeObject(_lineBg);
         _lineBg = null;
         ObjectUtils.disposeObject(_describeBackground);
         _describeBackground = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _upgradeBtn.addEventListener("click",__upgradeClickHandler);
         BuildingManager.instance.addEventListener("BUILDING_UPGRADE_RECEIVE",__upgradeBuildingReceive);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeClickHandler);
         }
         BuildingManager.instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",__upgradeBuildingReceive);
      }
      
      protected function __upgradeBuildingReceive(param1:BuildingEvent) : void
      {
         refreshView();
         var _loc2_:BuildingTempInfo = param1.buildingInfo.templeteInfo;
         if(_loc2_.MasterType == 13 || _loc2_.MasterType == 14)
         {
            return;
         }
      }
      
      private function __upgradeClickHandler(param1:MouseEvent) : void
      {
         if(BuildingManager.instance.isUpgradeAvaliable(_data))
         {
            BuildingManager.instance.upgradeBuildingByBuildingInfo(_data);
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
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      protected function refreshView() : void
      {
         titleText = _data.templeteInfo.BuildingName + " " + LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06"," " + _data.templeteInfo.BuildingGrade);
         var _loc2_:BuildingTempInfo = _data.templeteInfo;
         var _loc1_:BuildingTempInfo = _data.nextTemplateInfo;
         _currentValue.htmlText = _loc2_.Activity + getMsAddValue(_loc2_);
         if(_loc1_)
         {
            _recouceIcon.visible = true;
            _next.visible = true;
            _needResource.visible = true;
            _nextValue.visible = true;
            _resourceValue.visible = true;
            _maxGrade.visible = false;
            _nextValue.htmlText = _loc1_.Activity + getMsAddValue(_loc1_);
            _resourceValue.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.needResource2",ArmyManager.instance.thane.grades + 1);
         }
         else
         {
            _maxGrade.visible = true;
            _recouceIcon.visible = false;
            _next.visible = false;
            _needResource.visible = false;
            _nextValue.visible = false;
            _resourceValue.visible = false;
         }
         if(BuildingManager.instance.checkIsMaxLevel(_data))
         {
            _upgradeBtn.enable = false;
         }
      }
      
      public function getMsAddValue(param1:BuildingTempInfo) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         if(param1.SonType != 901)
         {
            return _loc2_;
         }
         var _loc3_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc4_ = Math.floor(_loc3_.tempInfo.AddValue * param1.Property1 / 100);
            _loc2_ = LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc4_);
         }
         return _loc2_;
      }
      
      protected function resetSize(param1:int) : void
      {
         _describeBackground.width = param1 - 150;
         _lineBg.width = param1;
         _upgradeBtn.x = _describeBackground.x + _describeBackground.width + 23;
      }
      
      protected function defaultView() : void
      {
         _headContain.x = -7;
         _headContain.y = 11;
         _describeBackground.width = 402;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
      
      public function get data() : BuildInfo
      {
         return _data;
      }
      
      public function set data(param1:BuildInfo) : void
      {
         _data = param1;
         _iconView.icon = IconFactory.getBuidIconByIcon(_data.templeteInfo.Icon);
         refreshView();
      }
      
      public function get upgradeBtn() : BaseButton
      {
         return _upgradeBtn;
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
   }
}

