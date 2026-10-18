package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.outyard.AreaPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardAreaArrowView extends Component
   {
      
      private var _arrowSprite:Component;
      
      private var _arrowImage1:ScaleFrameImage;
      
      private var _arrowImage2:ScaleFrameImage;
      
      private var _arrowImage3:ScaleFrameImage;
      
      private var _arrowImage4:ScaleFrameImage;
      
      private var _rolePoint:AreaPoint;
      
      public function OutyardAreaArrowView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _arrowSprite = new Component();
         _arrowImage1 = ComponentFactory.Instance.creatComponentByStylename("outyard.outyard.arrowFrameImage");
         _arrowImage2 = ComponentFactory.Instance.creatComponentByStylename("outyard.outyard.arrowFrameImage");
         _arrowImage3 = ComponentFactory.Instance.creatComponentByStylename("outyard.outyard.arrowFrameImage");
         _arrowImage4 = ComponentFactory.Instance.creatComponentByStylename("outyard.outyard.arrowFrameImage");
         addChild(_arrowSprite);
         _arrowSprite.addChild(_arrowImage1);
         _arrowImage1.x = -165;
         _arrowImage1.y = -24;
         _arrowSprite.addChild(_arrowImage2);
         _arrowImage2.x = -8;
         _arrowImage2.y = -158;
         _arrowSprite.addChild(_arrowImage3);
         _arrowImage3.x = 142;
         _arrowImage3.y = -22;
         _arrowSprite.addChild(_arrowImage4);
         _arrowImage4.x = -8;
         _arrowImage4.y = 117;
         _arrowImage1.visible = false;
         _arrowImage2.visible = false;
         _arrowImage3.visible = false;
         _arrowImage4.visible = false;
      }
      
      private function addEvent() : void
      {
         _arrowSprite.addEventListener("click",onArrow);
         NotificationManager.instance.addEventListener("CLICK_ARROW",__clickArrowHandler);
         NotificationManager.instance.addEventListener("BRANCH_ARROW",__branchHandler);
      }
      
      private function removeEvent() : void
      {
         _arrowSprite.removeEventListener("click",onArrow);
         NotificationManager.instance.removeEventListener("CLICK_ARROW",__clickArrowHandler);
         NotificationManager.instance.removeEventListener("BRANCH_ARROW",__branchHandler);
      }
      
      private function onArrow(param1:MouseEvent) : void
      {
         var _loc2_:AreaPoint = null;
         SoundManager.instance.play("022");
         var _loc3_:int = int(_rolePoint.row);
         var _loc4_:int = int(_rolePoint.col);
         var _loc5_:ScaleFrameImage;
         switch(_loc5_ = param1.target as ScaleFrameImage)
         {
            case _arrowImage1:
               _loc2_ = getInfo(_loc3_,_loc4_ - 1);
               break;
            case _arrowImage2:
               _loc2_ = getInfo(_loc3_ - 1,_loc4_);
               break;
            case _arrowImage3:
               _loc2_ = getInfo(_loc3_,_loc4_ + 1);
               break;
            case _arrowImage4:
               _loc2_ = getInfo(_loc3_ + 1,_loc4_);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_ARROW",_loc2_));
      }
      
      private function __branchHandler(param1:NotificationEvent) : void
      {
         var _loc2_:AreaPoint = null;
         _rolePoint = param1.data as AreaPoint;
         this.x = getPosByPoint(_rolePoint).x;
         this.y = getPosByPoint(_rolePoint).y;
         var _loc3_:int = int(_rolePoint.row);
         var _loc4_:int = int(_rolePoint.col);
         _loc2_ = getInfo(_loc3_,_loc4_ - 1);
         if(_loc2_ && _rolePoint.lineArr.indexOf(_loc2_.id) != -1)
         {
            _arrowImage1.visible = true;
            _arrowImage1.setFrame(3);
         }
         _loc2_ = getInfo(_loc3_ - 1,_loc4_);
         if(_loc2_ && _rolePoint.lineArr.indexOf(_loc2_.id) != -1)
         {
            _arrowImage2.visible = true;
            _arrowImage2.setFrame(4);
         }
         _loc2_ = getInfo(_loc3_,_loc4_ + 1);
         if(_loc2_ && _rolePoint.lineArr.indexOf(_loc2_.id) != -1)
         {
            _arrowImage3.visible = true;
            _arrowImage3.setFrame(1);
         }
         _loc2_ = getInfo(_loc3_ + 1,_loc4_);
         if(_loc2_ && _rolePoint.lineArr.indexOf(_loc2_.id) != -1)
         {
            _arrowImage4.visible = true;
            _arrowImage4.setFrame(2);
         }
      }
      
      private function getInfo(param1:int, param2:int) : AreaPoint
      {
         return OutyardManager.instance.areaModel.nodeDic[param1 + "#" + param2];
      }
      
      private function getPosByPoint(param1:AreaPoint) : Point
      {
         var _loc3_:int = 2600 / (OutyardManager.instance.areaModel.colNum + 1);
         var _loc2_:int = 1500 / (OutyardManager.instance.areaModel.rowNum + 1);
         return new Point((param1.col + 1) * _loc3_ + 100,(param1.row + 1) * _loc2_ + 50);
      }
      
      private function __clickArrowHandler(param1:NotificationEvent) : void
      {
         _arrowImage1.visible = false;
         _arrowImage2.visible = false;
         _arrowImage3.visible = false;
         _arrowImage4.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_arrowImage1);
         _arrowImage1 = null;
         ObjectUtils.disposeObject(_arrowImage2);
         _arrowImage2 = null;
         ObjectUtils.disposeObject(_arrowImage3);
         _arrowImage3 = null;
         ObjectUtils.disposeObject(_arrowImage4);
         _arrowImage4 = null;
         ObjectUtils.disposeObject(_arrowSprite);
         _arrowSprite = null;
         _rolePoint = null;
         super.dispose();
      }
   }
}

