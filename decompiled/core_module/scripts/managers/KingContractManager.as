package managers
{
   import com.road.yishi.proto.player.KingContractBuyMsg;
   import com.road.yishi.proto.player.KingContractInfoMsg;
   import com.road.yishi.proto.player.KingContractMsg;
   import events.KingContractEvents;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.kingcontract.KingContractModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class KingContractManager
   {
      
      private static var _instance:KingContractManager;
      
      private var _model:KingContractModel;
      
      public var kingList:Array = [1,2,3,4,5,6,8,9,10];
      
      public function KingContractManager()
      {
         super();
      }
      
      public static function get Instance() : KingContractManager
      {
         if(_instance == null)
         {
            _instance = new KingContractManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _model = new KingContractModel();
      }
      
      public function get model() : KingContractModel
      {
         return _model;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4434,__updateKingContractHandler);
      }
      
      private function __updateKingContractHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:KingContractInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:KingContractMsg = new KingContractMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as KingContractMsg;
         for each(var _loc3_:KingContractInfoMsg in _loc2_.kingContractInfos)
         {
            _loc5_ = _model.getInfoById(_loc3_.contractId);
            if(_loc5_)
            {
               _loc5_.endData = DateFormatter.parse(_loc3_.endData,"YYYY-MM-DD hh:mm:ss");
            }
         }
         NotificationManager.instance.dispatchEvent(new KingContractEvents("UPDATE_KINGCONTRACT",null));
      }
      
      public function sendKingContract(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8540);
         var _loc2_:KingContractBuyMsg = new KingContractBuyMsg();
         _loc2_.ids = param1;
         _loc2_.__use = false;
         _loc2_.friendId = 0;
         _loc2_.friendId = ArmyManager.instance.army.userId;
         _loc2_.friendname = ArmyManager.instance.army.nickName;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendKingContractFench() : void
      {
         var _loc2_:PackageOut = new PackageOut(8540);
         var _loc1_:KingContractBuyMsg = new KingContractBuyMsg();
         _loc1_.ids = [];
         _loc1_.__use = true;
         _loc1_.friendId = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function presentKingContract(param1:Array, param2:int, param3:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(8540);
         var _loc4_:KingContractBuyMsg = new KingContractBuyMsg();
         _loc4_.ids = param1;
         _loc4_.__use = false;
         _loc4_.friendId = param2;
         _loc4_.friendname = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function checkHasBuffById(param1:int) : Boolean
      {
         var _loc2_:KingContractInfo = model.getInfoById(param1);
         if(_loc2_ && _loc2_.leftTime > 0)
         {
            return true;
         }
         return false;
      }
   }
}

