package mvc.module.antaeus
{
   import yishi.manager.ArmyManager;
   
   public class AntaeusModel
   {
      
      public var antaeusData:AntaeusData;
      
      public function AntaeusModel()
      {
         super();
      }
      
      public function get canSign() : Boolean
      {
         var _loc3_:Number = ArmyManager.instance.thane.fightingCapacity;
         if(antaeusData.assistantList.length < 10)
         {
            return true;
         }
         var _loc1_:Boolean = false;
         var _loc2_:AntaeusAssistantData = antaeusData.assistantList[9];
         if(_loc3_ > _loc2_.power)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

