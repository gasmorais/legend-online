package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.active.MvpShopItemInfoMsg;
   import com.road.yishi.proto.active.MvpShopMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.mvpshop.MvpShopItemInfo;
   import mvc.module.mvpshop.MvpShopModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class MvpShopManager
   {
      
      private static var _instance:MvpShopManager;
      
      public static const BUY:int = 1;
      
      public static const REFRESH:int = 2;
      
      private var _model:MvpShopModel;
      
      public function MvpShopManager()
      {
         super();
      }
      
      public static function get instance() : MvpShopManager
      {
         if(_instance == null)
         {
            _instance = new MvpShopManager();
         }
         return _instance;
      }
      
      public function get model() : MvpShopModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new MvpShopModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4888,__updateMvpShopInfoMsg);
      }
      
      private function __updateMvpShopInfoMsg(param1:SLGSocketEvent) : void
      {
         var _loc5_:MvpShopItemInfo = null;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MvpShopMsg = new MvpShopMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MvpShopMsg;
         if(!model.isOpen && _loc2_.isopen)
         {
            model.openChange = true;
         }
         else
         {
            model.openChange = false;
         }
         if(_loc2_.hasIsopen)
         {
            model.isOpen = _loc2_.isopen;
         }
         if(_loc2_.hasBegin)
         {
            model.openTime = _loc2_.begin;
         }
         if(_loc2_.hasEnd)
         {
            model.stopTime = _loc2_.end;
         }
         if(_loc2_.nexttime)
         {
            model.nextTime = Int64Utils.int64ToNumber(_loc2_.nexttime);
         }
         if(_loc2_.hasMymvppoint)
         {
            if(_loc2_.mymvppoint > model.score)
            {
               MsgMan.notifyObserver("MVPSHOP_POINT_CHANGE");
            }
            model.score = _loc2_.mymvppoint;
         }
         model.itemList = [];
         model.goodsList = [];
         for each(_loc3_ in _loc2_.showitems)
         {
            _loc5_ = new MvpShopItemInfo();
            _loc5_.id = _loc3_.id;
            _loc5_.itemId = _loc3_.itemId;
            _loc5_.itemCount = _loc3_.itemCount;
            _loc5_.price = _loc3_.price;
            _loc5_.isBuy = _loc3_.isBuy;
            _loc5_.isRare = _loc3_.isRare;
            model.itemList.push(_loc5_);
         }
         for each(_loc3_ in _loc2_.myitems)
         {
            _loc5_ = new MvpShopItemInfo();
            _loc5_.id = _loc3_.id;
            _loc5_.itemId = _loc3_.itemId;
            _loc5_.itemCount = _loc3_.itemCount;
            _loc5_.price = _loc3_.price;
            _loc5_.isBuy = _loc3_.isBuy;
            _loc5_.isRare = _loc3_.isRare;
            model.goodsList.push(_loc5_);
         }
         MsgMan.notifyObserver("MVPSHOP_INFO_CHANGE");
      }
      
      public function sendRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9678);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

