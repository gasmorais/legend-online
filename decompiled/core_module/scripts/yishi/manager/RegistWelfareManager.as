package yishi.manager
{
   import com.road.yishi.proto.active.ItemBoxChainIndexListMsg;
   import com.road.yishi.proto.active.ItemBoxChainMsg;
   import com.road.yishi.proto.active.ItemBoxChainReqMsg;
   import com.road.yishi.proto.active.ItemBoxChainTemplateMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskListMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskRecordListMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskRecordMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskReqMsg;
   import com.road.yishi.proto.simpletask.SimpleTaskRewardMsg;
   import flash.utils.Dictionary;
   import mvc.module.registwelfare.ItemBoxIndexInfo;
   import mvc.module.registwelfare.ItemBoxInfo;
   import mvc.module.registwelfare.SimpleTaskInfo;
   import mvc.module.registwelfare.SimpleTaskRecordInfo;
   import mvc.module.registwelfare.SimpleTaskRewardInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class RegistWelfareManager
   {
      
      private static var _instance:RegistWelfareManager;
      
      private var _itemBoxIdx:int;
      
      private var _itemBoxCate:Dictionary;
      
      private var _boxLinkCate:Dictionary;
      
      private var _endDate:Date;
      
      private var _stone:int;
      
      private var _fashion:int;
      
      private var _mount:int;
      
      public const TYPE_GEM:int = 1;
      
      public const TYPE_FASHION:int = 2;
      
      public const TYPE_MOUNT:int = 3;
      
      private var _simpleTaskDic:Dictionary;
      
      private var _recordListDic:Dictionary;
      
      public function RegistWelfareManager()
      {
         super();
         _recordListDic = new Dictionary();
      }
      
      public static function get instance() : RegistWelfareManager
      {
         if(!_instance)
         {
            _instance = new RegistWelfareManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 261,__chainBoxHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 265,__taskMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 266,__taskRecordHandler);
      }
      
      private function __chainBoxHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ItemBoxChainMsg = null;
         var _loc3_:ItemBoxChainIndexListMsg = null;
         var _loc8_:ItemBoxInfo = null;
         var _loc6_:ItemBoxIndexInfo = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:ItemBoxChainTemplateMsg = new ItemBoxChainTemplateMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as ItemBoxChainTemplateMsg;
         _itemBoxCate = new Dictionary();
         _boxLinkCate = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.itemBoxChainMsg.length)
         {
            _loc5_ = _loc2_.itemBoxChainMsg[_loc4_] as ItemBoxChainMsg;
            _loc8_ = new ItemBoxInfo();
            _loc8_.id = _loc5_.id;
            _loc8_.type = _loc5_.type;
            _loc8_.price = _loc5_.price;
            _loc8_.items = _loc5_.items;
            _loc8_.preId = _loc5_.preId;
            _loc8_.nextId = _loc5_.nextId;
            _itemBoxCate[_loc8_.id] = _loc8_;
            _loc4_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc2_.itemBoxChainIndexList.length)
         {
            _loc3_ = _loc2_.itemBoxChainIndexList[_loc7_] as ItemBoxChainIndexListMsg;
            _loc6_ = new ItemBoxIndexInfo();
            _loc6_.type = _loc3_.type;
            _loc6_.itemIds = [];
            for each(var _loc10_:int in _loc3_.itemBoxId)
            {
               _loc6_.itemIds.push(_loc10_);
            }
            _boxLinkCate[_loc6_.type] = _loc6_;
            _loc7_++;
         }
      }
      
      private function __taskMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:SimpleTaskMsg = null;
         var _loc10_:SimpleTaskRewardMsg = null;
         var _loc5_:SimpleTaskInfo = null;
         var _loc6_:SimpleTaskRewardInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimpleTaskListMsg = new SimpleTaskListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as SimpleTaskListMsg;
         _simpleTaskDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.simpleTask.length)
         {
            _loc8_ = _loc2_.simpleTask[_loc3_] as SimpleTaskMsg;
            _loc5_ = new SimpleTaskInfo();
            _loc5_.taskId = _loc8_.taskId;
            _loc5_.type = _loc8_.type;
            _loc5_.detail = _loc8_.detail;
            _loc5_.extraRewardCost = _loc8_.extraRewardCost;
            _loc5_.generalReward = [];
            _loc5_.extraReward = [];
            _loc4_ = 0;
            while(_loc4_ < _loc8_.generalReward.length)
            {
               _loc10_ = _loc8_.generalReward[_loc4_] as SimpleTaskRewardMsg;
               _loc6_ = new SimpleTaskRewardInfo();
               _loc6_.rewardItemID = _loc10_.rewardItemID;
               _loc6_.rewardItemCount = _loc10_.rewardItemCount;
               _loc6_.toJob = _loc10_.toJob;
               _loc5_.generalReward.push(_loc6_);
               _loc4_++;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc8_.extraReward.length)
            {
               _loc10_ = _loc8_.extraReward[_loc9_] as SimpleTaskRewardMsg;
               _loc6_ = new SimpleTaskRewardInfo();
               _loc6_.rewardItemID = _loc10_.rewardItemID;
               _loc6_.rewardItemCount = _loc10_.rewardItemCount;
               _loc6_.toJob = _loc10_.toJob;
               _loc5_.extraReward.push(_loc6_);
               _loc9_++;
            }
            _simpleTaskDic[_loc5_.taskId] = _loc5_;
            _loc3_++;
         }
      }
      
      private function __taskRecordHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:SimpleTaskRecordMsg = null;
         var _loc4_:SimpleTaskRecordInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimpleTaskRecordListMsg = new SimpleTaskRecordListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SimpleTaskRecordListMsg;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.simpleTaskRecord.length)
         {
            _loc3_ = _loc2_.simpleTaskRecord[_loc5_] as SimpleTaskRecordMsg;
            _loc4_ = _recordListDic[_loc3_.taskId];
            if(!_loc4_)
            {
               _loc4_ = new SimpleTaskRecordInfo();
            }
            _loc4_.taskId = _loc3_.taskId;
            _loc4_.taskState = _loc3_.taskState;
            _recordListDic[_loc4_.taskId] = _loc4_;
            _loc5_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REGIST_TASK_RECORD"));
         InfoTipsManager.instance.dealData(28);
      }
      
      public function get generalRewardNum() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:SimpleTaskRecordInfo in _recordListDic)
         {
            if(_loc2_.taskState == 1)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get simpleTaskDic() : Dictionary
      {
         return _simpleTaskDic;
      }
      
      public function get recordListDic() : Dictionary
      {
         return _recordListDic;
      }
      
      public function getSimpleTaskDic(param1:int) : SimpleTaskInfo
      {
         return _simpleTaskDic[param1];
      }
      
      public function openChainBuy(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9561);
         var _loc2_:ItemBoxChainReqMsg = new ItemBoxChainReqMsg();
         _loc2_.itemBoxId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function receiveHandler(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9564);
         var _loc3_:SimpleTaskReqMsg = new SimpleTaskReqMsg();
         _loc3_.taskId = param1;
         _loc3_.rewardType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function increaseHandler(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9564);
         var _loc3_:SimpleTaskReqMsg = new SimpleTaskReqMsg();
         _loc3_.taskId = param1;
         _loc3_.rewardType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function getItemBoxByType(param1:int) : ItemBoxInfo
      {
         var _loc4_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc4_ = stone;
               break;
            case 1:
               _loc4_ = fashion;
               break;
            case 2:
               _loc4_ = mount;
         }
         if(_loc4_ == -1)
         {
            return null;
         }
         if(!_boxLinkCate)
         {
            return null;
         }
         var _loc2_:int = int(_boxLinkCate[param1].itemIds[_loc4_]);
         return _itemBoxCate[_loc2_];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get endDate() : Date
      {
         return _endDate;
      }
      
      public function set endDate(param1:Date) : void
      {
         _endDate = param1;
      }
      
      public function get stone() : int
      {
         return _stone;
      }
      
      public function set stone(param1:int) : void
      {
         _stone = param1;
      }
      
      public function get fashion() : int
      {
         return _fashion;
      }
      
      public function set fashion(param1:int) : void
      {
         _fashion = param1;
      }
      
      public function get mount() : int
      {
         return _mount;
      }
      
      public function set mount(param1:int) : void
      {
         _mount = param1;
      }
   }
}

