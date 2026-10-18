package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.active.SacrificeReqMsg;
   import com.road.yishi.proto.active.SacrificeRspMsg;
   import events.SacrificeEvent;
   import flash.events.EventDispatcher;
   import mvc.module.sacrifice.SacrificeModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class SacrificeManager extends EventDispatcher
   {
      
      private static var _instance:SacrificeManager;
      
      private var _model:SacrificeModel;
      
      public function SacrificeManager()
      {
         super();
      }
      
      public static function get instance() : SacrificeManager
      {
         if(!_instance)
         {
            _instance = new SacrificeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new SacrificeModel();
         addEvent();
      }
      
      public function get model() : SacrificeModel
      {
         return _model;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4962,__sacrificeRspHandler);
      }
      
      private function __sacrificeRspHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SacrificeRspMsg = new SacrificeRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SacrificeRspMsg;
         if(_loc2_.opType == 1 || _loc2_.opType == 3)
         {
            InfoTipsManager.instance.updateValue(24,_loc2_.times);
         }
         _model.updateInfo(_loc2_);
         dispatchEvent(new SacrificeEvent("INFO_UPDATE",_model.sacrificeInfo));
      }
      
      public function sendReq(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9543);
         var _loc3_:SacrificeReqMsg = new SacrificeReqMsg();
         _loc3_.opType = param1;
         _loc3_.param1 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

