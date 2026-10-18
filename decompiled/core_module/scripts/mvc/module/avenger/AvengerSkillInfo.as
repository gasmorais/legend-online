package mvc.module.avenger
{
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class AvengerSkillInfo
   {
      
      public var skillTempId:int;
      
      public var skillSontype:int;
      
      public var isFight:Boolean;
      
      public var attack:int;
      
      public var defence:int;
      
      public var magicDefence:int;
      
      public var live:int;
      
      public var forceHit:int;
      
      public var parry:int;
      
      public var penetrate:int;
      
      public var reduceResi:int;
      
      public var fireResi:int;
      
      public var waterResi:int;
      
      public var windResi:int;
      
      public var electResi:int;
      
      public var lightResi:int;
      
      public var darkResi:int;
      
      public var needItems:String;
      
      public function AvengerSkillInfo()
      {
         super();
      }
      
      public function get skillTemp() : SkillTempInfo
      {
         return TempleteManager.instance.skillTemplateDic[skillTempId];
      }
      
      public function get propAry() : Array
      {
         return [attack,defence,live,forceHit,parry,penetrate];
      }
      
      public function get resiAry() : Array
      {
         return [fireResi,waterResi,windResi,electResi,lightResi,darkResi];
      }
   }
}

