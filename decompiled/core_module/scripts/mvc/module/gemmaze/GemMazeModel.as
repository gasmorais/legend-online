package mvc.module.gemmaze
{
   import com.road.yishi.proto.minigame.DropItemInfoMsg;
   import com.road.yishi.proto.minigame.GemInfoMsg;
   import com.road.yishi.proto.minigame.GemInfoUpdateMsg;
   import com.road.yishi.proto.minigame.GemMazeInfoMsg;
   import events.GemMazeEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.gemmaze.info.GemInfoUpdateInfoVO;
   import mvc.module.gemmaze.info.GemMazeGemInfoVO;
   import mvc.module.gemmaze.info.GemMazeInfoVO;
   
   public class GemMazeModel extends EventDispatcher
   {
      
      private var _gemMazeInfo:GemMazeInfoVO;
      
      private var _gemUpdateArr:Array = [];
      
      public var invideByPlayerId:int;
      
      public var invideRemoveGemCount:int;
      
      private var _invideLeftTimes:int;
      
      public var canMoveGemByUser:Boolean = true;
      
      private var _orderList:Vector.<GemMazeOrderInfo>;
      
      public var boxTempleteIdArr:Array = [];
      
      public var invideByFriendIsOpen:Boolean = false;
      
      public var dropDict:Dictionary;
      
      public var scoreArr:Array;
      
      public function GemMazeModel()
      {
         super();
         _gemMazeInfo = new GemMazeInfoVO();
         _orderList = new Vector.<GemMazeOrderInfo>();
         scoreArr = [];
         dropDict = new Dictionary();
      }
      
      public function get gemUpdateArr() : Array
      {
         return _gemUpdateArr;
      }
      
      public function set gemUpdateArr(param1:Array) : void
      {
         _gemUpdateArr = param1;
      }
      
      public function get gemMazeInfo() : GemMazeInfoVO
      {
         return _gemMazeInfo;
      }
      
      public function set gemMazeInfo(param1:GemMazeInfoVO) : void
      {
         _gemMazeInfo = param1;
      }
      
      public function updateGemMazeInfo(param1:GemMazeInfoMsg) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:GemInfoMsg = null;
         var _loc2_:GemMazeGemInfoVO = null;
         var _loc7_:DropItemInfoMsg = null;
         gemMazeInfo.score = param1.score;
         gemMazeInfo.sort = param1.scoreOrder;
         gemMazeInfo.timesLeft = param1.timesLeft;
         gemMazeInfo.buyTimesLeft = param1.buyTimesLeft;
         gemMazeInfo.helpTimesLeft = param1.helpTimesLeft;
         gemMazeInfo.gemLevel = param1.gemLevel;
         gemMazeInfo.curExp = param1.curExp;
         gemMazeInfo.maxExp = param1.maxExp;
         gemMazeInfo.boxMark = param1.boxMark;
         gemMazeInfo.weekScore = param1.weekScore;
         gemMazeInfo.gemArr = [];
         _loc4_ = 0;
         while(_loc4_ < param1.allGems.length)
         {
            _loc3_ = param1.allGems[_loc4_];
            _loc2_ = new GemMazeGemInfoVO();
            _loc2_.type = _loc3_.color;
            _loc2_.index = _loc3_.mark;
            gemMazeInfo.gemArr.push(_loc2_);
            _loc4_++;
         }
         dropDict = new Dictionary();
         scoreArr = [];
         _loc4_ = 0;
         while(_loc4_ < param1.dropItemList.length)
         {
            _loc7_ = param1.dropItemList[_loc4_];
            if(!dropDict[_loc7_.score])
            {
               dropDict[_loc7_.score] = [];
            }
            (dropDict[_loc7_.score] as Array).push({
               "tempId":_loc7_.itemTempId,
               "count":_loc7_.count
            });
            _loc4_++;
         }
         for(var _loc6_:String in dropDict)
         {
            scoreArr.push(int(_loc6_));
         }
         scoreArr.sort(16);
         boxTempleteIdArr = param1.boxesId;
      }
      
      public function updateGemUpdateInfo(param1:GemInfoUpdateMsg) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:GemInfoMsg = null;
         var _loc2_:GemMazeGemInfoVO = null;
         var _loc3_:GemInfoUpdateMsg = param1;
         var _loc7_:GemInfoUpdateInfoVO = new GemInfoUpdateInfoVO();
         _loc7_.scoreAdd = _loc3_.score;
         _loc7_.curExp = _loc3_.curExp;
         _loc7_.maxExp = _loc3_.maxExp;
         _loc7_.addIntergal = param1.score;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.score.length)
         {
            _gemMazeInfo.score += _loc3_.score[_loc5_];
            _loc5_++;
         }
         _gemMazeInfo.curExp = _loc3_.curExp;
         _gemMazeInfo.maxExp = _loc3_.maxExp;
         _gemMazeInfo.gemLevel = _loc3_.gemLevel;
         _loc7_.rewardInfo.rewardIdArr = _loc3_.rewardInfo;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.gemAdd.length)
         {
            _loc4_ = _loc3_.gemAdd[_loc6_];
            _loc2_ = new GemMazeGemInfoVO();
            _loc2_.type = _loc4_.color;
            _loc2_.index = _loc4_.mark;
            _loc7_.gemAddArr.push(_loc2_);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.gemDel.length)
         {
            _loc4_ = _loc3_.gemDel[_loc6_];
            _loc2_ = new GemMazeGemInfoVO();
            _loc2_.type = _loc4_.color;
            _loc2_.index = _loc4_.mark;
            _loc7_.gemDelArr.push(_loc2_);
            _loc6_++;
         }
         gemUpdateArr.push(_loc7_);
      }
      
      public function updateSignUpdateData() : GemInfoUpdateInfoVO
      {
         if(gemUpdateArr.length == 0)
         {
            return null;
         }
         var _loc1_:GemInfoUpdateInfoVO = gemUpdateArr[0];
         gemMazeInfo.curExp = _loc1_.curExp;
         gemMazeInfo.maxExp = _loc1_.maxExp;
         gemUpdateArr.splice(0,1);
         return _loc1_;
      }
      
      public function setAllGemStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < gemMazeInfo.gemArr.length)
         {
            gemMazeInfo.gemArr[_loc1_].isMove = gemMazeInfo.gemArr[_loc1_].isRemove = gemMazeInfo.gemArr[_loc1_].isAdd = false;
            gemMazeInfo.gemArr[_loc1_].nextIndex = 0;
            _loc1_++;
         }
      }
      
      public function updateAllUpdateData() : void
      {
         _gemMazeInfo = new GemMazeInfoVO();
         canMoveGemByUser = true;
      }
      
      public function get invideLeftTimes() : int
      {
         return _invideLeftTimes;
      }
      
      public function set invideLeftTimes(param1:int) : void
      {
         _invideLeftTimes = param1;
         if(_invideLeftTimes <= 0)
         {
            _invideLeftTimes = 0;
         }
      }
      
      public function get orderList() : Vector.<GemMazeOrderInfo>
      {
         return _orderList;
      }
      
      public function updateOrderList() : void
      {
         dispatchEvent(new GemMazeEvent("ORDERDATA_LOAD_COMPLETE",null));
      }
   }
}

