package managers
{
   import com.road.yishi.proto.cccactive.FoisonHornMsg;
   import mvc.module.foisonhorn.FoisonHornModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class FoisonHornManager
   {
      
      private static var _instance:FoisonHornManager;
      
      public static const OPEN_FRAME:int = 1;
      
      public static const ACTIVATING:int = 2;
      
      private var _model:FoisonHornModel;
      
      public function FoisonHornManager()
      {
         super();
      }
      
      public static function get instance() : FoisonHornManager
      {
         if(_instance == null)
         {
            _instance = new FoisonHornManager();
         }
         return _instance;
      }
      
      public function get model() : FoisonHornModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new FoisonHornModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4877,__updateFoisonHornMsg);
      }
      
      private function __updateFoisonHornMsg(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:FoisonHornMsg = new FoisonHornMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as FoisonHornMsg;
         if(!model.isOpen && _loc2_.isOpen)
         {
            model.openChange = true;
         }
         else
         {
            model.openChange = false;
         }
         if(_loc2_.hasIsOpen)
         {
            model.isOpen = _loc2_.isOpen;
         }
         if(_loc2_.hasOpenTime)
         {
            model.openTime = _loc2_.openTime;
         }
         if(_loc2_.hasStopTime)
         {
            model.stopTime = _loc2_.stopTime;
         }
         if(_loc2_.hasCount)
         {
            model.totalCount = _loc2_.count;
         }
         if(_loc2_.hasRewardInfo)
         {
            model.rewardInfo = _loc2_.rewardInfo;
         }
         model.goodsList = [];
         model.activatingList = [];
         if(_loc2_.activation)
         {
            _loc4_ = _loc2_.activation;
            _loc5_ = _loc4_.split("|");
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc3_ = _loc5_[_loc6_].split(",");
               if(_loc3_.length == 3)
               {
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = int(_loc3_[0]);
                  _loc8_.count = int(_loc3_[1]);
                  model.goodsList.push(_loc8_);
                  model.activatingList.push(_loc3_[2]);
               }
               _loc6_++;
            }
         }
         MsgMan.notifyObserver("FOISONHORN_INFO_CHANGE");
      }
      
      public function sendRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,30);
         var _loc3_:FoisonHornMsg = new FoisonHornMsg();
         _loc3_.op = param1;
         _loc3_.itemId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

