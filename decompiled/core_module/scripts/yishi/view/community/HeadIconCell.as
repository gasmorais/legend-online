package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import yishi.utils.IconFactory;
   
   public class HeadIconCell extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_overStyle:String = "overStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_iconX:String = "iconX";
      
      public static const P_iconY:String = "iconY";
      
      public static const P_iconWidth:String = "iconWidth";
      
      public static const P_iconHeight:String = "iconHeight";
      
      private var _backStyle:String;
      
      private var _overStyle:String;
      
      private var _iconStyle:String;
      
      private var _iconViewX:int;
      
      private var _iconViewY:int;
      
      private var _iconViewWidth:int;
      
      private var _iconViewHeight:int;
      
      private var _back:DisplayObject;
      
      private var _overBack:DisplayObject;
      
      private var _icon:BaseIconView;
      
      private var _headId:int;
      
      private var _type:String = "smallhead";
      
      public function HeadIconCell()
      {
         super();
      }
      
      public function set backStyle(param1:String) : void
      {
         _backStyle = param1;
         onPropertiesChanged("backStyle");
      }
      
      public function set overStyle(param1:String) : void
      {
         _overStyle = param1;
         onPropertiesChanged("overStyle");
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
      
      public function get iconHeight() : int
      {
         return _iconViewHeight;
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
         if(_changedPropeties["overStyle"])
         {
            _overBack = ComponentFactory.Instance.creatComponentByStylename(_overStyle);
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
      
      public function set overEnable(param1:Boolean) : void
      {
         if(param1)
         {
            addEventListener("rollOver",__rollOverHandler);
            addEventListener("rollOut",__rollOutHandler);
         }
         else
         {
            removeEventListener("rollOver",__rollOverHandler);
            removeEventListener("rollOut",__rollOutHandler);
         }
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_overBack)
         {
            addChild(_overBack);
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_overBack && _overBack.parent)
         {
            _overBack.parent.removeChild(_overBack);
         }
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function set headId(param1:int) : void
      {
         _headId = param1;
         if(_icon)
         {
            _icon.buttonMode = false;
            if(_type == "smallhead")
            {
               _icon.icon = IconFactory.getHeadIcon(_headId,_type,".jpg");
            }
            else
            {
               _icon.icon = IconFactory.getHeadIcon(_headId,_type);
            }
         }
      }
      
      public function get headId() : int
      {
         return _headId;
      }
      
      override public function dispose() : void
      {
         overEnable = false;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_overBack)
         {
            ObjectUtils.disposeObject(_overBack);
         }
         _overBack = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

