package mvc.module.monsterexplore
{
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.manager.MonsterManager;
   
   public class MonsterExploreFormationInfo
   {
      
      public var monsterId:int;
      
      public var index:int;
      
      public var fightPos:int;
      
      public var isCaptain:Boolean;
      
      public function MonsterExploreFormationInfo()
      {
         super();
      }
      
      public function get monsterInfo() : MonsterInfo
      {
         if(monsterModel.monsterDic[monsterId])
         {
            return monsterModel.monsterDic[monsterId];
         }
         return null;
      }
      
      private function get monsterModel() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
   }
}

