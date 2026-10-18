package yishi.view.community
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import mvc.module.armyII.ArmyPawn;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   
   public class PawnContain extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_iconX:String = "iconX";
      
      public static const P_iconY:String = "iconY";
      
      public static const P_iconWidth:String = "iconWidth";
      
      public static const P_iconHeight:String = "iconHeight";
      
      public static const P_numberStyle:String = "numberStyle";
      
      public static const P_nameStyle:String = "nameStyle";
      
      private var _backStyle:String;
      
      private var _iconStyle:String;
      
      private var _iconViewX:int;
      
      private var _iconViewY:int;
      
      private var _iconViewWidth:int;
      
      private var _iconViewHeight:int;
      
      private var _numberStyle:String;
      
      private var _nameStyle:String;
      
      protected var _icon:BaseIconView;
      
      protected var _back:DisplayObject;
      
      protected var _pawn:ArmyPawn;
      
      protected var _number:FilterFrameText;
      
      protected var _name:FilterFrameText;
      
      protected var _filter:IFilterFormat;
      
      public var isLock:Boolean;
      
      public var dragEnable:Boolean;
      
      public function PawnContain()
      {
         super();
         _filter = new UIFilter();
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
      
      public function set iconHeight(param1:int) : void
      {
         _iconViewHeight = param1;
         onPropertiesChanged("iconHeight");
      }
      
      public function set numberStyle(param1:String) : void
      {
         _numberStyle = param1;
         onPropertiesChanged("numberStyle");
      }
      
      public function set nameStyle(param1:String) : void
      {
         _nameStyle = param1;
         onPropertiesChanged("nameStyle");
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
            _icon.commitChanges();
         }
         if(_changedPropeties["numberStyle"])
         {
            _number = ComponentFactory.Instance.creatComponentByStylename(_numberStyle);
         }
         if(_changedPropeties["nameStyle"])
         {
            _name = ComponentFactory.Instance.creatComponentByStylename(_nameStyle);
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
         if(_number)
         {
            addChild(_number);
         }
         if(_name)
         {
            addChild(_name);
         }
      }
      
      public function get pawn() : ArmyPawn
      {
         return _pawn;
      }
      
      public function set pawn(param1:ArmyPawn) : void
      {
         _pawn = param1;
         if(_pawn)
         {
            _pawn.addEventListener("pawnProppertyChager",__propertiesChanged);
            DoubleClickManager.Instance.enableDoubleClick(_icon);
            _icon.addEventListener("interactive_click",__clickHandler);
            _icon.addEventListener("interactive_double_click",__doubleClickHandler);
         }
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_pawn && _pawn.ownPawns != 0)
         {
            buttonMode = true;
            if(_number)
            {
               _number.text = _pawn.ownPawns.toString();
            }
            if(_name)
            {
               _name.text = _pawn.templateInfo.Name;
            }
            if(_icon)
            {
               _icon.tipData = _pawn;
               _icon.icon = IconFactory.getSoldierIconByIcon(_pawn.templateInfo.Icon);
            }
         }
         else
         {
            buttonMode = false;
            if(_number)
            {
               _number.text = "";
            }
            if(_name)
            {
               _name.text = "";
            }
            if(_icon)
            {
               _icon.icon = null;
               _icon.tipData = null;
            }
         }
      }
      
      private function __propertiesChanged(param1:PawnEvent = null) : void
      {
         refreshView();
      }
      
      private function __clickHandler(param1:InteractiveEvent) : void
      {
         if(dragEnable && pawn && pawn.ownPawns > 0)
         {
            starItemDrag();
         }
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
      }
      
      private function starItemDrag() : void
      {
         if(!_icon || !_icon.content)
         {
            return;
         }
         var _loc2_:DisplayObject = getDragIconObj();
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:GameDrag = DragManager.getInstance().starDrag(this,{"icon":_loc2_});
         _loc1_.onDrop = onDragStop;
         _loc1_.dropChecks = [PawnContain,Frame,stage];
         onStartDrag(_loc1_);
         filters = [UIFilter.getGrayFilter(),UIFilter.getLightingFilter()];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc3_:Bitmap = null;
         var _loc1_:BitmapData = null;
         var _loc4_:Bitmap = null;
         var _loc2_:Sprite = null;
         if(pawn)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.DragIconBack");
            _loc1_ = new BitmapData(_icon.content.width / _icon.content.scaleX,_icon.content.height / _icon.content.scaleY,true,0);
            _loc1_.draw(_icon.content);
            _loc3_.width = _loc1_.width + 4;
            _loc3_.height = _loc1_.height + 4;
            _loc4_ = new Bitmap(_loc1_);
            _loc4_.x = _loc4_.y = 2;
            _loc2_ = new Sprite();
            _loc2_.addChild(_loc3_);
            _loc2_.addChild(_loc4_);
            return _loc2_;
         }
         return null;
      }
      
      protected function __iTEM_DROP_BagNotic() : void
      {
         filters = null;
      }
      
      protected function onStartDrag(param1:GameDrag) : void
      {
      }
      
      protected function onDragStop(param1:GameDrag) : void
      {
      }
      
      override public function dispose() : void
      {
         if(_pawn)
         {
            _pawn.removeEventListener("pawnProppertyChager",__propertiesChanged);
         }
         if(_icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_icon);
            _icon.removeEventListener("interactive_click",__clickHandler);
            _icon.removeEventListener("interactive_double_click",__doubleClickHandler);
         }
         _pawn = null;
         _icon = null;
         _back = null;
         _number = null;
         _name = null;
         super.dispose();
      }
   }
}

