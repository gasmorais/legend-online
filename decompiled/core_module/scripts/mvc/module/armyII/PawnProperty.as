package mvc.module.armyII
{
   public class PawnProperty
   {
      
      public var bagData:Number = 0;
      
      public var starData:Number = 0;
      
      public var effectData:Number = 0;
      
      public var skillData:Number = 0;
      
      public var bagPer:Number = 0;
      
      public var starPer:Number = 0;
      
      public var effectPer:Number = 0;
      
      public var skillPer:Number = 0;
      
      public function PawnProperty()
      {
         super();
      }
      
      public function getTotalJoin(param1:Number) : Number
      {
         if(param1 == 0)
         {
            return 0;
         }
         return (param1 + bagData + starData + effectData) * (100 + effectPer) / 100 * (100 + bagPer + skillPer + starPer) / 100 + skillData;
      }
      
      public function getBaseJoin(param1:Number) : Number
      {
         if(param1 == 0)
         {
            return 0;
         }
         return (param1 + effectData) * (100 + effectPer) / 100 * (100 + bagPer + skillPer + starPer) / 100 + skillData;
      }
   }
}

