package outyard
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mvc.module.outyard.AreaPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardAreaSmallBar extends Component
   {
      
      private var _lineContain:Sprite;
      
      private var _nodeContain:Component;
      
      private var _personContain:Component;
      
      private var _person:MovieClip;
      
      private var _curPos:Point;
      
      private var _prePoint:AreaPoint;
      
      private var _curPoint:AreaPoint;
      
      private var _lineDic:Dictionary;
      
      private var _back1:Bitmap;
      
      private var _back2:Bitmap;
      
      private var _hideBtn1:BaseButton;
      
      private var _hideBtn2:BaseButton;
      
      private var _bg:Bitmap;
      
      private var _dataDic:Dictionary;
      
      private var _rect:Rectangle;
      
      private var _isHide:Boolean = false;
      
      private var _hideHeight:int = 32;
      
      private var _showHeight:int = 171;
      
      public function OutyardAreaSmallBar()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AreaPoint = null;
         var _loc3_:int = 0;
         _dataDic = OutyardManager.instance.areaModel.nodeDic;
         _lineContain = new Sprite();
         _nodeContain = new Component();
         _personContain = new Component();
         _lineDic = new Dictionary();
         _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
         _prePoint = _curPoint;
         _curPos = getPosByPoint(_curPoint);
         _back1 = ComponentFactory.Instance.creatBitmap("asset.outyard.areaSmallBarBg1");
         _back2 = ComponentFactory.Instance.creatBitmap("asset.outyard.areaSmallBarBg2");
         _hideBtn1 = ComponentFactory.Instance.creatComponentByStylename("outyard.areaSmallBarTopBtn");
         _hideBtn2 = ComponentFactory.Instance.creatComponentByStylename("outyard.areaSmallBarBottomBtn");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.areaSmallBg");
         _person = ComponentFactory.Instance.creatCustomObject("asset.outyard.areaTriangleBmp");
         _person.x = _curPos.x;
         _person.y = _curPos.y;
         _personContain.addChild(_person);
         var _loc2_:int = 1;
         var _loc5_:Point = new Point();
         var _loc4_:Point = new Point();
         for each(var _loc6_:AreaPoint in _dataDic)
         {
            _loc5_.x = getPosByPoint(_loc6_).x;
            _loc5_.y = getPosByPoint(_loc6_).y;
            _loc3_ = 0;
            while(_loc3_ < _loc6_.lineArr.length)
            {
               _loc1_ = _dataDic[_loc6_.lineArr[_loc3_]];
               if(!(!_loc1_ || (_lineDic[_loc6_.id + "_" + _loc1_.id] || _lineDic[_loc1_.id + "_" + _loc6_.id])))
               {
                  _loc4_.x = getPosByPoint(_loc1_).x;
                  _loc4_.y = getPosByPoint(_loc1_).y;
                  _lineContain.graphics.lineStyle(_loc2_,26316);
                  _lineContain.graphics.moveTo(_loc5_.x,_loc5_.y);
                  _lineContain.graphics.lineTo(_loc4_.x,_loc4_.y);
                  _lineContain.graphics.endFill();
                  _lineDic[_loc6_.id + "_" + _loc1_.id] = true;
                  _lineDic[_loc1_.id + "_" + _loc6_.id] = true;
               }
               _loc3_++;
            }
            _nodeContain.graphics.beginFill(255);
            _nodeContain.graphics.drawCircle(getPosByPoint(_loc6_).x,getPosByPoint(_loc6_).y,2);
            _nodeContain.graphics.endFill();
         }
         addChild(_back1);
         addChild(_back2);
         addChild(_hideBtn1);
         addChild(_hideBtn2);
         addChild(_bg);
         addChild(_lineContain);
         addChild(_nodeContain);
         addChild(_personContain);
         _rect = new Rectangle(0,0,201,171);
         _hideBtn1.visible = !_isHide;
         _hideBtn2.visible = _isHide;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("TRIANGLE_NEXT_NODE",__nextNodeHandler);
         NotificationManager.instance.addEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
         NotificationManager.instance.addEventListener("UPDATE_AREA_ADJUST",__areaAdjustHandler);
         _hideBtn1.addEventListener("click",__onBtnClickHandler);
         _hideBtn2.addEventListener("click",__onBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("TRIANGLE_NEXT_NODE",__nextNodeHandler);
         NotificationManager.instance.removeEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
         NotificationManager.instance.removeEventListener("UPDATE_AREA_ADJUST",__areaAdjustHandler);
         _hideBtn1.removeEventListener("click",__onBtnClickHandler);
         _hideBtn2.removeEventListener("click",__onBtnClickHandler);
      }
      
      private function __onBtnClickHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         _isHide = !_isHide;
         if(_isHide)
         {
            _loc2_ = 0;
            this.buttonMode = true;
            TweenLite.to(_rect,0.3,{
               "x":_loc2_,
               "height":_hideHeight,
               "onUpdate":updateRec
            });
         }
         else
         {
            _loc2_ = 0;
            this.buttonMode = false;
            TweenLite.to(_rect,0.3,{
               "x":_loc2_,
               "height":_showHeight,
               "onUpdate":updateRec
            });
         }
         _hideBtn1.visible = !_isHide;
         _hideBtn2.visible = _isHide;
      }
      
      private function updateRec() : void
      {
         scrollRect = _rect;
         if(_isHide)
         {
         }
      }
      
      private function __areaAdjustHandler(param1:NotificationEvent) : void
      {
         _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
         _prePoint = _curPoint;
         _curPos = getPosByPoint(_curPoint);
         _person.x = _curPos.x;
         _person.y = _curPos.y;
      }
      
      private function __updateTriggerHandler(param1:NotificationEvent) : void
      {
         var _loc2_:AreaPoint = param1.data as AreaPoint;
         if(_loc2_.eventType == 3)
         {
            _curPoint = OutyardManager.instance.areaModel.myAreaPoint;
            _prePoint = _curPoint;
            _curPos = getPosByPoint(_curPoint);
            TweenMax.killTweensOf(_person);
            _person.x = _curPos.x;
            _person.y = _curPos.y;
         }
      }
      
      private function __nextNodeHandler(param1:NotificationEvent) : void
      {
         _prePoint = _curPoint;
         _curPoint = param1.data as AreaPoint;
         var _loc3_:int = int(_prePoint.row);
         var _loc4_:int = int(_prePoint.col);
         var _loc5_:int = int(_curPoint.row);
         var _loc2_:int = int(_curPoint.col);
         if(_loc5_ == _loc3_ && _loc2_ == _loc4_ - 1)
         {
            _person.rotation = 90;
         }
         else if(_loc5_ == _loc3_ - 1 && _loc2_ == _loc4_)
         {
            _person.rotation = 180;
         }
         else if(_loc5_ == _loc3_ + 1 && _loc2_ == _loc4_)
         {
            _person.rotation = 0;
         }
         else if(_loc5_ == _loc3_ && _loc2_ == _loc4_ + 1)
         {
            _person.rotation = 270;
         }
         _curPos = getPosByPoint(_curPoint);
         TweenMax.to(_person,2,{
            "x":_curPos.x,
            "y":_curPos.y
         });
      }
      
      private function getPosByPoint(param1:AreaPoint) : Point
      {
         var _loc3_:int = 196 / (OutyardManager.instance.areaModel.colNum + 1);
         var _loc2_:int = 138 / (OutyardManager.instance.areaModel.rowNum + 1);
         return new Point((param1.col + 1) * _loc3_ + 8,(param1.row + 1) * _loc2_ + 35);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_person);
         _person = null;
         ObjectUtils.disposeObject(_lineContain);
         _lineContain = null;
         ObjectUtils.disposeObject(_nodeContain);
         _nodeContain = null;
         ObjectUtils.disposeObject(_personContain);
         _personContain = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_hideBtn1);
         _hideBtn1 = null;
         ObjectUtils.disposeObject(_hideBtn2);
         _hideBtn2 = null;
         _lineDic = null;
         _dataDic = null;
         super.dispose();
      }
   }
}

