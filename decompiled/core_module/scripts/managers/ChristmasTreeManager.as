package managers
{
   import com.road.yishi.proto.item.BottleDropListMsg;
   import com.road.yishi.proto.item.BottleOpMsg;
   import com.road.yishi.proto.item.BottlePassMsg;
   import flash.events.EventDispatcher;
   import mvc.module.christmastree.ChristmasTreeModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ChristmasTreeManager extends EventDispatcher
   {
      
      private static var _instance:ChristmasTreeManager;
      
      private var _model:ChristmasTreeModel;
      
      public function ChristmasTreeManager()
      {
         super();
      }
      
      public static function get instance() : ChristmasTreeManager
      {
         if(!_instance)
         {
            _instance = new ChristmasTreeManager();
         }
         return _instance;
      }
      
      public function get model() : ChristmasTreeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ChristmasTreeModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4957,__updateCTInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4958,__updateCTResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4959,__updateCTimes);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4960,__updateCTBoxView);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4961,__updateCTGoods);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4963,_updataCTCount);
      }
      
      private function __updateCTInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         if(_loc2_.passType == 1)
         {
            if(model.rewardsInfo)
            {
               model.rewardsInfo = model.rewardsInfo.concat(_loc2_.infos);
            }
            else
            {
               model.rewardsInfo = _loc2_.infos;
            }
         }
         else if(_loc2_.passType == 2)
         {
            model.luckShowInfo = _loc2_.infos;
         }
      }
      
      public function __updateCTResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottleDropListMsg = new BottleDropListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottleDropListMsg;
         model.showItemInfo = _loc2_.dropItem;
      }
      
      private function __updateCTimes(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         model.boxMark(_loc2_.infos);
      }
      
      private function __updateCTBoxView(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         model.boxMark(_loc2_.infos);
      }
      
      private function _updataCTCount(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
      }
      
      private function __updateCTGoods(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
      }
      
      public function sendOpenInfo(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9542);
         var _loc3_:BottleOpMsg = new BottleOpMsg();
         _loc3_.alterType = param1;
         _loc3_.opType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

