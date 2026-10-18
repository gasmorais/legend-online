package mvc.module.worldboss
{
   import com.road.pb.helper.army.ThaneInfoHelper;
   import events.WorldBossEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   
   public class WorldBossModel extends EventDispatcher
   {
      
      private var _woundInfoList:Array = [];
      
      private var _allWoundInfoList:Array = [];
      
      private var _jobWoundInfoList:Array = [];
      
      public var curHp:Number = 0;
      
      public var totalHp:Number = 0;
      
      public var campaignId:int;
      
      public var selfWoundInfo:WoundInfo = new WoundInfo(-1);
      
      public var myWound:int;
      
      public var totalNum:int;
      
      public var bossGrades:int;
      
      public var buffGrade:int;
      
      public var rewards:Array;
      
      public var woundAll:Boolean;
      
      public function WorldBossModel(param1:IEventDispatcher = null)
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 30)
         {
            _woundInfoList.push(new WoundInfo(_loc2_));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _allWoundInfoList.push(new WoundInfo(_loc2_));
            _jobWoundInfoList.push(new WoundInfo(_loc2_));
            _loc2_++;
         }
         super(param1);
      }
      
      public function getWoundInfoByIndex(param1:int) : WoundInfo
      {
         if(woundAll)
         {
            return _allWoundInfoList[param1] as WoundInfo;
         }
         return _jobWoundInfoList[param1] as WoundInfo;
      }
      
      public function getWoundInfoByNickname(param1:String) : WoundInfo
      {
         for each(var _loc2_:WoundInfo in _woundInfoList)
         {
            if(_loc2_.nickName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addWoundInfo(param1:WoundInfo) : void
      {
         var _loc2_:int = 0;
         for each(var _loc3_:WoundInfo in _woundInfoList)
         {
            if(_loc3_.nickName == param1.nickName)
            {
               _woundInfoList[_loc2_] = param1;
               return;
            }
            _loc2_++;
         }
         _woundInfoList.push(param1);
      }
      
      public function clear() : void
      {
         _woundInfoList = [];
      }
      
      public function get woundInfoList() : Array
      {
         if(woundAll)
         {
            return _allWoundInfoList;
         }
         return _jobWoundInfoList;
      }
      
      public function resetAll() : void
      {
         for each(var _loc1_:WoundInfo in _woundInfoList)
         {
            _loc1_.reset();
         }
      }
      
      public function commit() : void
      {
         var _loc3_:WoundInfo = null;
         var _loc5_:WoundInfo = null;
         var _loc1_:Boolean = false;
         var _loc8_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         for each(var _loc2_:WoundInfo in _woundInfoList)
         {
            if(StringHelper.isNullOrEmpty(_loc2_.nickName))
            {
               _loc2_.reset();
            }
            else if(_loc2_.userId == _loc8_)
            {
               if(_loc1_)
               {
                  _loc2_.reset();
               }
               else
               {
                  _loc1_ = true;
                  _loc2_.totalHp = selfWoundInfo.totalHp;
                  _loc2_.wound = selfWoundInfo.wound;
                  _loc2_.job = selfWoundInfo.job;
               }
            }
         }
         if(!_loc1_ && !StringHelper.isNullOrEmpty(selfWoundInfo.nickName))
         {
            _loc3_ = new WoundInfo(1);
            _loc3_.nickName = selfWoundInfo.nickName;
            _loc3_.totalHp = selfWoundInfo.totalHp;
            _loc3_.wound = selfWoundInfo.wound;
            _loc3_.job = selfWoundInfo.job;
            _loc3_.userId = _loc8_;
            _woundInfoList.push(_loc3_);
         }
         _woundInfoList = _woundInfoList.sortOn("wound",0x10 | 2);
         _allWoundInfoList = [];
         _jobWoundInfoList = [];
         var _loc7_:int = ThaneInfoHelper.getJob(PlayerManager.instance.currentPlayerModel.playerInfo.job);
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _allWoundInfoList.push(new WoundInfo(_loc4_));
            _jobWoundInfoList.push(new WoundInfo(_loc4_));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _woundInfoList.length)
         {
            _woundInfoList[_loc4_].index = _loc4_;
            if(_loc6_ < 10)
            {
               _loc5_ = new WoundInfo(_loc6_);
               _loc5_.nickName = (_woundInfoList[_loc4_] as WoundInfo).nickName;
               _loc5_.totalHp = (_woundInfoList[_loc4_] as WoundInfo).totalHp;
               _loc5_.wound = (_woundInfoList[_loc4_] as WoundInfo).wound;
               _loc5_.job = (_woundInfoList[_loc4_] as WoundInfo).job;
               _loc5_.userId = (_woundInfoList[_loc4_] as WoundInfo).userId;
               _allWoundInfoList[_loc6_] = _loc5_;
               _loc6_++;
            }
            if(ThaneInfoHelper.getJob(_woundInfoList[_loc4_].job) == _loc7_ && _loc9_ < 10)
            {
               _loc5_ = new WoundInfo(_loc9_);
               _loc5_.nickName = (_woundInfoList[_loc4_] as WoundInfo).nickName;
               _loc5_.totalHp = (_woundInfoList[_loc4_] as WoundInfo).totalHp;
               _loc5_.wound = (_woundInfoList[_loc4_] as WoundInfo).wound;
               _loc5_.job = (_woundInfoList[_loc4_] as WoundInfo).job;
               _loc5_.userId = (_woundInfoList[_loc4_] as WoundInfo).userId;
               _jobWoundInfoList[_loc9_] = _loc5_;
               _loc9_++;
            }
            _loc4_++;
         }
         while(_woundInfoList.length > 30)
         {
            _woundInfoList.pop();
         }
         this.dispatchEvent(new WorldBossEvent("UPDATE_WOUND_LIST",_woundInfoList));
      }
   }
}

