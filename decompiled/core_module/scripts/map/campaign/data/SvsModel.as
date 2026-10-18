package map.campaign.data
{
   import com.road.yishi.proto.timer.TimerInfoMsg;
   import flash.events.EventDispatcher;
   import map.campaign.event.SvsEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class SvsModel extends EventDispatcher
   {
      
      public static const DIVIDING_RANK:int = 16;
      
      public static const PAGE_NUM:int = 8;
      
      public static const PARANOID_GROUPID:int = 1000000;
      
      public static const OVER_GROUPID:int = 2000000;
      
      public static const JOIN_MAX:int = 40;
      
      public var svsCampaignInfo:SvsCampaignInfo;
      
      public var hostPlayerId:int;
      
      public var showSvsBtn:Boolean;
      
      public var selfServerName:String = "";
      
      public var matchServerName:String = "";
      
      public var currentTurn:int;
      
      public var groupId:int = 0;
      
      public var selfOrder:int;
      
      public var selfFightPower:int;
      
      public var openDate:Date;
      
      private var _warFightUserList:Array = [];
      
      private var _onlineUserList:Array = [];
      
      private var _finalOrderList:Array = [];
      
      private var _selectUser:ThaneInfo;
      
      public function SvsModel()
      {
         super();
         openDate = new Date();
         svsCampaignInfo = new SvsCampaignInfo();
      }
      
      public function initTimerInfo(param1:TimerInfoMsg) : void
      {
      }
      
      public function get isHostPlayer() : Boolean
      {
         if(hostPlayerId == ArmyManager.instance.thane.userId)
         {
            return true;
         }
         return false;
      }
      
      public function get warFightUserList() : Array
      {
         return _warFightUserList;
      }
      
      public function set warFightUserList(param1:Array) : void
      {
         _warFightUserList = param1;
         this.dispatchEvent(new SvsEvent("SVS_USER_LIST_CHANGE",param1));
      }
      
      public function get onlineUserList() : Array
      {
         return _onlineUserList;
      }
      
      public function set onlineUserList(param1:Array) : void
      {
         _onlineUserList = param1;
         this.dispatchEvent(new SvsEvent("SVS_USER_ONLINE_LIST_CHANGE",param1));
      }
      
      public function get finalOrderList() : Array
      {
         return _finalOrderList;
      }
      
      public function set finalOrderList(param1:Array) : void
      {
         _finalOrderList = param1;
         this.dispatchEvent(new SvsEvent("SVS_FINAL_ORDER_LIST_CHANGE",param1));
      }
      
      public function get selectUser() : ThaneInfo
      {
         return _selectUser;
      }
      
      public function set selectUser(param1:ThaneInfo) : void
      {
         _selectUser = param1;
         this.dispatchEvent(new SvsEvent("SVS_SELECT_USER_ITEM",param1));
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new SvsEvent("SVS_INFO_CHANGE",null));
      }
   }
}

