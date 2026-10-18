package battle.skillsys.mode.framedata
{
   public class DisplacementFrameData implements IFrameData
   {
      
      public var disappearEffect:String;
      
      public var appearEffect:String;
      
      public var persistentFrames:int;
      
      public var target:int;
      
      public var offsetX:int;
      
      public var offsetY:int;
      
      public var isForward:Boolean;
      
      public function DisplacementFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         var _loc1_:Array = [];
         if(disappearEffect && disappearEffect != "")
         {
            _loc1_.push(disappearEffect);
         }
         if(appearEffect && appearEffect != "")
         {
            _loc1_.push(appearEffect);
         }
         return _loc1_;
      }
   }
}

