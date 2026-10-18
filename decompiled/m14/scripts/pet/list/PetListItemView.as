package pet.list
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetListItemView extends Component implements ISelectable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overbg:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _stateFlag:ScaleFrameImage;
      
      private var _stateText:GradientText;
      
      private var _lockFlag:ScaleFrameImage;
      
      private var _data:PetData;
      
      private var _lockIcon:DisplayObject;
      
      private var _hBox:HBox;
      
      private var _selected:Boolean;
      
      private var _enable:Boolean = true;
      
      private var _state:int = 1;
      
      public var isGray:Boolean;
      
      private var filter:ColorMatrixFilter;
      
      public function PetListItemView()
      {
         super();
         initView();
         addEvent();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.PetItemBg");
         _overbg = ComponentFactory.Instance.creatComponentByStylename("pet.PetItemMouseOver");
         _icon = ComponentFactory.Instance.creatCustomObject("pet.PetIconView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PetItemName");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PetItemGrade");
         _stateFlag = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.StateFlag");
         _stateFlag.setFrame(1);
         _stateText = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.StateText");
         _lockFlag = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.LockFlag");
         _lockFlag.setFrame(1);
         _icon.mouseEnabled = _icon.mouseChildren = false;
         _overbg.mouseEnabled = _overbg.mouseChildren = false;
         _overbg.visible = false;
         _stateFlag.visible = false;
         _stateText.visible = false;
         _hBox = new HBox();
         _hBox.spacing = 0;
         addChild(_bg);
         addChild(_overbg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_hBox);
         _hBox.x = 86;
         _hBox.y = 44;
         addChild(_gradeTxt);
         addChild(_stateFlag);
         addChild(_stateText);
         addChild(_lockFlag);
         _nameTxt.text = "";
         _gradeTxt.text = "";
         _stateFlag.tipData = LanguageMgr.GetTranslation("pet.list.PetListItemView.enterWarTip");
         _stateText.text = LanguageMgr.GetTranslation("pet.list.PetListItemView.stateTip");
         _lockFlag.tipData = LanguageMgr.GetTranslation("pet.list.PetListItemView.lockTip");
         this.hitArea = _bg;
         _bg.mouseChildren = _bg.mouseEnabled = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overbg);
         _overbg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_stateFlag);
         _stateFlag = null;
         ObjectUtils.disposeObject(_stateText);
         _stateText = null;
         ObjectUtils.disposeObject(_lockFlag);
         _lockFlag = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function mouseOverHandler() : void
      {
         if(selected)
         {
            return;
         }
         if(state == 3)
         {
            _overbg.visible = true;
         }
      }
      
      public function mouseOutHandler() : void
      {
         if(selected)
         {
            return;
         }
         _overbg.visible = false;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         restore();
         _data = param1;
         refresh();
      }
      
      private function restore() : void
      {
         _nameTxt.text = "";
         _gradeTxt.text = "";
         _icon.visible = false;
         _stateFlag.visible = false;
         _stateText.visible = false;
         enable = true;
         selected = false;
         _lockFlag.setFrame(1);
         _lockFlag.visible = false;
         _hBox.visible = false;
      }
      
      private function refresh() : void
      {
         var _loc1_:String = null;
         if(!data)
         {
            hideVpLock();
            return;
         }
         _icon.visible = true;
         _hBox.visible = true;
         if(data.templateId != 0)
         {
            _loc1_ = IconFactory.getPetHeadBigIcon(data.templateId);
         }
         if(_icon.icon != _loc1_)
         {
            _icon.icon = _loc1_;
         }
         _stateFlag.visible = true;
         _stateFlag.setFrame(1);
         _stateText.visible = false;
         _overbg.setFrame(1);
         if(data.isEnterWar)
         {
            _stateFlag.setFrame(2);
            _overbg.setFrame(1);
         }
         else if(data.isChildWar != 0)
         {
            _stateFlag.setFrame(3);
         }
         if(data.isPractice)
         {
            _stateText.visible = true;
         }
         _lockFlag.visible = true;
         _lockFlag.setFrame(1);
         if(data.isBind)
         {
            _lockFlag.setFrame(2);
         }
         _nameTxt.text = data.name;
         _nameTxt.setFrame(_data.quality);
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         showStar();
         _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",data.grade);
         if(data && data.isLock)
         {
            _lockFlag.setFrame(1);
            showVpLock();
         }
         else if(data && !data.isLock)
         {
            hideVpLock();
         }
      }
      
      public function showVpLock() : void
      {
         if(_lockIcon == null)
         {
            _lockIcon = ComponentFactory.Instance.creat("asset.common.vp.icon");
            _lockIcon.x = 2;
            _lockIcon.y = 37;
            addChild(_lockIcon);
         }
         _lockIcon.visible = true;
      }
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      private function showStar() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc1_:UpgradeTemplateInfo = _data.qualityUpgradeTemplateInfo;
         if(_loc1_ == null)
         {
            return;
         }
         _loc3_ = _data.temQuality % 5 == 0 ? 5 : _data.temQuality % 5;
         if(_data.temQuality > 25)
         {
            _loc4_ = "asset.pet.smallMoonLightLevelImg";
            _loc5_ = "asset.pet.smallMoonDarkLevelImg";
         }
         else
         {
            _loc4_ = "asset.petList.StarLevelLightImg";
            _loc5_ = "asset.petList.StarLevelDarkImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc8_ = ComponentFactory.Instance.creatBitmap(_loc4_);
            _hBox.addChild(_loc8_);
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < 5 - _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap(_loc5_);
            _hBox.addChild(_loc2_);
            _loc7_++;
         }
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
         _selected = param1;
         _overbg.visible = _selected;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         mouseEnabled = _enable;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         if(_bg)
         {
            _bg.setFrame(param1);
         }
         if(param1 == 1)
         {
            buttonMode = true;
            tipData = LanguageMgr.GetTranslation("PetListItemView.morePos");
         }
         else
         {
            tipData = null;
            buttonMode = false;
         }
      }
      
      public function gray() : void
      {
         if(!filter)
         {
            filter = UIFilter.getGrayFilter();
         }
         this.filters = [filter];
         isGray = true;
      }
      
      public function normal() : void
      {
         this.filters = [];
         isGray = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

