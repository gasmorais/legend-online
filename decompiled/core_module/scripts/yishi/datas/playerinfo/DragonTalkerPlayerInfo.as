package yishi.datas.playerinfo
{
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTalkerPlayerInfo
   {
      
      public var isDragonTalker:Boolean;
      
      public var battleBeastId:int;
      
      public var symbiontList:Array;
      
      public var fightMountGp:int;
      
      public var talismanList:Array;
      
      public var dragonFashionWing:int;
      
      public var dragonFashionHat:int;
      
      public var dragonFashionArm:int;
      
      public var dragonFashionCloth:int;
      
      public function DragonTalkerPlayerInfo()
      {
         super();
         symbiontList = [];
         talismanList = [];
      }
      
      public function get fightMountGrade() : int
      {
         return TempleteManager.instance.getUpgradeGradeBy(140,fightMountGp);
      }
      
      public function getEquipInfoBySontype(param1:int) : DragonTalkerTalismanInfo
      {
         for each(var _loc2_:DragonTalkerTalismanInfo in talismanList)
         {
            if(_loc2_.goodsTempInfo.SonType == param1 && _loc2_.isEquip)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSymbioteInfoByIndex(param1:int) : DragonTalkerSymbioteInfo
      {
         for each(var _loc2_:DragonTalkerSymbioteInfo in symbiontList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

