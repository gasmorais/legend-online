package yishi.utils
{
   import mvc.module.emailII.BattleInfo;
   
   public class BattleReportHelp
   {
      
      public function BattleReportHelp()
      {
         super();
      }
      
      public static function covertToBattleInfo(param1:String) : BattleInfo
      {
         var _loc3_:XML = new XML(param1);
         var _loc2_:BattleInfo = new BattleInfo();
         _loc2_.type = _loc3_.info.@type;
         _loc2_.time = _loc3_.info.@time;
         if(_loc2_.type == 2)
         {
            _loc2_.content = _loc3_.info.@content;
         }
         else
         {
            _loc2_.camp = _loc3_.info.@camp;
            _loc2_.result = _loc3_.info.@result;
            _loc2_.playerName = _loc3_.info.@playerName;
            _loc2_.siteName = _loc3_.info.@siteName;
            _loc2_.pos = _loc3_.info.@pos;
            _loc2_.mapId = _loc3_.info.@mapId;
            _loc2_.selfHeroId = int(_loc3_.me.@heroId);
            _loc2_.selfSite1Name = _loc3_.me.@site1Name;
            _loc2_.selfSite1Count = _loc3_.me.@site1Count;
            _loc2_.selfSite2Name = _loc3_.me.@site2Name;
            _loc2_.selfSite2Count = _loc3_.me.@site2Count;
            _loc2_.selfStrengry = _loc3_.me.@strategy;
            _loc2_.selfGold = int(_loc3_.me.@gold);
            _loc2_.selfFight = _loc3_.me.@fight;
            _loc2_.selfGrade = _loc3_.me.@grade;
            _loc2_.selfCrystal = int(_loc3_.me.@crystal);
            _loc2_.enemyHeroId = _loc3_.he.@heroId;
            _loc2_.enemySite1Name = _loc3_.he.@site1Name;
            _loc2_.enemySite1Count = _loc3_.he.@site1Count;
            _loc2_.enemySite2Name = _loc3_.he.@site2Name;
            _loc2_.enemySite2Count = _loc3_.he.@site2Count;
            _loc2_.enemyStrengry = _loc3_.he.@strategy;
            _loc2_.enemyGold = int(_loc3_.he.@gold);
            _loc2_.enemyFight = _loc3_.he.@fight;
            _loc2_.enemyGrade = _loc3_.he.@grade;
            _loc2_.enemyCrystal = int(_loc3_.he.@crystal);
         }
         return _loc2_;
      }
   }
}

