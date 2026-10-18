package map.internals.data
{
   import map.internals.data.template.MapPhysicsTempInfo;
   import mvc.module.armyII.SystemArmy;
   import yishi.manager.TempleteManager;
   
   public class WildLand extends MapPhysics
   {
      
      public var createDate:Date;
      
      public var refreshTime:int;
      
      public var loadTime:int;
      
      private var _templateId:int;
      
      private var _tempInfo:MapPhysicsTempInfo;
      
      protected var _ownSysArmy:SystemArmy;
      
      public var fightCapaity:int;
      
      public var curArmyId:Array;
      
      public function WildLand()
      {
         super();
      }
      
      public function get tempInfo() : MapPhysicsTempInfo
      {
         return _tempInfo;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
         _tempInfo = TempleteManager.instance.mapPhysicsTempleteCate.getTemplateByID(_templateId);
      }
      
      public function get ownSysArmy() : SystemArmy
      {
         return _ownSysArmy;
      }
      
      public function set ownSysArmy(param1:SystemArmy) : void
      {
         if(!_ownSysArmy)
         {
            _ownSysArmy = param1;
         }
      }
   }
}

