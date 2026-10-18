package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.display.DisplayObject;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.IconFactory;
   
   public class HeroIconCell extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_iconX:String = "iconX";
      
      public static const P_iconY:String = "iconY";
      
      public static const P_iconWidth:String = "iconWidth";
      
      public static const P_iconHeight:String = "iconHeight";
      
      private var _backStyle:String;
      
      private var _iconStyle:String;
      
      private var _iconViewX:int;
      
      private var _iconViewY:int;
      
      private var _iconViewWidth:int;
      
      private var _iconViewHeight:int;
      
      private var _back:DisplayObject;
      
      private var _icon:BaseIconView;
      
      private var _heroInfo:ThaneInfo;
      
      public var tipEnable:Boolean;
      
      private var _type:String;
      
      public function HeroIconCell(param1:Function = null)
      {
         super();
      }
      
      public function set backStyle(param1:String) : void
      {
         _backStyle = param1;
         onPropertiesChanged("backStyle");
      }
      
      public function set iconStyle(param1:String) : void
      {
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set iconX(param1:int) : void
      {
         _iconViewX = param1;
         onPropertiesChanged("iconX");
      }
      
      public function get iconX() : int
      {
         return _iconViewX;
      }
      
      public function set iconY(param1:int) : void
      {
         _iconViewY = param1;
         onPropertiesChanged("iconY");
      }
      
      public function set iconWidth(param1:int) : void
      {
         _iconViewWidth = param1;
         onPropertiesChanged("iconWidth");
      }
      
      public function get iconWidth() : int
      {
         return _iconViewWidth;
      }
      
      public function set iconHeight(param1:int) : void
      {
         _iconViewHeight = param1;
         onPropertiesChanged("iconHeight");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backStyle"])
         {
            _back = ComponentFactory.Instance.creatComponentByStylename(_backStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatCustomObject(_iconStyle);
         }
         if(_changedPropeties["iconHeight"] || _changedPropeties["iconWidth"] || _changedPropeties["iconX"] || _changedPropeties["iconY"])
         {
            _icon.beginChanges();
            _icon.x = _iconViewX;
            _icon.y = _iconViewY;
            _icon.iconHeight = _iconViewHeight;
            _icon.iconWidth = _iconViewWidth;
            _icon.tipStyle = "yishi.view.tips.HeroTip";
            _icon.isFollowMouse = false;
            _icon.tipGapH = 0;
            _icon.tipGapV = 0;
            _icon.tipDirctions = "7,5,4,6";
            _icon.commitChanges();
         }
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
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         if(_heroInfo == param1)
         {
            return;
         }
         _heroInfo = param1;
         if(_heroInfo && _icon)
         {
            if(tipEnable)
            {
               _icon.tipData = _heroInfo;
            }
            _icon.icon = IconFactory.getHeroicon(_heroInfo.templateId);
         }
         else if(_icon)
         {
            _icon.icon = null;
         }
         refreshView();
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      protected function refreshView() : void
      {
      }
      
      public function get data() : ThaneInfo
      {
         return _heroInfo;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

