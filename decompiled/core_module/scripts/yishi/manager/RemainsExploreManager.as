package yishi.manager
{
   import com.road.yishi.proto.module.DoExploreResponseMsg;
   import com.road.yishi.proto.module.RemainsExploreMsg;
   import com.road.yishi.proto.module.RemainsExploreNodeMsg;
   import com.road.yishi.proto.module.RemainsLeedDataMsg;
   import com.road.yishi.proto.module.RemainsLeedUpdateMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.utils.Dictionary;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import mvc.module.remainsexplore.RemainsExploreNodeInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.RemainsExploreActivityInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class RemainsExploreManager
   {
      
      private static var _instance:RemainsExploreManager;
      
      private static var OP_GET_DATA:int = 0;
      
      private static var OP_EXPLORE:int = 1;
      
      private static var OP_BUY_TINDER:int = 2;
      
      private static var OP_ATTACK:int = 3;
      
      private static var OP_RECEIVE:int = 4;
      
      private static var OP_BOX:int = 5;
      
      public static var EVENT_PAWN:int = 1;
      
      public static var EVENT_GOODS:int = 2;
      
      public static var EVENT_HERO:int = 3;
      
      public static var EVENT_BOSS1:int = 4;
      
      public static var EVENT_BOSS2:int = 5;
      
      public static var DAY:int = 1;
      
      public static var WEEK:int = 2;
      
      private var _model:RemainsExploreModel;
      
      public function RemainsExploreManager()
      {
         super();
      }
      
      public static function get instance() : RemainsExploreManager
      {
         if(!_instance)
         {
            _instance = new RemainsExploreManager();
         }
         return _instance;
      }
      
      public function get model() : RemainsExploreModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new RemainsExploreModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 519,__exploreInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 520,__exploreUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 521,__leedUpdateHandler);
      }
      
      private function __leedUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemainsLeedUpdateMsg = new RemainsLeedUpdateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RemainsLeedUpdateMsg;
         if(_loc2_.hasDayLiveness)
         {
            model.dayLiveness = _loc2_.dayLiveness;
         }
         if(_loc2_.hasWeekLiveness)
         {
            model.weekLiveness = _loc2_.weekLiveness;
         }
         var _loc5_:Dictionary = TempleteManager.instance.remainsExploreActivityTempCate.getTemplates();
         model.dayLeedList = [];
         model.weekLeedList = [];
         for each(var _loc3_:RemainsLeedDataMsg in _loc2_.leedDataList)
         {
            for each(var _loc6_:RemainsExploreActivityInfo in _loc5_)
            {
               if(_loc6_.TemplateId == _loc3_.templateId)
               {
                  _loc6_.currentCount = _loc3_.currentCount;
                  _loc6_.completeState = _loc3_.completeState;
                  if(_loc6_.MasterType == DAY)
                  {
                     model.dayLeedList.push(_loc6_);
                  }
                  else
                  {
                     model.weekLeedList.push(_loc6_);
                  }
               }
            }
         }
         model.dayLeedList.sort(sortEquip);
         model.weekLeedList.sort(sortEquip);
         MsgMan.notifyObserver("REMAINS_LEED_UPDATE");
      }
      
      private function sortEquip(param1:RemainsExploreActivityInfo, param2:RemainsExploreActivityInfo) : int
      {
         if(param1.completeState > param2.completeState)
         {
            if(param1.completeState == 1)
            {
               return -1;
            }
            return 1;
         }
         if(param1.completeState < param2.completeState)
         {
            if(param2.completeState == 1)
            {
               return 1;
            }
            return -1;
         }
         return -1;
      }
      
      private function __exploreInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:RemainsExploreNodeInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemainsExploreMsg = new RemainsExploreMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RemainsExploreMsg;
         if(_loc2_.hasTinder)
         {
            model.tinder = _loc2_.tinder;
         }
         if(_loc2_.hasCanBuyTimes)
         {
            model.canBuyTimes = _loc2_.canBuyTimes;
         }
         if(_loc2_.hasDayLiveness)
         {
            model.dayLiveness = _loc2_.dayLiveness;
         }
         if(_loc2_.hasWeekLiveness)
         {
            model.weekLiveness = _loc2_.weekLiveness;
         }
         if(_loc2_.hasBoss1NodeId)
         {
            model.boss1NodeId = _loc2_.boss1NodeId;
         }
         if(_loc2_.hasBoss2NodeId)
         {
            model.boss2NodeId = _loc2_.boss2NodeId;
         }
         if(_loc2_.hasBoxStates)
         {
            model.boxStates = _loc2_.boxStates;
         }
         for each(var _loc3_:RemainsExploreNodeMsg in _loc2_.nodeList)
         {
            _loc5_ = new RemainsExploreNodeInfo();
            _loc5_.checkpointId = _loc3_.checkpointId;
            _loc5_.chapterId = _loc3_.chapterId;
            _loc5_.node = _loc3_.node;
            _loc5_.progress = _loc3_.progress;
            _loc5_.exploreCost = _loc3_.exploreCost;
            _loc5_.isBoss1Pass = _loc3_.isBoss1Pass;
            _loc5_.isBoss2Pass = _loc3_.isBoss2Pass;
            model.nodeList.add(_loc5_.checkpointId,_loc5_);
         }
         MsgMan.notifyObserver("EXPLORE_INFO_UPDATE");
      }
      
      private function __exploreUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:RemainsExploreNodeInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DoExploreResponseMsg = new DoExploreResponseMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DoExploreResponseMsg;
         if(_loc2_.hasTinder)
         {
            model.tinder = _loc2_.tinder;
         }
         if(_loc2_.hasCheckpointId)
         {
            _loc4_ = model.nodeList[_loc2_.checkpointId];
            if(_loc4_)
            {
               _loc4_.progress = _loc2_.progress;
            }
         }
         if(_loc2_.hasEventType)
         {
            model.eventType = _loc2_.eventType;
         }
         MsgMan.notifyObserver("DO_EXPLORE_UPDATE");
      }
      
      public function sendDataRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(9703);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_GET_DATA;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendExplore(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9703);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_EXPLORE;
         _loc2_.campaignId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBuy() : void
      {
         var _loc2_:PackageOut = new PackageOut(9703);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_BUY_TINDER;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendAttack(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9703);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = OP_ATTACK;
         _loc3_.campaignId = param1;
         _loc3_.type = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendReceive(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9703);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_RECEIVE;
         _loc2_.campaignId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBox(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9703);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = OP_BOX;
         _loc3_.value1 = param1;
         _loc3_.index = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

