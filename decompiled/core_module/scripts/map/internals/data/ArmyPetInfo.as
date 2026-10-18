package map.internals.data
{
   import events.ArmyEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.TempleteManager;
   
   public class ArmyPetInfo extends EventDispatcher
   {
      
      private var _petTemplateId:int;
      
      public var petTemplate:PetTemplate;
      
      private var _petName:String;
      
      private var _petQuaity:int = 1;
      
      private var _petTemQuality:int = 1;
      
      private var changed:Boolean = false;
      
      public var posX:int = 0;
      
      public var posY:int = 0;
      
      public function ArmyPetInfo()
      {
         super();
      }
      
      public function get petTemplateId() : int
      {
         return _petTemplateId;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         if(_petTemplateId == param1)
         {
            return;
         }
         _petTemplateId = param1;
         petTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(param1);
         changed = true;
      }
      
      public function get petName() : String
      {
         return _petName;
      }
      
      public function set petName(param1:String) : void
      {
         if(_petName == param1)
         {
            return;
         }
         _petName = param1;
         changed = true;
      }
      
      public function get petQuaity() : int
      {
         return _petQuaity;
      }
      
      public function set petQuaity(param1:int) : void
      {
         if(_petQuaity == param1)
         {
            return;
         }
         _petQuaity = param1;
         changed = true;
      }
      
      public function commit() : void
      {
         if(changed)
         {
            dispatchEvent(new ArmyEvent("PETINFO_CHANGED",this));
            changed = false;
         }
      }
      
      public function get petTemQuality() : int
      {
         return _petTemQuality;
      }
      
      public function set petTemQuality(param1:int) : void
      {
         if(_petTemQuality == param1)
         {
            return;
         }
         _petTemQuality = param1;
         changed = true;
      }
   }
}

