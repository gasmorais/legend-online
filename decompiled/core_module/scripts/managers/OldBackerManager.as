package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.oldbacker.OldBackerInfoMsg;
   import com.road.yishi.proto.oldbacker.OldBackerMsg;
   import mvc.module.oldbacker.OldBackerModel;
   import mvc.module.oldbacker.OldBackerViewInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class OldBackerManager
   {
      
      private static var _instance:OldBackerManager;
      
      public static const OP_SELECT:int = 1;
      
      public static const OP_SIGNKEY:int = 2;
      
      public static const OP_TAKEREWARD:int = 3;
      
      public static const OP_REWARDBUFF:int = 4;
      
      public static const TYPE_0:int = 0;
      
      public static const TYPE_1:int = 1;
      
      public static const TYPE_2:int = 2;
      
      public static const TYPE_3:int = 3;
      
      public static const TYPE_4:int = 4;
      
      public static const TYPE_5:int = 5;
      
      private var _model:OldBackerModel;
      
      public function OldBackerManager()
      {
         super();
         if(!_model)
         {
            _model = new OldBackerModel();
         }
      }
      
      public static function get instance() : OldBackerManager
      {
         if(!_instance)
         {
            _instance = new OldBackerManager();
         }
         return _instance;
      }
      
      public function get model() : OldBackerModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      public function sendInfo(param1:int, param2:int = 0, param3:String = "", param4:int = 1) : void
      {
         var _loc6_:PackageOut = new PackageOut(9666);
         var _loc5_:OldBackerMsg = new OldBackerMsg();
         _loc5_.op = param1;
         _loc5_.templateId = param2;
         _loc5_.signKey = param3;
         _loc5_.backerType = param4;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4843,__oldbackerInfoHandler);
      }
      
      private function __oldbackerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:OldBackerInfoMsg = null;
         var _loc3_:OldBackerViewInfo = null;
         var _loc6_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:OldBackerMsg = new OldBackerMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as OldBackerMsg;
         _model.openTime = _loc2_.openTime;
         _model.stopTime = _loc2_.stopTime;
         _model.backerType = _loc2_.backerType;
         _model.isOpenNewSvr = _loc2_.isOpenNewSvr;
         _model.needGrades = _loc2_.needGrades;
         if(_loc2_.openState == 1 && _model.openState != _loc2_.openState)
         {
            _model.openState = _loc2_.openState;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_OLDBACKER_SHOW"));
         }
         _model.singKey = _loc2_.signKey;
         _model.isUseKey = _loc2_.isUseSignKey;
         _model.isTakeBuffer = _loc2_.isTakeBuffer;
         _model.chargeTotalCount = _loc2_.chargeTotalCount;
         _model.viewInfoList = [];
         var _loc4_:int = int(_loc2_.info.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc2_.info[_loc6_];
            _loc3_ = new OldBackerViewInfo();
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.templateName = _loc5_.templateName;
            _loc3_.rewardTypes = _loc5_.rewardTypes;
            _loc3_.rewardLevel = _loc5_.rewardLevel;
            _loc3_.needPoints = _loc5_.needPoints;
            _loc3_.needGrades = _loc5_.needGrades;
            _loc3_.needLoginDay = _loc5_.needLoginDay;
            _loc3_.needCounts = _loc5_.needCounts;
            _loc3_.rewardItems = _loc5_.rewardItems;
            _loc3_.description = _loc5_.description;
            _loc3_.rewardState = _loc5_.rewardState;
            _model.viewInfoList.push(_loc3_);
            _loc6_ += 1;
         }
         _model.commit();
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

