package battle.logsys
{
   import battle.data.BufferDamageData;
   import battle.events.BattleEvent;
   import battle.skillsys.skills.BaseSkill;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   
   public class BattleLogSystem
   {
      
      public static var battleLogSys:*;
      
      private static var _embed:DebugBattleCreater;
      
      public function BattleLogSystem()
      {
         super();
      }
      
      public static function addSkillII(param1:BaseSkill) : void
      {
         if(battleLogSys)
         {
            battleLogSys.addSkillII(param1);
         }
      }
      
      public static function skillDannyFlag(param1:BaseSkill) : void
      {
         if(battleLogSys)
         {
            battleLogSys.skillDannyFlag(param1);
         }
      }
      
      public static function skillProgress(param1:BaseSkill, param2:int) : void
      {
         if(battleLogSys)
         {
            battleLogSys.skillProgress(param1,param2);
         }
      }
      
      public static function realExecuteTime(param1:BaseSkill, param2:int) : void
      {
         if(battleLogSys)
         {
            battleLogSys.realExecuteTime(param1,param2);
         }
      }
      
      public static function bufferLog(param1:BufferDamageData) : void
      {
         if(battleLogSys)
         {
            battleLogSys.bufferLog(param1);
         }
      }
      
      public static function addBloodLogDataII(param1:RoleInfo, param2:int) : void
      {
         if(battleLogSys)
         {
            battleLogSys.addBloodLogDataII(param1,param2);
         }
      }
      
      public static function exitBattle() : void
      {
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleComplete",null));
      }
      
      public static function clear() : void
      {
         if(battleLogSys)
         {
            battleLogSys.clear();
         }
      }
   }
}

