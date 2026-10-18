package managers
{
   import com.road.yishi.proto.active.FMBaseItem;
   import com.road.yishi.proto.active.FMDropMsg;
   import com.road.yishi.proto.active.FMReqMsg;
   import com.road.yishi.proto.active.FMResMsg;
   import com.road.yishi.proto.active.HotItemMsg;
   import mvc.module.exchange.ExchangeBoxModel;
   import mvc.module.mounts.MountShopInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class ExchangeBoxManager
   {
      
      private static var _instance:ExchangeBoxManager;
      
      private var _model:ExchangeBoxModel;
      
      public function ExchangeBoxManager()
      {
         super();
      }
      
      public static function get instance() : ExchangeBoxManager
      {
         if(!_instance)
         {
            _instance = new ExchangeBoxManager();
         }
         return _instance;
      }
      
      public function get model() : ExchangeBoxModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ExchangeBoxModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 367,__updateBuyDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 368,__updateHotListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 369,__updateDropListHandler);
      }
      
      private function __updateBuyDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FMResMsg = new FMResMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FMResMsg;
         var _loc3_:Object = {};
         if(_loc2_.hasType)
         {
            _loc3_.type = _loc2_.type;
         }
         if(_loc2_.hasOp)
         {
            _loc3_.op = _loc2_.op;
         }
         if(_loc2_.item)
         {
            _loc3_.list = _loc2_.item;
         }
         MsgMan.notifyObserver("EXCHANGE_BUY_BACK",_loc3_);
      }
      
      private function __updateHotListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MountShopInfo = null;
         var _loc3_:MountShopInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:HotItemMsg = new HotItemMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as HotItemMsg;
         model.hotFashionArr = [];
         model.hotMountArr = [];
         for each(var _loc6_:FMBaseItem in _loc2_.fashion)
         {
            _loc5_ = new MountShopInfo();
            _loc5_.tempId = _loc6_.itemId;
            _loc5_.count = _loc6_.itemCount;
            model.hotFashionArr.push(_loc5_);
         }
         model.hotFashionArr.sortOn("tempId",16);
         for each(var _loc4_:FMBaseItem in _loc2_.mount)
         {
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemId;
            _loc3_.count = _loc4_.itemCount;
            model.hotMountArr.push(_loc3_);
         }
         model.hotMountArr.sortOn("tempId",16);
         MsgMan.notifyObserver("EXCHANGE_HOT_UPDATE");
      }
      
      private function __updateDropListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MountShopInfo = null;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FMDropMsg = new FMDropMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FMDropMsg;
         model.fashionDropArr = [];
         model.fashionHotDropArr = [];
         model.mountDropArr = [];
         model.mountHotDropArr = [];
         for each(_loc4_ in _loc2_.fashionDrop)
         {
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemId;
            _loc3_.count = _loc4_.itemCount;
            model.fashionDropArr.push(_loc3_);
         }
         model.fashionDropArr.sortOn("tempId",16);
         for each(_loc4_ in _loc2_.fashionHotDrop)
         {
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemId;
            _loc3_.count = _loc4_.itemCount;
            model.fashionHotDropArr.push(_loc3_);
         }
         model.fashionHotDropArr.sortOn("tempId",16);
         for each(_loc4_ in _loc2_.mountDrop)
         {
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemId;
            _loc3_.count = _loc4_.itemCount;
            model.mountDropArr.push(_loc3_);
         }
         model.mountDropArr.sortOn("tempId",16);
         for each(_loc4_ in _loc2_.mountHotDrop)
         {
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemId;
            _loc3_.count = _loc4_.itemCount;
            model.mountHotDropArr.push(_loc3_);
         }
         model.mountHotDropArr.sortOn("tempId",16);
         MsgMan.notifyObserver("EXCHANGE_DROP_UPDATE");
      }
      
      public function sendExchangeBoxOperate(param1:int, param2:int = 0, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(9613);
         var _loc4_:FMReqMsg = new FMReqMsg();
         _loc4_.type = param1;
         _loc4_.op = param2;
         _loc4_.payType = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

