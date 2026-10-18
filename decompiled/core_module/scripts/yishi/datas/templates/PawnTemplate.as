package yishi.datas.templates
{
   import flash.events.EventDispatcher;
   import yishi.manager.TempleteManager;
   
   public class PawnTemplate extends EventDispatcher
   {
      
      public var TemplateId:int;
      
      public var NextLevelTemplateId:int;
      
      public var MasterType:int;
      
      public var SonType:int;
      
      public var Camp:int;
      
      public var PawnName:String;
      
      public var Description:String;
      
      public var LumberConsume:int;
      
      public var StoneConsume:int;
      
      public var CrystalsConsume:int;
      
      public var GoldConsume:int;
      
      public var NeedBuilding:String;
      
      public var NeedTime:int;
      
      public var NeedPopulation:int;
      
      public var Swf:String;
      
      public var AttackType:String;
      
      public var DefaultSkill:int;
      
      public var Icon:String;
      
      public var Level:int;
      
      public var Live:int;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public var ForceHit:int;
      
      public var Parry:int;
      
      public var HighSkill:String;
      
      public var HeroSkill:String;
      
      public var AI:int;
      
      public function PawnTemplate()
      {
         super();
      }
      
      public function get neenBuildings() : Array
      {
         return NeedBuilding.split(",");
      }
      
      public function get Name() : String
      {
         return PawnName;
      }
      
      public function get DefaultSkillTemplateInfo() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(DefaultSkill);
      }
   }
}

