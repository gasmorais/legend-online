package planeswar.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import planeswar.mediator.PlanesMapViewHelper;
   import planeswar.mediator.PlanesWarCursorMediator;
   import planeswar.mediator.PlanesWarDragMediator;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PlanesWarManager;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesWarMapView extends Component
   {
      
      public static const FLAG_NUM:int = 10000;
      
      public static const NAME:String = "planeswar.view.PlanesWarMapView";
      
      private var _back:Bitmap;
      
      private var _mapLayer:Component;
      
      private var _fogView:PlanesWarFogView;
      
      private var _walkLayer:PlanesWalkLayer;
      
      private var _gridIconObj:Object = {};
      
      private var _sprite1:Component;
      
      private var _fogBoard:Bitmap;
      
      public var isDraging:Boolean = false;
      
      private var _mediatorKey:String;
      
      private var mouseIsMove:Boolean;
      
      private var toX:int;
      
      private var toY:int;
      
      private var lastXY:int = -1;
      
      private var _intervalTime:Number = 0;
      
      public function PlanesWarMapView(param1:Bitmap)
      {
         super();
         _back = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         PlanesWarManager.instance.mapView = this;
         _fogBoard = ComponentFactory.Instance.creatBitmap("asset.planesWar.planesWarFogView.boardFogType" + model.currentSize);
         _walkLayer = new PlanesWalkLayer();
         _fogView = new PlanesWarFogView();
         _sprite1 = new Component();
         _mapLayer = new Component();
         if(_back)
         {
            _mapLayer.addChild(_back);
         }
         addChild(_mapLayer);
         _mapLayer.x = _mapLayer.y = 300;
         addChild(_fogView);
         addChild(_fogBoard);
         addChild(_sprite1);
         _sprite1.x = _sprite1.y = 300;
         addChild(_walkLayer);
         _walkLayer.x = 300;
         _walkLayer.y = 320;
         _fogView.mouseChildren = _fogView.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("addedToStage",__addStageHandler);
         this.addEventListener("mouseDown",__mouseDownHandler);
         PlanesWarManager.instance.addEventListener("PLANES_GRIDINFO_UPDATE",updateView);
         KeyBoardRegister.instance.registerMapKey(__leftMove,__rightMove,__upMove,__downMove);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("addedToStage",__addStageHandler);
         this.removeEventListener("mouseDown",__mouseDownHandler);
         PlanesWarManager.instance.removeEventListener("PLANES_GRIDINFO_UPDATE",updateView);
         KeyBoardRegister.instance.removeMapKey(__leftMove,__rightMove,__upMove,__downMove);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         this.addEventListener("mouseMove",onMouseMove);
         this.addEventListener("mouseUp",onMouseUp);
         mouseIsMove = false;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         mouseIsMove = true;
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.removeEventListener("mouseMove",onMouseMove);
         this.removeEventListener("mouseUp",onMouseUp);
         if(mouseIsMove)
         {
            return;
         }
         __clickMapHandler(param1);
      }
      
      private function __clickMapHandler(param1:MouseEvent) : void
      {
         if(model.selfArmy.isMoving)
         {
            return;
         }
         var _loc2_:int = (param1.stageX - this.x - 300) / 100;
         var _loc3_:int = (param1.stageY - this.y - 300) / 100;
         if(param1.stageX < this.x + 300 || _loc2_ >= model.COLUMN_NUM)
         {
            return;
         }
         if(param1.stageY < this.y + 300 || _loc3_ >= model.ROW_NUM)
         {
            return;
         }
         if(model.getGridByXY(_loc2_,_loc3_))
         {
            if(model.getGridByXY(_loc2_,_loc3_).opened == false)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.PlanesGridIconView.noPathAlert"));
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.PlanesGridIconView.noPathAlert"));
         }
      }
      
      private function updateView(param1:PlanesWarEvent) : void
      {
         initGrid(1);
      }
      
      private function initGrid(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PlanesGridInfo = null;
         var _loc4_:PlanesGridIconView = null;
         removeGrid(param1);
         _loc3_ = 0;
         while(_loc3_ < model.planesWarInfo.gridArr.length)
         {
            _loc2_ = model.planesWarInfo.gridArr[_loc3_];
            _loc4_ = _gridIconObj[_loc2_.index];
            if(_loc2_.opened)
            {
               _fogView.addHole(_loc2_.x,_loc2_.y);
            }
            if(_loc4_ == null)
            {
               _loc4_ = new PlanesGridIconView();
            }
            _loc4_.data = _loc2_;
            _loc4_.addEventIcon(_loc4_.eventIcon);
            _gridIconObj[_loc2_.index] = _loc4_;
            _loc4_.x = _loc2_.x * 100;
            _loc4_.y = _loc2_.y * 100;
            _sprite1.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      private function removeGrid(param1:int) : void
      {
         var _loc2_:PlanesGridIconView = null;
         var _loc3_:BaseIconView = null;
         for(var _loc4_:String in _gridIconObj)
         {
            if(_gridIconObj[_loc4_] != null && Boolean(this.contains(_gridIconObj[_loc4_])))
            {
               _loc2_ = _gridIconObj[_loc4_] as PlanesGridIconView;
               _loc3_ = _loc2_.eventIcon;
               if(_loc3_)
               {
                  _loc2_.removeEventIcon(_loc3_);
               }
               _sprite1.removeChild(_gridIconObj[_loc4_]);
            }
         }
      }
      
      private function __leftMove() : void
      {
         toX = model.planesWarInfo.posX - 1;
         toY = model.planesWarInfo.posY;
         FrameControllerManager.instance.planesWarControler.moveGridByXY(toX,toY);
      }
      
      private function __rightMove() : void
      {
         toX = model.planesWarInfo.posX + 1;
         toY = model.planesWarInfo.posY;
         FrameControllerManager.instance.planesWarControler.moveGridByXY(toX,toY);
      }
      
      private function __upMove() : void
      {
         toX = model.planesWarInfo.posX;
         toY = model.planesWarInfo.posY - 1;
         FrameControllerManager.instance.planesWarControler.moveGridByXY(toX,toY);
      }
      
      private function __downMove() : void
      {
         toX = model.planesWarInfo.posX;
         toY = model.planesWarInfo.posY + 1;
         FrameControllerManager.instance.planesWarControler.moveGridByXY(toX,toY);
      }
      
      public function onDraging() : void
      {
         isDraging = true;
         if(lastXY != this.x * 10000 + this.y)
         {
            if(getTimer() - _intervalTime < 500)
            {
               return;
            }
            _intervalTime = getTimer();
            lastXY = this.x * 10000 + this.y;
         }
      }
      
      public function DragOver() : void
      {
         isDraging = false;
         if(lastXY != this.x * 10000 + this.y)
         {
            lastXY = this.x * 10000 + this.y;
         }
      }
      
      private function __addStageHandler(param1:Event) : void
      {
         var _loc2_:Array = [PlanesWarDragMediator,PlanesWarCursorMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"planeswar.view.PlanesWarMapView");
         var _loc3_:Point = new Point(model.planesWarInfo.posX * 100 - StageReferance.stageWidth / 2,model.planesWarInfo.posY * 100 - StageReferance.stageHeight / 2);
      }
      
      public function motionMap(param1:Point) : void
      {
         param1 = PlanesMapViewHelper.checkTargetPoint(param1);
         var _loc2_:Point = param1;
         if(this.x == _loc2_.x && this.y == _loc2_.y)
         {
            return;
         }
         this.x = _loc2_.x;
         this.y = _loc2_.y;
         lastXY = this.x * 10000 + this.y;
      }
      
      override public function get width() : Number
      {
         return _fogBoard.width;
      }
      
      override public function get height() : Number
      {
         return _fogBoard.height;
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function get walkLayer() : PlanesWalkLayer
      {
         return _walkLayer;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(_fogView)
         {
            _fogView.dispose();
         }
         _fogView = null;
         if(_walkLayer)
         {
            _walkLayer.dispose();
         }
         _walkLayer = null;
         ObjectUtils.disposeObject(_fogBoard);
         _fogBoard = null;
         if(_gridIconObj)
         {
            for(var _loc1_:String in _gridIconObj)
            {
               ObjectUtils.disposeObject(_gridIconObj[_loc1_]);
               _gridIconObj[_loc1_] = null;
            }
            ObjectUtils.disposeObject(_sprite1);
            _sprite1 = null;
            _gridIconObj = null;
         }
         PlanesWarManager.instance.mapView = null;
         super.dispose();
      }
   }
}

