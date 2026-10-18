package mvc.module.crisis
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class PlaneCrisisModel extends EventDispatcher
   {
      
      public var currMapId:int = 1;
      
      public var width:int = 2659;
      
      public var height:int = 2320;
      
      public var mapOffsetX:int = 305;
      
      public var mapOffsetY:int = 90;
      
      public var oneStepMoveNum:int;
      
      public var pointBuyPrice:int;
      
      public var buyActionNum:int;
      
      public var buffPrice:int;
      
      public var limitBuy:int;
      
      public var attackEndBossNeedNum:int;
      
      public var difficulty:int;
      
      private var _selfArmy:PlaneCrisisArmy;
      
      private var _selfInfo:PlaneCrisisPlayerInfo;
      
      private var _nodeItemDic:Dictionary;
      
      private var _nodeInfoDic:Dictionary;
      
      private var _planeCrisisInfoDic:Dictionary;
      
      private var _armyViewDic:Dictionary;
      
      private var _eventProgessDic:Dictionary;
      
      private var _rewardDic:Dictionary;
      
      private var _changeObj:SimpleDictionary;
      
      public function PlaneCrisisModel()
      {
         super();
         _changeObj = new SimpleDictionary();
         _nodeInfoDic = new Dictionary();
         _planeCrisisInfoDic = new Dictionary();
         _eventProgessDic = new Dictionary();
         _nodeItemDic = new Dictionary();
         _armyViewDic = new Dictionary();
         _rewardDic = new Dictionary();
         initGameInfos();
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function flag(param1:String, param2:Object) : void
      {
         _changeObj[param1] = param2;
      }
      
      public function commit() : void
      {
         var _loc1_:Object = null;
         _loc1_ = _changeObj["PlaneCrisisEventType.updateNodeInfo"];
         if(_loc1_ != null)
         {
            dispatchEvent(new NotificationEvent("PlaneCrisisEventType.updateNodeInfo",_loc1_));
         }
         _loc1_ = _changeObj["PlaneCrisisEventType.updatePlayerInfo"];
         if(_loc1_ != null)
         {
            dispatchEvent(new Event("PlaneCrisisEventType.updatePlayerInfo"));
         }
         _loc1_ = _changeObj["PlaneCrisisEventType.updateEventCount"];
         if(_loc1_ != null)
         {
            dispatchEvent(new Event("PlaneCrisisEventType.updateEventCount"));
         }
      }
      
      public function selfWarkOver() : void
      {
         dispatchEvent(new Event("PlaneCrisisEventType.selfmoveOver"));
      }
      
      public function transMoveMap() : void
      {
         dispatchEvent(new Event("PlaneCrisisEventType.TRANS_MAP_EVENT"));
      }
      
      private function initGameInfos() : void
      {
         var _loc1_:String = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc7_:String = null;
         var _loc3_:Array = null;
         var _loc6_:String = null;
         var _loc12_:Array = null;
         var _loc9_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("crisis_map_coordinate");
         if(_loc9_ != null)
         {
            _loc1_ = _loc9_.ConfigValue;
            _loc10_ = _loc1_.split("|");
            for each(var _loc2_:String in _loc10_)
            {
               _loc11_ = _loc2_.split(",");
               if(_loc11_[0] == currMapId)
               {
                  width = int(_loc11_[1]);
                  height = int(_loc11_[2]);
                  mapOffsetX = int(_loc11_[3]);
                  mapOffsetY = int(_loc11_[4]);
               }
            }
         }
         oneStepMoveNum = TempleteManager.instance.getConfigValue("crisis_activity_consume");
         var _loc8_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("crisis_activity_additional");
         if(_loc8_)
         {
            _loc4_ = _loc8_.ConfigValue;
            _loc5_ = _loc4_.split("|");
            _loc7_ = _loc5_[0];
            _loc3_ = _loc7_.split(",");
            pointBuyPrice = int(_loc3_[0]);
            buyActionNum = int(_loc3_[1]);
            _loc6_ = _loc5_[1];
            _loc12_ = _loc6_.split(",");
            buffPrice = int(_loc12_[0]);
            limitBuy = int(_loc5_[2]);
         }
      }
      
      public function get rewardDic() : Dictionary
      {
         return _rewardDic;
      }
      
      public function get nodeItemDic() : Dictionary
      {
         return _nodeItemDic;
      }
      
      public function get armyViewDic() : Dictionary
      {
         return _armyViewDic;
      }
      
      public function addPlayCrisisInfo(param1:PlaneCrisisPlayerInfo) : void
      {
         if(param1.armyData == null)
         {
            return;
         }
         var _loc2_:int = param1.armyData.userId;
         if(!_planeCrisisInfoDic[_loc2_])
         {
            _planeCrisisInfoDic[_loc2_] = param1;
            dispatchEvent(new NotificationEvent("PlaneCrisisEventType.addArmy",param1));
         }
      }
      
      public function deletePlayCrisisInfo(param1:int) : void
      {
         var _loc2_:PlaneCrisisPlayerInfo = _planeCrisisInfoDic[param1];
         if(_loc2_)
         {
            delete _planeCrisisInfoDic[param1];
            dispatchEvent(new NotificationEvent("PlaneCrisisEventType.removeArmy",_loc2_));
         }
      }
      
      public function get hasOnffLineTeamer() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_:PlaneCrisisPlayerInfo in _planeCrisisInfoDic)
         {
            if(_loc2_.isOffline)
            {
               _loc1_ = true;
               break;
            }
         }
         return _loc1_;
      }
      
      public function commitPersonPostion(param1:int) : void
      {
         var _loc2_:PlaneCrisisPlayerInfo = _planeCrisisInfoDic[param1];
         if(_loc2_ != null)
         {
            _loc2_.commitPostion();
         }
      }
      
      public function get selfArmy() : PlaneCrisisArmy
      {
         var _loc1_:int = 0;
         if(_selfArmy == null)
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
            for each(var _loc2_:PlaneCrisisPlayerInfo in _planeCrisisInfoDic)
            {
               if(_loc2_.armyData.userId == _loc1_)
               {
                  _selfArmy = _loc2_.armyData;
                  _selfInfo = _loc2_;
                  break;
               }
            }
         }
         return _selfArmy;
      }
      
      public function get selfInfo() : PlaneCrisisPlayerInfo
      {
         var _loc1_:int = 0;
         if(_selfInfo == null)
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
            for each(var _loc2_:PlaneCrisisPlayerInfo in _planeCrisisInfoDic)
            {
               if(_loc2_.armyData.userId == _loc1_)
               {
                  _selfArmy = _loc2_.armyData;
                  _selfInfo = _loc2_;
                  break;
               }
            }
         }
         return _selfInfo;
      }
      
      public function get nodeInfoDic() : Dictionary
      {
         return _nodeInfoDic;
      }
      
      public function get planeCrisisInfoDic() : Dictionary
      {
         return _planeCrisisInfoDic;
      }
      
      public function get eventProgessDic() : Dictionary
      {
         return _eventProgessDic;
      }
      
      public function reset() : void
      {
         _nodeItemDic = null;
         _armyViewDic = null;
         _changeObj.clear();
         _nodeItemDic = new Dictionary();
         _armyViewDic = new Dictionary();
      }
      
      public function dispose() : void
      {
         trace("释放planeCrisisModel资源");
         _nodeItemDic = null;
         _nodeInfoDic = null;
         _planeCrisisInfoDic = null;
         _eventProgessDic = null;
         _armyViewDic = null;
         _changeObj = null;
      }
   }
}

