package battle.skillsys.mode.framedata
{
   public class MoveFrameData implements IFrameData
   {
      
      public var type:int;
      
      public var speed:int;
      
      public var target:int;
      
      public var distance:int;
      
      public var dustRes:String;
      
      public var dustGap:int;
      
      public function MoveFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [dustRes];
      }
   }
}

