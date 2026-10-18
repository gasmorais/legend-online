package managers
{
   import com.road.yishi.proto.item.BottlePassMsg;
   import com.road.yishi.proto.mapshop.MapShopInfoMsg;
   import com.road.yishi.proto.mapshop.MapShopquestMsg;
   import com.road.yishi.proto.mapshop.MapshopIteminfoMsg;
   import mvc.module.outercityshop.OuterCityShopItemInfo;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class OuterCityShopManager
   {
      
      private static var _instance:OuterCityShopManager;
      
      private var _model:OuterCityShopModel;
      
      public function OuterCityShopManager()
      {
         super();
         if(!_model)
         {
            _model = new OuterCityShopModel();
         }
      }
      
      public static function get instance() : OuterCityShopManager
      {
         if(!_instance)
         {
            _instance = new OuterCityShopManager();
         }
         return _instance;
      }
      
      public function get model() : OuterCityShopModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4946,__mapShopInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 294,__updateShopInfoHandler);
      }
      
      private function __updateShopInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         model.shopLuckShowInfo = _loc2_.infos;
      }
      
      private function __mapShopInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:OuterCityShopItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MapShopInfoMsg = new MapShopInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MapShopInfoMsg;
         model.fresh_time = DateFormatter.parse(_loc2_.freshTime,"YYYY-MM-DD hh:mm:ss");
         model.bless = _loc2_.bless;
         model.fresh_count = _loc2_.freshCount;
         model.consumePoints = _loc2_.score;
         model.goodsList = [];
         for each(var _loc4_:MapshopIteminfoMsg in _loc2_.items)
         {
            _loc3_ = new OuterCityShopItemInfo();
            _loc3_.index = _loc4_.index;
            _loc3_.itemId = _loc4_.mapshopitemid;
            _loc3_.isBuy = _loc4_.isbuy;
            model.goodsList.push(_loc3_);
         }
         model.commit();
      }
      
      public function sendAction(param1:int, param2:int = 0, param3:int = 0, param4:int = -1) : void
      {
         var _loc6_:PackageOut = new PackageOut(9528);
         var _loc5_:MapShopquestMsg = new MapShopquestMsg();
         _loc5_.op = param1;
         _loc5_.para1 = param2;
         _loc5_.para2 = param3;
         if(param4 != -1)
         {
            _loc5_.payType = param4;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

