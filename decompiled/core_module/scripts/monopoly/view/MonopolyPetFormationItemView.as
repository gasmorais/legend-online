package monopoly.view
{
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
   import mvc.controler.PetChallengeController;
   import mvc.module.pet.PetData;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.utils.GameDrag;
   import yishi.view.tools.PetFormationMovieClip;
   
   public class MonopolyPetFormationItemView extends Component
   {
      
      private var _bottom:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _controller:PetChallengeController = FrameControllerManager.instance.petchallengeController;
      
      private var _shape:Sprite;
      
      private var _pos:int;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _darkColorTransForm:ColorTransform = new ColorTransform(0.6,0.6,0.6);
      
      private var _normalColorTransForm:ColorTransform = new ColorTransform();
      
      private const SCALE:Number = 0.815;
      
      private var dragView:MonopolyPetFormationItemView;
      
      private var _data:PetData;
      
      private var _body:MovieClip;
      
      private var _heroMovie:PetFormationMovieClip;
      
      private var _loader:Loader;
      
      private var _poolSprite:Shape;
      
      private var _isDrag:Boolean;
      
      public var dropEnable:Boolean = true;
      
      private var _isDrak:Boolean = false;
      
      public function MonopolyPetFormationItemView(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creat("asset.monopoly.Bottom");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationItemView.nameTxt");
         _shape = new Sprite();
         _shape.alpha = 0;
         _bottom.scaleX = _bottom.scaleY = 0.815;
         _shape.scaleX = _shape.scaleY = 0.815;
         addChild(_bottom);
         addChild(_shape);
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
         clearBody();
         _loader = null;
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
         var _loc2_:PetData = this.data;
         this.data = null;
         dragView = new MonopolyPetFormationItemView();
         dragView.data = _loc2_;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc3_.data = _loc2_;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [MonopolyPetFormationItemView,VBox,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",dragView);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:MonopolyPetFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is MonopolyPetFormationItemView)
         {
            _loc2_ = param1.dropTarget as MonopolyPetFormationItemView;
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         if(_loc2_ && _loc2_.dropEnable)
         {
            this.data = _loc2_.data;
            _loc2_.data = param1.data as PetData;
         }
         else if(param1.dropTarget is VBox)
         {
            if(param1.data.petId == 0)
            {
               this.data = param1.data as PetData;
            }
            else
            {
               this.data = null;
            }
         }
         else
         {
            this.data = param1.data as PetData;
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
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(_data == param1)
         {
            return;
         }
         if(param1 == null && _data != null)
         {
            _controller.saveShape(_data.templateId,_poolSprite);
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
      
      private function heroMovieClipLoadComplete() : void
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
         clearBody();
         if(_heroMovie)
         {
            _body = _heroMovie;
            setBodyProperty();
            addChild(_body);
            addChild(_nameTxt);
            _loc1_ = _body["pos_head"] as MovieClip;
            if(_loc1_)
            {
               _nameTxt.y = _loc1_.y - 5 + 20;
            }
            drawBackground();
            _body.gotoAndPlay(1);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function refresh() : void
      {
         var _loc3_:HeroRoleInfo = null;
         var _loc2_:String = null;
         var _loc1_:MovieClip = null;
         _nameTxt.text = data.name;
         _nameTxt.setFrame(data.quality);
         _nameTxt.x = -_nameTxt.textWidth / 2;
         clearBody();
         if(data.petId == 0)
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyProperty();
            drawBackground();
            _loc3_ = new HeroRoleInfo();
            _loc3_.heroInfo = thane;
            _heroMovie = new PetFormationMovieClip(_loc3_);
            _heroMovie.callBackComplete.addSingleListener(heroMovieClipLoadComplete);
            _heroMovie.startLoad();
         }
         else if(_controller.classDefineDic[_data.templateId])
         {
            createBody();
         }
         else
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyProperty();
            drawBackground();
            _loc2_ = PathManager.solveHeroAvatarPath(data.template.PetAvatar,2);
            LoaderManagerII.instance.load(_loc2_,1,8,__loadedCompleteHandler);
         }
         if(_body)
         {
            addChild(_body);
         }
         addChild(_nameTxt);
         setBottomVisible(false);
         if(_body && _body["pos_head"])
         {
            _loc1_ = _body["pos_head"] as MovieClip;
            _nameTxt.y = _loc1_.y - 5 + 20;
         }
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
            createBody();
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
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
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
         clearBody();
         var _loc2_:Class = _controller.classDefineDic[_data.templateId] as Class;
         if(_loc2_)
         {
            _body = new _loc2_();
            setBodyProperty();
            addChild(_body);
            addChild(_nameTxt);
            _loc1_ = _body["pos_head"] as MovieClip;
            if(_loc1_)
            {
               _nameTxt.y = _loc1_.y - 5 + 20;
            }
            drawBackground();
         }
      }
      
      private function setBodyProperty() : void
      {
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = 0.815;
      }
      
      private function drawBackground() : void
      {
         var _loc11_:BitmapData = null;
         var _loc5_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:* = 0;
         var _loc8_:* = 0;
         var _loc10_:Number = NaN;
         if(!_body)
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
         var _loc1_:Rectangle = _body.getBounds(_body);
         var _loc3_:Number = (_loc1_.width - _loc1_.width * 0.815) * 0.5;
         var _loc4_:Number = _loc1_.height - _loc1_.height * 0.815;
         _shape.x = _loc1_.x + _loc3_;
         _shape.y = _loc1_.y + _loc4_;
         this.hitArea = _shape;
         var _loc6_:Shape = _controller.getShape(_data.templateId);
         if(!_loc6_)
         {
            _loc6_ = new Shape();
            _loc11_ = drawDisplayObject(_body);
            if(!_loc11_)
            {
               return;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc11_.width)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc11_.height)
               {
                  _loc2_ = _loc11_.getPixel32(_loc5_,_loc7_);
                  _loc8_ = uint(_loc2_ >> 24 & 0xFF);
                  _loc10_ = _loc8_ / 255;
                  if(_loc2_ > 50)
                  {
                     _loc6_.graphics.beginFill(0,_loc10_);
                     _loc6_.graphics.drawCircle(_loc5_,_loc7_,1);
                     _loc6_.graphics.endFill();
                  }
                  _loc7_++;
               }
               _loc5_++;
            }
            _loc11_.dispose();
            _loc11_ = null;
         }
         _shape.addChild(_loc6_);
         var _loc9_:String = getQualifiedClassName(_body);
         if(_loc9_ != "asset.avatar::DefaultAvatarMovieAsset")
         {
            _poolSprite = _loc6_;
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
         ObjectUtils.disposeObject(_body);
         _body = null;
         drawBackground();
      }
      
      public function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeObject(_body);
         _body = null;
         _nameTxt.text = "";
         drawBackground();
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
         dropEnable = param1;
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
      
      override public function dispose() : void
      {
         if(_heroMovie && _heroMovie.callBackComplete)
         {
            _heroMovie.callBackComplete.removeListener(heroMovieClipLoadComplete);
         }
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

