package childpve
{
   import child.attribute.ChildShowAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import mvc.controler.ChildPveController;
   import mvc.module.children.ChildData;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class ChildFormationItemView extends Component
   {
      
      private var _bottom:MovieClip;
      
      private var _figure:ChildShowAvatar;
      
      private var _nameTxt:FilterFrameText;
      
      private var _controller:ChildPveController = FrameControllerManager.instance.childPveController;
      
      private var _shape:Sprite;
      
      private var _pos:int;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _darkColorTransForm:ColorTransform = new ColorTransform(0.6,0.6,0.6);
      
      private var _normalColorTransForm:ColorTransform = new ColorTransform();
      
      private var dragView:ChildFormationItemView;
      
      private var _data:ChildData;
      
      private var _loader:Loader;
      
      private var _poolSprite:Shape;
      
      private var _isDrag:Boolean;
      
      private var _isDrak:Boolean = false;
      
      public function ChildFormationItemView(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creat("asset.childformation.Bottom");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildFormationItemView.nameTxt");
         _figure = new ChildShowAvatar();
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
         ObjectUtils.disposeViolentMc(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         clearBody();
         _loader = null;
         _simpleFilter = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
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
         dragView = new ChildFormationItemView();
         dragView.data = _loc2_;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc3_.data = _loc2_;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [ChildFormationItemView,VBox,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:ChildFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is ChildFormationItemView)
         {
            _loc2_ = param1.dropTarget as ChildFormationItemView;
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         if(_loc2_)
         {
            this.data = _loc2_.data;
            _loc2_.data = param1.data as ChildData;
         }
         else if(param1.dropTarget is VBox)
         {
            this.data = null;
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
         if(param1 == null && _data != null)
         {
            _poolSprite = null;
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
      
      public function refresh() : void
      {
         _nameTxt.text = data.name;
         _nameTxt.x = -_nameTxt.textWidth / 2;
         _figure.data = _data;
         addChild(_nameTxt);
         setBottomVisible(false);
         _nameTxt.y = -1 * _figure.height;
         this.buttonMode = true;
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         clearBody();
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         var _loc5_:Class = _controller.classDefineDic[_data.templateId] as Class;
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
               _loc4_ = new LoaderContext(false,_loc3_);
               disposeLoader();
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("complete",__complete);
               _loader.loadBytes(param2 as ByteArray,_loc4_);
            }
         }
         else
         {
            crateBody();
         }
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__complete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      private function __complete(param1:Event) : void
      {
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__complete);
         var _loc3_:Class = _controller.classDefineDic[_data.templateId] as Class;
         if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
         {
            _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
            _controller.classDefineDic[_data.templateId] = _loc3_;
         }
         crateBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function crateBody() : void
      {
      }
      
      private function drawBackground() : void
      {
         var _loc9_:BitmapData = null;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc8_:Number = NaN;
         if(!_figure)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         _shape.x = 0;
         _shape.y = 0;
         var _loc1_:Rectangle = _figure.getBounds(_figure);
         _shape.x = _loc1_.x;
         _shape.y = _loc1_.y;
         this.hitArea = _shape;
         var _loc4_:Shape = _controller.getShape(_data.templateId);
         if(!_loc4_)
         {
            _loc4_ = new Shape();
            _loc9_ = drawDisplayObject(_figure);
            if(!_loc9_)
            {
               return;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc9_.width)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc9_.height)
               {
                  _loc2_ = _loc9_.getPixel32(_loc3_,_loc5_);
                  _loc6_ = uint(_loc2_ >> 24 & 0xFF);
                  _loc8_ = _loc6_ / 255;
                  if(_loc2_ > 50)
                  {
                     _loc4_.graphics.beginFill(0,_loc8_);
                     _loc4_.graphics.drawCircle(_loc3_,_loc5_,1);
                     _loc4_.graphics.endFill();
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
            _loc9_.dispose();
            _loc9_ = null;
         }
         _shape.addChild(_loc4_);
         var _loc7_:String = getQualifiedClassName(_figure);
         if(_loc7_ != "asset.avatar::DefaultAvatarMovieAsset")
         {
            _poolSprite = _loc4_;
         }
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
      
      private function clearBody() : void
      {
         drawBackground();
      }
      
      public function clean() : void
      {
         _nameTxt.text = "";
         drawBackground();
         _figure.data = null;
         this.hitArea = _bottom;
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = 0;
         this.buttonMode = false;
         _controller;
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
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         if(_data && _controller)
         {
            _controller.saveShape(_data.templateId,_poolSprite);
            _poolSprite = null;
         }
         clearTimeout(BaseManager.delayId);
         disposeLoader();
         removeEvent();
         uintView();
         if(dragView)
         {
            dragView.dispose();
            dragView = null;
         }
         super.dispose();
         _controller = null;
      }
   }
}

