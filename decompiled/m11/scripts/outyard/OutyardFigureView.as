package outyard
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.StackHeadAttackMsg;
   import flash.geom.Point;
   import map.campaign.data.OutyardAttackInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardFigureView extends Component
   {
      
      private var _figure_1_2:OutyardFigureItem;
      
      private var _figure_1_3:OutyardFigureItem;
      
      private var _figure_1_4:OutyardFigureItem;
      
      private var _figure_2_1:OutyardFigureItem;
      
      private var _figure_2_3:OutyardFigureItem;
      
      private var _figure_2_4:OutyardFigureItem;
      
      private var _figure_3_1:OutyardFigureItem;
      
      private var _figure_3_2:OutyardFigureItem;
      
      private var _figure_3_4:OutyardFigureItem;
      
      private var _figure_4_1:OutyardFigureItem;
      
      private var _figure_4_2:OutyardFigureItem;
      
      private var _figure_4_3:OutyardFigureItem;
      
      public function OutyardFigureView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("OUTYARD_UPDATE_INFO",__updateInfoHandler);
         NotificationManager.instance.addEventListener("OUTYARD_OPEN_FRAME",__openFrameHandler);
         __openFrameHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("OUTYARD_UPDATE_INFO",__updateInfoHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_OPEN_FRAME",__openFrameHandler);
      }
      
      private function __openFrameHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = OutyardManager.instance.crystalModel.attackArr;
         if(_loc2_.length == 0)
         {
            return;
         }
         _figure_1_2 = new OutyardFigureItem(new Point(68,178),new Point(170,112),_loc2_[0],this);
         _figure_1_3 = new OutyardFigureItem(new Point(91,220),new Point(301,224),_loc2_[1],this);
         _figure_1_4 = new OutyardFigureItem(new Point(56,240),new Point(133,304),_loc2_[2],this);
         _figure_2_1 = new OutyardFigureItem(new Point(170,112),new Point(68,178),_loc2_[3],this);
         _figure_2_3 = new OutyardFigureItem(new Point(246,116),new Point(329,189),_loc2_[4],this);
         _figure_2_4 = new OutyardFigureItem(new Point(207,128),new Point(188,292),_loc2_[5],this);
         _figure_3_1 = new OutyardFigureItem(new Point(301,224),new Point(91,220),_loc2_[6],this);
         _figure_3_2 = new OutyardFigureItem(new Point(329,189),new Point(246,116),_loc2_[7],this);
         _figure_3_4 = new OutyardFigureItem(new Point(336,252),new Point(230,317),_loc2_[8],this);
         _figure_4_1 = new OutyardFigureItem(new Point(133,304),new Point(56,240),_loc2_[9],this);
         _figure_4_2 = new OutyardFigureItem(new Point(188,292),new Point(207,128),_loc2_[10],this);
         _figure_4_3 = new OutyardFigureItem(new Point(230,317),new Point(336,252),_loc2_[11],this);
         addChild(_figure_1_2);
         addChild(_figure_1_3);
         addChild(_figure_1_4);
         addChild(_figure_2_1);
         addChild(_figure_2_3);
         addChild(_figure_2_4);
         addChild(_figure_3_1);
         addChild(_figure_3_2);
         addChild(_figure_3_4);
         addChild(_figure_4_1);
         addChild(_figure_4_2);
         addChild(_figure_4_3);
      }
      
      private function __updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:StackHeadAttackMsg = null;
         var _loc3_:OutyardAttackInfo = null;
         var _loc2_:Array = param1.data as Array;
         var _loc7_:Array = OutyardManager.instance.crystalModel.attackArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_] as StackHeadAttackMsg;
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc3_ = _loc7_[_loc5_] as OutyardAttackInfo;
               if(_loc3_.key == _loc6_.fromPos + "_" + _loc6_.toPos)
               {
                  this["_figure_" + _loc6_.fromPos + "_" + _loc6_.toPos].changeCount(_loc6_.changeCount,_loc6_.totalCount);
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_figure_1_2);
         _figure_1_2 = null;
         ObjectUtils.disposeObject(_figure_1_3);
         _figure_1_3 = null;
         ObjectUtils.disposeObject(_figure_1_4);
         _figure_1_4 = null;
         ObjectUtils.disposeObject(_figure_2_1);
         _figure_2_1 = null;
         ObjectUtils.disposeObject(_figure_2_3);
         _figure_2_3 = null;
         ObjectUtils.disposeObject(_figure_2_4);
         _figure_2_4 = null;
         ObjectUtils.disposeObject(_figure_3_1);
         _figure_3_1 = null;
         ObjectUtils.disposeObject(_figure_3_2);
         _figure_3_2 = null;
         ObjectUtils.disposeObject(_figure_3_4);
         _figure_3_4 = null;
         ObjectUtils.disposeObject(_figure_4_1);
         _figure_4_1 = null;
         ObjectUtils.disposeObject(_figure_4_2);
         _figure_4_2 = null;
         ObjectUtils.disposeObject(_figure_4_3);
         _figure_4_3 = null;
         super.dispose();
      }
   }
}

