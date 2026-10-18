package mvc.module.team
{
   import events.FreedomTeamEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.armyII.BaseArmy;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class FreedomTeamModel extends EventDispatcher
   {
      
      public static const OPEN_INVITEFRAME:String = "OPEN_INVITEFRAME";
      
      public static const OPEN_SORTFRAME:String = "OPEN_SORTFRAME";
      
      public static const OPEN_MANAGEFRAME:String = "OPEN_MANAGEFRAME";
      
      private var _allMembers:Array;
      
      private var _captainId:int;
      
      private var _captainServerName:String;
      
      private var _memberFightPos:Array;
      
      private var _memberId:Array;
      
      private var _memberFightCapacity:Dictionary;
      
      private var _memberState:Dictionary;
      
      private var _transferMapping:Dictionary;
      
      public var followId:int = 0;
      
      private var _followFlag:Boolean = false;
      
      public function FreedomTeamModel()
      {
         super();
         _allMembers = [];
         _memberFightPos = [];
         _memberId = [];
         _memberFightCapacity = new Dictionary();
         _memberState = new Dictionary();
         _transferMapping = new Dictionary();
         _transferMapping["10000-20001"] = 5;
         _transferMapping["10000-30000"] = 15;
         _transferMapping["20001-20002"] = 2000102;
         _transferMapping["20001-10000"] = 2000150;
         _transferMapping["20002-20003"] = 2000202;
         _transferMapping["20002-20001"] = 2000201;
         _transferMapping["20003-20004"] = 2000341;
         _transferMapping["20003-20002"] = 2000301;
         _transferMapping["20004-20003"] = 2000401;
         _transferMapping["30000-10000"] = 3000002;
         _transferMapping["30000-30001"] = 3000056;
         _transferMapping["30001-30000"] = 3000101;
      }
      
      public function get followFlag() : Boolean
      {
         return _followFlag;
      }
      
      public function set followFlag(param1:Boolean) : void
      {
         _followFlag = param1;
         if(!param1)
         {
            followId = 0;
         }
      }
      
      public function get transferMapping() : Dictionary
      {
         return _transferMapping;
      }
      
      public function getMemberByUserId(param1:int) : BaseArmy
      {
         var _loc3_:int = 0;
         var _loc2_:BaseArmy = null;
         _loc3_ = 0;
         while(_loc3_ < _allMembers.length)
         {
            _loc2_ = _allMembers[_loc3_] as BaseArmy;
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function addMember(param1:BaseArmy) : void
      {
         if(_allMembers.indexOf(param1) == -1)
         {
            _allMembers.push(param1);
         }
         dispatchEvent(new FreedomTeamEvent("ADD_MEMBER",param1));
      }
      
      public function removeMemberByUserId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseArmy = getMemberByUserId(param1);
         if(_loc2_)
         {
            _loc3_ = _allMembers.indexOf(_loc2_);
            _allMembers.splice(_loc3_,1);
            _loc3_ = _memberId.indexOf(param1);
            _memberId.splice(_loc3_,1);
            _loc3_ = _memberFightPos.indexOf(param1);
            _memberFightPos.splice(_loc3_,1);
            delete _memberFightCapacity[param1];
            delete _memberState[param1];
            dispatchEvent(new FreedomTeamEvent("REMOVE_MEMBER",_loc2_));
         }
      }
      
      public function get allMembers() : Array
      {
         return _allMembers;
      }
      
      public function set memberFightPos(param1:Array) : void
      {
         if(_memberFightPos != param1)
         {
            _memberFightPos = param1;
         }
      }
      
      public function get armyFightPos() : Array
      {
         return _memberFightPos;
      }
      
      public function set captainId(param1:int) : void
      {
         if(_captainId != param1)
         {
            _captainId = param1;
            if(_captainId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("TEAMCAPTAINCHANGE"));
            }
         }
      }
      
      public function get captainId() : int
      {
         return _captainId;
      }
      
      public function get captainServerName() : String
      {
         return _captainServerName;
      }
      
      public function set captainServerName(param1:String) : void
      {
         _captainServerName = param1;
      }
      
      public function get memberId() : Array
      {
         return _memberId;
      }
      
      public function set memberId(param1:Array) : void
      {
         if(_memberId != param1)
         {
            _memberId = param1;
         }
      }
      
      public function get memberFightCapacity() : Dictionary
      {
         return _memberFightCapacity;
      }
      
      public function set memberFightCapacity(param1:Dictionary) : void
      {
         if(_memberFightCapacity != param1)
         {
            _memberFightCapacity = param1;
         }
      }
      
      public function get memberState() : Dictionary
      {
         return _memberState;
      }
      
      public function set memberState(param1:Dictionary) : void
      {
         if(_memberState != param1)
         {
            _memberState = param1;
         }
      }
      
      public function dispose() : void
      {
         _allMembers = null;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("TEAMCAPTAINCHANGE"));
      }
   }
}

