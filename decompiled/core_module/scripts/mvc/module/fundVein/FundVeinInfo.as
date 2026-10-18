package mvc.module.fundVein
{
   import com.road.yishi.proto.active.GradeRewardInfoMsg;
   import com.road.yishi.proto.active.LevelInfoMsg;
   import com.road.yishi.proto.active.LodeListMsg;
   import com.road.yishi.proto.active.RewardItemInfoMsg;
   import mvc.module.fund.ActiveParmaInfo;
   import yishi.manager.InfoTipsManager;
   
   public class FundVeinInfo
   {
      
      private var _msg:LodeListMsg;
      
      public var leveInfo:Array = [];
      
      public var totalTakedInfo:Array = [];
      
      public var isOver:Boolean = true;
      
      public var rewardAmount:int = 0;
      
      public function FundVeinInfo()
      {
         super();
      }
      
      public function set info(param1:LodeListMsg) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         clear();
         if(param1.hasIsOver)
         {
            this.isOver = param1.isOver;
         }
         _loc3_ = 0;
         _loc2_ = int(param1.leveInfo.length);
         while(_loc3_ < _loc2_)
         {
            this.leveInfo[_loc3_] = LevelInfoMsgToLevelInfo(param1.leveInfo[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         _loc5_ = int(param1.totalTakedInfo.length);
         while(_loc4_ < _loc5_)
         {
            this.totalTakedInfo[_loc4_] = RewardItemInfoMsgToRewardItemInfo(param1.totalTakedInfo[_loc4_]);
            _loc4_++;
         }
         InfoTipsManager.instance.dealData(22);
         setGridTipsData();
      }
      
      private function setGridTipsData() : void
      {
         var _loc4_:LevelInfo = null;
         var _loc1_:ActiveParmaInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         _loc2_ = int(this.leveInfo.length);
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new ActiveParmaInfo();
            _loc4_ = this.leveInfo[_loc3_];
            _loc1_.level = _loc4_.level;
            _loc1_.costDiamond = _loc4_.needPoint;
            _loc1_.harvestCount = _loc4_.infoMsg.length;
            _loc1_.totalGetInfo = _loc4_.allTakedInfo;
            _loc1_.getInfos = _loc4_.infoMsg;
            _loc4_.gridTipsData = _loc1_;
            _loc3_++;
         }
      }
      
      private function clear() : void
      {
         var _loc2_:LevelInfo = null;
         rewardAmount = 0;
         var _loc1_:int = this.leveInfo.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.leveInfo.pop();
            _loc2_.clear();
            _loc1_--;
         }
         totalTakedInfo.length = 0;
      }
      
      private function LevelInfoMsgToLevelInfo(param1:LevelInfoMsg) : LevelInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:LevelInfo = new LevelInfo();
         if(param1.hasNeedPoint)
         {
            _loc6_.needPoint = param1.needPoint;
         }
         if(param1.hasIsBuy)
         {
            _loc6_.isBuy = param1.isBuy;
         }
         if(param1.hasLevel)
         {
            _loc6_.level = param1.level;
         }
         _loc3_ = 0;
         _loc2_ = int(param1.infoMsg.length);
         while(_loc3_ < _loc2_)
         {
            _loc6_.infoMsg[_loc3_] = gradeRewardInfoMsgToGradeRewardInfo(param1.infoMsg[_loc3_],_loc6_.isBuy);
            if(GradeRewardInfo(_loc6_.infoMsg[_loc3_]).isGained)
            {
               rewardAmount = rewardAmount + 1;
            }
            _loc3_++;
         }
         _loc4_ = 0;
         _loc5_ = int(param1.allTakedInfo.length);
         while(_loc4_ < _loc5_)
         {
            _loc6_.allTakedInfo[_loc4_] = RewardItemInfoMsgToRewardItemInfo(param1.allTakedInfo[_loc4_]);
            _loc4_++;
         }
         return _loc6_;
      }
      
      private function gradeRewardInfoMsgToGradeRewardInfo(param1:GradeRewardInfoMsg, param2:Boolean) : GradeRewardInfo
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:GradeRewardInfo = new GradeRewardInfo();
         if(param1.hasNeedGrade)
         {
            _loc5_.needGrade = param1.needGrade;
         }
         if(param1.hasIsTaked)
         {
            _loc5_.isTaked = param1.isTaked;
         }
         if(param1.hasIndex)
         {
            _loc5_.index = param1.index;
         }
         _loc5_.isParentLevelBuy = param2;
         _loc4_ = 0;
         _loc3_ = int(param1.itemInfo.length);
         while(_loc4_ < _loc3_)
         {
            _loc5_.itemInfo[_loc4_] = RewardItemInfoMsgToRewardItemInfo(param1.itemInfo[_loc4_]);
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function RewardItemInfoMsgToRewardItemInfo(param1:RewardItemInfoMsg) : RewardItemInfo
      {
         var _loc2_:RewardItemInfo = new RewardItemInfo();
         if(param1.hasTempId)
         {
            _loc2_.tempId = param1.tempId;
         }
         if(param1.hasCount)
         {
            _loc2_.count = param1.count;
         }
         return _loc2_;
      }
   }
}

