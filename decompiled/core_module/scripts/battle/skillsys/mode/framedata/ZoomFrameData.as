package battle.skillsys.mode.framedata
{
   public class ZoomFrameData implements IFrameData
   {
      
      public var zoomType:int;
      
      public var zoomTime:Number;
      
      public var stopTime:Number;
      
      public var backTime:Number;
      
      public var zoom:Number;
      
      public var posX:Number;
      
      public var posY:Number;
      
      public function ZoomFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [];
      }
   }
}

