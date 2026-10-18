package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public final class BoneData
   {
      
      dragonBones_internal var _displayNames:Vector.<String>;
      
      dragonBones_internal var _parent:String;
      
      public var node:BoneTransform;
      
      public function BoneData()
      {
         super();
         this._displayNames = new Vector.<String>();
         this.node = new BoneTransform();
      }
      
      public function get parent() : String
      {
         return this._parent;
      }
      
      public function dispose() : void
      {
         this._displayNames.length = 0;
      }
   }
}

