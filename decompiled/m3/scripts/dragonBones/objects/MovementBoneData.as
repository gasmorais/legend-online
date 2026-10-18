package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class MovementBoneData
   {
      
      dragonBones_internal static const HIDE_DATA:MovementBoneData = new MovementBoneData();
      
      dragonBones_internal var _frameList:Vector.<FrameData>;
      
      public var scale:Number;
      
      public var delay:Number;
      
      public function MovementBoneData()
      {
         super();
         this.scale = 1;
         this.delay = 0;
         this._frameList = new Vector.<FrameData>();
      }
      
      public function dispose() : void
      {
         this._frameList.length = 0;
      }
      
      public function getFrame() : Vector.<FrameData>
      {
         return this._frameList;
      }
      
      public function setValues(param1:Number = 1, param2:Number = 0) : void
      {
         this.scale = param1 > 0 ? param1 : 1;
         this.delay = (param2 || 0) % 1;
         if(this.delay > 0)
         {
            this.delay -= 1;
         }
         this.delay *= -1;
      }
   }
}

