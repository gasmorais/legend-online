package yishi.manager
{
   import com.road.yishi.proto.antaeus.AntaeusMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import events.AntaeusEvent;
   import flash.events.EventDispatcher;
   import mvc.module.antaeus.AntaeusData;
   import mvc.module.antaeus.AntaeusModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class AntaeusManager extends EventDispatcher
   {
      
      private static const OP_OPENVIEW:int = 1;
      
      private static const OP_SIGN:int = 2;
      
      private static const OP_INVITATION:int = 3;
      
      public static const CAMPAIGN_TITAN:int = 1;
      
      public static const CAMPAIGN_ECLIPTIC_PALACE:int = 2;
      
      public static const CAMPAIGN_TOWER:int = 3;
      
      private static var _instance:AntaeusManager;
      
      private var _model:AntaeusModel;
      
      public function AntaeusManager()
      {
         super();
         _model = new AntaeusModel();
      }
      
      public static function get instance() : AntaeusManager
      {
         if(!_instance)
         {
            _instance = new AntaeusManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4894,receiveAntaeusInfo);
      }
      
      protected function receiveAntaeusInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AntaeusMsg = new AntaeusMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AntaeusMsg;
         if(!model.antaeusData)
         {
            model.antaeusData = new AntaeusData(_loc2_);
         }
         else
         {
            model.antaeusData.update(_loc2_);
         }
         sendEvent("UPDATE_INFO");
      }
      
      private function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new AntaeusEvent(param1,param2));
      }
      
      public function sendOpenView() : void
      {
         var _loc2_:PackageOut = new PackageOut(9682);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSign() : void
      {
         var _loc2_:PackageOut = new PackageOut(9682);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendInvite(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9682);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 3;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function clear() : void
      {
         model.antaeusData.assistantList = [];
      }
      
      public function get model() : AntaeusModel
      {
         return _model;
      }
      
      public function set model(param1:AntaeusModel) : void
      {
         _model = param1;
      }
   }
}

