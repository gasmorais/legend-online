package map.outercity
{
   import yishi.manager.TempleteManager;
   
   public class MapBossMsgInfo
   {
      
      public var count1:int;
      
      public var canKillCount1:int;
      
      public var count2:int;
      
      public var canKillCount2:int;
      
      public var count3:int;
      
      public var canKillCount3:int;
      
      public var bosslist:Array;
      
      public var leftBossTime:int;
      
      private var _leftFogTime:int;
      
      public var bossBoxList:Array;
      
      public var archaeologyKillCount:int;
      
      public var atchaeologyMonsterCount:int;
      
      public function MapBossMsgInfo()
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         super();
         try
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("WorldMapKill").ConfigValue;
            _loc2_ = _loc1_.split(",");
            canKillCount1 = _loc2_[0];
            canKillCount2 = _loc2_[1];
            canKillCount3 = _loc2_[2];
         }
         catch(e:Error)
         {
         }
      }
      
      public function get leftFogTime() : int
      {
         return _leftFogTime;
      }
      
      public function set leftFogTime(param1:int) : void
      {
         _leftFogTime = param1;
      }
   }
}

