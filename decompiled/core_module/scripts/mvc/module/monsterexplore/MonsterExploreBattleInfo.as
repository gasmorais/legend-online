package mvc.module.monsterexplore
{
   import yishi.manager.TempleteManager;
   
   public class MonsterExploreBattleInfo
   {
      
      public var isMonster:Boolean;
      
      public var templateId:int;
      
      public var name:String;
      
      public var index:int;
      
      public var hp:int;
      
      public var maxHp:int;
      
      public var damages:Array;
      
      public function MonsterExploreBattleInfo()
      {
         super();
      }
      
      public function get tempInfo() : Object
      {
         if(isMonster)
         {
            return TempleteManager.instance.monsterTempCate.getTemplateById(templateId);
         }
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(templateId);
      }
   }
}

