package dragonBones.events
{
   import dragonBones.Armature;
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const MOVEMENT_CHANGE:String = "movementChange";
      
      public static const START:String = "start";
      
      public static const COMPLETE:String = "complete";
      
      public static const LOOP_COMPLETE:String = "loopComplete";
      
      public var exMovementID:String;
      
      public var movementID:String;
      
      public function AnimationEvent(param1:String, param2:Boolean = false)
      {
         super(param1,false,param2);
      }
      
      public function get armature() : Armature
      {
         return target as Armature;
      }
      
      override public function clone() : Event
      {
         var _loc1_:AnimationEvent = new AnimationEvent(type,cancelable);
         _loc1_.exMovementID = this.exMovementID;
         _loc1_.movementID = this.movementID;
         return _loc1_;
      }
   }
}

