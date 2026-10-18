package managers
{
   import com.road.yishi.proto.activitydaily.ActivityDailyData;
   import com.road.yishi.proto.activitydaily.ActivityDailyFinishedReqMsg;
   import com.road.yishi.proto.activitydaily.ActivityDailyRspMsg;
   import com.road.yishi.proto.activitydaily.ActivityDailyUpdatedRspMsg;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.NewActiveLeedInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class NewActiveLeedManager
   {
      
      private static var _instance:NewActiveLeedManager;
      
      public static const OP_OPEN:int = 1;
      
      private var _model:NewActiveLeedModel;
      
      public function NewActiveLeedManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : NewActiveLeedManager
      {
         if(!_instance)
         {
            _instance = new NewActiveLeedManager();
         }
         return _instance;
      }
      
      public function get model() : NewActiveLeedModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new NewActiveLeedModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 529,__activityUpdateHandler);
      }
      
      private function __activityUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:NewActiveLeedInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActivityDailyUpdatedRspMsg = new ActivityDailyUpdatedRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ActivityDailyUpdatedRspMsg;
         if(_loc2_.hasBuffStopDate)
         {
            model.buffTime = _loc2_.buffStopDate;
         }
         if(_loc2_.hasVipNum)
         {
            model.vipNum = _loc2_.vipNum;
         }
         for each(var _loc4_:ActivityDailyData in _loc2_.activityDailyData)
         {
            _loc6_ = TempleteManager.instance.newActiveLeedCate.getInfoByTaskType(_loc4_.masterType,_loc4_.sonType,_loc4_.taskType);
            if(_loc6_)
            {
               _loc6_.curCount = _loc4_.currentCount;
               _loc6_.isComplete = _loc4_.isComplete;
            }
         }
         for each(var _loc3_:ActivityDailyRspMsg in _loc2_.activityDaily)
         {
            model.dailyArr.add(_loc3_.masterType,_loc3_);
         }
         MsgMan.notifyObserver("NEW_ACTIVELEED_UPDATE");
      }
      
      public function sendGetReward(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(9707);
         var _loc4_:ActivityDailyFinishedReqMsg = new ActivityDailyFinishedReqMsg();
         _loc4_.masterType = param1;
         _loc4_.index = param2;
         _loc4_.isWeek = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendBuyBuff() : void
      {
         var _loc1_:PackageOut = new PackageOut(9708);
         SocketManager.instance.socket.send(_loc1_);
      }
   }
}

