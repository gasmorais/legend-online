package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.active.GodTreasureReqMsg;
   import com.road.yishi.proto.active.GodTreasureRspMsg;
   import events.GodTreasureEvent;
   import flash.events.EventDispatcher;
   import mvc.module.godTreasure.GodTreasureModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class GodTreasureManager extends EventDispatcher
   {
      
      private static var _instance:GodTreasureManager;
      
      private var _model:GodTreasureModel;
      
      public function GodTreasureManager()
      {
         super();
      }
      
      public static function get instance() : GodTreasureManager
      {
         if(!_instance)
         {
            _instance = new GodTreasureManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         addEvent();
         _model = new GodTreasureModel();
      }
      
      public function get godtreasureModel() : GodTreasureModel
      {
         if(_model == null)
         {
            _model = new GodTreasureModel();
         }
         return _model;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4968,__godTreasureRspHandler);
      }
      
      private function __godTreasureRspHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GodTreasureRspMsg = new GodTreasureRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GodTreasureRspMsg;
         _model.updateInfo(_loc2_);
         dispatchEvent(new GodTreasureEvent("INFO_UPDATE",_model.godTreasureInfo));
      }
      
      public function senReq(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9546);
         var _loc3_:GodTreasureReqMsg = new GodTreasureReqMsg();
         _loc3_.opType = param1;
         _loc3_.level = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

