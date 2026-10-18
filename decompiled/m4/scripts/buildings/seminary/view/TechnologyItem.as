package buildings.seminary.view
{
   import buildings.seminary.event.TechnologyItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TechnologyItem extends Component implements ISelectable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overImg:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _upgradeBtn:TextButton;
      
      private var _levelBg:Image;
      
      private var _data:BuildInfo;
      
      private var _iconView:BaseIconView;
      
      private var _newIcon:Bitmap;
      
      private var _temp:BuildingTempInfo;
      
      private var _selected:Boolean;
      
      private var _isShowNewIcon:Boolean = true;
      
      private var _isShowName:Boolean;
      
      public function TechnologyItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("seminary.technologyItemBg");
         _bg.setFrame(1);
         addChild(_bg);
         _overImg = ComponentFactory.Instance.creatBitmap("asset.seminary.glowBgImg");
         addChild(_overImg);
         _overImg.visible = false;
         _iconView = ComponentFactory.Instance.creatCustomObject("seminary.technologyItem");
         addChild(_iconView);
         _levelBg = ComponentFactory.Instance.creatComponentByStylename("seminary.technologyItemLevelBg");
         addChild(_levelBg);
         _level = ComponentFactory.Instance.creatComponentByStylename("seminary.technologyItemLevel");
         _level.text = "";
         addChild(_level);
         _name = ComponentFactory.Instance.creatComponentByStylename("seminary.technologyItemName");
         _name.text = "";
         _name.mouseEnabled = false;
         addChild(_name);
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("seminary.technologyItemUpgradeBtn");
         _upgradeBtn.text = LanguageMgr.GetTranslation("buildings.seminary.view.TechnologyItem.upgradeBtn.text");
         addChild(_upgradeBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _upgradeBtn = null;
         _name = null;
         _level = null;
         _iconView = null;
         _levelBg = null;
         _bg = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__itemOverHandler);
         addEventListener("rollOut",__itemOutHandler);
         NotificationManager.instance.addEventListener(TechnologyItemEvent.UPDATA,__onDataUpdateHandler);
         _upgradeBtn.addEventListener("click",__onUpgradeClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__itemOverHandler);
         removeEventListener("rollOut",__itemOutHandler);
         NotificationManager.instance.removeEventListener(TechnologyItemEvent.UPDATA,__onDataUpdateHandler);
         _upgradeBtn.removeEventListener("click",__onUpgradeClick);
      }
      
      private function __itemOverHandler(param1:MouseEvent) : void
      {
         _overImg.visible = true;
         checkCrystalsEnough();
      }
      
      private function __itemOutHandler(param1:MouseEvent) : void
      {
         _overImg.visible = false;
         this.dispatchEvent(new TechnologyItemEvent(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT));
      }
      
      private function __onUpgradeClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            SoundManager.instance.play("022");
            NotificationManager.instance.dispatchEvent(new NotificationEvent("TEC_UPGRADE_CLICK",_data));
         }
      }
      
      protected function __onDataUpdateHandler(param1:TechnologyItemEvent) : void
      {
         var _loc2_:BuildInfo = param1.data;
         if(_loc2_ && _data && _loc2_.sonType == _data.sonType)
         {
            data = _loc2_;
            onPropertiesChanged("tipData");
            checkCrystalsEnough();
         }
      }
      
      private function checkCrystalsEnough() : void
      {
         if(_data)
         {
            if(getNextGrade(_temp) && (_data.getNextNeedResource(getNextGrade(_temp)) as Dictionary)["CrystalsConsume"] > ResourceManager.instance.waterCrystal.count)
            {
               this.dispatchEvent(new TechnologyItemEvent(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER));
            }
         }
      }
      
      public function get upgradeBtn() : TextButton
      {
         return _upgradeBtn;
      }
      
      private function getTipContent(param1:Object) : Object
      {
         return null;
      }
      
      public function get data() : BuildInfo
      {
         return _data;
      }
      
      public function set data(param1:BuildInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            _iconView.icon = null;
            isShowName = false;
            isShowNewIcon = false;
            _bg.setFrame(1);
            return;
         }
         isShowName = true;
         _temp = getTemp(_data);
         _iconView.icon = IconFactory.getTecIconByIcon(_temp.Icon);
         if(_temp.TemplateId > 200000)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
         if(_data.templeteInfo.BuildingGrade == 0)
         {
            _newIcon = ComponentFactory.Instance.creatBitmap("asset.seminary.newIconImg");
            addChild(_newIcon);
            isShowNewIcon = true;
            _newIcon.visible = isShowNewIcon;
            _level.visible = false;
            _levelBg.visible = false;
         }
         else if(_newIcon)
         {
            if(_newIcon.parent)
            {
               _newIcon.parent.removeChild(_newIcon);
            }
            _newIcon = null;
         }
         if(isShowName)
         {
            if(_temp.BuildingGrade)
            {
               _level.text = String(_temp.BuildingGrade);
            }
            _name.text = _temp.BuildingName;
         }
      }
      
      public function set isShowNewIcon(param1:Boolean) : void
      {
         _isShowNewIcon = param1;
         if(_newIcon)
         {
            _newIcon.visible = _isShowNewIcon;
         }
      }
      
      public function get isShowNewIcon() : Boolean
      {
         return _isShowNewIcon;
      }
      
      public function set isShowName(param1:Boolean) : void
      {
         _level.visible = param1;
         _levelBg.visible = param1;
         _name.visible = param1;
         _upgradeBtn.visible = param1;
         _isShowName = param1;
      }
      
      public function get isShowName() : Boolean
      {
         return _isShowName;
      }
      
      private function getTemp(param1:BuildInfo) : BuildingTempInfo
      {
         var _loc2_:BuildingTempInfo = null;
         if(param1.templateId != 0)
         {
            _loc2_ = param1.templeteInfo;
         }
         else
         {
            _loc2_ = TempleteManager.instance.buildTemplateCate.getMinGradeBuildingTemplete(param1.sonType);
         }
         return _loc2_;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            NotificationManager.instance.dispatchEvent(new TechnologyItemEvent(TechnologyItemEvent.ITEM_CLICK,_data));
         }
      }
      
      private function getNextGrade(param1:BuildingTempInfo) : BuildingTempInfo
      {
         if(param1.NextGradeTemplateId != 0)
         {
            return TempleteManager.instance.buildTemplateCate.getTemplateByID(int(param1.NextGradeTemplateId));
         }
         return null;
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

