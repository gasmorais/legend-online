package battle.data
{
   public class DamageData
   {
      
      public var bloodType:int;
      
      public var damageValue:Number;
      
      public var displayBlood:int;
      
      public var leftValue:Number;
      
      public var extraData:int;
      
      public var target:int;
      
      public var parry:Boolean;
      
      public var dropList:Array = [];
      
      public var damageCount:int;
      
      public var hpMaxAdd:Number = 0;
      
      public var buffId:int = 0;
      
      public var isUpdated:Boolean;
      
      public function DamageData()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[bloodType:" + bloodType + ",damageValue:" + damageValue + ",target:" + target + ",damageCount:" + damageCount + ",buffId:" + buffId + "]";
      }
   }
}

