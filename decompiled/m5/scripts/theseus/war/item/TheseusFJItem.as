package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.mediator.TheseusFJItemClickMediator;
   import theseus.war.mediator.TheseusFJItemDropMediator;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusFJItem extends Component
   {
      
      public static const P_starStyle:String = "starStyle";
      
      public var showProfile:Boolean;
      
      private var _back:DisplayObject;
      
      private var _textIcon:Image;
      
      private var _icon:BaseIconView;
      
      private var _profile:ScaleFrameImage;
      
      private var _itemText:FilterFrameText;
      
      private var _mediatorKey:String;
      
      private var _registed:Boolean;
      
      private var _data:TheseusWarsoulItemInfo;
      
      protected var _filter:IFilterFormat;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _starSpace:int;
      
      private var _starItem:TheseusStarItem;
      
      private var _starStyle:String;
      
      public const P_backgroundStyle:String = "backgroundStyle";
      
      public const P_iconStyle:String = "iconStyle";
      
      public const P_profileStyle:String = "profileStyle";
      
      public const P_profileX:String = "profileX";
      
      public const P_profileY:String = "profileY";
      
      public const P_profileWidth:String = "profileWidth";
      
      public const P_profileHeight:String = "profileHeight";
      
      public const P_textStyle:String = "textStyle";
      
      public const P_textIcon:String = "textIcon";
      
      public const NAME:String = "theseus.war.item.TheseusFJItem";
      
      private var _textIconStyle:String;
      
      private var _backgroundStyle:String;
      
      private var _iconStyle:String;
      
      private var _profileStyle:String;
      
      private var _profileX:Number;
      
      private var _profileY:Number;
      
      private var _profileWidth:Number;
      
      private var _profileHeight:Number;
      
      private var _textStyle:String;
      
      public var iconBack:Function;
      
      public function TheseusFJItem()
      {
         super();
         _filter = new UIFilter();
      }
      
      public function set starSpace(param1:int) : void
      {
         _starSpace = param1;
      }
      
      public function set starStyle(param1:String) : void
      {
         _starStyle = param1;
         onPropertiesChanged("starStyle");
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
      
      public function get data() : TheseusWarsoulItemInfo
      {
         return _data;
      }
      
      private function clean() : void
      {
         buttonMode = false;
         if(_profile)
         {
            _profile.visible = false;
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
      
      public function set data(param1:TheseusWarsoulItemInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            _icon.icon = IconFactory.getTheseusWarSoulIcon(_data.warTempInfo.Icon);
            _icon.tipData = _data;
            if(_profile)
            {
               _profile.visible = showProfile;
               _profile.setFrame(_data.warTempInfo.Profile - 1);
            }
            if(_itemText && _data.num > 1)
            {
               _itemText.text = "" + _data.num;
            }
            if(_starItem)
            {
               _starItem.visible = true;
               _starItem.showStar(_data.star);
            }
         }
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [TheseusFJItemClickMediator,TheseusFJItemDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusFJItem");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_textIcon)
         {
            addChild(_textIcon);
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
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_textIcon);
         _textIcon = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_itemText);
         _itemText = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function set textIconStyle(param1:String) : void
      {
         _textIconStyle = param1;
         onPropertiesChanged("textIcon");
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
      
      private function iconLoadBack(param1:BaseIconView) : void
      {
         if(iconBack != null)
         {
            iconBack(this);
         }
         iconBack = null;
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
         if(_changedPropeties["starStyle"])
         {
            _starItem = ComponentFactory.Instance.creatCustomObject(_starStyle,[_starSpace]);
         }
         if(_changedPropeties["textIcon"])
         {
            _textIcon = ComponentFactory.Instance.creatComponentByStylename(_textIconStyle);
         }
      }
   }
}

