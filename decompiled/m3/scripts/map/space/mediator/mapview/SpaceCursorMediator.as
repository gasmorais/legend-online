package map.space.mediator.mapview
{
   import bag.helper.BagHelper;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import managers.RingTaskManager;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.view.SpaceSceneMapView;
   import map.space.view.physics.SpaceArmyView;
   import map.space.view.physics.SpaceNpcView;
   import map.space.view.physics.SpacePhysicsView;
   import mvc.module.ringtask.RingTask;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   
   public class SpaceCursorMediator implements IMediator
   {
      
      private var _timeId:int;
      
      private var _mouseDownPoint:Point;
      
      private var _mouseDown:Boolean;
      
      private var _target:SpaceSceneMapView;
      
      public function SpaceCursorMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as SpaceSceneMapView;
         _target.addEventListener("mouseMove",__mouseMoveHandler);
         _target.addEventListener("rollOut",__mouseOutHandler);
         _target.addEventListener("mouseDown",__mouseDownHandler);
         _target.addEventListener("mouseUp",__mouseUpHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         _target.removeEventListener("mouseMove",__mouseMoveHandler);
         _target.removeEventListener("rollOut",__mouseOutHandler);
         _target.removeEventListener("mouseDown",__mouseDownHandler);
         _target.removeEventListener("mouseUp",__mouseUpHandler);
         _target = null;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         _mouseDown = true;
         _mouseDownPoint = new Point(param1.stageX,param1.stageY);
         if(_timeId != 0)
         {
            clearInterval(_timeId);
         }
         _timeId = setTimeout(startDragCall,300);
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         _mouseDown = false;
         _mouseDownPoint = null;
         startDragCall();
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         _mouseDown = false;
         _mouseDownPoint = null;
         if(CursorManagerII.instance.currentState != "SELL_CIRSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
         startDragCall();
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         refreshCursor(param1,_target);
      }
      
      private function startDragCall() : void
      {
         clearInterval(_timeId);
         _timeId = 0;
      }
      
      private function refreshCursor(param1:MouseEvent, param2:SpaceSceneMapView) : void
      {
         var _loc5_:SpaceNpcView = null;
         var _loc4_:SpacePhysicsView = null;
         var _loc13_:RingTask = null;
         var _loc9_:OfferRewardConditionTemplate = null;
         var _loc3_:RingTask = null;
         var _loc8_:OfferRewardConditionTemplate = null;
         var _loc7_:SpaceArmyView = null;
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            return;
         }
         var _loc10_:SpaceModel = SpaceManager.instance.model;
         if(!_loc10_.mapTielsData)
         {
            return;
         }
         var _loc12_:Boolean = Boolean(BagHelper.instance.isSelling);
         if(_loc12_)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         if(!param2.buildingLayer)
         {
            return;
         }
         var _loc6_:Boolean = param2.buildingLayer.mouseMoveHandler(param1);
         var _loc11_:Boolean = param2.npcLayer.mouseMoveHandler(param1);
         if(_loc6_ || _loc11_)
         {
            _loc5_ = param1.target as SpaceNpcView;
            if(_loc5_)
            {
               if(CursorManagerII.instance.currentState != "SPACE_NPC_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
               }
               return;
            }
            for each(_loc5_ in param2.npcLayer.avatarList)
            {
               if(_loc5_.mouseMoveHandler(param1))
               {
                  if(CursorManagerII.instance.currentState != "SPACE_NPC_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
                  }
                  return;
               }
            }
            _loc4_ = param1.target as SpacePhysicsView;
            if(_loc4_)
            {
               if(_loc4_.mouseMoveHandler(param1))
               {
                  if((_loc4_.info as SpaceNode).nodeId == 18)
                  {
                     _loc13_ = RingTaskManager.instance.getRingTask();
                     if(!_loc13_)
                     {
                        return;
                     }
                     _loc9_ = _loc13_.conditionList[0] as OfferRewardConditionTemplate;
                     if(_loc9_.CondictionType != 4)
                     {
                        return;
                     }
                     if(_loc9_.Para1 + "" != (_loc4_.info as SpaceNode).param4)
                     {
                        return;
                     }
                     if(_loc13_.isCompleted)
                     {
                        return;
                     }
                     if(CursorManagerII.instance.currentState != "FARM_PICK_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("FARM_PICK_CURSOR");
                     }
                  }
                  else if(CursorManagerII.instance.currentState != "SPACE_NPC_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
                  }
                  return;
               }
            }
            for each(_loc4_ in param2.buildingLayer.buildList)
            {
               if(_loc4_.mouseMoveHandler(param1))
               {
                  if((_loc4_.info as SpaceNode).nodeId == 18)
                  {
                     _loc3_ = RingTaskManager.instance.getRingTask();
                     if(!_loc3_)
                     {
                        return;
                     }
                     _loc8_ = _loc3_.conditionList[0] as OfferRewardConditionTemplate;
                     if(_loc8_.CondictionType != 4)
                     {
                        return;
                     }
                     if(_loc8_.Para1 + "" != (_loc4_.info as SpaceNode).param4)
                     {
                        return;
                     }
                     if(_loc3_.isCompleted)
                     {
                        return;
                     }
                     if(CursorManagerII.instance.currentState != "FARM_PICK_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("FARM_PICK_CURSOR");
                     }
                  }
                  else if(CursorManagerII.instance.currentState != "SPACE_NPC_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
                  }
                  return;
               }
            }
            _loc7_ = param1.target as SpaceArmyView;
            if(_loc7_)
            {
               if(CursorManagerII.instance.currentState != "SPACE_PLAYER_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("SPACE_PLAYER_CURSOR");
               }
               return;
            }
         }
         CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
      }
   }
}

