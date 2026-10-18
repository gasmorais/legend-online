package dragonBones.events
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import flash.events.Event;
   
   public class FrameEvent extends Event
   {
      
      public static const MOVEMENT_FRAME_EVENT:String = "movementFrameEvent";
      
      public static const BONE_FRAME_EVENT:String = "boneFrameEvent";
      
      public var movementID:String;
      
      public var frameLabel:String;
      
      private var _bone:Bone;
      
      public function FrameEvent(param1:String, param2:Boolean = false, param3:Bone = null)
      {
         super(param1,false,param2);
         this._bone = param3;
      }
      
      public function get armature() : Armature
      {
         return target as Armature;
      }
      
      public function get bone() : Bone
      {
         return this._bone;
      }
      
      override public function clone() : Event
      {
         var _loc1_:FrameEvent = new FrameEvent(type,cancelable);
         _loc1_.movementID = this.movementID;
         _loc1_.frameLabel = this.frameLabel;
         _loc1_._bone = this._bone;
         return _loc1_;
      }
   }
}

