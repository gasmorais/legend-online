package yishi.manager
{
   import com.road.yishi.proto.module.ShadowLandMsg;
   import com.road.yishi.proto.module.ShadowLandNodeMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import mvc.module.shadowland.ShadowLandChapterInfo;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class ShadowLandManager
   {
      
      private static var _instance:ShadowLandManager;
      
      private static var OP_REQUEST_DATA:int = 0;
      
      private static var OP_FIGHT:int = 1;
      
      private static var OP_REWARD:int = 2;
      
      private var _model:ShadowLandModel;
      
      public function ShadowLandManager()
      {
         super();
      }
      
      public static function get instance() : ShadowLandManager
      {
         if(!_instance)
         {
            _instance = new ShadowLandManager();
         }
         return _instance;
      }
      
      public function get model() : ShadowLandModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ShadowLandModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 517,__shadowLandUpdateHandler);
      }
      
      private function __shadowLandUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:ShadowLandChapterInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShadowLandMsg = new ShadowLandMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ShadowLandMsg;
         if(_loc2_.hasOpenAreaId)
         {
            model.openMaxAreaId = _loc2_.openAreaId;
         }
         if(_loc2_.hasBodyStrength)
         {
            model.curNum = _loc2_.bodyStrength;
         }
         if(_loc2_.hasBoxStates)
         {
            model.boxStates = _loc2_.boxStates;
         }
         var _loc5_:String = "";
         for each(var _loc3_:ShadowLandNodeMsg in _loc2_.nodeList)
         {
            _loc6_ = new ShadowLandChapterInfo();
            _loc6_.areaId = _loc3_.areaId;
            _loc6_.difficulty = _loc3_.difficulty;
            _loc6_.passNodeId = _loc3_.nodeId;
            _loc5_ = _loc6_.areaId + "_" + _loc6_.difficulty;
            model.areaInfoDic.add(_loc5_,_loc6_);
         }
         MsgMan.notifyObserver("SHADOWLAND_INFO_UPDATE");
      }
      
      public function sendDataRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(9702);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_REQUEST_DATA;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendFight(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9702);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_FIGHT;
         _loc2_.id = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendGetReward(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9702);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = OP_REWARD;
         _loc3_.chapterId = param1;
         _loc3_.value1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

