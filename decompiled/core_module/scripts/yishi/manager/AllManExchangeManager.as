package yishi.manager
{
   import com.road.yishi.proto.active.AllExchangeMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import events.AllManExchangeEvent;
   import flash.events.EventDispatcher;
   import mvc.module.allmanexchange.AllManExchangeModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class AllManExchangeManager extends EventDispatcher
   {
      
      private static const OP_OPENVIEW:int = 1;
      
      private static var _instance:AllManExchangeManager;
      
      private var _model:AllManExchangeModel;
      
      public function AllManExchangeManager()
      {
         super();
         _model = new AllManExchangeModel();
      }
      
      public static function get instance() : AllManExchangeManager
      {
         if(!_instance)
         {
            _instance = new AllManExchangeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4955,receiveInfo);
      }
      
      protected function receiveInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AllExchangeMsg = new AllExchangeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AllExchangeMsg;
         model.update(_loc2_);
         sendEvent("UPDATE_INFO");
      }
      
      private function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new AllManExchangeEvent(param1,param2));
      }
      
      public function sendOpenView() : void
      {
         var _loc2_:PackageOut = new PackageOut(9007);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendGetAward(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9007);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 1;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendExchangePoint(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9007);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 2;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function get model() : AllManExchangeModel
      {
         return _model;
      }
      
      public function set model(param1:AllManExchangeModel) : void
      {
         _model = param1;
      }
   }
}

