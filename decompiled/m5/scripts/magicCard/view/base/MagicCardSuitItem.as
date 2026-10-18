package magicCard.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class MagicCardSuitItem extends Component implements ISelectable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _shineBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _selected:Boolean;
      
      private var _enable:Boolean = true;
      
      private var _filter:ColorMatrixFilter;
      
      private var _type:int;
      
      private var _isActived:Boolean = false;
      
      public function MagicCardSuitItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get isActived() : Boolean
      {
         return _isActived;
      }
      
      public function set isActived(param1:Boolean) : void
      {
         _isActived = param1;
         if(_isActived)
         {
            normal();
         }
         else
         {
            black();
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         if(_type == -1)
         {
            enable = false;
            _icon.icon = PathManager.getCardTabDefaultPath();
         }
         else
         {
            enable = true;
            _icon.icon = PathManager.getCardTabPath(_type);
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("magicCard.border");
         _shineBg = ComponentFactory.Instance.creatBitmap("asset.magicCard.SelectedBorder");
         _icon = ComponentFactory.Instance.creatCustomObject("magicCard.suitIcon");
         addChild(_icon);
         addChild(_back);
         addChild(_shineBg);
         _shineBg.visible = false;
         _icon.mouseChildren = _icon.mouseEnabled = false;
         _back.setFrame(1);
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         if(_enable)
         {
            light();
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         if(!_isActived && _type != -1)
         {
            black();
            return;
         }
         normal();
      }
      
      public function set icon(param1:String) : void
      {
         _icon.icon = param1;
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
         _shineBg.visible = _selected;
         if(!isActived)
         {
            black();
         }
      }
      
      public function light() : void
      {
         if(!_filter)
         {
            _filter = UIFilter.getLightingFilter();
         }
         _icon.filters = [_filter];
      }
      
      public function gray() : void
      {
         if(!_filter)
         {
            _filter = UIFilter.getGrayFilter();
         }
         _icon.filters = [_filter];
      }
      
      public function black() : void
      {
         var _loc1_:ColorMatrixFilter = UIFilter.getBlackFilter();
         _icon.filters = [_loc1_];
      }
      
      public function normal() : void
      {
         _icon.filters = [];
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         mouseEnabled = _enable;
         buttonMode = _enable;
         var _loc2_:int = _enable ? 1 : 2;
         _back.setFrame(_loc2_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _filter = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_shineBg);
         _shineBg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

