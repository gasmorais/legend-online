package battle.skillsys.mode.framedata
{
   public class EffectFrameData implements IFrameData
   {
      
      public static const TYPE_MAP:int = 0;
      
      public static const TYPE_ROLE:int = 1;
      
      public static const TYPE_TARGET:int = 2;
      
      public var type:int;
      
      public var effectRes:String;
      
      public var target:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var arrange:int;
      
      public var count:int;
      
      public var backDistance:int;
      
      public var delayBleed:int;
      
      public function EffectFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [effectRes];
      }
   }
}

