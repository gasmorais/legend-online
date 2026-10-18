package theseus.war.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.mediator.TheseusInsfBagCellClickMediator;
   import theseus.war.mediator.TheseusInsfBagCellDropMediator;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusInsfBagCell extends Component implements IManualSize
   {
      
      public static const P_backgroundStyle:String = "backgroundStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_profileStyle:String = "profileStyle";
      
      public static const P_profileX:String = "profileX";
      
      public static const P_profileY:String = "profileY";
      
      public static const P_profileWidth:String = "profileWidth";
      
      public static const P_profileHeight:String = "profileHeight";
      
      public static const P_textStyle:String = "textStyle";
      
      public static const P_starStyle:String = "starStyle";
      
      public static const NAME:String = "theseus.war.item.TheseusInsfBagCell";
      
      private var _lockIcon:DisplayObject;
      
      protected var relativeLockPos:int = 0;
      
      public const P_equipStyle:String = "equipStyle";
      
      private var _equipStyle:String;
      
      private var _equipFlg:Bitmap;
      
      public var iconBack:Function;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      public var showProfile:Boolean;
      
      public var mainType:int;
      
      public var funType:int;
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      protected var _data:TheseusWarsoulItemInfo;
      
      protected var _filter:IFilterFormat;
      
      protected var _back:DisplayObject;
      
      protected var _icon:BaseIconView;
      
      protected var _profile:ScaleFrameImage;
      
      protected var _itemText:FilterFrameText;
      
      protected var _starSpace:int;
      
      private var _textStyle:String;
      
      private var _backgroundStyle:String;
      
      private var _iconStyle:String;
      
      private var _profileStyle:String;
      
      private var _starItem:TheseusStarItem;
      
      private var _starStyle:String;
      
      private var _profileX:Number;
      
      private var _profileY:Number;
      
      private var _profileWidth:Number;
      
      private var _profileHeight:Number;
      
      public function TheseusInsfBagCell()
      {
         super();
         _filter = new UIFilter();
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equipStyle");
      }
      
      public function set starSpace(param1:int) : void
      {
         _starSpace = param1;
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,53,52);
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [TheseusInsfBagCellClickMediator,TheseusInsfBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusInsfBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function set textStyle(param1:String) : void
      {
         _textStyle = param1;
         onPropertiesChanged("textStyle");
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
      
      public function set starStyle(param1:String) : void
      {
         _starStyle = param1;
         onPropertiesChanged("starStyle");
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
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_starItem)
         {
            addChild(_starItem);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_equipFlg)
         {
            addChild(_equipFlg);
         }
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
         if(_changedPropeties["starStyle"])
         {
            _starItem = ComponentFactory.Instance.creatCustomObject(_starStyle,[_starSpace]);
         }
         if(_changedPropeties["profileHeight"] || _changedPropeties["profileWidth"] || _changedPropeties["profileX"] || _changedPropeties["profileY"])
         {
            if(_profile)
            {
               _profile.beginChanges();
               _profile.x = _profileX;
               _profile.y = _profileY;
               _profile.width = _profileWidth;
               _profile.height = _profileHeight;
               _profile.commitChanges();
            }
         }
         if(_changedPropeties["equipStyle"])
         {
            _equipFlg = ComponentFactory.Instance.creatBitmap(_equipStyle);
         }
         if(_changedPropeties["textStyle"])
         {
            _itemText = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
            _itemText.mouseEnabled = false;
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
      
      override public function dispose() : void
      {
         unregisterMediator();
         if(_lockIcon)
         {
            ObjectUtils.disposeObject(_lockIcon);
            _lockIcon = null;
         }
         if(_icon)
         {
            ShowTipManager.Instance.removeTip(_icon);
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_equipFlg);
         _equipFlg = null;
         ObjectUtils.disposeObject(_itemText);
         _itemText = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      protected function clean() : void
      {
         hideVpLock();
         buttonMode = false;
         if(_profile)
         {
            _profile.visible = false;
         }
         if(_equipFlg)
         {
            _equipFlg.visible = false;
         }
         if(_starItem)
         {
            _starItem.visible = false;
         }
         if(_itemText)
         {
            _itemText.text = "";
         }
         if(_icon)
         {
            ShowTipManager.Instance.removeTip(_icon);
            _icon.icon = null;
            _icon.iconBackStyle = null;
         }
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
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      public function get data() : TheseusWarsoulItemInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusWarsoulItemInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.isLock)
            {
               showVpLock();
            }
            else if(!_data.isLock)
            {
               hideVpLock();
            }
            _icon.icon = IconFactory.getTheseusWarSoulIcon(_data.warTempInfo.Icon);
            _icon.tipData = _data;
            if(_profile)
            {
               _profile.visible = showProfile;
               _profile.setFrame(_data.warTempInfo.Profile - 1);
            }
            if(_equipFlg)
            {
               _equipFlg.visible = _data.isEquip;
            }
            if(_starItem)
            {
               _starItem.visible = true;
               _starItem.showStar(_data.star);
            }
            if(_itemText && _data.num > 1)
            {
               _itemText.text = getCountStr(_data.num);
            }
         }
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      protected function getCountStr(param1:int) : String
      {
         var _loc2_:Number = param1 / 10000;
         if(param1 % 10000 == 0)
         {
            if(_loc2_ >= 1)
            {
               return int(_loc2_) + "W";
            }
         }
         else
         {
            if(_loc2_ >= 1 && _loc2_ < 10)
            {
               return _loc2_.toFixed(1) + "W";
            }
            if(_loc2_ > 10)
            {
               return int(_loc2_) + "W";
            }
         }
         return param1.toString();
      }
   }
}

