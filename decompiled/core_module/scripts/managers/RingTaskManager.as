package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.reward.RewardInfo;
   import com.road.yishi.proto.reward.RewardUpdatedRspMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import events.RingTaskEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.ringtask.RingTask;
   import mvc.module.ringtask.RingTaskModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.datas.templates.OfferRewardGoodsTemplate;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   
   public class RingTaskManager extends EventDispatcher
   {
      
      public static var isTask:Boolean = false;
      
      private static var _instance:RingTaskManager;
      
      private var _model:RingTaskModel;
      
      private var _unfinishedTaskArr:Array;
      
      public var _isRingTask:Boolean = false;
      
      public var _defaultList:SimpleDictionary;
      
      public function RingTaskManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : RingTaskManager
      {
         if(!_instance)
         {
            _instance = new RingTaskManager();
         }
         return _instance;
      }
      
      public function get model() : RingTaskModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new RingTaskModel();
         }
         initUnfinishedTask();
         _defaultList = new SimpleDictionary();
         initEvent();
      }
      
      private function initUnfinishedTask() : void
      {
         _unfinishedTaskArr = [];
         var _loc2_:Dictionary = TempleteManager.instance.offerRewardTemplateDic;
         for each(var _loc1_:OfferRewardTemplate in _loc2_)
         {
            if(_loc1_.Type == 3)
            {
               _unfinishedTaskArr.push(_loc1_);
            }
         }
      }
      
      public function getOfferTemplete() : RingTask
      {
         var _loc2_:RingTask = null;
         var _loc1_:OfferRewardTemplate = null;
         var _loc4_:int = 0;
         var _loc3_:int = ArmyManager.instance.thane.grades;
         _loc4_ = 0;
         while(_loc4_ < _unfinishedTaskArr.length)
         {
            _loc1_ = _unfinishedTaskArr[_loc4_];
            if(_loc3_ >= _loc1_.NeedMinLevel && _loc3_ < _loc1_.NeedMaxLevel)
            {
               _loc2_ = new RingTask();
               _loc2_.ringTaskTemp = _loc1_;
               _loc2_.currTaskId = _loc1_.TemplateId;
               _loc2_.rewardGoodsList = getRewardGoods(200);
               return _loc2_;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4617,__finishTaskHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4614,__refreshTaskHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4615,__finishAllTaskHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4616,__refreshRingNumHandler);
      }
      
      private function __finishTaskHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __refreshTaskHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:RewardInfo = null;
         var _loc6_:RingTask = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardUpdatedRspMsg = new RewardUpdatedRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as RewardUpdatedRspMsg;
         var _loc3_:int = int(_loc2_.reward.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.reward[_loc5_];
            if(model.hasAccessList[_loc4_.templateId])
            {
               _loc6_ = model.hasAccessList[_loc4_.templateId];
               _loc6_.isNew = false;
               if(_loc4_.isComplete)
               {
                  if(_loc6_)
                  {
                     _loc6_.removeConditionListener();
                  }
                  model.hasAccessList.del(_loc4_.templateId);
                  dispatchEvent(new RingTaskEvent("COMPLETETASK",_loc6_));
               }
               else
               {
                  _loc6_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
                  model.hasAccessList[_loc4_.templateId].currTask = _loc4_;
               }
            }
            else
            {
               _loc6_ = new RingTask();
               _loc6_.currTaskId = _loc4_.templateId;
               _loc6_.ringTaskTemp = getRewardTempByTempId(_loc4_.templateId);
               _loc6_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               _loc6_.currTask = _loc4_;
               model.hasAccessList.add(_loc4_.templateId,_loc6_);
               _loc6_.addConditionListener();
               _loc6_.isNew = true;
               if(model.rewardNum % 10 == 0)
               {
                  _loc6_.rewardGoodsList = getRewardGoods(model.rewardNum);
               }
               dispatchEvent(new RingTaskEvent("ADDRINGTASK",_loc6_));
            }
            _loc5_++;
         }
         dispatchEvent(new RingTaskEvent("REFRESHTING",_loc6_));
      }
      
      private function __finishAllTaskHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __refreshRingNumHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.rewardNum = _loc2_.param1;
         updateRingTaskMsg();
      }
      
      public function updateRingTaskMsg() : void
      {
         var _loc1_:RingTask = null;
         var _loc3_:int = 0;
         var _loc2_:RingTask = null;
         var _loc4_:RingTask = null;
         if(model.rewardNum > 200)
         {
            _loc1_ = getOfferTemplete();
            _defaultList.del(_loc1_.ringTaskTemp.TemplateId);
         }
         else
         {
            _defaultList.clear();
            _loc3_ = ArmyManager.instance.thane.grades;
            if(_loc3_ < 35)
            {
               return;
            }
            _loc2_ = getOfferTemplete();
            if(!_loc2_)
            {
               return;
            }
            _loc2_.ringTaskTemp.Title = LanguageMgr.GetTranslation("managers.RingTaskManager.taskTitle");
            if(_loc3_ >= 35 && _loc3_ < 45)
            {
               _loc2_.ringTaskTemp.RewardGold = 400000;
               _loc2_.ringTaskTemp.RewardStrategy = 2000000;
            }
            else if(_loc3_ >= 45 && _loc3_ < 55)
            {
               _loc2_.ringTaskTemp.RewardGold = 480000;
               _loc2_.ringTaskTemp.RewardStrategy = 2400000;
            }
            else if(_loc3_ >= 55 && _loc3_ < 65)
            {
               _loc2_.ringTaskTemp.RewardGold = 600000;
               _loc2_.ringTaskTemp.RewardStrategy = 3000000;
            }
            else if(_loc3_ >= 65 && _loc3_ < 100)
            {
               _loc2_.ringTaskTemp.RewardGold = 800000;
               _loc2_.ringTaskTemp.RewardStrategy = 4000000;
            }
            _loc2_.rewardGoodsList = getRewardGoods(10);
            _defaultList.add(_loc2_.ringTaskTemp.TemplateId,_loc2_);
            dispatchEvent(new RingTaskEvent("REFRESHTING",_loc2_));
         }
         if(model.rewardNum % 10 == 0)
         {
            _loc4_ = getRingTask();
            if(_loc4_)
            {
               _loc4_.rewardGoodsList = getRewardGoods(model.rewardNum);
            }
         }
      }
      
      public function accessRingTask() : void
      {
         var _loc1_:PackageOut = new PackageOut(8732);
         sendProtoBuffer(_loc1_);
      }
      
      public function submitRingTask() : void
      {
         var _loc1_:PackageOut = new PackageOut(8729);
         sendProtoBuffer(_loc1_);
      }
      
      public function CompletedImmediately(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8730);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1 ? 0 : 1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function updataState() : void
      {
         var _loc1_:PackageOut = new PackageOut(8731);
         sendProtoBuffer(_loc1_);
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public function getRewardGoods(param1:int) : Array
      {
         var _loc9_:OfferRewardGoodsTemplate = null;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc2_:Array = TempleteManager.instance.offerRewardGoodsTemplateList;
         var _loc4_:int = int(_loc2_.length);
         var _loc6_:int = ArmyManager.instance.thane.grades;
         var _loc5_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = _loc2_[_loc7_] as OfferRewardGoodsTemplate;
            _loc3_ = _loc9_.RepeatStep.split(",");
            if(getFlag(_loc3_,param1))
            {
               if(_loc6_ >= _loc9_.RepeatMinLevel && _loc6_ < _loc9_.RepeatMaxLevel)
               {
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = _loc9_.RewardItemID;
                  _loc8_.count = _loc9_.RewardItemCount;
                  _loc5_.push(_loc8_);
               }
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function getRewardGoodsTemp(param1:RingTask) : Array
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc10_:OfferRewardGoodsTemplate = null;
         var _loc4_:Array = null;
         var _loc7_:int = 0;
         var _loc5_:RingTask = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Array = [];
         if(param1)
         {
            _loc3_ = TempleteManager.instance.offerRewardGoodsTemplateList;
            _loc6_ = int(_loc3_.length);
            _loc7_ = ArmyManager.instance.thane.grades;
            _loc5_ = getRingTask();
            _loc8_ = int(_loc5_ ? model.rewardNum : 200);
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               _loc10_ = _loc3_[_loc9_] as OfferRewardGoodsTemplate;
               _loc4_ = _loc10_.RepeatStep.split(",");
               if(getFlag(_loc4_,_loc8_))
               {
                  if(_loc7_ >= _loc10_.RepeatMinLevel && _loc7_ < _loc10_.RepeatMaxLevel)
                  {
                     _loc2_.push(_loc10_);
                  }
               }
               _loc9_++;
            }
         }
         return _loc2_;
      }
      
      public function getAllRingTaskGoodsReward() : Array
      {
         var _loc7_:OfferRewardGoodsTemplate = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = TempleteManager.instance.offerRewardGoodsTemplateList;
         var _loc4_:int = int(_loc2_.length);
         var _loc5_:int = ArmyManager.instance.thane.grades;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc2_[_loc6_] as OfferRewardGoodsTemplate;
            _loc3_ = _loc7_.RepeatStep.split(",");
            if(getFlag(_loc3_,10))
            {
               if(_loc5_ >= _loc7_.RepeatMinLevel && _loc5_ < _loc7_.RepeatMaxLevel)
               {
                  _loc1_.push(_loc7_);
               }
            }
            if(getFlag(_loc3_,50))
            {
               if(_loc5_ >= _loc7_.RepeatMinLevel && _loc5_ < _loc7_.RepeatMaxLevel)
               {
                  _loc1_.push(_loc7_);
               }
            }
            if(getFlag(_loc3_,200))
            {
               if(_loc5_ >= _loc7_.RepeatMinLevel && _loc5_ < _loc7_.RepeatMaxLevel)
               {
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         return _loc1_;
      }
      
      public function getRewardTempByTempId(param1:int) : OfferRewardTemplate
      {
         for each(var _loc2_:OfferRewardTemplate in OfferRewardManager.instance.model.rewardTempDic)
         {
            if(_loc2_.TemplateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getFlag(param1:Array, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getRingTask() : RingTask
      {
         var _loc2_:Dictionary = model.hasAccessList;
         var _loc4_:int = 0;
         var _loc3_:Dictionary = _loc2_;
         for each(var _loc1_:RingTask in _loc3_)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function getRingTaskType() : int
      {
         var _loc1_:OfferRewardConditionTemplate = getCurrCondition();
         if(!_loc1_)
         {
            return -10;
         }
         return _loc1_.CondictionType;
      }
      
      public function getCurrCondition() : OfferRewardConditionTemplate
      {
         var _loc3_:RingTask = getRingTask();
         if(!_loc3_)
         {
            return null;
         }
         var _loc1_:Array = _loc3_.conditionList;
         return _loc1_[0];
      }
      
      public function getTalkTaskNPCNode() : int
      {
         var _loc3_:RingTask = getRingTask();
         if(!_loc3_)
         {
            return -100;
         }
         var _loc1_:Array = _loc3_.ringTaskTemp.conditionList;
         var _loc2_:OfferRewardConditionTemplate = _loc1_[0];
         if(_loc2_.CondictionType == 16)
         {
            return _loc2_.Para1;
         }
         return -100;
      }
      
      public function hasTaskAndNotCompleted(param1:int) : Boolean
      {
         var _loc2_:RingTask = getRingTask();
         if(!_loc2_)
         {
            return false;
         }
         if(param1 == _loc2_.ringTaskTemp.TemplateId)
         {
            return !_loc2_.isCompleted;
         }
         return false;
      }
   }
}

