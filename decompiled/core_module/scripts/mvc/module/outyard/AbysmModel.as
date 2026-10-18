package mvc.module.outyard
{
   import com.road.yishi.proto.guardendless.GuardEndlessBossMsg;
   import com.road.yishi.proto.guardendless.GuardEndlessPosMsg;
   import com.road.yishi.proto.guardendless.GuardendlessOpMsg;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class AbysmModel extends EventDispatcher
   {
      
      public var bossNum:int;
      
      public var index:int;
      
      public var currentLayer:int;
      
      public var maxIndex:int;
      
      public var sealNum:int;
      
      public var bossList:Array = [];
      
      public var childList:Array = [];
      
      public var mopupList:Array = [];
      
      public var goodsList:String;
      
      public var is_OverGame:Boolean;
      
      private var _abysmChildFightId:int;
      
      private var _mopupCount:int;
      
      private var timeoutId:int;
      
      private var _isHorrible:Boolean;
      
      public function AbysmModel()
      {
         super();
      }
      
      public function get isHorrible() : Boolean
      {
         return _isHorrible;
      }
      
      public function set isHorrible(param1:Boolean) : void
      {
         _isHorrible = param1;
      }
      
      public function get abysmChildFightId() : int
      {
         return _abysmChildFightId;
      }
      
      public function set abysmChildFightId(param1:int) : void
      {
         _abysmChildFightId = param1;
      }
      
      public function abysmInfoHandler(param1:GuardendlessOpMsg) : void
      {
         var _loc3_:AbysmBossInfo = null;
         var _loc4_:GuardEndlessBossMsg = null;
         var _loc6_:AbysmChildInfo = null;
         var _loc8_:GuardEndlessPosMsg = null;
         bossNum = param1.bossNum;
         index = param1.index;
         currentLayer = param1.plies;
         maxIndex = param1.maxIndex;
         sealNum = param1.guardSealNum;
         is_OverGame = param1.isFinishes;
         var _loc2_:Array = [];
         var _loc5_:int = int(param1.bossInfo.length);
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = param1.bossInfo[_loc7_];
            _loc3_ = new AbysmBossInfo();
            _loc3_.bossId = _loc4_.bossOrder;
            _loc3_.state = _loc4_.bossState;
            _loc3_.pos = _loc4_.bossIndex;
            _loc2_.push(_loc3_);
            _loc7_ += 1;
         }
         bossList = _loc2_;
         _loc2_ = [];
         _loc7_ = 0;
         _loc5_ = int(param1.guardPos.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = param1.guardPos[_loc7_];
            _loc6_ = new AbysmChildInfo();
            _loc6_.childId = _loc8_.param1;
            _loc6_.attackPos = _loc8_.param2;
            _loc6_.pos = _loc8_.param3;
            if(_loc6_.pos == 1)
            {
               abysmChildFightId = _loc6_.childId;
            }
            _loc2_.push(_loc6_);
            _loc7_ += 1;
         }
         _loc2_.sort(infoSortFuncDesc);
         mopupCount = param1.sweepIndex;
         childList = _loc2_;
         goodsList = param1.items;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ABYSM_INFO_UPDATA"));
      }
      
      public function updateMopup(param1:Object = null) : void
      {
         dispatchEvent(new OutyardEvent("UPDATEMOPUP",param1));
      }
      
      public function get mopupCount() : int
      {
         return _mopupCount;
      }
      
      public function set mopupCount(param1:int) : void
      {
         if(_mopupCount == param1)
         {
            return;
         }
         _mopupCount = param1;
         if(_mopupCount > 0)
         {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(enterSpaceShow,200);
         }
      }
      
      private function enterSpaceShow() : void
      {
         clearTimeout(timeoutId);
         if(isHorrible)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",18);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",8);
         }
      }
      
      public function changePos(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc7_:AbysmChildInfo = null;
         var _loc5_:int = int(childList.length);
         var _loc6_:int = 0;
         var _loc8_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = childList[_loc6_];
            if(param3 == 1 && (_loc7_.pos == param1 || _loc7_.pos == param2))
            {
               _loc8_.push(_loc6_);
            }
            else if(param3 == 2 && (_loc7_.attackPos == param1 || _loc7_.attackPos == param2))
            {
               _loc8_.push(_loc6_);
            }
            _loc6_ += 1;
         }
         if(_loc8_.length != 2)
         {
            return;
         }
         var _loc4_:AbysmChildInfo = childList[_loc8_[0]];
         if(param3 == 1)
         {
            if(_loc4_.pos == param1)
            {
               childList[_loc8_[0]].pos = param2;
               childList[_loc8_[1]].pos = param1;
            }
            else
            {
               childList[_loc8_[0]].pos = param1;
               childList[_loc8_[1]].pos = param2;
            }
         }
         else if(param3 == 2)
         {
            if(_loc4_.attackPos == param1)
            {
               childList[_loc8_[0]].attackPos = param2;
               childList[_loc8_[1]].attackPos = param1;
            }
            else
            {
               childList[_loc8_[0]].attackPos = param1;
               childList[_loc8_[1]].attackPos = param2;
            }
         }
      }
      
      private function infoSortFuncDesc(param1:AbysmChildInfo, param2:AbysmChildInfo) : int
      {
         if(param1.pos < param2.pos)
         {
            return -1;
         }
         if(param1.pos > param2.pos)
         {
            return 1;
         }
         return 0;
      }
   }
}

