package map.internals.data
{
   import events.ArmyEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ArmyMonsterInfo extends EventDispatcher
   {
      
      private var _monsterTemplateId:int;
      
      private var changed:Boolean = false;
      
      public var monsterTemplate:MonsterTempInfo;
      
      public function ArmyMonsterInfo()
      {
         super();
      }
      
      public function get monsterTemplateId() : int
      {
         return _monsterTemplateId;
      }
      
      public function set monsterTemplateId(param1:int) : void
      {
         if(_monsterTemplateId == param1)
         {
            return;
         }
         _monsterTemplateId = param1;
         monsterTemplate = TempleteManager.instance.monsterTempCate.getTemplateById(param1);
         changed = true;
      }
      
      public function commit() : void
      {
         if(changed)
         {
            dispatchEvent(new ArmyEvent("MONSTER_CHANGED",this));
            changed = false;
         }
      }
   }
}

