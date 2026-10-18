package childformation
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import managers.ChildManager;
   import mvc.controler.PetChallengeController;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.utils.GameDrag;
   
   public class ChildCommonFormationItemView extends Component
   {
      
      private var _bottom:MovieClip;
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _shape:Sprite;
      
      private var _pos:int;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _darkColorTransForm:ColorTransform = new ColorTransform(0.6,0.6,0.6);
      
      private var _normalColorTransForm:ColorTransform = new ColorTransform();
      
      private var _isDrak:Boolean = false;
      
      private var _isDrag:Boolean;
      
      private var _data:ChildData;
      
      private var _formationType:int;
      
      private const SCALE:Number = 0.75;
      
      private var dragView:ChildCommonFormationItemView;
      
      public function ChildCommonFormationItemView(param1:int = 0)
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
         _shape = new Sprite();
         _shape.alpha = 0;
         addChild(_bottom);
         addChild(_shape);
         addChild(_nameTxt);
         setBottomVisible(false);
         this.hitArea = _bottom;
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
         dragView = new ChildCommonFormationItemView();
         dragView.data = _loc2_;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc3_.data = _loc2_;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [ChildCommonFormationItemView,HBox,VBox,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:ChildCommonFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is ChildCommonFormationItemView)
         {
            _loc2_ = param1.dropTarget as ChildCommonFormationItemView;
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         if(_loc2_)
         {
            this.data = _loc2_.data;
            _loc2_.data = param1.data as ChildData;
         }
         else if(param1.dropTarget is VBox)
         {
            if(param1.dropTarget["stylename"] == "ChildPveFrame.vBox")
            {
               if(formationChildList.length > 1)
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
         }
         else if(param1.dropTarget is HBox)
         {
            if(param1.dropTarget["stylename"] == "SpiritExpeditionFormationFrame.headBox")
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
         if(_body && !_isDrak)
         {
            _simpleFilter.setGlowFilter(_body);
         }
         if(_bottom && !_bottom.isPlaying)
         {
            _bottom.play();
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_body)
         {
            _simpleFilter.setNormalFilter(_body);
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
      
      private function createBody() : void
      {
         var _loc1_:MovieClip = null;
         if(!_data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeObject(_body);
         _body = null;
         var _loc2_:Class = control.childDefineDic[_data.childId] as Class;
         if(_loc2_)
         {
            _body = new _loc2_();
            setBodyProperty();
            _body.mouseEnabled = true;
            addChild(_body);
            _nameTxt.text = data.name;
            _nameTxt.x = -_nameTxt.textWidth / 2;
            addChild(_nameTxt);
            setBottomVisible(false);
            this.buttonMode = true;
            _loc1_ = _body["pos_leg"] as MovieClip;
            if(_loc1_)
            {
               _nameTxt.y = _loc1_.y;
            }
         }
      }
      
      private function setBodyProperty() : void
      {
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = 0.75;
      }
      
      public function refresh() : void
      {
         var _loc1_:String = null;
         ObjectUtils.disposeObject(_body);
         _body = null;
         if(control.childDefineDic[_data.templateId])
         {
            createBody();
         }
         else
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyProperty();
            _loc1_ = PathManager.solveChildAvatarPath(data.job,data.growthGrade);
            LoaderManagerII.instance.load(_loc1_,1,8,__loadedCompleteHandler);
         }
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         ObjectUtils.disposeObject(_body);
         _body = null;
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         var _loc5_:Class = control.childDefineDic[_data.childId] as Class;
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
               _loc4_ = new LoaderContext(false,_loc3_);
               disposeLoader();
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("complete",__byteComplete);
               _loader.loadBytes(param2 as ByteArray,_loc4_);
            }
         }
         else
         {
            createBody();
         }
      }
      
      private function __byteComplete(param1:Event) : void
      {
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__byteComplete);
         var _loc3_:Class = control.childDefineDic[_data.childId] as Class;
         if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
         {
            _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
            control.childDefineDic[_data.childId] = _loc3_;
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__byteComplete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      public function clean() : void
      {
         ObjectUtils.disposeObject(_body);
         _body = null;
         _nameTxt.text = "";
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
         if(_body)
         {
            _body.transform.colorTransform = _darkColorTransForm;
         }
         _isDrak = true;
         this.hitArea = _bottom;
         _shape.mouseChildren = _shape.mouseEnabled = false;
      }
      
      public function normal() : void
      {
         if(_body)
         {
            _body.transform.colorTransform = _normalColorTransForm;
            this.hitArea = _shape;
         }
         else
         {
            this.hitArea = _bottom;
         }
         _isDrak = false;
         _shape.mouseChildren = _shape.mouseEnabled = true;
      }
      
      public function get formationType() : int
      {
         return _formationType;
      }
      
      public function set formationType(param1:int) : void
      {
         _formationType = param1;
      }
      
      private function get formationChildList() : Array
      {
         if(formationType == 1)
         {
            return arenaModel.childAreanFromationList;
         }
         return [];
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      private function get control() : PetChallengeController
      {
         return FrameControllerManager.instance.petchallengeController;
      }
      
      override public function dispose() : void
      {
         clearTimeout(BaseManager.delayId);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         disposeLoader();
         _simpleFilter = null;
         _normalColorTransForm = null;
         _darkColorTransForm = null;
         removeEvent();
         ObjectUtils.disposeViolentMc(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         ObjectUtils.disposeObject(dragView);
         dragView = null;
         super.dispose();
      }
   }
}

