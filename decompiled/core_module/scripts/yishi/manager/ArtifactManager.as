package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityMsg;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityOpMsg;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityResMsg;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityTemplateMsg;
   import com.road.yishi.proto.artifactgiftactivity.LotteryItemInfoMsg;
   import com.road.yishi.proto.step.StepListMsg;
   import com.road.yishi.proto.step.StepMsg;
   import flash.utils.Dictionary;
   import mvc.module.artifact.ArtifactBoxTempInfo;
   import mvc.module.artifact.ArtifactStepTempInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ArtifactManager
   {
      
      private static var _instance:ArtifactManager;
      
      private var _stepTempDic:Dictionary;
      
      private var _boxTempArr:Array;
      
      private var _rewardTempArr:Array;
      
      private var _activityMsg:ArtifactGiftActivityMsg;
      
      private const ARTIFACT:int = 1;
      
      public var openArtifact:Boolean;
      
      public var ARTIFACT_END_DATE:Date;
      
      public function ArtifactManager()
      {
         super();
      }
      
      public static function get instance() : ArtifactManager
      {
         if(!_instance)
         {
            _instance = new ArtifactManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 321,__stepTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 323,__boxTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 322,__activityMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 326,__activityOperateHandler);
      }
      
      private function __stepTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:StepMsg = null;
         var _loc4_:ArtifactStepTempInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:StepListMsg = new StepListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as StepListMsg;
         if(_loc2_.type == 0)
         {
            _stepTempDic = new Dictionary();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.step.length)
            {
               _loc3_ = _loc2_.step[_loc5_] as StepMsg;
               _loc4_ = new ArtifactStepTempInfo();
               _loc4_.id = _loc3_.id;
               _loc4_.name = _loc3_.name;
               _loc4_.type = _loc3_.type;
               _loc4_.step = _loc3_.step;
               _loc4_.value = _loc3_.value;
               if(_loc3_.type == 1)
               {
                  _stepTempDic[_loc4_.step] = _loc4_;
               }
               _loc5_++;
            }
         }
         else if(_loc2_.type == 1)
         {
            _stepTempDic = new Dictionary();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.step.length)
            {
               _loc3_ = _loc2_.step[_loc5_] as StepMsg;
               _loc4_ = new ArtifactStepTempInfo();
               _loc4_.id = _loc3_.id;
               _loc4_.name = _loc3_.name;
               _loc4_.type = _loc3_.type;
               _loc4_.step = _loc3_.step;
               _loc4_.value = _loc3_.value;
               _stepTempDic[_loc4_.step] = _loc4_;
               _loc5_++;
            }
         }
      }
      
      private function __boxTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:LotteryItemInfoMsg = null;
         var _loc3_:ArtifactBoxTempInfo = null;
         var _loc4_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactGiftActivityTemplateMsg = new ArtifactGiftActivityTemplateMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ArtifactGiftActivityTemplateMsg;
         _boxTempArr = [];
         _rewardTempArr = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.lotteryItem.length)
         {
            _loc5_ = _loc2_.lotteryItem[_loc4_] as LotteryItemInfoMsg;
            _loc3_ = new ArtifactBoxTempInfo();
            _loc3_.itemId = _loc5_.itemId;
            _loc3_.itemCount = _loc5_.itemCount;
            _loc3_.pos = _loc5_.pos;
            _boxTempArr.push(_loc3_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.rewardItem.length)
         {
            _loc5_ = _loc2_.rewardItem[_loc4_] as LotteryItemInfoMsg;
            _loc3_ = new ArtifactBoxTempInfo();
            _loc3_.itemId = _loc5_.itemId;
            _loc3_.itemCount = _loc5_.itemCount;
            _loc3_.pos = _loc5_.pos;
            _rewardTempArr.push(_loc3_);
            _loc4_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ARTIFACT_TEMP_REFRESH"));
         ARTIFACT_END_DATE = new Date(Int64Utils.int64ToNumber(_loc2_.endTime));
         if(_loc2_.open && playerModel.nowDate < ARTIFACT_END_DATE.time)
         {
            openArtifact = true;
         }
         else
         {
            openArtifact = false;
         }
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      private function __activityMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactGiftActivityMsg = new ArtifactGiftActivityMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArtifactGiftActivityMsg;
         _activityMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ARTIFACT_MSG_RECORD"));
      }
      
      private function __activityOperateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactGiftActivityResMsg = new ArtifactGiftActivityResMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArtifactGiftActivityResMsg;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ARTIFACT_MSG_RESULT",_loc2_));
      }
      
      public function get stepTempDic() : Dictionary
      {
         return _stepTempDic;
      }
      
      public function get boxTempArr() : Array
      {
         return _boxTempArr;
      }
      
      public function get rewardTempArr() : Array
      {
         return _rewardTempArr;
      }
      
      public function get activityMsg() : ArtifactGiftActivityMsg
      {
         return _activityMsg;
      }
      
      public function getMaxStep() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:ArtifactStepTempInfo in _stepTempDic)
         {
            if(_loc2_.step > _loc1_)
            {
               _loc1_ = _loc2_.step;
            }
         }
         return _loc1_;
      }
      
      public function getAllScore() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:ArtifactStepTempInfo in _stepTempDic)
         {
            _loc1_ += _loc2_.value;
         }
         return _loc1_;
      }
      
      public function getNextStepTemp(param1:int) : ArtifactStepTempInfo
      {
         for each(var _loc2_:ArtifactStepTempInfo in _stepTempDic)
         {
            if(_loc2_.step == param1 + 1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function getCurrentTotalScore(param1:int, param2:int) : int
      {
         var _loc4_:int = param2;
         for each(var _loc3_:ArtifactStepTempInfo in _stepTempDic)
         {
            if(_loc3_.step <= param1)
            {
               _loc4_ += _loc3_.value;
            }
         }
         return _loc4_;
      }
      
      public function OperateArtifact(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9580);
         var _loc2_:ArtifactGiftActivityOpMsg = new ArtifactGiftActivityOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

