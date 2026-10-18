package map.campaign.data
{
   import com.road.yishi.proto.timer.TimerInfoMsg;
   import flash.events.EventDispatcher;
   import map.campaign.event.SteelEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class SteelModel extends EventDispatcher
   {
      
      public static const APPLY_PAGE_NUM:int = 8;
      
      public static const RANK_LIST_PAGE_NUM:int = 10;
      
      public static const JOIN_MAX:int = 20;
      
      public static const APPLY_MAX:int = 5;
      
      public static const PLAYER_OP_CREATETEAM:int = 1;
      
      public static const PLAYER_OP_KILLPLAYER:int = 2;
      
      public static const PLAYER_OP_INVTPLAYER:int = 3;
      
      public static const PLAYER_OP_APPLYENTER:int = 4;
      
      public static const PLAYER_OP_CHANGEMAST:int = 5;
      
      public static const PLAYER_OP_ENTER:int = 6;
      
      public static const PLAYER_OP_LISTUSERS:int = 7;
      
      public static const PLAYER_OP_LISTTEAMS:int = 8;
      
      public static const PLAYER_OP_MYTEAM:int = 9;
      
      public static const PLAYER_OP_CANCLEAPPLY:int = 10;
      
      public static const PLAYER_OP_APPLYLIST:int = 11;
      
      public static const PLAYER_OP_AGREEAPPLY:int = 12;
      
      public static const PLAYER_OP_INVITE_STATE:int = 13;
      
      public static const PLAYER_OP_EXITTEAM:int = 14;
      
      public static const PLAYER_OP_ORDERLIST:int = 15;
      
      public var steelCampaignInfo:SteelCampaignInfo;
      
      public var hostPlayerId:int;
      
      public var showSteelBtn:Boolean;
      
      public var shineSteelBtn:Boolean;
      
      public var selfTeamUid:String;
      
      public var selfTeamName:String;
      
      public var selfOrder:int;
      
      public var selfWinCount:int;
      
      public var selfPoint:int;
      
      public var openDate:Date;
      
      private var _finalOrderList:Array = [];
      
      private var _teamList:Array = [];
      
      private var _applyList:Array = [];
      
      private var _userList:Array = [];
      
      private var _auditList:Array = [];
      
      private var _rankDetailList:Array = [];
      
      private var _selectUser:ThaneInfo;
      
      private var _recruitCurrentPage:int = 1;
      
      private var _recruitListTotalPage:int = 1;
      
      public function SteelModel()
      {
         super();
         openDate = new Date();
         steelCampaignInfo = new SteelCampaignInfo();
      }
      
      public function initTimerInfo(param1:TimerInfoMsg) : void
      {
      }
      
      public function isInTeam(param1:int) : Boolean
      {
         var _loc2_:* = null;
         for each(_loc2_ in userList)
         {
            if(_loc2_.userId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isHostPlayer() : Boolean
      {
         if(hostPlayerId == ArmyManager.instance.thane.userId)
         {
            return true;
         }
         return false;
      }
      
      public function get userList() : Array
      {
         return _userList;
      }
      
      public function set userList(param1:Array) : void
      {
         _userList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_USER_LIST_CHANGE",param1));
      }
      
      public function get finalOrderList() : Array
      {
         return _finalOrderList;
      }
      
      public function set finalOrderList(param1:Array) : void
      {
         _finalOrderList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_FINAL_ORDER_LIST_CHANGE",param1));
      }
      
      public function get teamList() : Array
      {
         return _teamList;
      }
      
      public function set teamList(param1:Array) : void
      {
         _teamList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_TEAM_LIST_CHANGE",param1));
      }
      
      public function get applyList() : Array
      {
         return _applyList;
      }
      
      public function set applyList(param1:Array) : void
      {
         _applyList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_APPLY_LIST_CHANGE",param1));
      }
      
      public function get auditList() : Array
      {
         return _auditList;
      }
      
      public function set auditList(param1:Array) : void
      {
         _auditList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_AUDIT_LIST_CHANGE",param1));
      }
      
      public function get rankDetailList() : Array
      {
         return _rankDetailList;
      }
      
      public function set rankDetailList(param1:Array) : void
      {
         _rankDetailList = param1;
         this.dispatchEvent(new SteelEvent("STEEL_RANK_DETAIL_LIST_CHANGE",param1));
      }
      
      public function get selectUser() : ThaneInfo
      {
         return _selectUser;
      }
      
      public function set selectUser(param1:ThaneInfo) : void
      {
         _selectUser = param1;
         this.dispatchEvent(new SteelEvent("STEEL_SELECT_USER_ITEM",param1));
      }
      
      public function get recruitCurrentPage() : int
      {
         return _recruitCurrentPage;
      }
      
      public function set recruitCurrentPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _recruitCurrentPage = param1;
      }
      
      public function get recruitListTotalPage() : int
      {
         return _recruitListTotalPage;
      }
      
      public function set recruitListTotalPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _recruitListTotalPage = param1;
         this.dispatchEvent(new SteelEvent("UPDE_RECRUIT_SEARCH_PAGE"));
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new SteelEvent("STEEL_INFO_CHANGE"));
      }
   }
}

