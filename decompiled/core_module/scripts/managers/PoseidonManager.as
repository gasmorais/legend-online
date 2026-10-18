package managers
{
   import com.road.yishi.proto.poseidonshop.PoseidonShopBuyReqMsg;
   import com.road.yishi.proto.poseidonshop.PoseidonShopBuyRspMsg;
   import com.road.yishi.proto.poseidonshop.PoseidonShopInfoListMsg;
   import com.road.yishi.proto.poseidonshop.PoseidonShopInfoMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mvc.module.poseidon.PoseidonGoodInfo;
   import mvc.module.poseidon.PoseidonModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class PoseidonManager extends EventDispatcher
   {
      
      public static const EVENT_POSEIDON_REFRESH:String = "EVENT_POSEIDON_REFRESH";
      
      private static var _ins:PoseidonManager;
      
      private var _model:PoseidonModel;
      
      public function PoseidonManager()
      {
         super();
         _model = new PoseidonModel();
      }
      
      public static function get Ins() : PoseidonManager
      {
         if(_ins == null)
         {
            _ins = new PoseidonManager();
         }
         return _ins;
      }
      
      public function get model() : PoseidonModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 522,__goodInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 523,__buyInfosHandler);
      }
      
      private function __goodInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PoseidonGoodInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PoseidonShopInfoListMsg = new PoseidonShopInfoListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PoseidonShopInfoListMsg;
         for each(var _loc3_:PoseidonShopInfoMsg in _loc2_.list)
         {
            _loc5_ = _model.getGoodInfo(_loc3_.id);
            if(!_loc5_)
            {
               _loc5_ = new PoseidonGoodInfo();
               _model.addGoodInfo(_loc3_.id,_loc5_);
            }
            _loc5_.goodId = _loc3_.id;
            _loc5_.buyCount = _loc3_.buyNumber;
         }
         dispatchEvent(new Event("EVENT_POSEIDON_REFRESH"));
      }
      
      private function __buyInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PoseidonGoodInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PoseidonShopBuyRspMsg = new PoseidonShopBuyRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PoseidonShopBuyRspMsg;
         _loc4_ = _model.getGoodInfo(_loc2_.id);
         if(!_loc4_)
         {
            _loc4_ = new PoseidonGoodInfo();
            _model.addGoodInfo(_loc2_.id,_loc4_);
         }
         _loc4_.goodId = _loc2_.id;
         _loc4_.buyCount = _loc2_.result;
         dispatchEvent(new Event("EVENT_POSEIDON_REFRESH"));
      }
      
      public function requestInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(9704);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function buyGood(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9705);
         var _loc3_:PoseidonShopBuyReqMsg = new PoseidonShopBuyReqMsg();
         _loc3_.id = param1;
         _loc3_.count = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

