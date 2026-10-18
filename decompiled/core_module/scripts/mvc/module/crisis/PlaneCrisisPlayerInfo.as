package mvc.module.crisis
{
   import flash.display.DisplayObject;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisPlayerInfo
   {
      
      public var buyTime:int;
      
      public var userId:int;
      
      public var color:int;
      
      public var actionNum:int;
      
      public var fragment:int;
      
      public var armyData:PlaneCrisisArmy;
      
      public var isOffline:Boolean;
      
      private var _lastStandNodeId:int;
      
      private var _standNodeId:int;
      
      public function PlaneCrisisPlayerInfo()
      {
         super();
      }
      
      public function get standNodeId() : int
      {
         return _standNodeId;
      }
      
      public function set standNodeId(param1:int) : void
      {
         _standNodeId = param1;
         if(armyData != null)
         {
            armyData.standNodeId = _standNodeId;
         }
      }
      
      public function commitPostion() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:PlaneCrisisTempInfo = null;
         if(model != null && model.armyViewDic != null && armyData != null)
         {
            _loc2_ = model.armyViewDic[armyData.userId];
            if(_loc2_ != null)
            {
               _loc1_ = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,_standNodeId);
               if(_loc1_)
               {
                  _loc2_.x = _loc1_.X;
                  _loc2_.y = _loc1_.Y;
               }
            }
         }
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      public function get lastStandNodeId() : int
      {
         return _lastStandNodeId;
      }
      
      public function set lastStandNodeId(param1:int) : void
      {
         _lastStandNodeId = param1;
         if(armyData != null)
         {
            armyData.lastStandNodeId = _lastStandNodeId;
         }
      }
   }
}

