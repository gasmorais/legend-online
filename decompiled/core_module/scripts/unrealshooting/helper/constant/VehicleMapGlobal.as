package unrealshooting.helper.constant
{
   import flash.media.SoundTransform;
   import unrealshooting.helper.utils.VehicleQTree;
   
   public class VehicleMapGlobal
   {
      
      public static const InjuryEffect_SELF:int = 0;
      
      public static const InjuryEffect_MONOMER:int = 1;
      
      public static const InjuryEffect_GROUP:int = 2;
      
      public static const InjuryEffect_TRAP:int = 4;
      
      public static const InjuryEffect_PASSIVE:int = 3;
      
      public static var ADD_ATTACK:int = 1;
      
      public static var DEBUFF_AVOID:int = 2;
      
      public static var ATTACK_AVOID:int = 12;
      
      public static var STUN:int = 4;
      
      public static var STUN_AVOID:int = 5;
      
      public static var SPEED_CHANGE:int = 6;
      
      public static var SPEED_DOWN_AVOID:int = 7;
      
      public static var HP_CHANGE:int = 8;
      
      public static var STEAL_HP:int = 9;
      
      public static var ADD_DAMAGE:int = 10;
      
      public static var qtree:VehicleQTree;
      
      public static var volume0:SoundTransform = new SoundTransform(0);
      
      public static var volume1:SoundTransform = new SoundTransform(1);
      
      public function VehicleMapGlobal()
      {
         super();
      }
   }
}

