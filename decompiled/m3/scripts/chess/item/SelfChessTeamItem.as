package chess.item
{
   import chess.SelfChessRecycleView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
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
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessModel;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfChessTeamItem extends Component
   {
      
      public var site:int;
      
      public var isLock:Boolean;
      
      public var dragEnable:Boolean;
      
      private var _dateTempId:int = -1;
      
      private var _data:SelfChessTempInfo;
      
      private var _isDrag:Boolean;
      
      private var _dropEnable:Boolean = true;
      
      private var _isDrak:Boolean = false;
      
      private var _bottom:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _shape:Sprite;
      
      private var _pos:int;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _darkColorTransForm:ColorTransform = new ColorTransform(0.6,0.6,0.6);
      
      private var _normalColorTransForm:ColorTransform = new ColorTransform();
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var dragView:SelfChessTeamItem;
      
      private var _poolSprite:Shape;
      
      private var _partList:Vector.<String> = new Vector.<String>();
      
      private var starBox:HBox;
      
      private var SCALE:Number = 0.7;
      
      public function SelfChessTeamItem(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         starBox = new HBox();
         _bottom = ComponentFactory.Instance.creat("asset.selfchess.lineUpBottom");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("army.skillFrame.lineUp.nameTxt");
         _shape = new Sprite();
         _shape.alpha = 0;
         addChild(_bottom);
         addChild(_shape);
         addChild(_nameTxt);
         addChild(starBox);
         _nameTxt.y = 0;
         starBox.y = -3;
         setBottomVisible(false);
         this.hitArea = _bottom;
         _bottom.scaleX = _bottom.scaleY = SCALE;
      }
      
      private function uintView() : void
      {
         clean();
         clearBody();
         ObjectUtils.disposeAllChildren(_shape);
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         ObjectUtils.disposeAllChildren(this);
         _loader = null;
         _simpleFilter = null;
         _normalColorTransForm = null;
         _darkColorTransForm = null;
         _partList = null;
      }
      
      private function get model() : SelfChessModel
      {
         return SelfChessManager.Ins.model;
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
         this.removeEventListener("mouseMove",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeObject(_body);
         _body = null;
         drawBackground();
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
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         this.addEventListener("mouseMove",__mouseMoveHandler);
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
      
      private function beginDrag(param1:String) : void
      {
         var _loc2_:SelfChessTempInfo = this.data;
         this.data = null;
         dragView = new SelfChessTeamItem();
         dragView.data = _loc2_;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc3_.data = _loc2_;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [SelfChessTeamItem,SelfChessRecycleView,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",dragView);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc7_:SelfChessTeamItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SelfChessPlayerInfo = null;
         var _loc5_:SelfChessTeamItem = null;
         var _loc6_:int = 0;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is SelfChessTeamItem)
         {
            _loc7_ = param1.dropTarget as SelfChessTeamItem;
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         if(_loc7_ && _loc7_.dropEnable)
         {
            _loc2_ = _loc7_.pos;
            _loc3_ = _pos;
            this.data = _loc7_.data;
            if(_loc2_ != _loc3_)
            {
               _loc4_ = model.selfInfo;
               if(_loc4_ && _loc4_.isBattleFull)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("selfchess.battleFull"));
               }
               SelfChessManager.Ins.sendOp(5,_loc3_,_loc2_);
            }
            else
            {
               _loc7_.data = param1.data;
            }
         }
         else if(param1.dropTarget is SelfChessRecycleView)
         {
            SelfChessManager.Ins.sendOp(4,_pos);
            _loc5_ = param1.dragIcon as SelfChessTeamItem;
            if(_loc5_ && _loc5_.data)
            {
               _loc6_ = _loc5_.data.Grade + (_loc5_.data.Star - 1) * 2;
               NotificationManager.instance.sendNotification("slefChessPlayGold",_loc6_);
            }
         }
         else
         {
            this.data = param1.data;
         }
         NotificationManager.instance.sendNotification("END_DRAG",this);
         if(dragView)
         {
            ObjectUtils.disposeObject(dragView);
         }
         dragView = null;
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
         var _loc5_:Class = model.classDefineDic[_data.TemplateId] as Class;
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
      
      private function drawBackground() : void
      {
         var _loc9_:BitmapData = null;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc8_:Number = NaN;
         if(_shape)
         {
            _shape.x = 0;
            _shape.y = 0;
         }
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
         var _loc1_:Rectangle = _body.getBounds(_body);
         if(_shape)
         {
            _shape.x = _loc1_.x * SCALE;
            _shape.y = _loc1_.y * SCALE;
            this.hitArea = _shape;
         }
         var _loc4_:Shape = model.getShape(_data.TemplateId);
         if(!_loc4_)
         {
            _loc4_ = new Shape();
            _loc9_ = drawDisplayObject(_body);
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
         if(_shape)
         {
            ObjectUtils.disposeAllChildren(_shape);
            _shape.addChild(_loc4_);
         }
         var _loc7_:String = getQualifiedClassName(_body);
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
      
      private function rereshStar() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc3_:int = 0;
         if(_data)
         {
            _loc2_ = int(_data.Star);
            starBox.disposeAllChildren();
            starBox.beginChanges();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.selfchess.star");
               starBox.addChild(_loc1_);
               _loc3_++;
            }
            starBox.commitChanges();
         }
      }
      
      private function refresh() : void
      {
         var _loc4_:String = null;
         var _loc1_:String = null;
         var _loc3_:String = null;
         SCALE = _data.Scale / 100;
         _shape.scaleX = _shape.scaleY = SCALE;
         _nameTxt.text = _data.TemplateName;
         _nameTxt.setFrame(1);
         clearBody();
         rereshStar();
         var _loc2_:int = (_nameTxt.textWidth + starBox.displayWidth) / 2;
         _nameTxt.x = -_loc2_;
         starBox.x = _nameTxt.textWidth - _loc2_ + 2;
         if(_data.ResType == 2)
         {
            if(model.classDefineDic[_data.TemplateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               drawBackground();
               _loc4_ = PathManager.solveHeroAvatarPath(_data.ResPath,2);
               LoaderManagerII.instance.load(_loc4_,1,8,__loadedCompleteHandler);
            }
         }
         else if(_data.ResType == 3)
         {
            if(model.classDefineDic[_data.TemplateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               drawBackground();
               _loc1_ = PathManager.solveCampaignMovieByUrl(_data.ResPath);
               LoaderManagerII.instance.load(_loc1_,1,8,__loadedCompleteHandler);
            }
         }
         else if(_data.ResType == 1)
         {
            if(model.classDefineDic[_data.TemplateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               drawBackground();
               _loc3_ = PathManager.solveRolePath(_data.ResPath);
               LoaderManagerII.instance.load(_loc3_,1,8,__loadedCompleteHandler);
            }
         }
         if(_body)
         {
            addChild(_body);
         }
         addChild(_nameTxt);
         addChild(starBox);
         setBottomVisible(false);
         this.buttonMode = true;
      }
      
      private function __complete(param1:Event) : void
      {
         var _loc3_:Class = null;
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__complete);
         if(_data.ResType == 2)
         {
            _loc3_ = model.classDefineDic[_data.TemplateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
               model.classDefineDic[_data.TemplateId] = _loc3_;
            }
         }
         else if(_data.ResType == 1)
         {
            _loc3_ = model.classDefineDic[_data.TemplateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + _data.ResPath))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + _data.ResPath) as Class;
               model.classDefineDic[_data.TemplateId] = _loc3_;
            }
         }
         else if(_data.ResType == 3)
         {
            _loc3_ = model.classDefineDic[_data.TemplateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
               model.classDefineDic[_data.TemplateId] = _loc3_;
            }
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function createBody() : void
      {
         if(!_data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         var _loc1_:Class = model.classDefineDic[_data.TemplateId] as Class;
         if(_loc1_)
         {
            _body = new _loc1_();
            setBodyProperty();
            addChild(_body);
            addChild(_nameTxt);
            addChild(starBox);
            drawBackground();
         }
      }
      
      private function setBodyProperty() : void
      {
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = SCALE;
      }
      
      private function clean() : void
      {
         if(starBox)
         {
            starBox.disposeAllChildren();
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeObject(_body);
         _body = null;
         if(_nameTxt != null)
         {
            _nameTxt.text = "";
         }
         drawBackground();
         this.hitArea = _bottom;
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = 0;
         this.buttonMode = false;
      }
      
      public function set dateTempId(param1:int) : void
      {
         if(_dateTempId == param1)
         {
            return;
         }
         _dateTempId = param1;
         if(_dateTempId == 0)
         {
            data = null;
         }
         else
         {
            data = TempleteManager.instance.selfChessTempCate.getTempById(_dateTempId);
         }
      }
      
      public function set data(param1:SelfChessTempInfo) : void
      {
         if(param1 == null && _data != null)
         {
            model.saveShape(_data.TemplateId,_poolSprite);
            _poolSprite = null;
            _dateTempId = -1;
         }
         _data = param1;
         if(_data)
         {
            tipData = _data;
            refresh();
            addEvent();
         }
         else
         {
            tipData = null;
            clean();
            removeEvent();
         }
      }
      
      public function get data() : SelfChessTempInfo
      {
         return _data;
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
      
      public function get isDrag() : Boolean
      {
         return _isDrag;
      }
      
      public function set dropEnable(param1:Boolean) : void
      {
         _dropEnable = param1;
      }
      
      public function get dropEnable() : Boolean
      {
         return _dropEnable;
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
         removeEvent();
         if(_data)
         {
            model.saveShape(_data.TemplateId,_poolSprite);
            _poolSprite = null;
         }
         disposeLoader();
         uintView();
         dragView = null;
         super.dispose();
      }
   }
}

