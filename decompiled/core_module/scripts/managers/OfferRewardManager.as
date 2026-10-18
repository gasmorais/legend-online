package managers
{
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.player.RewardCountUpdateRspMsg;
   import com.road.yishi.proto.reward.RewardAddedMsg;
   import com.road.yishi.proto.reward.RewardArrestMsg;
   import com.road.yishi.proto.reward.RewardFinishedReqMsg;
   import com.road.yishi.proto.reward.RewardFreshReqMsg;
   import com.road.yishi.proto.reward.RewardFreshRspMsg;
   import com.road.yishi.proto.reward.RewardInfo;
   import com.road.yishi.proto.reward.RewardRemovedMsg;
   import com.road.yishi.proto.reward.RewardUpdatedRspMsg;
   import events.RewardEvent;
   import flash.events.EventDispatcher;
   import mvc.controler.OfferRewardController;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.offerreward.BaseOfferReward;
   import ui.gameroll.TaskGainMovie;
   import yishi.actions.task.NewTaskAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.SimpleDictionary;
   
   public class OfferRewardManager extends EventDispatcher
   {
      
      private static var _instance:OfferRewardManager;
      
      private var _model:OfferRewardModel;
      
      public var isAllFinish:Boolean;
      
      public function OfferRewardManager()
      {
         super();
      }
      
      public static function get instance() : OfferRewardManager
      {
         if(!_instance)
         {
            _instance = new OfferRewardManager();
         }
         return _instance;
      }
      
      public function get model() : OfferRewardModel
      {
         return _model;
      }
      
      public function get controller() : OfferRewardController
      {
         return FrameControllerManager.instance.offerRewardController;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new OfferRewardModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4198,__updateRewardHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4197,__refreshRewardListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4360,__updateRewardCountHandler);
      }
      
      private function __updateRewardCountHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardCountUpdateRspMsg = new RewardCountUpdateRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RewardCountUpdateRspMsg;
         model.maxRewardCount = 20 + _loc2_.rewardCount;
         DayGuideManager.instance.maxRewardCount = model.maxRewardCount;
      }
      
      private function __updateRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:RewardInfo = null;
         var _loc6_:BaseOfferReward = null;
         var _loc7_:BaseOfferReward = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardUpdatedRspMsg = new RewardUpdatedRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as RewardUpdatedRspMsg;
         var _loc3_:int = int(_loc2_.reward.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.reward[_loc5_];
            if(_loc4_ && _loc4_.isSelect)
            {
               if(model.baseRewardDic[_loc4_.templateId])
               {
                  _loc6_ = model.baseRewardDic[_loc4_.templateId];
                  if(_loc4_.isComplete)
                  {
                     if(!isAllFinish)
                     {
                        TaskGainMovie.taskMovie(_loc6_);
                     }
                     if(_loc6_)
                     {
                        _loc6_.removeConditionListener();
                     }
                     model.baseRewardDic.del(_loc4_.templateId);
                     dispatchEvent(new RewardEvent("REWARD_TASK_FINISH",_loc6_));
                  }
                  else
                  {
                     _loc6_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
                     model.baseRewardDic[_loc4_.templateId].rewardInfo = _loc4_;
                     dispatchEvent(new RewardEvent("REWARD_TASK_UPDATE",model.baseRewardDic[_loc4_.templateId]));
                  }
               }
               else
               {
                  _loc7_ = new BaseOfferReward();
                  _loc7_.rewardID = _loc4_.templateId;
                  _loc7_.rewardInfo = _loc4_;
                  _loc7_.rewardTemp = getRewardTempByTempId(_loc4_.templateId);
                  model.baseRewardDic.add(_loc4_.templateId,_loc7_);
                  _loc7_.addConditionListener();
                  _loc7_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
                  dispatchEvent(new RewardEvent("REWARD_TASK_ADD",_loc7_));
                  dispatchEvent(new RewardEvent("REWARD_TASK_UPDATE",_loc7_));
                  if(!OfferRewardModel.isLogin)
                  {
                     DelayActionsUtils.instance.addAction(new NewTaskAction(_loc7_));
                  }
               }
            }
            _loc5_++;
         }
         OfferRewardModel.isLogin = false;
      }
      
      private function __refreshRewardListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardFreshRspMsg = new RewardFreshRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as RewardFreshRspMsg;
         if(_loc2_.hasRewardLastdate)
         {
            model.lastRefreshRewardListDate = DateFormatter.parse(_loc2_.rewardLastdate,"YYYY-MM-DD hh:mm:ss");
         }
         var _loc6_:SimpleDictionary = new SimpleDictionary();
         var _loc5_:SimpleDictionary = new SimpleDictionary();
         var _loc3_:SimpleDictionary = new SimpleDictionary();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.templateId.length)
         {
            _loc6_.add(_loc4_,getRewardTempByTempId(_loc2_.templateId[_loc4_]));
            _loc5_.add(_loc4_,_loc2_.isIsValid[_loc4_]);
            _loc3_.add(_loc4_,_loc2_.qualitys[_loc4_]);
            _loc4_++;
         }
         model.offerRewardTaskDic = _loc6_;
         model.offerRewardTaskStateDic = _loc5_;
         model.offerRewardTaskProfileDic = _loc3_;
         model.freeRefreshCount = _loc2_.freeTimes;
         thane.rewardCount = _loc2_.rewardTimes;
         if(model.isNeedReset)
         {
            model.isNeedReset = false;
         }
         dispatchEvent(new RewardEvent("OFFER_REWARD_LIST_REFRESH",null));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getRewardTempByTempId(param1:int) : OfferRewardTemplate
      {
         for each(var _loc2_:OfferRewardTemplate in model.rewardTempDic)
         {
            if(_loc2_.TemplateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function checkRewardExist(param1:int) : Boolean
      {
         return model.baseRewardDic[param1];
      }
      
      public function get completedRewardList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:BaseOfferReward in model.baseRewardDic)
         {
            if(_loc2_.isCompleted)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function sendAddRewardTask(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8288);
         var _loc2_:RewardAddedMsg = new RewardAddedMsg();
         _loc2_.rewardId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendRemoveRewardTask(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8289);
         var _loc2_:RewardRemovedMsg = new RewardRemovedMsg();
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendFinishRewardTask(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8291);
         var _loc3_:RewardFinishedReqMsg = new RewardFinishedReqMsg();
         _loc3_.templateId = param1;
         _loc3_.isPass = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendRefreshRewardList(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8290);
         var _loc3_:RewardFreshReqMsg = new RewardFreshReqMsg();
         _loc3_.isButton = param1;
         _loc3_.payType = 0;
         if(!param2)
         {
            _loc3_.payType = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAllFinishRequest(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(9583);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendRewardArrest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8298);
         var _loc3_:RewardArrestMsg = new RewardArrestMsg();
         _loc3_.condictionType = param1;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

