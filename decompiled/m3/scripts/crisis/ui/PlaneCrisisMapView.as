package crisis.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.item.PlaneCrisisPointItem;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisNodeInfo;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.TweenDrag;
   
   public class PlaneCrisisMapView extends Sprite
   {
      
      private var _showContainer:Sprite;
      
      private var _showMask:Shape;
      
      private var _backView:PlaneCrisisBackView;
      
      private var _pointItemDic:Dictionary;
      
      private var _pointContainer:Sprite;
      
      private var _warkLayer:PlaneCrisisWarkLayer;
      
      private var _leftView:PlaneCrisisLeftView;
      
      private var _topView:PlaneCrirsTopView;
      
      private var _smallMap:PlaneCrisisSmallMapView;
      
      private var _selfUserId:int;
      
      private var _armyDic:Dictionary;
      
      private var _dragObj:TweenDrag;
      
      private var _isDraging:Boolean;
      
      private var _mapWidth:int = 2659;
      
      private var _mapHeight:int = 2320;
      
      private const MAP_WIDTH:int = 1920;
      
      private const MAP_HEIGHT:int = 1080;
      
      public function PlaneCrisisMapView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:PlaneCrisisPointItem = null;
         var _loc6_:PlaneCrisisNodeInfo = null;
         if(model == null)
         {
            return;
         }
         _selfUserId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _mapWidth = model.width;
         _mapHeight = model.height;
         _showContainer = new Sprite();
         _showMask = new Shape();
         _showMask.graphics.beginFill(16711680,0);
         _showMask.graphics.drawRect(0,0,1920,1080);
         _showMask.graphics.endFill();
         addChild(_showContainer);
         addChild(_showMask);
         _showContainer.mask = _showMask;
         _backView = new PlaneCrisisBackView();
         _showContainer.addChild(_backView);
         _pointContainer = new Sprite();
         _showContainer.addChild(_pointContainer);
         _warkLayer = new PlaneCrisisWarkLayer();
         _showContainer.addChild(_warkLayer);
         _armyDic = new Dictionary();
         _pointItemDic = model.nodeItemDic;
         var _loc5_:int = int(model.currMapId);
         var _loc2_:Array = TempleteManager.instance.planeCrisisTempCate.getOneMapNodes(_loc5_);
         var _loc3_:Dictionary = model.nodeInfoDic;
         for each(var _loc4_:PlaneCrisisTempInfo in _loc2_)
         {
            _loc1_ = new PlaneCrisisPointItem();
            _pointItemDic[_loc4_.NodeId] = _loc1_;
            _pointContainer.addChild(_loc1_);
            _loc1_.tempInfo = _loc4_;
            _loc6_ = _loc3_[_loc4_.NodeId];
            if(_loc6_ != null)
            {
               _loc1_.data = _loc6_;
            }
         }
         updateTeamHandler();
         _topView = new PlaneCrirsTopView();
         _leftView = new PlaneCrisisLeftView();
         _smallMap = new PlaneCrisisSmallMapView();
         _dragObj = new TweenDrag(_showContainer,this as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
         initMoveMap();
      }
      
      private function dragStartCallBack() : void
      {
      }
      
      private function dragingCallBack() : void
      {
         mapMoveCheck(_showContainer.x,_showContainer.y);
      }
      
      private function dropCallBack() : void
      {
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = StageReferance.stage.stageWidth - _mapWidth;
         var _loc4_:int = StageReferance.stage.stageHeight - _mapHeight;
         if(param1 >= 0)
         {
            param1 = 0;
         }
         else if(param1 <= _loc3_)
         {
            param1 = _loc3_;
         }
         if(param2 >= 0)
         {
            param2 = 0;
         }
         else if(param2 <= _loc4_)
         {
            param2 = _loc4_;
         }
         _showContainer.x = param1;
         _showContainer.y = param2;
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         model.addEventListener("PlaneCrisisEventType.updateNodeInfo",updateNodeInfoHandler);
         model.addEventListener("PlaneCrisisEventType.updatePlayerInfo",updateTeamHandler);
         model.addEventListener("PlaneCrisisEventType.TRANS_MAP_EVENT",selfMoveMapHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         model.removeEventListener("PlaneCrisisEventType.updateNodeInfo",updateNodeInfoHandler);
         model.removeEventListener("PlaneCrisisEventType.updatePlayerInfo",updateTeamHandler);
         model.removeEventListener("PlaneCrisisEventType.TRANS_MAP_EVENT",selfMoveMapHandler);
      }
      
      private function selfMoveMapHandler(param1:Event = null) : void
      {
         initMoveMap();
      }
      
      private function updateTeamHandler(param1:Event = null) : void
      {
         var _loc2_:PlaneCrisisPointItem = null;
         var _loc3_:Dictionary = model.planeCrisisInfoDic;
         for each(var _loc4_:PlaneCrisisPlayerInfo in _loc3_)
         {
            _loc2_ = _pointItemDic[_loc4_.armyData.standNodeId];
            if(_loc2_)
            {
               _loc2_.showTeams();
            }
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         initMoveMap();
      }
      
      private function updateNodeInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PlaneCrisisPointItem = null;
         var _loc4_:Array = param1.data as Array;
         for each(var _loc3_:PlaneCrisisNodeInfo in _loc4_)
         {
            _loc2_ = _pointItemDic[_loc3_.nodeId];
            if(_loc2_ != null)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      public function initMoveMap() : void
      {
         var _loc5_:int = StageReferance.stage.stageWidth * 0.5;
         var _loc3_:int = StageReferance.stage.stageHeight * 0.5;
         var _loc8_:int = int(model.selfArmy.standNodeId);
         var _loc1_:PlaneCrisisTempInfo = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,_loc8_);
         var _loc6_:int = _loc5_ - _loc1_.X;
         var _loc4_:int = _loc3_ - _loc1_.Y;
         var _loc2_:int = StageReferance.stage.stageWidth - _mapWidth;
         var _loc7_:int = StageReferance.stage.stageHeight - _mapHeight;
         if(Math.abs(_loc6_) > Math.abs(_loc2_))
         {
            _loc6_ = _loc2_;
         }
         if(Math.abs(_loc4_) > Math.abs(_loc7_))
         {
            _loc4_ = _loc7_;
         }
         mapMoveCheck(_loc6_,_loc4_);
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:PlaneCrisisPointItem in _pointItemDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _pointItemDic = null;
         ObjectUtils.disposeObject(_backView);
         _backView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_smallMap);
         _smallMap = null;
         ObjectUtils.disposeObject(_warkLayer);
         _warkLayer = null;
         ObjectUtils.disposeObject(_dragObj);
         _dragObj = null;
         ObjectUtils.disposeObject(_pointContainer);
         _pointContainer = null;
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _armyDic = null;
      }
   }
}

