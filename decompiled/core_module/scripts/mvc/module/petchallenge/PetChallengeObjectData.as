package mvc.module.petchallenge
{
   import mvc.module.pet.PetData;
   
   public class PetChallengeObjectData
   {
      
      public var petList:Array;
      
      public var uuid:String;
      
      public var userId:int;
      
      public var userName:String;
      
      public var serverName:String;
      
      public var ranking:int;
      
      public var score:int;
      
      public var fightCapacity:int;
      
      public var isSelf:Boolean = false;
      
      public var result:int;
      
      public var logDate:int;
      
      public function PetChallengeObjectData()
      {
         super();
         petList = [];
      }
      
      public function get totalFightPower() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:PetData in petList)
         {
            _loc1_ += _loc2_.fightPower;
         }
         return _loc1_;
      }
      
      public function get petData() : PetData
      {
         var _loc1_:PetData = null;
         for each(var _loc2_:PetData in petList)
         {
            if(!_loc1_ || _loc2_.fightPower > _loc1_.fightPower)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
   }
}

