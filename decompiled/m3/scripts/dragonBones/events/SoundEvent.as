package dragonBones.events
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.utils.dragonBones_internal;
   import flash.events.Event;
   
   use namespace dragonBones_internal;
   
   public class SoundEvent extends Event
   {
      
      public static const SOUND:String = "sound";
      
      public var movementID:String;
      
      public var sound:String;
      
      public var soundEffect:String;
      
      dragonBones_internal var _armature:Armature;
      
      dragonBones_internal var _bone:Bone;
      
      public function SoundEvent(param1:String, param2:Boolean = false)
      {
         super(param1,false,param2);
      }
      
      public function get armature() : Armature
      {
         return this._armature;
      }
      
      public function get bone() : Bone
      {
         return this._bone;
      }
      
      override public function clone() : Event
      {
         var _loc1_:SoundEvent = new SoundEvent(type,cancelable);
         _loc1_.movementID = this.movementID;
         _loc1_.sound = this.sound;
         _loc1_.soundEffect = this.soundEffect;
         _loc1_._armature = this._armature;
         _loc1_._bone = this._bone;
         return _loc1_;
      }
   }
}

