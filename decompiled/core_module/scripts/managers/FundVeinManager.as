package managers
{
   import com.road.yishi.proto.active.DepositActiveMsg;
   import com.road.yishi.proto.active.LodeListMsg;
   import flash.events.EventDispatcher;
   import mvc.module.fundVein.FundVeinInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.FundEvent;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class FundVeinManager extends EventDispatcher
   {
      
      private static var _instance:FundVeinManager;
      
      public const OP_TYPE_QUERY:int = 0;
      
      public const OP_TYPE_BUY:int = 1;
      
      public const OP_TYPE_GET:int = 2;
      
      private var _model:FundVeinInfo;
      
      public function FundVeinManager()
      {
         super();
         _model = new FundVeinInfo();
         setup();
      }
      
      public static function get instance() : FundVeinManager
      {
         if(!_instance)
         {
            _instance = new FundVeinManager();
         }
         return _instance;
      }
      
      public function get info() : FundVeinInfo
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4640,__getFundInfoHandler);
      }
      
      private function __getFundInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LodeListMsg = new LodeListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LodeListMsg;
         _model.info = _loc2_;
         dispatchEvent(new FundEvent("SHOWTOPBTN"));
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FUND_VEIN_INFO_REFRESH"));
      }
      
      public function fundOperate(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8751);
         var _loc4_:DepositActiveMsg = new DepositActiveMsg();
         _loc4_.opType = param1;
         if(param1 == 1)
         {
            _loc4_.opParam = param2;
         }
         else if(param1 == 2)
         {
            _loc4_.depositLevel = param2;
            _loc4_.opParam = param3;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function get isShowBtn() : Boolean
      {
         return !_model.isOver;
      }
      
      public function get isCanGetGift() : Boolean
      {
         return _model.rewardAmount > 0;
      }
   }
}

