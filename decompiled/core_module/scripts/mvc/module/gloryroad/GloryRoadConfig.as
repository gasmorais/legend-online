package mvc.module.gloryroad
{
   public class GloryRoadConfig
   {
      
      public var baseScore:int;
      
      public var baseGloryScore:int;
      
      public var baseBuffStar:int;
      
      public var resurgenceTimes:int;
      
      public var resetTimes:int;
      
      public var openBoxTimes:int;
      
      public var openBoxPoint:int;
      
      public var resurgencePoint:int;
      
      public var resurgenceChildPoint:int;
      
      public var normalFactor:Number;
      
      public var nightmareFactor:Number;
      
      public var hellFactor:Number;
      
      public function GloryRoadConfig()
      {
         super();
      }
      
      public function getBaseDifficultyValues() : Array
      {
         return [normalFactor,nightmareFactor,hellFactor];
      }
   }
}

