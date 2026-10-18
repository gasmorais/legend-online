package mvc.module.apex
{
   import ui.toptoolbar.TopToolsBar;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   
   public class ApexModel
   {
      
      public static const GRADE_BRONZE:int = 1;
      
      public static const GRADE_SILVER:int = 2;
      
      public static const GRADE_GOLD:int = 3;
      
      public static const GRADE_PLAN:int = 4;
      
      public static const GRADE_DIAMOND:int = 5;
      
      public static const GRADE_MASTER:int = 6;
      
      public static const HAND_REFRESH_LIMIT:int = 20;
      
      public var apexState:ApexState;
      
      public var apexBattleState:ApexBattleState;
      
      public var isSign:Boolean;
      
      public var curTeamMemNum:int;
      
      public var lastWinnerPlayerList:Vector.<ApexPlayerViewData>;
      
      public var apexRoomRankModel:ApexRankModel;
      
      public var apexRankModel:ApexRankModel;
      
      public var isOpen:Boolean = true;
      
      public var apexBetData:ApexBetData;
      
      public var apexResultData:ApexResultData;
      
      public var betWinPlayers:Array;
      
      public var teams:HashMap;
      
      private var _myTeam:ApexTeamData;
      
      public var myTeamPlayer:ApexTeamMemberData;
      
      public var isQuickInvite:Boolean = false;
      
      public var refreshTime:int = -1;
      
      public function ApexModel()
      {
         super();
      }
      
      public function get signCost() : int
      {
         if(TempleteManager.instance.getConfigInfoByConfigName("apex_sign_in_gold"))
         {
            return int(TempleteManager.instance.getConfigInfoByConfigName("apex_sign_in_gold").ConfigValue);
         }
         return 3000000;
      }
      
      public function get signMinFP() : int
      {
         if(TempleteManager.instance.getConfigInfoByConfigName("apex_sign_in_min_fight_capacity"))
         {
            return int(TempleteManager.instance.getConfigInfoByConfigName("apex_sign_in_min_fight_capacity").ConfigValue);
         }
         return 100;
      }
      
      public function get canGuess() : Boolean
      {
         return apexState.stage > 1;
      }
      
      public function get myTeam() : ApexTeamData
      {
         return _myTeam;
      }
      
      public function set myTeam(param1:ApexTeamData) : void
      {
         _myTeam = param1;
         if(_myTeam && _myTeam.members)
         {
            curTeamMemNum = _myTeam.members.length;
         }
         TopToolsBar.instance.apexState = apexState.state;
      }
   }
}

