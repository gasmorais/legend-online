package map.campaign.data
{
   import battle.events.BattleEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TrailPropInfo extends EventDispatcher
   {
      
      public var index:int = 0;
      
      public var id:int = 0;
      
      private var _useCount:int = 0;
      
      public var currentCount:int = 0;
      
      public var maxCount:int;
      
      public var cost:int;
      
      public var coolDown:int;
      
      public var NeedItemId:int;
      
      public function TrailPropInfo()
      {
         super();
      }
      
      public function get useCount() : int
      {
         return _useCount;
      }
      
      public function set useCount(param1:int) : void
      {
         var _loc2_:Boolean = _useCount < param1;
         _useCount = param1;
         dispatchEvent(new BattleEvent("TRAIL_USECOUNT_CHANGE",_loc2_));
      }
      
      public function get skillTemp() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(id);
      }
   }
}

