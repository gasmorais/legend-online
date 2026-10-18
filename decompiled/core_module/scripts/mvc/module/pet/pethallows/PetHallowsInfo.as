package mvc.module.pet.pethallows
{
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class PetHallowsInfo
   {
      
      public var hallowType:int;
      
      public var hallowTempId:int;
      
      public var infuseIndex:int;
      
      public var propAddValue0:int;
      
      public var propAddValue1:int;
      
      public var propAddValue2:int;
      
      public var propAddValue3:int;
      
      public var propAddValue4:int;
      
      public var propAddValue5:int;
      
      public var equipPetId:int;
      
      public var lookFightPower:int;
      
      public var propAddGp0:int;
      
      public var propAddGp1:int;
      
      public var propAddGp2:int;
      
      public var propAddGp3:int;
      
      public var propAddGp4:int;
      
      public var propAddGp5:int;
      
      public var propAddGrade0:int;
      
      public var propAddGrade1:int;
      
      public var propAddGrade2:int;
      
      public var propAddGrade3:int;
      
      public var propAddGrade4:int;
      
      public var propAddGrade5:int;
      
      public var activeSkillTempId:int;
      
      public function PetHallowsInfo()
      {
         super();
      }
      
      public function get templateInfo() : PetHallowsTemplateInfo
      {
         return TempleteManager.instance.petHallowsTemplateCate.getTemplateById(hallowTempId);
      }
   }
}

