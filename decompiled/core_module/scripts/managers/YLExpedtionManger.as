package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.childpatrol.ChildCampInfoMsg;
   import com.road.yishi.proto.childpatrol.ChildCampListMsg;
   import com.road.yishi.proto.childpatrol.ChildCampTimeInfoMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class YLExpedtionManger
   {
      
      private static var _instance:YLExpedtionManger;
      
      private var _model:YLExpedtionModel;
      
      public function YLExpedtionManger()
      {
         super();
      }
      
      public static function get instance() : YLExpedtionManger
      {
         if(!_instance)
         {
            _instance = new YLExpedtionManger();
         }
         return _instance;
      }
      
      public function get model() : YLExpedtionModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new YLExpedtionModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4215,__updateInfoHandler);
      }
      
      private function __updateInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ChildCampInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildCampListMsg = new ChildCampListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ChildCampListMsg;
         var _loc3_:int = _loc2_.op;
         for each(var _loc6_:ChildCampInfoMsg in _loc2_.campList)
         {
            _loc4_ = _model.camp_list[_loc6_.id];
            if(_loc4_ == null)
            {
               _loc4_ = new ChildCampInfo();
               _model.camp_list[_loc6_.id] = _loc4_;
            }
            _loc4_.id = _loc6_.id;
            _loc4_.grade = _loc6_.grade;
            _loc4_.nowExp = _loc6_.nowExp;
            _loc4_.childId = _loc6_.childId;
            _loc4_.difficulty = _loc6_.difficulty;
            _loc4_.sneakCount = _loc6_.sneakCount;
            _loc4_.defenseCount = _loc6_.defenseCount;
            _loc4_.startTime = Int64Utils.int64ToNumber(_loc6_.startTime);
            _loc4_.sneakTime = Int64Utils.int64ToNumber(_loc6_.sneakTime);
            _loc4_.isCover = _loc6_.isCover;
         }
         for each(var _loc5_:ChildCampTimeInfoMsg in _loc2_.childList)
         {
            _model.child_list[_loc5_.childId] = Int64Utils.int64ToNumber(_loc5_.overTime);
         }
         NotificationManager.instance.sendNotification("YLExpedtionModel.EVENT_UPDATE_INFO");
      }
      
      public function sendOp(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9018);
         var _loc5_:PropertyMsg = new PropertyMsg();
         _loc5_.param1 = param1;
         _loc5_.param2 = param2;
         _loc5_.param3 = param3;
         _loc5_.param10 = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

