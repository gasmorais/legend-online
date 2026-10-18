package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.seek.MessageForSeekMsg;
   import com.road.yishi.proto.seek.PlayerSeekInfoMsg;
   import com.road.yishi.proto.seek.SeekNodeListMsg;
   import com.road.yishi.proto.seek.SeekNodeListMsg.SeekNodeMsg;
   import flash.events.EventDispatcher;
   import mvc.module.treasurehunt.HuntEvent;
   import mvc.module.treasurehunt.HuntPointData;
   import mvc.module.treasurehunt.HuntPointModel;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class TreasureHuntManager extends EventDispatcher
   {
      
      private static var _instance:TreasureHuntManager;
      
      public var isFirst:Boolean = true;
      
      public var model:HuntPointModel;
      
      public function TreasureHuntManager()
      {
         super();
         model = new HuntPointModel();
      }
      
      public static function get instance() : TreasureHuntManager
      {
         if(!_instance)
         {
            _instance = new TreasureHuntManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4914,__nodeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4915,__infoTxtHandler);
      }
      
      private function __nodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:SeekNodeListMsg = null;
         var _loc6_:HuntPointData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerSeekInfoMsg = new PlayerSeekInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerSeekInfoMsg;
         if(_loc2_.op == 1)
         {
            _loc5_ = _loc2_.seekNodeList;
            for each(var _loc3_:SeekNodeMsg in _loc5_.seekNode)
            {
               _loc6_ = new HuntPointData();
               _loc6_.nodeId = _loc3_.nodeId;
               _loc6_.nodeName = _loc3_.nodeName;
               _loc6_.pointX = _loc3_.pointX;
               _loc6_.pointY = _loc3_.pointY;
               model.nodeList.push(_loc6_);
            }
         }
         model.seekCount = _loc2_.seekCount;
         model.nextAddTime = Int64Utils.int64ToNumber(_loc2_.nextAddTime);
         model.state = _loc2_.state;
         model.eventDesc = _loc2_.eventDesc;
         model.curNodeId = _loc2_.curNodeId;
         model.op = _loc2_.op;
         dispatchEvent(new HuntEvent("HUNT_TEM"));
      }
      
      private function __infoTxtHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MessageForSeekMsg = new MessageForSeekMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MessageForSeekMsg;
         dispatchEvent(new HuntEvent("INFO_SHOW",_loc2_));
      }
   }
}

