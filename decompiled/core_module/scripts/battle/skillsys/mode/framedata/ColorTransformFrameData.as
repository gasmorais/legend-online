package battle.skillsys.mode.framedata
{
   public class ColorTransformFrameData implements IFrameData
   {
      
      public var color:uint;
      
      public var tweenTime:Number;
      
      public var stopTime:Number;
      
      public var atOnceBool:Boolean;
      
      public var isReduce:Boolean;
      
      public function ColorTransformFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [];
      }
   }
}

