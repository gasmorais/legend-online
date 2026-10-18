package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.shop.UpgradePresentListMsg;
   import com.road.yishi.proto.shop.UpgradePresentMsg;
   import managers.ShopManager;
   import mvc.module.upgradepresent.UpgradePresentInfo;
   import mvc.module.upgradepresent.UpgradePresentModel;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class UpgradePresentManager
   {
      
      private static var _instance:UpgradePresentManager;
      
      private var _model:UpgradePresentModel;
      
      public function UpgradePresentManager()
      {
         super();
      }
      
      public static function get instance() : UpgradePresentManager
      {
         if(!_instance)
         {
            _instance = new UpgradePresentManager();
         }
         return _instance;
      }
      
      public function get model() : UpgradePresentModel
      {
         if(!_model)
         {
            _model = new UpgradePresentModel();
         }
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 176,__upgradePresentMsgBack);
      }
      
      private function __upgradePresentMsgBack(param1:SLGSocketEvent) : void
      {
         var _loc5_:UpgradePresentInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:UpgradePresentListMsg = new UpgradePresentListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as UpgradePresentListMsg;
         model.presentList = [];
         for each(var _loc3_:UpgradePresentMsg in _loc2_.list)
         {
            _loc5_ = new UpgradePresentInfo();
            _loc5_.area = _loc3_.area;
            _loc5_.endTime = int(Math.ceil(Int64Utils.int64ToNumber(_loc3_.endTime) / 1000));
            _loc5_.boughtCountArr = _loc3_.boughtCount;
            _loc5_.shopIdArr = _loc3_.shopId;
            _loc5_.setPresentInfo();
            model.presentList.push(_loc5_);
         }
         model.presentList.sortOn("area",16);
         model.setModelData();
         MsgMan.notifyObserver("UPGRADE_PRESNET_INFO_CHANGE");
      }
      
      public function sendUpgradePresentBuy(param1:int) : void
      {
         var _loc2_:int = 1;
         var _loc3_:int = 1;
         var _loc4_:int = ArmyManager.instance.thane.userId;
         ShopManager.Instance.buyOne(param1,_loc2_,_loc4_,_loc3_,false);
      }
   }
}

