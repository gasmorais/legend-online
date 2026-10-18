package battle.skillsys.mode.framedata
{
   public class ShootFrameData implements IFrameData
   {
      
      public static const FLY_TYPE_COMMON:int = 1;
      
      public static const LFY_TYPE_CURVE:int = 2;
      
      public var arrowRes:String;
      
      public var flyType:int;
      
      public var speed:Number;
      
      public var dannyRes:String;
      
      public var rippleRes:String;
      
      public var rippleGap:int;
      
      public var curve:int = 300;
      
      public var arrowWidth:int;
      
      public var startX:int;
      
      public var startY:int;
      
      public var dannyFrame:int;
      
      public function ShootFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [arrowRes,dannyRes,rippleRes];
      }
   }
}

