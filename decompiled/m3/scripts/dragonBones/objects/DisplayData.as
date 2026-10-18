package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class DisplayData
   {
      
      public var pivotX:Number;
      
      public var pivotY:Number;
      
      dragonBones_internal var _isArmature:Boolean;
      
      public function DisplayData()
      {
         super();
         this.pivotX = 0;
         this.pivotY = 0;
      }
      
      public function get isArmature() : Boolean
      {
         return this._isArmature;
      }
   }
}

