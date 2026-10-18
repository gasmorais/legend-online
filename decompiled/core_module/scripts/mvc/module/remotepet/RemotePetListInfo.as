package mvc.module.remotepet
{
   import mvc.module.pet.PetData;
   import yishi.utils.SimpleDictionary;
   
   public class RemotePetListInfo
   {
      
      public var fight:int;
      
      public var petPos:String;
      
      public var formationString:String = "-1,-1,-1,-1,-1,-1,-1,-1";
      
      public var petList:SimpleDictionary;
      
      public function RemotePetListInfo()
      {
         super();
         petList = new SimpleDictionary();
      }
      
      public function get remotePetFormationOfArray() : Array
      {
         if(formationString)
         {
            return formationString.split(",");
         }
         return [];
      }
      
      public function getPet(param1:int) : PetData
      {
         for each(var _loc2_:PetData in petList)
         {
            if(_loc2_ && _loc2_.petId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

