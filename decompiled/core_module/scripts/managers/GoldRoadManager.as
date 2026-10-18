package managers
{
   import com.road.yishi.proto.goldenroad.CastDiceMsg;
   import com.road.yishi.proto.goldenroad.GoldenRoadClientRequestMsg;
   import com.road.yishi.proto.goldenroad.GoldenRoadMsg;
   import events.GoldRoadEvent;
   import flash.events.EventDispatcher;
   import mvc.module.goldroad.GoldRoadGoodsInfo;
   import mvc.module.goldroad.GoldRoadModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class GoldRoadManager extends EventDispatcher
   {
      
      private static var _instance:GoldRoadManager;
      
      private var _model:GoldRoadModel;
      
      public function GoldRoadManager()
      {
         super();
         if(!_model)
         {
            _model = new GoldRoadModel();
         }
      }
      
      public static function get instance() : GoldRoadManager
      {
         if(!_instance)
         {
            _instance = new GoldRoadManager();
         }
         return _instance;
      }
      
      public function get model() : GoldRoadModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4933,__goldRoadInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4934,__diceInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 300,__closeGoldRoadFrameHanlder);
      }
      
      private function __goldRoadInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:GoldRoadGoodsInfo = null;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoldenRoadMsg = new GoldenRoadMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as GoldenRoadMsg;
         model.stepKey = _loc2_.playerStatue;
         model.score = _loc2_.score;
         model.GoldRoadGoodList = new Vector.<GoldRoadGoodsInfo>();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.cellInfo.length)
         {
            _loc5_ = new GoldRoadGoodsInfo();
            _loc5_.cellValue = _loc3_;
            _loc5_.tempId = _loc2_.cellInfo[_loc3_].itemID;
            _loc5_.count = _loc2_.cellInfo[_loc3_].count;
            model.GoldRoadGoodList.push(_loc5_);
            _loc3_++;
         }
         this.dispatchEvent(new GoldRoadEvent("GOLDROADRE_FRESH",null));
      }
      
      private function __diceInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastDiceMsg = new CastDiceMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CastDiceMsg;
         model.stepKey = _loc2_.curPos;
         model.randomNum = _loc2_.diceNumber;
         model.score = _loc2_.score;
         model.dropTempStr = _loc2_.tempIds;
         this.dispatchEvent(new GoldRoadEvent("GOLDROADRE_DICE",null));
      }
      
      private function __closeGoldRoadFrameHanlder(param1:SLGSocketEvent) : void
      {
         if(model.hasOpenFrame)
         {
            FrameControllerManager.instance.openControllerByInfo("goldroad");
         }
      }
      
      public function getOrRefreshGoldInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9520);
         var _loc2_:GoldenRoadClientRequestMsg = new GoldenRoadClientRequestMsg();
         _loc2_.refreshType = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function throwDice(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(9521);
         var _loc4_:GoldenRoadClientRequestMsg = new GoldenRoadClientRequestMsg();
         _loc4_.diceType = param1;
         _loc4_.consumeType = param2;
         _loc4_.isBatch = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendBroadCast(param1:Boolean = false, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9522);
         var _loc3_:GoldenRoadClientRequestMsg = new GoldenRoadClientRequestMsg();
         _loc3_.requestBroadcast = param1;
         _loc3_.bagOPType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

