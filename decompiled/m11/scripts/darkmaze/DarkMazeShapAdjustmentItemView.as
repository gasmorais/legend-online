package darkmaze
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mvc.module.children.ChildData;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class DarkMazeShapAdjustmentItemView extends Component
   {
      
      private var _bottom:MovieClip;
      
      private var _figure:DarkMazeChildShowAvatar;
      
      private var _nameTxt:FilterFrameText;
      
      private var _shape:Sprite;
      
      private var _pos:int;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _dragView:DarkMazeShapAdjustmentItemView;
      
      private var _darkColorTransForm:ColorTransform = new ColorTransform(0.6,0.6,0.6);
      
      private var _normalColorTransForm:ColorTransform = new ColorTransform();
      
      private var _isDrag:Boolean;
      
      private var _data:ChildData;
      
      private var dragView:DarkMazeShapAdjustmentItemView;
      
      private var _isDrak:Boolean = false;
      
      private var _enable:Boolean = true;
      
      public function DarkMazeShapAdjustmentItemView(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creat("asset.darkmaze.bottom");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.nameTxt");
         _figure = new DarkMazeChildShowAvatar();
         _figure.x = -100;
         _figure.y = -165;
         _figure.scaleX = _figure.scaleY = 0.75;
         _figure.mouseChildren = true;
         _figure.mouseEnabled = true;
         _shape = new Sprite();
         _shape.alpha = 0;
         addChild(_bottom);
         addChild(_shape);
         addChild(_figure);
         addChild(_nameTxt);
         setBottomVisible(false);
         this.hitArea = _bottom;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         _simpleFilter = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         _normalColorTransForm = null;
         _darkColorTransForm = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseDown",__mouseDownHandler);
         this.addEventListener("mouseUp",__mouseUpHandler);
         this.addEventListener("mouseMove",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__mouseDownHandler);
         this.removeEventListener("mouseUp",__mouseMoveHandler);
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         this.removeEventListener("mouseMove",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         this.addEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"down");
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"click");
      }
      
      private function beginDrag(param1:String) : void
      {
         var _loc2_:ChildData = this.data;
         this.data = null;
         _dragView = new DarkMazeShapAdjustmentItemView();
         _dragView.data = _loc2_;
         _dragView.isDrag = true;
         _dragView.mouseChildren = _dragView.mouseEnabled = false;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_dragView,
            "type":param1
         });
         _loc3_.data = _loc2_;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [DarkMazeShapAdjustmentItemView,ScrollPanel,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:DarkMazeShapAdjustmentItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is DarkMazeShapAdjustmentItemView)
         {
            _loc2_ = param1.dropTarget as DarkMazeShapAdjustmentItemView;
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         if(_loc2_)
         {
            this.data = _loc2_.data;
            _loc2_.data = param1.data as ChildData;
         }
         else if(param1.dropTarget is ScrollPanel)
         {
            if(param1.dropTarget["stylename"] == "DarkMazeShapeAdjustmentFrame.scrollPanle")
            {
               this.data = null;
            }
            else
            {
               this.data = param1.data as ChildData;
            }
         }
         else
         {
            this.data = param1.data as ChildData;
         }
         dragView = null;
         NotificationManager.instance.sendNotification("END_DRAG",this);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_figure && !_isDrak)
         {
            _simpleFilter.setGlowFilter(_figure);
         }
         if(_bottom && !_bottom.isPlaying)
         {
            _bottom.play();
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_figure)
         {
            _simpleFilter.setNormalFilter(_figure);
         }
         if(_bottom)
         {
            _bottom.stop();
         }
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(_data)
         {
            refresh();
            addEvent();
         }
         else
         {
            clean();
            removeEvent();
         }
      }
      
      private function refresh() : void
      {
         _nameTxt.text = data.name;
         _nameTxt.x = -_nameTxt.textWidth / 2;
         _figure.data = _data;
         addChild(_nameTxt);
         setBottomVisible(false);
         _nameTxt.y = -1 * _figure.height;
         this.buttonMode = true;
      }
      
      public function drawDisplayObject(param1:DisplayObject = null) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Matrix = null;
         var _loc2_:Rectangle = param1.getBounds(param1);
         if(param1 is Stage || _loc2_.width != 0 && _loc2_.height != 0)
         {
            _loc4_ = new Rectangle(0,0,Math.abs(_loc2_.width),Math.abs(_loc2_.height));
            _loc4_.width = _loc4_.width > 2880 ? 2880 : _loc4_.width;
            _loc4_.height = _loc4_.height > 2880 ? 2880 : _loc4_.height;
            _loc3_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc5_ = new Matrix();
            _loc5_.translate(-_loc2_.x,-_loc2_.y);
            _loc3_.draw(param1,_loc5_);
         }
         return _loc3_;
      }
      
      private function clean() : void
      {
         _nameTxt.text = "";
         _figure.data = null;
         this.hitArea = _bottom;
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = 0;
         this.buttonMode = false;
      }
      
      public function get isDrag() : Boolean
      {
         return _isDrag;
      }
      
      public function set isDrag(param1:Boolean) : void
      {
         _isDrag = param1;
         if(_bottom)
         {
            _bottom.visible = !_isDrag;
         }
         this.mouseChildren = this.mouseEnabled = !_isDrag;
      }
      
      public function setBottomVisible(param1:Boolean) : void
      {
         if(_bottom)
         {
            _bottom.visible = param1;
            _bottom.stop();
         }
         if(param1)
         {
            this.addEventListener("mouseMove",__rollOverHandler);
            this.addEventListener("rollOut",__rollOutHandler);
         }
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function dark() : void
      {
         if(_figure)
         {
            _figure.transform.colorTransform = _darkColorTransForm;
         }
         _isDrak = true;
         this.hitArea = _bottom;
         _shape.mouseChildren = _shape.mouseEnabled = false;
      }
      
      public function normal() : void
      {
         if(_figure)
         {
            _figure.transform.colorTransform = _normalColorTransForm;
            this.hitArea = _shape;
         }
         else
         {
            this.hitArea = _bottom;
         }
         _isDrak = false;
         _shape.mouseChildren = _shape.mouseEnabled = true;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_enable)
         {
            filters = null;
         }
         else
         {
            filters = [UIFilter.getGrayFilter()];
         }
      }
      
      override public function dispose() : void
      {
         clearTimeout(BaseManager.delayId);
         removeEvent();
         uintView();
         if(dragView)
         {
            dragView.dispose();
            dragView = null;
         }
         super.dispose();
      }
   }
}

