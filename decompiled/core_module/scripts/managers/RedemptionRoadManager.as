package managers
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.redemptionroad.RedemptionRoadLayerMsg;
   import com.road.yishi.proto.redemptionroad.RedemptionRoadMsg;
   import com.road.yishi.proto.redemptionroad.RedemptionRoadUserMsg;
   import mvc.module.redemptionroad.RedemptionRoadModel;
   import mvc.module.redemptionroad.RedemptionRoadNodeInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class RedemptionRoadManager
   {
      
      private static var _instance:RedemptionRoadManager;
      
      private var _model:RedemptionRoadModel;
      
      public function RedemptionRoadManager()
      {
         super();
      }
      
      public static function get instance() : RedemptionRoadManager
      {
         if(_instance == null)
         {
            _instance = new RedemptionRoadManager();
         }
         return _instance;
      }
      
      public function get model() : RedemptionRoadModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new RedemptionRoadModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 208,__nodeTempInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 209,__nodeUserInfoHandler);
      }
      
      private function __nodeTempInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:RedemptionRoadNodeInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RedemptionRoadMsg = new RedemptionRoadMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RedemptionRoadMsg;
         model.nodeDic = new SimpleDictionary();
         for each(var _loc3_:RedemptionRoadLayerMsg in _loc2_.layers)
         {
            _loc4_ = new RedemptionRoadNodeInfo();
            _loc4_.id = _loc3_.id;
            _loc4_.layer = _loc3_.layer;
            _loc4_.pos = _loc3_.pos;
            _loc4_.buff = _loc3_.buff;
            _loc4_.debuff = _loc3_.debuff;
            _loc4_.boss = _loc3_.boss;
            _loc4_.npc = _loc3_.npc;
            _loc4_.rewards = _loc3_.reward;
            model.nodeDic.add(_loc4_.layer + "_" + _loc4_.pos,_loc4_);
         }
         MsgMan.notifyObserver("TEMP_INFO_CHANGE");
      }
      
      private function __nodeUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RedemptionRoadUserMsg = new RedemptionRoadUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RedemptionRoadUserMsg;
         if(_loc2_.difficulty)
         {
            model.difficulty = _loc2_.difficulty;
         }
         if(_loc2_.layer)
         {
            model.curLayer = _loc2_.layer;
         }
         if(_loc2_.cdTime)
         {
            model.cdEndTime = DateFormatter.parse(_loc2_.cdTime,"YYYY-MM-DD hh:mm:ss");
         }
         model.roadPaths = _loc2_.path;
         MsgMan.notifyObserver("USER_INFO_CHANGE");
      }
      
      public function sendRedemptionRoadRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8659);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.id = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

