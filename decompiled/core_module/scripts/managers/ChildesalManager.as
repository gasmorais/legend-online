package managers
{
   import com.road.yishi.proto.childseal.ChildSealMsg;
   import com.road.yishi.proto.childseal.ChildSealRequestMsg;
   import com.road.yishi.proto.childseal.ChildSealRewardMsg;
   import events.ChildesalEvent;
   import mvc.module.childseal.ChildesalModel;
   import mvc.module.childseal.ChildesalRewardInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ChildesalManager
   {
      
      private static var _instance:ChildesalManager;
      
      private var _model:ChildesalModel;
      
      public function ChildesalManager()
      {
         super();
      }
      
      public static function get instance() : ChildesalManager
      {
         if(!_instance)
         {
            _instance = new ChildesalManager();
         }
         return _instance;
      }
      
      public function get model() : ChildesalModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ChildesalModel();
         }
         addEvent();
      }
      
      public function sendChildsealInfo(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9641);
         var _loc4_:ChildSealRequestMsg = new ChildSealRequestMsg();
         _loc4_.op = param1;
         _loc4_.sealId = 0;
         _loc4_.payType = 0;
         if(param1 == 1)
         {
            _loc4_.sealId = param2;
         }
         if(param1 > 1)
         {
            _loc4_.payType = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 420,__receiveChildsealInfo);
      }
      
      private function __receiveChildsealInfo(param1:SLGSocketEvent) : void
      {
         var _loc7_:ChildesalRewardInfo = null;
         var _loc4_:ChildSealRewardMsg = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildSealMsg = new ChildSealMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ChildSealMsg;
         _model.rewardList.length = 0;
         _model.starCount = _loc2_.star;
         _model.countNum = _loc2_.count;
         _model.sealsList = _loc2_.seals;
         _model.invokeList = _loc2_.activatedSeals;
         _model.choseList = _loc2_.optionSeals;
         var _loc3_:int = int(_loc2_.rewards.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.rewards[_loc5_];
            _loc7_ = new ChildesalRewardInfo();
            _loc7_.starNum = _loc4_.needStar;
            _loc7_.templateId = _loc4_.templateId;
            _loc7_.count = _loc4_.count;
            _loc7_.isGet = _loc4_.isGet;
            _model.rewardList.push(_loc7_);
            _loc5_ += 1;
         }
         _model.rewardList.sort(infoSortFuncDesc);
         if(_model.countNum < _model.maxCount)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CHILD_ESAL_EFFECT",{"open":true}));
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CHILD_ESAL_EFFECT",{"open":false}));
         }
         _model.dispatchEvent(new ChildesalEvent("CHILDSEAL_INFO_UP_DATA"));
      }
      
      private function infoSortFuncDesc(param1:ChildesalRewardInfo, param2:ChildesalRewardInfo) : int
      {
         if(param1.starNum < param2.starNum)
         {
            return -1;
         }
         if(param1.starNum > param2.starNum)
         {
            return 1;
         }
         return 0;
      }
   }
}

