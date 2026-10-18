package mvc.module.outyard
{
   import com.road.yishi.proto.hugehead.HugeHeadGuildMsg;
   import com.road.yishi.proto.hugehead.HugeHeadUserMsg;
   import com.road.yishi.proto.hugehead.StackHeadAttackMsg;
   import com.road.yishi.proto.hugehead.StackHeadBattleDefenceMsg;
   import com.road.yishi.proto.hugehead.StackHeadBattleFieldMsg;
   import com.road.yishi.proto.hugehead.StackHeadForceMsg;
   import com.road.yishi.proto.hugehead.StackHeadForceUserListMsg;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg;
   import map.campaign.data.OutyardAttackInfo;
   import map.campaign.data.OutyardForceInfo;
   import map.campaign.data.OutyardUserInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.utils.SimpleDictionary;
   
   public class OutyardCrystalModel
   {
      
      public static const OPEN_FRAME:int = 1;
      
      public static const HEART:int = 2;
      
      public static const CLOSE_FRAME:int = 3;
      
      public static const DEFENCE_BUFF:int = 4;
      
      public static const ATTACK_BUFF:int = 5;
      
      public static const ATTACK:int = 6;
      
      public static const REQUEST_LIST:int = 7;
      
      public static const SET_SENIOR:int = 8;
      
      public static const CHANGE_NOTICE:int = 9;
      
      public static const BUY_EXECUTION:int = 10;
      
      public static const ENTER:int = 11;
      
      public static const CRYSTAL:int = 12;
      
      private var _battleDefenceMsg:StackHeadBattleDefenceMsg;
      
      private var _selfMsg:StackHeadSelfMsg;
      
      private var _memberList:SimpleDictionary;
      
      private var _nomalArr:Array = [];
      
      private var _seniorArr:Array = [];
      
      private var _forceArr:Array = [];
      
      private var _attackArr:Array = [];
      
      private var _weekUnion:int;
      
      public function OutyardCrystalModel()
      {
         super();
         _memberList = new SimpleDictionary(true);
      }
      
      public function crystalHandler(param1:StackHeadBattleFieldMsg) : void
      {
         var _loc7_:OutyardForceInfo = null;
         var _loc4_:OutyardAttackInfo = null;
         var _loc2_:StackHeadForceMsg = null;
         var _loc9_:StackHeadAttackMsg = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Array = param1.forceList;
         var _loc3_:Array = param1.attackList;
         _weekUnion = param1.weekUnionStrongForce;
         if(param1.op == 1)
         {
            _forceArr = [];
            _attackArr = [];
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc2_ = _loc5_[_loc6_] as StackHeadForceMsg;
               _loc7_ = new OutyardForceInfo();
               _loc7_.forceIndex = _loc2_.forceIndex;
               _loc7_.score = _loc2_.score;
               _loc7_.attackBuffLevel = _loc2_.attackBuffLevel;
               _loc7_.defenceBuffLevel = _loc2_.defenceBuffLevel;
               _loc7_.defenceAliveCount = _loc2_.defenceAliveCount;
               _loc7_.defenceTotalCount = _loc2_.defenceTotalCount;
               _forceArr.push(_loc7_);
               _loc6_++;
            }
            _attackArr.push(new OutyardAttackInfo(1,2));
            _attackArr.push(new OutyardAttackInfo(1,3));
            _attackArr.push(new OutyardAttackInfo(1,4));
            _attackArr.push(new OutyardAttackInfo(2,1));
            _attackArr.push(new OutyardAttackInfo(2,3));
            _attackArr.push(new OutyardAttackInfo(2,4));
            _attackArr.push(new OutyardAttackInfo(3,1));
            _attackArr.push(new OutyardAttackInfo(3,2));
            _attackArr.push(new OutyardAttackInfo(3,4));
            _attackArr.push(new OutyardAttackInfo(4,1));
            _attackArr.push(new OutyardAttackInfo(4,2));
            _attackArr.push(new OutyardAttackInfo(4,3));
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc9_ = _loc3_[_loc6_] as StackHeadAttackMsg;
               _loc8_ = 0;
               while(_loc8_ < _attackArr.length)
               {
                  _loc4_ = _attackArr[_loc8_] as OutyardAttackInfo;
                  if(_loc4_.key == _loc9_.fromPos + "_" + _loc9_.toPos)
                  {
                     _loc4_.totalCount = _loc9_.totalCount;
                  }
                  _loc8_++;
               }
               _loc6_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_OPEN_FRAME"));
         }
         else if(param1.op == 12)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc2_ = _loc5_[_loc6_] as StackHeadForceMsg;
               _loc8_ = 0;
               while(_loc8_ < _forceArr.length)
               {
                  _loc7_ = _forceArr[_loc8_] as OutyardForceInfo;
                  if(_loc7_.forceIndex == _loc2_.forceIndex)
                  {
                     _loc7_.score = _loc2_.score;
                     _loc7_.attackBuffLevel = _loc2_.attackBuffLevel;
                     _loc7_.defenceBuffLevel = _loc2_.defenceBuffLevel;
                     _loc7_.defenceAliveCount = _loc2_.defenceAliveCount;
                     _loc7_.defenceTotalCount = _loc2_.defenceTotalCount;
                  }
                  _loc8_++;
               }
               _loc6_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_UPDATE_INFO",param1.attackList));
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_FULL_INFO"));
      }
      
      public function userlistHandler(param1:StackHeadForceUserListMsg) : void
      {
         var _loc7_:OutyardUserInfo = null;
         var _loc4_:HugeHeadUserMsg = null;
         var _loc3_:StackHeadSeniorGeneralMsg = null;
         var _loc8_:OutyardUserInfo = null;
         var _loc2_:HugeHeadGuildMsg = param1.guild;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.op == 7)
         {
            if(param1.current <= param1.total)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.userList.length)
               {
                  _loc4_ = _loc2_.userList[_loc5_] as HugeHeadUserMsg;
                  _loc7_ = new OutyardUserInfo();
                  _loc7_.userUid = _loc4_.userUid;
                  _loc7_.userId = _loc4_.userid;
                  _loc7_.nickName = _loc4_.nickName;
                  _loc7_.defenceAlive = _loc4_.stackHeadAlive;
                  _loc7_.defenceDebuffLevel = _loc4_.stackHeadDebuffLevel;
                  _loc7_.fightingCapacity = _loc4_.fightCapacity;
                  _loc7_.grades = _loc4_.grade;
                  _loc7_.firstChangeGrade = _loc4_.firstChangeGrade;
                  _loc7_.secondChangeGrade = _loc4_.secondChangeGrade;
                  _loc7_.changeBranch = _loc4_.changeBranch;
                  _loc7_.job = _loc4_.job;
                  _nomalArr.push(_loc7_);
                  _memberList.add(_loc7_.userUid,_loc7_);
                  _loc5_++;
               }
            }
         }
         else if(param1.op == 8)
         {
            _seniorArr = [];
            _loc5_ = 0;
            while(_loc5_ < param1.seniorGeneralUser.length)
            {
               _loc3_ = param1.seniorGeneralUser[_loc5_] as StackHeadSeniorGeneralMsg;
               _loc8_ = new OutyardUserInfo();
               _loc6_ = 0;
               while(_loc6_ < _nomalArr.length)
               {
                  _loc7_ = _nomalArr[_loc6_] as OutyardUserInfo;
                  if(_loc3_.userUid == _loc7_.userUid)
                  {
                     _loc8_ = _loc7_.copy(_loc8_);
                  }
                  _loc6_++;
               }
               _loc8_.index = _loc3_.index;
               _loc8_.alive = _loc3_.alive;
               _loc8_.inBattle = _loc3_.inBattle;
               _seniorArr.push(_loc8_);
               _loc5_++;
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_USERLIST_INFO"));
      }
      
      public function battleDefenceHandler(param1:StackHeadBattleDefenceMsg) : void
      {
         _battleDefenceMsg = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_BATTLE_DEFENCE"));
      }
      
      public function selfInfoHandler(param1:StackHeadSelfMsg) : void
      {
         _selfMsg = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_SELF_INFO"));
      }
      
      public function get battleDefenceMsg() : StackHeadBattleDefenceMsg
      {
         return _battleDefenceMsg;
      }
      
      public function get selfMsg() : StackHeadSelfMsg
      {
         return _selfMsg;
      }
      
      public function get myForcePos() : int
      {
         return OutyardManager.instance.model.signInMsg.forceIndex;
      }
      
      public function get myForce() : OutyardForceInfo
      {
         var _loc2_:OutyardForceInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _forceArr.length)
         {
            _loc2_ = _forceArr[_loc1_] as OutyardForceInfo;
            if(_loc2_.forceIndex == myForcePos)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get forceArr() : Array
      {
         return _forceArr;
      }
      
      public function get attackArr() : Array
      {
         return _attackArr;
      }
      
      public function get weekUnion() : int
      {
         return _weekUnion;
      }
      
      public function getMemberArrByType(param1:int) : Array
      {
         if(param1 == 0)
         {
            return _nomalArr;
         }
         return _seniorArr;
      }
      
      public function get memberList() : SimpleDictionary
      {
         return _memberList;
      }
      
      public function clearMemberList() : void
      {
         _nomalArr = [];
         _memberList = new SimpleDictionary();
      }
      
      public function getSortMemberList(param1:String = "fightingCapacity", param2:Boolean = true) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:OutyardUserInfo in _memberList)
         {
            _loc3_.push(_loc4_);
         }
         if(param1 == "nickName")
         {
            if(param2)
            {
               _loc3_.sortOn(["isOnline",param1],[2,2]);
            }
            else
            {
               _loc3_.sortOn(["isOnline",param1],[2,1]);
            }
         }
         else if(param1 == "crossGuildTeamId")
         {
            if(param2)
            {
               _loc3_.sortOn([param1],[0x10 | 2]);
            }
            else
            {
               _loc3_.sortOn([param1],[16]);
            }
         }
         else if(param1 == "grades")
         {
            if(param2)
            {
               _loc3_.sortOn(["isOnline","vocationGrades",param1],[2,0x10 | 2,0x10 | 2]);
            }
            else
            {
               _loc3_.sortOn(["isOnline","vocationGrades",param1],[2,16,16]);
            }
         }
         else if(param2)
         {
            _loc3_.sortOn(["isOnline",param1],[2,0x10 | 2]);
         }
         else
         {
            _loc3_.sortOn(["isOnline",param1],[2,16]);
         }
         return _loc3_;
      }
   }
}

