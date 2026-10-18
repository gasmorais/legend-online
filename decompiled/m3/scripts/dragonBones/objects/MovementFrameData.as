package dragonBones.objects
{
   public class MovementFrameData
   {
      
      public var duration:Number;
      
      public var movement:String;
      
      public var event:String;
      
      public var sound:String;
      
      public var soundEffect:String;
      
      public function MovementFrameData()
      {
         super();
      }
      
      public function setValues(param1:Number, param2:String, param3:String, param4:String) : void
      {
         this.duration = param1;
         this.movement = param2;
         this.event = param3;
         this.sound = param4;
      }
   }
}

