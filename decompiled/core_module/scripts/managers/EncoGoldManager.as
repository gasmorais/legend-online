package managers
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.sumpassion.EncoDayMsg;
   import com.road.yishi.proto.sumpassion.EncoGoldListMsg;
   import events.EncoGoldEvents;
   import mvc.module.encoGold.EncoGoldItemInfo;
   import mvc.module.encoGold.EncoGoldModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class EncoGoldManager
   {
      
      private static var _instance:EncoGoldManager;
      
      private var _model:EncoGoldModel;
      
      public function EncoGoldManager()
      {
         super();
      }
      
      public static function get instance() : EncoGoldManager
      {
         if(!_instance)
         {
            _instance = new EncoGoldManager();
         }
         return _instance;
      }
      
      public function get model() : EncoGoldModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new EncoGoldModel();
         }
         addEvent();
      }
      
      public function sendSeverInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(9643);
         SocketSendManager.instance.send(_loc1_);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 421,__receiveOpenInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 422,__receiveInfo);
      }
      
      private function __receiveOpenInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.isOpen = _loc2_.param7;
         MsgMan.notifyObserver("ENCO_GOLD_OPENSTATE_UPDTAE");
      }
      
      private function __receiveInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:EncoDayMsg = null;
         var _loc6_:EncoGoldItemInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:EncoGoldListMsg = new EncoGoldListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as EncoGoldListMsg;
         model.stratTime = _loc2_.openTime;
         model.stopTime = _loc2_.stopTime;
         model.totalTakePoint = _loc2_.totalTakePoint;
         model.totalBackPoint = _loc2_.totalBackPoint;
         model.limitConsumePoint = _loc2_.limitConsumePoint;
         model.maxBackPoint = _loc2_.maxBackPoint;
         model.limitBackPer = _loc2_.limitBackPer;
         model.maxBackPer = _loc2_.maxBackPer;
         var _loc3_:int = int(_loc2_.dayMsg.length);
         var _loc5_:int = 0;
         model.dayMsgList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.dayMsg[_loc5_];
            _loc6_ = new EncoGoldItemInfo();
            _loc6_.dayStr = _loc4_.dayStr;
            _loc6_.type = _loc4_.encoType;
            _loc6_.isDouble = _loc4_.isDouble;
            _loc6_.isTaked = _loc4_.isTaked;
            _loc6_.takePoint = _loc4_.takePoint;
            _loc6_.consumPoint = _loc4_.consumPoint;
            model.dayMsgList.push(_loc6_);
            _loc5_ += 1;
         }
         model.dayMsgList.sort(infoSortFuncDesc);
         _loc3_ = int(model.dayMsgList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = model.dayMsgList[_loc5_];
            if(_loc6_.dayStr == toDayStr)
            {
               model.currentDay = _loc5_ + 1;
               break;
            }
            _loc5_ += 1;
         }
         model.dispatchEvent(new EncoGoldEvents("ENCO_GOLD_INFO_UP_DATA"));
      }
      
      private function get toDayStr() : String
      {
         var _loc6_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc1_:Date = new Date(_loc6_ * 1000);
         var _loc5_:String = String(_loc1_.fullYear);
         var _loc4_:String = _loc1_.month + 1 >= 10 ? String(_loc1_.month + 1) : "0" + (_loc1_.month + 1);
         var _loc2_:String = _loc1_.date >= 10 ? String(_loc1_.date) : "0" + _loc1_.date;
         return _loc5_ + "-" + _loc4_ + "-" + _loc2_;
      }
      
      private function infoSortFuncDesc(param1:EncoGoldItemInfo, param2:EncoGoldItemInfo) : int
      {
         var _loc3_:Number = DateFormatter.parse(param1.dayStr,"YYYY-MM-DD").time;
         var _loc4_:Number = DateFormatter.parse(param2.dayStr,"YYYY-MM-DD").time;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}

