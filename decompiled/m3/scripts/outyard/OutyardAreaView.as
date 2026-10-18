package outyard
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.stackhead.StackHeadExploreResMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.outercity.helper.mapview.MapViewHelper;
   import mvc.module.outyard.AreaPoint;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.view.base.DashedLine;
   
   public class OutyardAreaView extends Component implements IEnterFrame
   {
      
      public static const NAME:String = "outyard.OutyardAreaView";
      
      private var _lineContain:DashedLine;
      
      private var _nodeContain:Component;
      
      private var _personContain:Component;
      
      private var _person:OutyardHunterView;
      
      private var _curPos:Point;
      
      private var _pos:Point;
      
      private var _step:int = 0;
      
      private var _curPoint:AreaPoint;
      
      private var _nextPoint:AreaPoint;
      
      private var _lineDic:Dictionary;
      
      private var _bg:Bitmap;
      
      private var _diceBtn1:ScaleFrameImage;
      
      private var _diceBtn2:ScaleFrameImage;
      
      private var _diceBtn3:ScaleFrameImage;
      
      private var _dataDic:Dictionary;
      
      private var _linePath:Array = [];
      
      private var _diceId:int;
      
      private var _triggerMove:Boolean;
      
      private var _arrowView:OutyardAreaArrowView;
      
      private var _stepSprite:MovieClip;
      
      public var isMove:Boolean;
      
      private var _mediatorKey:String;
      
      private var _moveTimeId:int;
      
      private var startY:int = 0;
      
      private var startX:int = 0;
      
      private var mapWidth:int = 2800;
      
      private var mapHeight:int = 1600;
      
      public function OutyardAreaView()
      {
         super();
         initView();
         addEvent();
         initRegisterList();
      }
      
      private function initView() : void
      {
         var _loc1_:AreaPoint = null;
         var _loc4_:int = 0;
         var _loc2_:AreaNodeView = null;
         _dataDic = OutyardManager.instance.areaModel.nodeDic;
         _lineContain = new DashedLine(5,792836,0.6,new Array(4,4,4,4));
         _nodeContain = new Component();
         _personContain = new Component();
         _arrowView = new OutyardAreaArrowView();
         _lineDic = new Dictionary();
         _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
         if(!prePoint)
         {
            prePoint = _curPoint;
         }
         _curPos = getPosByPoint(_curPoint);
         _stepSprite = ComponentFactory.Instance.creatCustomObject("asset.outyard.numberGreen");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.areaBg");
         _person = ComponentFactory.Instance.creatCustomObject("outyard.OutyardHunterView");
         _person.x = _curPos.x;
         _person.y = _curPos.y;
         _person.standImp();
         _person.scaleX = _person.scaleY = 0.8;
         _person.updateAngle(OutyardManager.instance.areaModel.personAngle);
         _personContain.addChild(_person);
         _personContain.mouseChildren = _personContain.mouseEnabled = false;
         var _loc8_:AIBaseInfo = new AIBaseInfo();
         _loc8_.isLiving = true;
         _loc8_.speed = 8;
         _person.info = _loc8_;
         var _loc3_:int = 6;
         var _loc6_:Point = new Point();
         var _loc5_:Point = new Point();
         for each(var _loc7_:AreaPoint in _dataDic)
         {
            _loc6_.x = getPosByPoint(_loc7_).x;
            _loc6_.y = getPosByPoint(_loc7_).y;
            _loc4_ = 0;
            while(_loc4_ < _loc7_.lineArr.length)
            {
               _loc1_ = _dataDic[_loc7_.lineArr[_loc4_]];
               if(!(!_loc1_ || (_lineDic[_loc7_.id + "_" + _loc1_.id] || _lineDic[_loc1_.id + "_" + _loc7_.id])))
               {
                  _loc5_.x = getPosByPoint(_loc1_).x;
                  _loc5_.y = getPosByPoint(_loc1_).y;
                  _lineContain.moveTo(_loc6_.x,_loc6_.y);
                  _lineContain.lineTo(_loc5_.x,_loc5_.y);
                  _lineContain.endFill();
                  _lineDic[_loc7_.id + "_" + _loc1_.id] = true;
                  _lineDic[_loc1_.id + "_" + _loc7_.id] = true;
               }
               _loc4_++;
            }
            _loc2_ = new AreaNodeView();
            _loc2_.x = getPosByPoint(_loc7_).x;
            _loc2_.y = getPosByPoint(_loc7_).y;
            _loc2_.info = _loc7_;
            _nodeContain.addChild(_loc2_);
         }
         addChild(_bg);
         addChild(_lineContain);
         addChild(_nodeContain);
         addChild(_personContain);
         addChild(_arrowView);
         _person.addChild(_stepSprite);
         _stepSprite.gotoAndStop(1);
         motionTo();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("CLICK_ARROW",__clickArrowHandler);
         NotificationManager.instance.addEventListener("AREA_WALK_OVER",__walkOverHandler);
         NotificationManager.instance.addEventListener("DICE_STEP_CLICK",__diceStepHandler);
         NotificationManager.instance.addEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
         NotificationManager.instance.addEventListener("UPDATE_AREA_ADJUST",__areaAdjustHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("CLICK_ARROW",__clickArrowHandler);
         NotificationManager.instance.removeEventListener("AREA_WALK_OVER",__walkOverHandler);
         NotificationManager.instance.removeEventListener("DICE_STEP_CLICK",__diceStepHandler);
         NotificationManager.instance.removeEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
         NotificationManager.instance.removeEventListener("UPDATE_AREA_ADJUST",__areaAdjustHandler);
      }
      
      private function initRegisterList() : void
      {
         var _loc1_:Array = [OutyardDragMediator,OutyardMapCursorMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"outyard.OutyardAreaView");
      }
      
      private function __clickArrowHandler(param1:NotificationEvent) : void
      {
         _nextPoint = param1.data as AreaPoint;
         setPos(_nextPoint);
      }
      
      private function __walkOverHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         refreshStepNum();
         _linePath.push(_curPoint.id);
         if(_step <= 0)
         {
            _person.standImp();
            OutyardManager.instance.OperateArea(1,_diceId,_linePath);
            return;
         }
         if(_curPoint.lineArr.length > 2)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BRANCH_ARROW",_curPoint));
            _person.standImp();
            return;
         }
         if(_curPoint.lineArr.length == 1)
         {
            _nextPoint = _dataDic[_curPoint.lineArr[0]];
         }
         else if(_curPoint.lineArr.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < _curPoint.lineArr.length)
            {
               if(_curPoint.lineArr[_loc3_] != prePoint.id)
               {
                  _loc2_ = _curPoint.lineArr[_loc3_];
               }
               _loc3_++;
            }
            _nextPoint = _dataDic[_loc2_];
         }
         setPos(_nextPoint);
      }
      
      private function __areaAdjustHandler(param1:NotificationEvent) : void
      {
         var _loc2_:StackHeadExploreResMsg = param1.data as StackHeadExploreResMsg;
         if(_loc2_.errorCode != 12 && _loc2_.errorCode != 13 && _loc2_.errorCode != 3)
         {
            _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
            prePoint = _curPoint;
            _curPos = getPosByPoint(_curPoint);
            _person.x = _curPos.x;
            _person.y = _curPos.y;
         }
      }
      
      private function __updateTriggerHandler(param1:NotificationEvent) : void
      {
         var _loc2_:AreaPoint = param1.data as AreaPoint;
         if(_loc2_.eventType == 3)
         {
            _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
            prePoint = _curPoint;
            _curPos = getPosByPoint(_curPoint);
            _person.x = _curPos.x;
            _person.y = _curPos.y;
            motionTo();
            _triggerMove = true;
         }
      }
      
      private function __diceStepHandler(param1:NotificationEvent = null) : void
      {
         _diceId = int(param1.data);
         _step = OutyardManager.instance.areaModel.diceDic[_diceId].point;
         refreshStepNum();
         _linePath = [];
         if(_triggerMove)
         {
            _triggerMove = false;
            _linePath.push(_curPoint.id);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BRANCH_ARROW",_curPoint));
            return;
         }
         __walkOverHandler();
      }
      
      private function refreshStepNum() : void
      {
         if(_step > 0)
         {
            _stepSprite.visible = true;
            _stepSprite.gotoAndStop(_step);
         }
         else
         {
            _stepSprite.visible = false;
         }
      }
      
      public function setPos(param1:AreaPoint) : void
      {
         if(!param1)
         {
            return;
         }
         prePoint = _curPoint;
         _pos = getPosByPoint(param1);
         _person.info.pathInfo = [_curPos,_pos];
         _curPoint = param1;
         _curPos = _pos;
         _step = _step - 1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("TRIANGLE_NEXT_NODE",_curPoint));
      }
      
      public function motionTo() : void
      {
         var _loc1_:Point = new Point(_person.x - StageReferance.stageWidth / 2,_person.y - StageReferance.stageHeight / 2);
         _loc1_ = checkTargetPoint(_loc1_);
         var _loc2_:Point = _loc1_;
         if(this.x == _loc2_.x && this.y == _loc2_.y)
         {
            return;
         }
         if(isMove)
         {
            return;
         }
         isMove = true;
         var _loc3_:int = MapViewHelper.checkDistance(this.x,this.y,_loc2_.x,_loc2_.y);
         if(_moveTimeId > 0)
         {
            clearInterval(_moveTimeId);
         }
         _moveTimeId = 0;
         if(_loc3_ > 1000)
         {
            this.x = _loc2_.x;
            this.y = _loc2_.y;
            moveTweencompleted();
            this.alpha = 0.95;
            _moveTimeId = setInterval(unLockScene,1300);
         }
         else
         {
            TweenLite.to(this,0.3,{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "onComplete":moveTweencompleted
            });
         }
      }
      
      private function unLockScene() : void
      {
         if(_moveTimeId > 0)
         {
            clearInterval(_moveTimeId);
         }
         _moveTimeId = 0;
         this.alpha = 1;
      }
      
      private function moveTweencompleted() : void
      {
         isMove = false;
      }
      
      public function checkTargetPoint(param1:Point) : Point
      {
         if(param1.x + StageReferance.stageWidth > mapWidth)
         {
            param1.x = mapWidth - StageReferance.stageWidth;
         }
         if(param1.y + StageReferance.stageHeight > mapHeight)
         {
            param1.y = mapHeight - StageReferance.stageHeight;
         }
         if(-param1.x > startX)
         {
            param1.x = startX;
         }
         else
         {
            param1.x = -param1.x;
         }
         if(-param1.y > startY)
         {
            param1.y = startY;
         }
         else
         {
            param1.y = -param1.y;
         }
         return param1;
      }
      
      private function set prePoint(param1:AreaPoint) : void
      {
         OutyardManager.instance.areaModel.prePoint = param1;
      }
      
      private function get prePoint() : AreaPoint
      {
         return OutyardManager.instance.areaModel.prePoint;
      }
      
      private function getPosByPoint(param1:AreaPoint) : Point
      {
         var _loc3_:int = 2600 / (OutyardManager.instance.areaModel.colNum + 1);
         var _loc2_:int = 1500 / (OutyardManager.instance.areaModel.rowNum + 1);
         return new Point((param1.col + 1) * _loc3_ + 100,(param1.row + 1) * _loc2_ + 50);
      }
      
      public function enterFrame() : void
      {
         if(_person && _person.info)
         {
            _person.execute();
            OutyardManager.instance.areaModel.personAngle = _person.personAngle;
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         ObjectUtils.disposeObject(_person);
         _person = null;
         ObjectUtils.disposeObject(_lineContain);
         _lineContain = null;
         ObjectUtils.disposeObject(_nodeContain);
         _nodeContain = null;
         ObjectUtils.disposeObject(_personContain);
         _personContain = null;
         ObjectUtils.disposeObject(_arrowView);
         _arrowView = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_diceBtn1);
         _diceBtn1 = null;
         ObjectUtils.disposeObject(_diceBtn2);
         _diceBtn2 = null;
         ObjectUtils.disposeObject(_diceBtn3);
         _diceBtn3 = null;
         ObjectUtils.disposeObject(_stepSprite);
         _stepSprite = null;
         _lineDic = null;
         _dataDic = null;
         _linePath = null;
         super.dispose();
      }
   }
}

