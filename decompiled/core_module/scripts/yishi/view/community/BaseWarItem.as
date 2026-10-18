package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class BaseWarItem extends Component
   {
      
      public static const P_backgroundStyle:String = "backgroundStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_fashionStyle:String = "fashionstyle";
      
      public static const P_profileStyle:String = "profileStyle";
      
      public static const P_profileX:String = "profileX";
      
      public static const P_profileY:String = "profileY";
      
      public static const P_fashionTextY:String = "fashionTextY";
      
      public static const P_fashionIconY:String = "fashionIconY";
      
      public static const P_profileWidth:String = "profileWidth";
      
      public static const P_profileHeight:String = "profileHeight";
      
      public static const P_profileSc:String = "profileSca";
      
      public static const P_Strengthen:String = "strengthen";
      
      public static const P_StrengthenX:String = "strengthenX";
      
      public static const P_StrengthenY:String = "strengthenY";
      
      public static const P_textStyle:String = "textStyle";
      
      public static const P_typeTextStyle:String = "typeTextStyle";
      
      public static const DEFAULT_WIDTH:int = 60;
      
      public static const DEFAULT_HEIGHT:int = 60;
      
      private var _fashionStyle:String;
      
      private var _fashionTextY:int;
      
      private var _fashionIconY:int;
      
      private var _backgroundStyle:String;
      
      private var _iconStyle:String;
      
      private var _profileStyle:String;
      
      private var _profileX:Number;
      
      private var _profileY:Number;
      
      private var _profileSca:Number = 1;
      
      private var _profileWidth:Number;
      
      private var _profileHeight:Number;
      
      private var _textStyle:String;
      
      private var _strengthenStyle:String;
      
      private var _strengthenX:Number;
      
      private var _strengthenY:Number;
      
      private var _typeTextStyle:String;
      
      protected var _back:DisplayObject;
      
      protected var _icon:BaseIconView;
      
      protected var _profile:ScaleFrameImage;
      
      protected var _itemText:FilterFrameText;
      
      protected var _strengthenIcon:MovieImage;
      
      protected var _fashionImage:ScaleFrameImage;
      
      protected var _fashionFullLevel:Bitmap;
      
      protected var _fashionText:FilterFrameText;
      
      protected var _typeText:Image;
      
      protected var _dragontalker:Bitmap;
      
      protected var _gInfo:WarFrameItemInfo;
      
      public var iconBack:Function;
      
      public var bagType:int = 0;
      
      public var objectId:int = 0;
      
      public var pos:int;
      
      public var showProfile:Boolean;
      
      public var isDraging:Boolean = false;
      
      public var isNormalFilter:Boolean = true;
      
      protected var _filter:IFilterFormat;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      protected var relativeLockPos:int = 0;
      
      private var _lockIcon:DisplayObject;
      
      private var _mountAreaIcon:ScaleFrameImage;
      
      private var activeText:FilterFrameText;
      
      protected var _avengerPearlGradeImage:Bitmap;
      
      public function BaseWarItem()
      {
         super();
         _filter = new UIFilter();
         _colorMatrix = [0.2,0,0,0,6.1,0,0.2,0,0,6.1,0,0,0.2,0,6.1,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
      }
      
      public function set fashionTextY(param1:Number) : void
      {
         _fashionTextY = param1;
         onPropertiesChanged("fashionTextY");
      }
      
      public function set fashionIconY(param1:Number) : void
      {
         _fashionIconY = param1;
         onPropertiesChanged("fashionIconY");
      }
      
      public function set fashionStyle(param1:String) : void
      {
         _fashionStyle = param1;
         onPropertiesChanged("fashionstyle");
      }
      
      public function set backgroundStyle(param1:String) : void
      {
         _backgroundStyle = param1;
         onPropertiesChanged("backgroundStyle");
      }
      
      public function set iconStyle(param1:String) : void
      {
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set profileStyle(param1:String) : void
      {
         _profileStyle = param1;
         onPropertiesChanged("profileStyle");
      }
      
      public function set profileX(param1:Number) : void
      {
         _profileX = param1;
         onPropertiesChanged("profileX");
      }
      
      public function set profileY(param1:Number) : void
      {
         _profileY = param1;
         onPropertiesChanged("profileY");
      }
      
      public function set profileSca(param1:Number) : void
      {
         _profileSca = param1;
         onPropertiesChanged("profileSca");
      }
      
      public function set profileWidth(param1:Number) : void
      {
         _profileWidth = param1;
         onPropertiesChanged("profileWidth");
      }
      
      public function set profileHeight(param1:Number) : void
      {
         _profileHeight = param1;
         onPropertiesChanged("profileHeight");
      }
      
      public function set textStyle(param1:String) : void
      {
         _textStyle = param1;
         onPropertiesChanged("textStyle");
      }
      
      public function set strengthenStyle(param1:String) : void
      {
         _strengthenStyle = param1;
         onPropertiesChanged("strengthen");
      }
      
      public function set strengthenX(param1:Number) : void
      {
         _strengthenX = param1;
         onPropertiesChanged("strengthenX");
      }
      
      public function set strengthenY(param1:Number) : void
      {
         _strengthenY = param1;
         onPropertiesChanged("strengthenY");
      }
      
      public function set typeTextStyle(param1:String) : void
      {
         _typeTextStyle = param1;
         onPropertiesChanged("typeTextStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backgroundStyle"])
         {
            _back = ComponentFactory.Instance.creat(_backgroundStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatCustomObject(_iconStyle,[iconLoadBack]);
         }
         if(_changedPropeties["profileStyle"])
         {
            _profile = ComponentFactory.Instance.creatComponentByStylename(_profileStyle);
            _profile.mouseChildren = false;
            _profile.mouseEnabled = false;
         }
         if(_changedPropeties["textStyle"])
         {
            _itemText = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
            _itemText.mouseEnabled = false;
         }
         if(_changedPropeties["strengthen"])
         {
            _strengthenIcon = ComponentFactory.Instance.creat(_strengthenStyle);
            _strengthenIcon.mouseEnabled = _strengthenIcon.mouseChildren = false;
            _strengthenIcon.visible = false;
         }
         if(_changedPropeties["strengthenX"] || _changedPropeties["strengthenY"])
         {
            if(_strengthenIcon)
            {
               _strengthenIcon.beginChanges();
               _strengthenIcon.x = _strengthenX;
               _strengthenIcon.y = _strengthenY;
               _strengthenIcon.commitChanges();
            }
         }
         if(_changedPropeties["profileHeight"] || _changedPropeties["profileWidth"] || _changedPropeties["profileX"] || _changedPropeties["profileY"])
         {
            if(_profile)
            {
               _profile.beginChanges();
               _profile.x = _profileX;
               _profile.y = _profileY;
               _profile.scaleX = _profile.scaleY = _profileSca;
               _profile.width = _profileWidth;
               _profile.height = _profileHeight;
               _profile.commitChanges();
            }
         }
         if(_changedPropeties["fashionstyle"])
         {
            _fashionImage = ComponentFactory.Instance.creatComponentByStylename(_fashionStyle);
            _fashionImage.visible = false;
            _fashionImage.mouseEnabled = false;
            _fashionImage.mouseChildren = false;
            _fashionText = ComponentFactory.Instance.creatComponentByStylename("core.BaseItemView.FashionText");
            _fashionText.visible = false;
         }
         if(_changedPropeties["fashionTextY"] && _changedPropeties["fashionIconY"])
         {
            if(_fashionImage)
            {
               _fashionImage.y = _fashionIconY;
            }
            if(_fashionImage)
            {
               _fashionText.y = _fashionTextY;
            }
         }
         if(_changedPropeties["typeTextStyle"])
         {
            _typeText = ComponentFactory.Instance.creatComponentByStylename(_typeTextStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_typeText)
         {
            addChild(_typeText);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_strengthenIcon)
         {
            addChild(_strengthenIcon);
         }
         if(_fashionImage)
         {
            addChild(_fashionImage);
         }
         if(_fashionText)
         {
            addChild(_fashionText);
         }
      }
      
      private function iconLoadBack(param1:BaseIconView) : void
      {
         if(iconBack != null)
         {
            iconBack(this);
         }
         iconBack = null;
      }
      
      protected function clean() : void
      {
         buttonMode = false;
         if(_profile)
         {
            _profile.visible = false;
         }
         if(_itemText)
         {
            _itemText.text = "";
         }
         if(_icon)
         {
            _icon.icon = null;
            _icon.iconBackStyle = null;
         }
         if(_strengthenIcon)
         {
            _strengthenIcon.visible = false;
         }
         if(_fashionImage)
         {
            _fashionImage.visible = false;
         }
         if(_fashionText)
         {
            _fashionText.visible = false;
         }
         if(_dragontalker)
         {
            _dragontalker.visible = false;
         }
         if(_mountAreaIcon)
         {
            ObjectUtils.disposeObject(_mountAreaIcon);
         }
         _mountAreaIcon = null;
         if(_avengerPearlGradeImage)
         {
            ObjectUtils.disposeObject(_avengerPearlGradeImage);
         }
         _avengerPearlGradeImage = null;
         if(activeText)
         {
            ObjectUtils.disposeObject(activeText);
         }
         activeText = null;
         if(_fashionFullLevel)
         {
            ObjectUtils.disposeObject(_fashionFullLevel);
            _fashionFullLevel = null;
         }
         ShowTipManager.Instance.removeTip(_icon);
         setBrightFilter();
      }
      
      public function setItemText(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 0)
         {
            if(_itemText)
            {
               _itemText.text = "";
            }
            return;
         }
         var _loc3_:Number = param1 / 10000;
         if(param1 % 10000 == 0)
         {
            if(_loc3_ >= 1 && _loc3_ < 100)
            {
               _loc2_ = int(_loc3_ * 10) + "K";
            }
            else
            {
               _loc2_ = (_loc3_ / 100).toFixed(1) + "M";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = int(_loc3_ * 10) + "K";
         }
         else if(_loc3_ > 10 && _loc3_ < 100)
         {
            _loc2_ = int(_loc3_ * 10) + "K";
         }
         else if(_loc3_ >= 100)
         {
            _loc2_ = (_loc3_ / 100).toFixed(1) + "M";
         }
         _loc2_ = param1.toString();
         if(_itemText)
         {
            _itemText.text = _loc2_;
         }
      }
      
      public function setItemTextOther(param1:String) : void
      {
         if(_itemText)
         {
            _itemText.text = param1;
         }
      }
      
      public function get itemText() : FilterFrameText
      {
         return _itemText;
      }
      
      public function set data(param1:WarFrameItemInfo) : void
      {
         var _loc3_:GoodsInfo = null;
         _gInfo = param1;
         clean();
         if(!param1)
         {
            hideVpLock();
            return;
         }
         if(param1 && param1.isLock)
         {
            showVpLock();
         }
         else if(param1 && !param1.isLock)
         {
            hideVpLock();
         }
         var _loc2_:GoodsTemplateInfo = _gInfo.warTempInfo;
         if(!_loc2_)
         {
            return;
         }
         if(_itemText)
         {
            _itemText.text = getCountStr(_gInfo);
         }
         if(_icon)
         {
            _icon.icon = IconFactory.getGoodsIconByTID(_loc2_.TemplateId);
            if(_gInfo.type == 1)
            {
               _icon.tipData = _gInfo;
            }
            else
            {
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _gInfo.templateId;
               _loc3_.count = _gInfo.count;
               _icon.tipData = _loc3_;
            }
            setTipStyle();
         }
         if(_profile)
         {
            _profile.visible = true;
            if(_gInfo.type == 1)
            {
               _profile.setFrame(_gInfo.reform - 1);
            }
            else
            {
               _profile.setFrame(_gInfo.warTempInfo.Profile - 1);
            }
         }
         if(_loc2_.Job == "99")
         {
            showDragonTalker();
         }
         else
         {
            hideDragonTalker();
         }
      }
      
      public function showAvengerPearlGradeImage(param1:GoodsTemplateInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_avengerPearlGradeImage == null)
         {
            _avengerPearlGradeImage = ComponentFactory.Instance.creatBitmap("asset.baseItem.avengerPearlGradeImage" + param1.Property1);
            addChild(_avengerPearlGradeImage);
         }
         if(icon)
         {
            _loc2_ = int(icon.iconWidth != 0 ? icon.iconWidth : icon.displayWidth);
            _loc3_ = int(icon.iconHeight != 0 ? icon.iconHeight : icon.displayHeight);
            _avengerPearlGradeImage.scaleX = _loc2_ / 60;
            _avengerPearlGradeImage.scaleY = _loc3_ / 60;
            _avengerPearlGradeImage.x = icon.x + _loc2_ - _avengerPearlGradeImage.width - 4;
            _avengerPearlGradeImage.y = icon.y + 2;
         }
      }
      
      public function showMountAreaType(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_mountAreaIcon == null)
         {
            _mountAreaIcon = ComponentFactory.Instance.creatComponentByStylename("mounts.areaType");
            addChild(_mountAreaIcon);
            _mountAreaIcon.setFrame(param1 + 1);
         }
         if(icon)
         {
            _loc2_ = int(_profileWidth != 0 ? _profileWidth : icon.iconWidth);
            _loc3_ = int(_profileHeight != 0 ? _profileHeight : icon.iconHeight);
            _mountAreaIcon.scaleX = _loc2_ / 60;
            _mountAreaIcon.scaleY = _loc3_ / 60;
            _mountAreaIcon.x = icon.x + _loc2_ - _mountAreaIcon.width * _mountAreaIcon.scaleX;
            _mountAreaIcon.y = icon.y;
         }
         _mountAreaIcon.visible = true;
      }
      
      public function showVpLock() : void
      {
         if(_lockIcon == null)
         {
            _lockIcon = ComponentFactory.Instance.creat("asset.common.vp.icon");
            addChild(_lockIcon);
            if(relativeLockPos > 0)
            {
               _lockIcon.x = relativeLockPos;
               _lockIcon.y = relativeLockPos;
            }
         }
         _lockIcon.visible = true;
      }
      
      public function showDragonTalker() : void
      {
         if(_dragontalker == null)
         {
            _dragontalker = ComponentFactory.Instance.creat("asset.common.dragontalker");
            _dragontalker.width = _icon.iconWidth;
            _dragontalker.height = _icon.iconHeight;
            _dragontalker.x = _icon.x;
            _dragontalker.y = _icon.y;
            addChild(_dragontalker);
         }
         _dragontalker.visible = true;
      }
      
      public function hideDragonTalker() : void
      {
         if(_dragontalker)
         {
            _dragontalker.visible = false;
         }
      }
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      private function getFashionLevel(param1:GoodsInfo) : int
      {
         var _loc2_:int = param1.randomSkill1;
         if(!TempleteManager.instance.getSkillTemplateInfoById(param1.randomSkill1))
         {
            _loc2_ = int(param1.templateInfo.DefaultSkill.split(",")[0]);
         }
         return TempleteManager.instance.getSkillTemplateInfoById(_loc2_).Grades;
      }
      
      protected function getCountStr(param1:WarFrameItemInfo) : String
      {
         if(!param1.warTempInfo || param1.count <= 0)
         {
            return "";
         }
         var _loc2_:Number = param1.count / 10000;
         if(param1.count % 10000 == 0)
         {
            if(_loc2_ >= 1 && _loc2_ < 100)
            {
               return int(_loc2_ * 10) + "K";
            }
            return (_loc2_ / 100).toFixed(1) + "M";
         }
         if(_loc2_ >= 1 && _loc2_ < 10)
         {
            return int(_loc2_ * 10) + "K";
         }
         if(_loc2_ > 10 && _loc2_ < 100)
         {
            return int(_loc2_ * 10) + "K";
         }
         if(_loc2_ >= 100)
         {
            return (_loc2_ / 100).toFixed(1) + "M";
         }
         return param1.count.toString();
      }
      
      public function get data() : WarFrameItemInfo
      {
         return _gInfo;
      }
      
      public function set profile(param1:int) : void
      {
         if(_profile)
         {
            _profile.setFrame(param1 - 1);
         }
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      protected function setTipStyle() : void
      {
         if(_gInfo.type == 1)
         {
            _icon.tipStyle = "yishi.view.tips.goods.TheseusEquipTip";
         }
         else
         {
            _icon.tipStyle = "yishi.view.tips.goods.PropTips";
         }
      }
      
      public function setLightFilter() : void
      {
         if(_icon)
         {
            _filter.setLightingFilter(_icon);
         }
      }
      
      public function setGrayFilter() : void
      {
         if(_icon)
         {
            _filter.setGrayFilter(_icon);
            isNormalFilter = false;
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_icon)
         {
            _filter.setNormalFilter(_icon);
            isNormalFilter = true;
         }
      }
      
      public function setDarkFilter() : void
      {
         filters = [_colorFilter];
      }
      
      public function setBrightFilter() : void
      {
         filters = null;
      }
      
      public function setProfileVisible(param1:Boolean) : void
      {
         if(_profile != null)
         {
            _profile.visible = param1;
         }
      }
      
      override public function dispose() : void
      {
         clean();
         filters = null;
         if(_filter && _icon)
         {
            _filter.setNormalFilter(_icon);
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_itemText);
         _itemText = null;
         ObjectUtils.disposeObject(_fashionText);
         _fashionText = null;
         ObjectUtils.disposeObject(_fashionImage);
         _fashionImage = null;
         ObjectUtils.disposeObject(_fashionFullLevel);
         _fashionFullLevel = null;
         ObjectUtils.disposeViolentMc(_strengthenIcon);
         _strengthenIcon = null;
         ObjectUtils.disposeObject(_dragontalker);
         _dragontalker = null;
         ObjectUtils.disposeObject(_mountAreaIcon);
         _mountAreaIcon = null;
         ObjectUtils.disposeObject(_avengerPearlGradeImage);
         _avengerPearlGradeImage = null;
         if(_lockIcon)
         {
            ObjectUtils.disposeObject(_lockIcon);
            _lockIcon = null;
         }
         _gInfo = null;
         iconBack = null;
         _filter = null;
         _colorFilter = null;
         _colorMatrix = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

